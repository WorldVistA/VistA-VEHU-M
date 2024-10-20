PSOERX1H ;ALB/MFR - eRx Utilities ;Aug 14, 2020@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**700,746**;DEC 1997;Build 106
 ;
 ;Reference to NEW^TIUPNAPI in ICR #1911
 ;Reference to UPDATE^TIUSRVP in ICR #3535
 ;
DEANOTE ; DEA Note for CS Digitally Signed eRx records
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"This prescription meets the requirements of the Drug Enforcement Administration")
 S LINE=LINE+1 D SET^VALM10(LINE,"(DEA) electronic prescribing for controlled substances rules (21 CFR Parts 1300,")
 S LINE=LINE+1 D SET^VALM10(LINE,"1304, 1306, & 1311).")
 Q
 ;
BATCHREM(ERXIEN,REMVIEN,REMCOMM,TYPE) ; Batch Remove/Un-Remove for Additional eRx (Received Same Day, Patient and Provider)
 ;Input: ERXIEN   - eRx IEN (Pointer to #52.49)
 ;       REMVIEN  - Remove Code IEN (Pointer to #52.45)
 ;       REMCOMM  - Remove/Un-Remove Comments
 ;       TYPE     - R: Remove | U:Un-Remove
 ;Output: Marked eRx either Remove/Un-Remove
 N MSGDTTM,EPRVIEN,EPATIEN,RECDAT,REMOVERX,REMVARR,MTYPE,NEWSTS,MSGTYPE,MBMSITE,RXSTAT,SKIPRX,TMPPSOIEN
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S MSGDTTM=$$GET1^DIQ(52.49,ERXIEN,.03,"I")
 S EPRVIEN=+$$GET1^DIQ(52.49,ERXIEN,2.1,"I")
 S EPATIEN=+$$GET1^DIQ(52.49,ERXIEN,.04,"I")
 S TMPPSOIEN=$G(PSOIEN)
 S RECDAT=MSGDTTM\1
 F  S RECDAT=$O(^PS(52.49,"PAT2",EPATIEN,RECDAT)) Q:'RECDAT!((RECDAT\1)'=(MSGDTTM\1))  D
 . S SKIPRX=0,REMOVERX=0 F  S REMOVERX=$O(^PS(52.49,"PAT2",EPATIEN,RECDAT,REMOVERX)) Q:'REMOVERX  D
 . . I ERXIEN=REMOVERX Q
 . . I TYPE="R" D  Q:$G(SKIPRX)
 . . . S RXSTAT=$$GET1^DIQ(52.49,REMOVERX,1,"E")
 . . . I RXSTAT="RJ"!(RXSTAT="RM")!($G(MBMSITE)&($E(RXSTAT,1,3)="REM"))!(RXSTAT="PR") S SKIPRX=1 Q
 . . . S PSOIEN=REMOVERX I '$$OPACCESS^PSOERXU7("PSO ERX REMOVE",DUZ,REMOVERX) S SKIPRX=1
 . . I TYPE="U" D  Q:$G(SKIPRX) 
 . . . I REMVIEN=$$GET1^DIQ(52.49,REMOVERX,1,"I") S SKIPRX=1 Q
 . . . D CHKSTA(REMOVERX) I RXSTAT'="RM" S SKIPRX=1
 . . I EPRVIEN'=$$GET1^DIQ(52.49,REMOVERX,2.1,"I") Q
 . . S REMVARR(REMOVERX)=REMOVERX
 I '$D(REMVARR) Q
 ;
 W !!,"The following prescriptions are from the same provider and received on the"
 W !,"same day:",!
 W !,"PROVIDER: "_$$GET1^DIQ(52.49,ERXIEN,2.1),?40,"eRx RECEIVED DATE: "_$$GET1^DIQ(52.49,ERXIEN,.03)
 D LSTERXS^PSOERPT1(.REMVARR,0,0)
 W !
 N X,Y,DIR,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="Y",DIR("A")="Do you want to "
 I TYPE="R" S DIR("A")=DIR("A")_"'Remove' them - "_$$GET1^DIQ(52.45,REMVIEN,.01)
 I TYPE="U" S DIR("A")=DIR("A")_"'Un-Remove' them"
 S DIR("B")="No" D ^DIR I '$G(Y) Q
 ;
 W !,"Updating..."
 S REMOVERX=0
 F  S REMOVERX=$O(REMVARR(REMOVERX)) Q:'REMOVERX  D
 . S NEWSTS=REMVIEN
 . I TYPE="R" D UPDSTAT^PSOERXU1(REMOVERX,$S('$G(MBMSITE):"RM",1:$$GET1^DIQ(52.45,NEWSTS,.01)),REMCOMM)
 . I TYPE="U" D UPDSTAT^PSOERXU1(REMOVERX,$$GET1^DIQ(52.45,NEWSTS,.01),REMCOMM)
 H .5 W "done.",$C(7) H 1
 I $G(TMPPSOIEN) S PSOIEN=TMPPSOIEN
 Q
 ;
CHKSTA(REMOVERX) ; check if status is RM or type is "REM"
 S STAIEN=+$G(^PS(52.49,REMOVERX,1)),RXSTAT=$P(^PS(52.45,STAIEN,0),"^",1)
 I RXSTAT="RM" K STAIEN Q
 S RXSTAT=$S($P(^PS(52.45,STAIEN,0),"^",3)="REM":"RM",1:"") K STAIEN
 Q 
CREATEPN(PSOIEN,CRERXIEN,PNCOMM,CRMEDS,TIUTITLE) ;CREATE A PROGRESS NOTE FOR PATIENT
 ;Input : PSOIEN   - Original eRx IEN (Pointer to #52.49)
 ;        CRERXIEN - Change Request eRx IEN (Pointer to #52.49)
 ;        PNCOMM   - Additional Progress Note Comments
 ;                   Example: This is a sample addtional VA Pharmacy Progress Note Comments.
 ;        CRMEDS   - Input array passed by reference.
 ;                   This is an array of the eRx change request medication list.
 ;        TIUTITLE - The TIU Document Definitiona name in File #8925.1
 ;Output: Update existing TIU Document for the Patient
 N TARGET,PSODFN,PSOPTNM,PSOTITL,PSOTIUDA,CRFDA
 ;
 I $G(PSOIEN)=""!($G(CRERXIEN)="")!($G(TIUTITLE)="") Q
 Q:",CX,CR,"'[(","_$P($$ERXMTYPE^PSOERSE1(CRERXIEN),"^")_",")
 S TARGET=$NA(^TMP("TIUP",$J)) K @TARGET
 I $$GET1^DIQ(52.49,CRERXIEN,.08,"I")="CR" W !,"Creating a new Progress Note..."
 D BUILDLST^PSOERSE4(TARGET,CRERXIEN,$G(PNCOMM))
 S PSOTITL=$$FIND1^DIC(8925.1,"","X",TIUTITLE,"B")
 Q:'+PSOTITL  ;IF NO TITLE ON SYSTEM
 S PSODFN=$$GET1^DIQ(52.49,PSOIEN,.05,"I")
 S PSOPTNM=$P($G(^DPT(PSODFN,0)),U,1)
 D NEW^TIUPNAPI(.PSOTIUDA,PSODFN,DUZ,$$NOW^XLFDT,PSOTITL,$G(PSOCLNC))
 I +$G(PSOTIUDA)<0 D  Q
 . I $$GET1^DIQ(52.49,CRERXIEN,.08,"I")="CR" W !,$G(IOINHI),"A problem was encountered while creating the Progress Note.",$G(IOINORM),!
 D UPDATEPN(+$G(PSOTIUDA),PSOIEN,.CRMEDS)
 S CRFDA(52.49,CRERXIEN_",",320.1)=+$G(PSOTIUDA) ;parent TIU IEN reference number for eRx Change Request
 I $G(PNCOMM)'="" S CRFDA(52.49,CRERXIEN_",",320.2)=$G(PNCOMM) ;VA Pharmacy Progress Notes
 D FILE^DIE(,"CRFDA") K CRFDA
 I $$GET1^DIQ(52.49,CRERXIEN,.08,"I")="CR" W "Done." H .5
 Q
 ;
UPDATEPN(PSOTIUDA,PSOIEN,CRMEDS) ;Update existing patient progress notes
 ;Input : PSOTIUDA - TIU IEN (Pointer to #8925)
 ;        PSOIEN   - Original eRx IEN (Pointer to #52.49)
 ;        CRMEDS   - Input array passed by reference.
 ;                   This is an array of the eRx change request medication list.
 ;Output: Update existing TIU Document for the Patient
 ;
 N ERXRET,TIUX,SUBJECT,CNTR,ERXDRUG,DRUGNAME
 Q:$G(PSOTIUDA)=""
 S ERXDRUG=$$GET1^DIQ(52.49,PSOIEN,3.1,"E") ;get the drugname first from the original erx
 I '$L(ERXDRUG) S ERXDRUG=$$GETDRUG^PSOERXU5(PSOIEN)
 S SUBJECT=$P(ERXDRUG," ")
 I $O(CRMEDS(0)) D
 . S CNTR=0,SUBJECT=SUBJECT_":"
 . F  S CNTR=$O(CRMEDS(CNTR)) Q:CNTR=""  D
 . . S DRUGNAME=$P($P(CRMEDS(CNTR),U,2)," ")
 . . I $P(SUBJECT,":",2)'[DRUGNAME S SUBJECT=SUBJECT_DRUGNAME_","
 . S $E(SUBJECT,$L(SUBJECT))=""
 . I $L(SUBJECT)>80 S SUBJECT=$E(SUBJECT,1,77)_"..."
 ;
 S TIUX(.05)=$$FIND1^DIC(8925.6,"","X","COMPLETED","B")
 S TIUX(1501)=$$NOW^XLFDT()
 S TIUX(1502)=DUZ
 S TIUX(1503)=$$GET1^DIQ(200,+DUZ,20.2)
 S TIUX(1504)=$$GET1^DIQ(200,+DUZ,20.3)
 S TIUX(1505)="E"
 S TIUX(1701)=$S($L(SUBJECT)>80:$E(SUBJECT,1,61)_"...",1:SUBJECT)
 D UPDATE^TIUSRVP(.ERXRET,PSOTIUDA,.TIUX)
 Q
 ;
DRUGHDR ;
 ; - Drug Matching Header Line
 I $G(SDERXFLG) D  ;SDERXFLG is set in the PSOERSE1 routine
 . S AMATCH=$$GET1^DIQ(52.49,ERXIEN,1.4,"I")
 . S VALUSER=$$GET1^DIQ(52.49,ERXIEN,1.11,"E"),VALDTTM=$$GET1^DIQ(52.49,ERXIEN,1.12,"I")
 . I $$GET1^DIQ(52.49,ERXIEN,.08,"I")="RE",'VALDTTM D
 . . S MATCH="PREVIOUSLY MATCHED/VALIDATED (RENEWAL)"
 . E  D
 . . S MATCH=$S(AMATCH=1:"AUTO-MATCHED",AMATCH=2:"AUTO-MATCHED/EDITED",VADRGIEN:"MANUALLY-MATCHED",1:"")
 . . I VALUSER'="",MATCH'="" S MATCH=MATCH_" | VALIDATED by "_$E(VALUSER,1,19)_" on "_$$FMTE^XLFDT(VALDTTM,"2Y")
 . . I MATCH="" S MATCH="NOT MATCHED"
 . S MATCH="DRUG "_MATCH I $L(MATCH)>78 S MATCH=$E(MATCH,1,78)
 . S HDR="",$E(HDR,(80-$L(MATCH))\2+1)=MATCH,$E(HDR,81)=""
 . S $E(MATCH,81)=""
 . S UNDERLN(LINE,1)=100 I HDR["/EDITED" S BLINKLN(LINE,$F(HDR,"/EDITED")-6)=6
 . D ADDLINE^PSOERUT0("LM",NMSPC,HDR,"")
 Q
 ;
ADDPNOTE(LINE,PNCOMM) ;
 N DUZTITLE
 S LINE=LINE+1 S @TMPGBL@(LINE,0)=""
 S LINE=LINE+1 S @TMPGBL@(LINE,0)=PNCOMM
 S LINE=LINE+1 S @TMPGBL@(LINE,0)=""
 S LINE=LINE+1 S @TMPGBL@(LINE,0)="Provider's feedback pending."
 S LINE=LINE+1 S @TMPGBL@(LINE,0)=""
 Q
 ;
CHECKREC(RECARY) ;check if there are any change requests made for this original eRx.
 ;Input : RECARY   - A pass by reference variable name of the array that contain all eRx already been sent
 ;Output: SELCTREC - Selected option: N for New or R for Resend
 ;                   If R, it will be concatenated with the entry # to resend.
 N RECCNT,RECIEN,DDASH,ERXHUBID,ERXTYPE,ERXSTAT,ERXDTM,CNTR,RECENTRY
 I $D(RECARY) D
 . W !,"#",?5,"ERX ID",?21,"ERX TYPE",?40,"STATUS",?50,"DATE/TIME"
 . S $P(DDASH,"-",81)="" W !,DDASH
 . S CNTR=0
 . F  S CNTR=$O(RECARY(CNTR)) Q:'CNTR  D
 . . S RECIEN=RECARY(CNTR)
 . . S ERXHUBID=$P($G(^PS(52.49,RECIEN,0)),"^",1)
 . . S ERXTYPE=$$GET1^DIQ(52.49,RECIEN,.08,"E")
 . . S ERXSTAT=$$GET1^DIQ(52.49,RECIEN,1,"E")
 . . S ERXDTM=$$GET1^DIQ(52.49,RECIEN,.03,"I"),ERXDTM=$$FMTE^XLFDT(ERXDTM,1)
 . . W !,CNTR,?5,ERXHUBID,?21,ERXTYPE,?40,ERXSTAT,?50,ERXDTM
 . . S RECCNT=CNTR
 . S SELCTREC=$$SELCTREC
 . I SELCTREC="R" D
 . . K DIR S DIR(0)="LO^1:"_RECCNT,DIR("A")="Select Entry # to Resend"
 . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 . . S RECENTRY=+Y
 Q $G(SELCTREC)_$S($G(SELCTREC)="R":$G(RECENTRY),1:"")
 ;
SELCTREC() ;prompt user to select REC
 ; N - New
 ; R - Resend existing REC
 N PSOASK,PSODIRA,PSODIRB,PSODIRH,PSODIR0
 W !
 S PSODIRA="Select Suggestion Option: (N)EW   (R)ESEND: "
 S PSODIRB=""
 S PSODIRH="^D HELP^PSOERX1H"
 S PSODIR0="SOA^N:NEW;R:RESEND"
 S PSOASK=$$ANSWER(PSODIRA,PSODIRB,PSODIR0,PSODIRH)
 Q $G(PSOASK)
 ;
ANSWER(PSODIRA,PSODIRB,PSODIR0,PSODIRH) ;
 ; Input:
 ;   PSODIR0 - DIR(0) string
 ;   PSODIRA - DIR("A") string
 ;   PSODIRB - DIR("B") string
 ;   PSODIRH - DIR("?") string
 ; Output:
 ;   Function Value - Internal value returned from ^DIR or -1 if user
 ;   up-arrows, double up-arrows or the read times out.
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $D(PSODIR0) S DIR(0)=PSODIR0
 I $D(PSODIRA) S DIR("A")=PSODIRA
 I $G(PSODIRB)]"" S DIR("B")=PSODIRB
 I $D(PSODIRH) S DIR("?")=PSODIRH,DIR("??")=PSODIRH
 D ^DIR
 S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U)) Q Z
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
HELP ;REC help
 I X="?"!(X="??") D
 . W !!,"NEW     - Adds a new Drug/SIG/Qty/Refills/Days Supply suggestion be sent to"
 . W "               the prescriber as an alternative for this Change Request.",!
 . W !,"RESEND  - Allow users to edit and resend an eRx Change Request."
 Q
 ;
BUILDSUM(ERXIEN) ;Build the existing record of the erx that the user selected
 ;Input  - eRx IEN (Pointer to #52.49)
 ;Output - None
 N IENS,RSNTXT,X,RET,INDEX,CODE,Y
 K INDEX S CODE=0
 F  S CODE=$O(^PS(52.45,"TYPE","MRC",CODE)) Q:'CODE  S INDEX($$GET1^DIQ(52.45,CODE,.01))=CODE
 S REACODE=$$GET1^DIQ(52.49,ERXIEN,315.1,"I"),Y=$$GET1^DIQ(52.49,ERXIEN,315.1,"E")
 I $G(REACODE)'=+$G(INDEX(Y)) S REASCODE=0,EXTSCODE="" K REATXT
 S REACODE=+$G(INDEX(Y)),EXTRCODE=$$GET1^DIQ(52.45,REACODE,.01)
 S IENS=$O(^PS(52.49,ERXIEN,316,0))
 I IENS D
 . S IENS=IENS_","_ERXIEN_","
 . S REASCODE=$$GET1^DIQ(52.49316,IENS,1,"I")
 . S EXTSCODE=$$GET1^DIQ(52.45,REASCODE,.01)
 . S EXTRCODE=$$GET1^DIQ(52.45,REACODE,.01)
 I '$G(IENS) S EXTSCODE=""
 S RSNTXT=$$GET1^DIQ(52.49,ERXIEN,317,,"REATXT")
 I $G(REATXT(1))'="" D
 . S X=REATXT(1) K RET D TXT2ARY^PSOERXD1(.RET,X," ",80)
 . K REATXT M REATXT=RET
 D MEDREQ(ERXIEN)
 Q
 ;
MEDREQ(ERXIEN) ;Existing Medication Requested
 ;Input  - eRx IEN (Pointer to #52.49)
 ;Output - CRMEDS array containing the medication requested
 N FILE,I,II,IENS,MEDREQ,DRUG,DRUGCODE,DRUGCODQ,SUBS,NOTE,QTYQUAL,QTY,NUMREFS,QUOM,CRMED
 K ^TMP("PSOCRSIG",$J),CRMEDS
 S II=0
 F  S II=$O(^PS(52.49,ERXIEN,311,II)) Q:'II  D  ;Only requested medications
 . S FILE=52.49311,IENS=II_","_ERXIEN_","
 . K MEDREQ D GETS^DIQ(FILE,IENS,"**","IE","MEDREQ")
 . I $G(MEDREQ(FILE,IENS,.02,"I"))="R" D
 . . S DRUG=$G(MEDREQ(FILE,IENS,.03,"E"))
 . . S DRUGTYPE=$S($G(MEDREQ(FILE,IENS,1.2,"E"))="ND":"V",1:"E")
 . . S DRUGCODE=$G(MEDREQ(FILE,IENS,1.1,"E"))
 . . S DRUGCODQ=$G(MEDREQ(FILE,IENS,1.2,"E"))
 . . S SUBS=$G(MEDREQ(FILE,IENS,2.7,"I"))
 . . S NOTE=$G(MEDREQ(FILE,IENS,5,"E"))
 . . S QTYQUAL=$G(MEDREQ(FILE,IENS,5.2,"E"))
 . . S QTYUM=$G(MEDREQ(FILE,IENS,5.4,"E"))
 . . S QTY=$G(MEDREQ(FILE,IENS,2.1,"E"))
 . . S NUMREFS=$G(MEDREQ(FILE,IENS,2.8,"E"))
 . . S DAYSSUP=$G(MEDREQ(FILE,IENS,2.4,"E"))
 . . S QUOM=$G(MEDREQ(FILE,IENS,2.3,"I"))
 . . S QUOM=$$GET1^DIQ(52.45,QUOM,.02,"E")
 . . S CRMED=$O(CRMEDS(99),-1)+1
 . . S CRMEDS(CRMED)=DRUGTYPE_"^"_DRUG_"^"_DRUGCODE_"^"_DRUGCODQ_"^"_SUBS_"^"_QTY_"^"_QTYQUAL_"^"_QTYUM_"^"_DAYSSUP_"^"_NUMREFS
 . . S CRMEDS(CRMED,"NOTE")=NOTE
 . . S X=$$GET1^DIQ(FILE,IENS,8,,"ERXSIG")
 . . F I=1:1 Q:'$D(ERXSIG(I))  S ^TMP("PSOCRSIG",$J,I,0)=ERXSIG(I)
 . . M CRMEDS(CRMED,"SIG")=^TMP("PSOCRSIG",$J)
 Q
 ;
ASKCONT ; display "Press <Enter> or '^' to exit" prompt
 N Z
 W !,$$CJ^XLFSTR("Press <Enter> or '^' to exit.",1)
 R Z:DTIME
 Q
