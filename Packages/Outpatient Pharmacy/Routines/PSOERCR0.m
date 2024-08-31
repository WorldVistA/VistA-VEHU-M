PSOERCR0 ;BHAM/MR - eRx Change Request Functionality ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**746**;DEC 1997;Build 106
 ;
EN ; Action Entry Point
 N ERXSTS,CRMEDS,CRMED,MED,MEDCNT,DIR,Y,X,INDEX,CODE,HLP,DESC,I,REACODE,EXTRCODE,REASCODE,EXTSCODE,LINE,DIRUT,DIROUT,DUOUT,SELCTREC,FDAPNCOM
 N REATXT,DIC,DWLW,DWPK,DIWESUB,X,DELMED,TMPARR,WRPHELP,HELP,DESC,LINE,PSOQUIT,ERROR,FINISH,PSSRET,HUBID,VADAT,NPIINST,GBL,RECARY,RTHID
 N INSTNAME,STATION,INSTNPI,DIV,NOTE2PRV,REASONTXT,RELERX,CRFOUND,PNCOMM,CODETYPE,DDWFLAGS,MESSID,CRERXIEN,NPLEN,RECFOUND,ORGRXIEN,TMPIEN
 I '$G(ERXIEN) Q
 D FULL^VALM1 S VALMBCK="R"
 ;
 S NPIINST=$$GET1^DIQ(59,PSOSITE,101,"I"),INSTNAME=$$NAME^XUAF4(NPIINST),STATION=$$WHAT^XUAF4(NPIINST,99)
 S INSTNPI=$$NPI^XUSNPI("Organization_ID",NPIINST) I $P(INSTNPI,U)<1 D
 . S INSTNPI=$$WHAT^XUAF4(NPIINST,41.99)
 I '$G(INSTNPI) W !!,"Institution NPI Number could not be found. Cannot create Change Request." D DIRE^PSOERXX1 Q
 ;
 I '$D(^XUSEC("PSDRPH",DUZ)),'($D(^XUSEC("PSO ERX ADV TECH",DUZ))) D  Q
 . W !!,$G(IOINHI),"You do not have the appropriate key to access this option.",!,$G(IOINORM)  D DIRE^PSOERXX1
 ;
 S SELCTREC=""
 I $G(RESEND) S RECFOUND=0,ORGRXIEN="" D RESENDEC K RECFOUND Q  ;entry point for  PSO ERX RESEND CHANGE REQUEST Protocol action
 ;
 S ERXSTS=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 I $$GET1^DIQ(52.49,ERXIEN,.08,"I")'="N"!(ERXSTS="RJ")!(ERXSTS="RM")!(ERXSTS="CAN")!(ERXSTS="CAC")!($E(ERXSTS)="H")!(ERXSTS="CXQ") D  Q
 . W !!,$G(IOINHI),"Change Request may not be used for this record type.",!,$G(IOINORM) D DIRE^PSOERXX1
 ;
 I '$$GET1^DIQ(52.49,ERXIEN,1.7,"I") D  Q
 . W !!,$G(IOINHI),"The VistA Patient must be matched and validated first.",!,$G(IOINORM) D DIRE^PSOERXX1
 ;
 D DSPERX^PSOERUT(ERXIEN)
 ;
 S (RELERX,CRFOUND)=0 F  S RELERX=$O(^PS(52.49,ERXIEN,201,"B",RELERX)) Q:'RELERX  D
 . I $$GET1^DIQ(52.49,RELERX,.08,"I")="CR" S CRFOUND=CRFOUND+1,RECARY(CRFOUND)=RELERX
 I CRFOUND>0 D  Q:($G(SELCTREC)'="N")&($G(SELCTREC)'="R")
 . W !!,$G(IOINHI),CRFOUND," Rx Change Request",$S(CRFOUND>1:"s have",1:" has")," already been sent for this eRx.",$G(IOINORM)
 . W !
 . ;Display any change requests made for this original eRx, so they can either create a brand new ERX change request or resend the existing one.
 . S SELCTREC=$$CHECKREC^PSOERX1H(.RECARY)
 . I $E(SELCTREC,1)="R" S RECENTRY=$E(SELCTREC,2),SELCTREC=$E(SELCTREC,1)
 I $G(SELCTREC)="R" D  Q:+$G(RECENTRY)<1!(+$G(RECFOUND))
 . I +$G(RECENTRY)>0 S RECFOUND=0,ORGRXIEN="",ERXIEN=$G(RECARY(RECENTRY)) D RESENDEC
 ;
EN1 ; Loop Entry Point
 K INDEX S CODE=0 K DIR S DIR(0)="SO^",HLP=0,DIR("?")=" "
 F  S CODE=$O(^PS(52.45,"TYPE","MRC",CODE)) Q:'CODE  D
 . S INDEX($$GET1^DIQ(52.45,CODE,.01))=CODE
 . S DIR(0)=DIR(0)_$$GET1^DIQ(52.45,CODE,.01)_":"_$$GET1^DIQ(52.45,CODE,.02)_";"
 . S HLP=HLP+1,DIR("?",HLP)="    "_$$GET1^DIQ(52.45,CODE,.01)_" - "
 . K DESC S X=$$GET1^DIQ(52.45,CODE,1,"","DESC") I '$D(DESC) Q
 . S HELP=$G(DESC(1)) F I=2:1 Q:'$D(DESC(I))  S HELP=HELP_" "_DESC(I)
 . K WRPHELP D WRAP^PSOERUT(HELP,70,.WRPHELP)
 . F I=1:1 Q:'$D(WRPHELP(I))  S:I>1 HLP=HLP+1 S $E(DIR("?",HLP),10)=$G(WRPHELP(I,0))
 S DIR("A")="CHANGE REQUEST CODE" I $G(REACODE) S DIR("B")=$$GET1^DIQ(52.45,REACODE,.01)
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 I Y="G",'$$GET1^DIQ(52.49,ERXIEN,5.8,"I") D  G EN1
 . W !!,$G(IOINHI),"Substitutions are already allowed by prescriber for this eRx.",$G(IOINORM),$C(7)
 I $G(REACODE)'=+$G(INDEX(Y)) S REASCODE=0,EXTSCODE="" K REATXT
 S REACODE=+$G(INDEX(Y)),EXTRCODE=$$GET1^DIQ(52.45,REACODE,.01)
 W ! I '$D(REATXT) S X=$$GET1^DIQ(52.45,REACODE,20,,"REATXT")
 ;
 S PSOQUIT=0
 I (" D U "[(" "_EXTRCODE_" ")) D  I $G(PSOQUIT) G EXIT
 . K INDEX  K DIR S DIR(0)="SO^",DIR("L",1)="     Select one of the following:",DIR("L",2)=" "
 . S HLP=0,LINE=2,DIR("L")="        "_$S(EXTRCODE="D":"Type '?' for the full list. ",1:"")
 . S DIR("?")="^D HELP^PSOERCR0"
 . S CODETYPE=$S(EXTRCODE="D":"REA",1:"MRSC")
 . F  S CODE=$O(^PS(52.45,"TYPE",CODETYPE,CODE)) Q:'CODE  D
 . . S INDEX($$GET1^DIQ(52.45,CODE,.01))=CODE
 . . S DIR(0)=DIR(0)_$$GET1^DIQ(52.45,CODE,.01)_":"_$$GET1^DIQ(52.45,CODE,.02)_";"
 . . I EXTRCODE="U"!(EXTRCODE="D"&(",DA,DD,HD,LD,MS,TD,AR,DI,DR,ID,UD,PS,SX,TP,"[(","_$$GET1^DIQ(52.45,CODE,.01)_","))) D
 . . . S LINE=LINE+1,DIR("L",LINE)="   "_$S(EXTRCODE="D":"     ",1:"")_$$GET1^DIQ(52.45,CODE,.01)_" - "_$$GET1^DIQ(52.45,CODE,.02)
 . . S HLP=HLP+1,DIR("?",HLP)="   "_$S(EXTRCODE="D":"     ",1:"")_$$GET1^DIQ(52.45,CODE,.01)_" - "_$$GET1^DIQ(52.45,CODE,.02)
 . I EXTRCODE="D" S LINE=LINE+1,DIR("L",LINE)=" "
 . S DIR("A")="CHANGE REQUEST SUB-CODE" I $G(REASCODE) S DIR("B")=$$GET1^DIQ(52.45,REASCODE,.01)
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I $G(REASCODE)'=+$G(INDEX(Y)) K REATXT
 . S REASCODE=+$G(INDEX(Y)),EXTSCODE=$$GET1^DIQ(52.45,REASCODE,.01)
 . W ! I '$D(REATXT) S X=$$GET1^DIQ(52.45,REASCODE,20,,"REATXT")
 ;
NOTES ; NOTE TO PROVIDER Prompt (Max 260 characters)
 K ^TMP("PSOERN2P",$J)
 F I=1:1 Q:'$D(REATXT(I))  S ^TMP("PSOERN2P",$J,I,0)=REATXT(I)
 S PSOQUIT=0
 F I=1:1 S FINISH=1 D  I FINISH!PSOQUIT Q
 . S NPLEN=0,DIC="^TMP(""PSOERN2P"""_",$J,"
 . S DWLW=80,DWPK=1
 . S DIWESUB="NOTE TO PROVIDER" W !,DIWESUB,":"
 . D EN^DIWE I $G(DUOUT) S PSOQUIT=1 Q
 . F I=1:1 Q:'$D(^TMP("PSOERN2P",$J,I))  D  I 'FINISH Q
 . . S X=^TMP("PSOERN2P",$J,I,0)
 . . S NPLEN=NPLEN+$L(X) I NPLEN>260 W !!,$G(IOINHI),"The maximum length for this note is 260 characters.",$G(IOINORM),$C(7) S FINISH=0 D PAUSE^PSOSPMU1 Q
 . . I X["[DRUG_NAME]" W !!,$G(IOINHI),"The place holder [DRUG_NAME] must be replaced before proceeding.",$G(IOINORM),$C(7) S FINISH=0 D PAUSE^PSOSPMU1 Q
 . . I X["[ADD_TEXT_HERE]" W !!,$G(IOINHI),"The place holder [ADD_TEXT_HERE] must be replaced before proceeding.",$G(IOINORM),$C(7) S FINISH=0 D PAUSE^PSOSPMU1 Q
 I PSOQUIT G EXIT
 K REATXT F I=1:1 Q:'$D(^TMP("PSOERN2P",$J,I))  S REATXT(I)=$G(^TMP("PSOERN2P",$J,I,0))
 ;
 I (" P U "'[(" "_EXTRCODE_" ")) D  I $G(PSOQUIT) G EXIT
 . S (LINE,FINISH,ERROR,PSOQUIT)=0 W !
 . F I=1:1 D  I FINISH!PSOQUIT Q
 . . S (MED,MEDCNT)=0 F  S MED=$O(CRMEDS(MED)) Q:'MED  S MEDCNT=MEDCNT+1
 . . D:'$G(ERROR) LISTMEDS S ERROR=0
 . . K DIR S DIR(0)="SOA^N:NEW;"_$S(MEDCNT>0:"E:EDIT;D:DELETE;",1:"")_"F:FINISH"
 . . S DIR("A")="Select Drug Suggestion Option:  (N)EW  "_$S(MEDCNT>0:"(E)DIT  (D)ELETE  ",1:"")_"(F)INISH: "
 . . S II=0
 . . S II=II+1,DIR("?",II)="  NEW    - Adds a new Drug/SIG/Qty/Refills/Days Supply suggestion be sent to"
 . . S II=II+1,DIR("?",II)="           the prescriber as an alternative for this Change Request."
 . . I MEDCNT D
 . . . S II=II+1,DIR("?",II)="  EDIT   - Edits a previously entered suggestion"
 . . . S II=II+1,DIR("?",II)="  DELETE - Deletes a previously entered suggestion"
 . . S II=II+1,DIR("?",II)="  FINISH - Finishes entering suggestions and continue on to sending the"
 . . S DIR("?")="           Change Request."
 . . D ^DIR I X="^" S PSOQUIT=1 Q
 . . I $D(DIROUT)!$G(DIRUT) S FINISH=1 Q
 . . I Y="N" D  Q
 . . . S CRMED=$O(CRMEDS(99),-1)+1 I CRMED>9 W !!,"A maximum of 9 Drug Suggestion can be entered!",!,$C(7) S ERROR=1 Q
 . . . W ! D DSPERX^PSOERUT(ERXIEN) D EN^PSOERCR1
 . . I Y="E" D  W ! Q
 . . . K DIR S DIR(0)="L^1:"_MEDCNT,DIR("A")="Select Entry # to Edit"
 . . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 . . . S CRMED=+Y D EN^PSOERCR1
 . . I Y="F" S FINISH=1 Q
 . . I Y="D" D  W ! Q
 . . . K DIR S DIR(0)="L^1:"_MEDCNT,DIR("A")="Select Entry # to Delete"
 . . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 . . . S DELMED=+Y
 . . . K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO"
 . . . S DIR("A")="Confirm? "
 . . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="N") W ! Q
 . . . W !?64,"Deleting..." K CRMEDS(DELMED) H .5 W "Ok.",! H .5
 . . . K TMPARR M TMPARR=CRMEDS K CRMEDS S MED=0 F I=1:1 S MED=$O(TMPARR(MED)) Q:'MED  M CRMEDS(I)=TMPARR(MED)
 ;
PNCOMM ; Patient Progress Note Comments
 K DIR,DIRUT S DIR(0)="FO^1:210",DIR("A")="VA PROGRESS NOTE COMMENTS (Optional)" I $G(PNCOMM)'="" S DIR("B")=PNCOMM
 S DIR("?")="This text will be appended at the bottom of the Patient Progress Notes that will be created after this Rx Change Request is submitted."
 W ! D ^DIR I Y="^" G EXIT
 S PNCOMM=Y
 ;
 I EXTRCODE'="U",'$D(REATXT),'$O(CRMEDS(0)) D  G NOTES
 . W !!,$G(IOINHI),"You must enter either Notes to Provider or at least one Drug Suggestion",$G(IOINORM),$C(7)
 . W !,$G(IOINHI),"before proceeding.",$G(IOINORM),$C(7) D PAUSE^PSOSPMU1
 ;
RESENDEC ;Allows a user to resend an eRx Change request in the Inbound eRx application
 I $G(RESEND)!($G(SELCTREC)="R") D  Q:'$G(RECFOUND)
 . Q:RECFOUND  ;only build existing record once
 . I $$GET1^DIQ(52.49,ERXIEN,.08,"I")="CR" D  Q  ;resend eRx ONLY if message type is 'CR' FOR RXCHANGEREQUEST
 . . S ORGRXIEN=$P(^PS(52.49,ERXIEN,0),"^",14),ORGRXIEN=$O(^PS(52.49,"B",ORGRXIEN,0)),TMPIEN=PSOIEN
 . . S RECFOUND=1,PNCOMM=""
 . . D BUILDSUM^PSOERX1H(ERXIEN)
 . . K PNCOMM S PNCOMM=$$GET1^DIQ(52.49,ERXIEN,320.2) ;CH REQ PROGRESS NOTE COMMENT
 . W !!,$G(IOINHI),"Resend Change Request may not be used for this record type.",$G(IOINORM),! D ASKCONT^PSOERX1H
 D SUMMARY
 ;
 W ! K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO"
 S DIR("A")="Would you like to edit this Rx Change Request before sending it? "
 D ^DIR I $D(DIRUT)!$D(DIROUT) G EXIT
 I $G(Y)="Y" G EN1
 ;
 W ! K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="YES"
 S DIR("A")="Would you like to send this Rx Change Request? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="N") G EXIT
 ;
 W !!,"Sending Request to Provider..."
 ; Building & Sending RxChangeRequest Message to the Provider
 S GBL=$NA(^TMP("PSOERCR0",$J)) K @GBL
 S CNT=0
 ;
 I $G(RESEND)!($G(SELCTREC)="R") S ERXIEN=$G(ORGRXIEN) ;send the original erx instead of the new CRN type eRx.
 ;
 D MSG^PSOERXOA(.GBL,1)
 ; Header
 S MESSID=$$HEADER^PSOERXOA(.GBL,ERXIEN)
 ; Body Header
 D BHF^PSOERXOA(.GBL,1)
  ; Request Type Header
 D RTYPE^PSOERXOA(.GBL,"RxChangeRequest",1)
 ; RxChangeRequest Code/Sub-Code
 D BL^PSOERXOA(GBL,.CNT,"MessageRequestCode",EXTRCODE)
 D BL^PSOERXOA(GBL,.CNT,"MessageRequestSubCode",EXTSCODE)
 S REASONTXT="" F I=1:1 Q:'$D(REATXT(I))  S REASONTXT=REASONTXT_" "_REATXT(I)
 S $E(REASONTXT,1)=""
 D BL^PSOERXOA(GBL,.CNT,"ChangeReasonText",REASONTXT)
 ;
 ; call prompting logic
 ; RETURN RECEIPT, REQUESTREFERENCENUMBER, URGENCY INDICATOR CODE, FOLLLOWUP REQUEST
 D OALLERGY^PSOERXOB(GBL,.CNT,ERXIEN) ;(ONLY 1 INSTANCE - XSD IS 0..1)
 D OBENEFIT^PSOERXOB(GBL,.CNT,ERXIEN) ;outbound benefits coordination section
 D OFAC^PSOERXOB(GBL,.CNT,ERXIEN) ;outbound facility segment
 D PATIENT^PSOERXOC(GBL,.CNT,PSOSITE,ERXIEN) ;outbound patient segment
 D OPHARM^PSOERXOD(GBL,.CNT,PSOSITE,ERXIEN) ; brad/steve
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,ERXIEN,"PR") ; PRESCRIBER - brad/steve
 D OOBSERVE^PSOERXOB(GBL,.CNT,ERXIEN) ;outbound observation segment
 ; Bulding the <MedicationPrescribed> Segment
 D MEDS^PSOERXOG(GBL,.CNT,ERXIEN,"P")
 ; Bulding the <MedicationRequested> Segment
 I $O(CRMEDS(0)) D MEDREQ^PSOERXON(GBL,.CNT,.CRMEDS)
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,ERXIEN,"FU") ; FOLLOW UP PRESCRIBER
 D RTYPE^PSOERXOA(GBL,"RxChangeRequest",2)
 D BHF^PSOERXOA(.GBL,2)
 D MSG^PSOERXOA(.GBL,2)
 ;
 ; send message
 S DIV=INSTNAME_"^"_INSTNPI
 S RXIEN=$$GET1^DIQ(52.49,ERXIEN,.13,"I")
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 K DIR I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") K DIR S DIR(0)="E" D ^DIR K DIR Q
 S HUBID=$G(PSSRET("outboundMsgId")) I 'HUBID W !,"The eRx Processing hub did not return a Hub identification number." S DIR(0)="E" D ^DIR K DIR Q 0
 ; vista generated message will be V12345 (V concatenated to the hubId)
 S HUBID="V"_HUBID
 N RES,I,XXL1
 S I=0 F  S I=$O(@GBL@(I)) Q:'I  D
 . S XXL1=$G(XXL1)_$G(@GBL@(I,0))
 S VADAT=DUZ
 S RTHID=$$GET1^DIQ(52.49,ERXIEN,.01,"E")
 S HUBID=HUBID_U_U_RTHID
 W "Done." H .5
 D INCERX^PSOERXI1(.RES,.XXL1,"","","",STATION,DIV,HUBID,"","",VADAT,"")
 I $P(RES,U)=0 D
 . W !,"A problem was encountered while trying to file the RxChange request."
 . W !,"RxChange Request was not filed in vista."
 . W !!,"ERROR: "_$P(RES,U,2)
 . K DIR S DIR(0)="E" D ^DIR K DIR
 I '$G(RESEND)!($G(SELCTREC)'="R") D UPDSTAT^PSOERXU1(ERXIEN,"HC")
 ;
 ; Creating Patient Progress Note
 I $P(HUBID,"^")'="" D
 . S CRERXIEN=$O(^PS(52.49,"B",$P(HUBID,"^"),0))
 . D CREATEPN^PSOERX1H(ERXIEN,CRERXIEN,PNCOMM,.CRMEDS,"ERX RX CHANGE REQUEST NOTE")
 I $G(RESEND)!($G(SELCTREC)="R") S ERXIEN=TMPIEN ;put back the ERXIEN used during the entry point
 ;
 K @GBL
 ;
 W ! D DIRE^PSOERXX1
 ;
 D REF^PSOERSE1
 ;
 Q
 ;
EXIT ; Exit the action
 I $G(SELCTREC)="R"!($G(RESEND)) S ERXIEN=TMPIEN ;put back the ERXIEN used during the entry point
 I '$O(CRMEDS(0)) Q
 W ! K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="YES"
 S DIR("A")="Are you sure you want to exit (ALL INFORMATION ENTERED WILL BE LOST)? "
 D ^DIR I Y="N" G EN1
 Q
 ;
DEFREA(REACODE) ; Returns the Default Change Request Reason Text
 ; Input: REACODE - Pointer to the ERX SERVICE REASON CODES (#52.45)
 ;Output: DEFREA  - Default Change Request Reason Text for the Code passed in
 N DEFREA,I,X,REATXT
 S DEFREA="",X=$$GET1^DIQ(52.45,REACODE,20,,"REATXT")
 F I=1:1 Q:'$D(REATXT(I))  S DEFREA=DEFREA_" "_$G(REATXT(I))
 S $E(DEFREA)=""
 Q DEFREA
 ;
HELP ; Sub-Code List
 N I,XX W !,"     Complete List of Change Request Sub-Codes:",!
 F I=1:1 Q:'$D(DIR("?",I))  W !,DIR("?",I) I '(I#20) R !,"Type <Enter> to continue or '^' to exit:",XX:DTIME I XX="^" Q
 D:(I#20) PAUSE^PSOSPMU1
 Q
 ;
LISTMEDS ; Display Meds Already entered
 N XX,Z,MED,Y,SIG
 ;D DSPERX^PSOERUT(ERXIEN)
 I '$O(CRMEDS(0)) Q
 ;
 S LINE=1 D PAUSE W ! W:$D(IOUON) IOUON W "#  DRUG",?50,"QTY",?55,"# REFS",?63,"DAYS SUPPLY",?76,"SUBS" W:$D(IOUOFF) IOUOFF
 I '$D(IOUON) S $P(XX,"-",81)="" D PAUSE W !,XX,! S LINE=2
 S MED=0 F  S MED=$O(CRMEDS(MED)) Q:'MED  D
 . S Z=$G(CRMEDS(MED))
 . I MED=1 W !
 . D PAUSE W MED,?3,"(",$P(Z,"^"),")",$E($P(Z,"^",2),1,43),?50,$J($P(Z,"^",6),3),?57,$J($P(Z,"^",10),2)
 . W ?65,$J($P(Z,"^",9),4),?76,$S($P(Z,"^",5):"NO",1:"YES"),!
 . I $O(CRMEDS(MED,"SIG",0)) D
 . . D PAUSE W ?3 W:$D(IOUON) IOUON W "Sig :" W:$D(IOUOFF) IOUOFF
 . . S SIG="" F I=1:1 Q:'$D(CRMEDS(MED,"SIG",I))  S SIG=SIG_CRMEDS(MED,"SIG",I,0)_" "
 . . F I=1:1 Q:(SIG="")  W ?9,$E(SIG,1,70),! S SIG=$E(SIG,71,999) D PAUSE
 . I $G(CRMEDS(MED,"NOTE"))'="" D
 . . D PAUSE W ?3 W:$D(IOUON) IOUON W "Note:" W:$D(IOUOFF) IOUOFF S NOTE=CRMEDS(MED,"NOTE")
 . . F I=1:1 Q:NOTE=""  W ?9,$E(NOTE,1,71),! S NOTE=$E(NOTE,72,999) D PAUSE
 Q
 ;
SUMMARY ; Displays a Summary of the RxChangeRequest
 N HIGH,NORM,XX,ERXSIG,NOTES,MEDIEN,QTYQUAL
 ;
 W @IOF S LINE=0
 S HIGH=$G(IOINHI),NORM=$G(IOINORM)
 W ! D PAUSE S $P(XX,$S($D(IOUON):" ",1:"-"),81)="",$E(XX,27,51)="RX CHANGE REQUEST SUMMARY" W !,$G(IOUON),XX,$G(IOUOFF)
 W ! D PAUSE W "Change Request Reason Code: ",HIGH,$$GET1^DIQ(52.45,+$G(REACODE),.01)," - ",$$GET1^DIQ(52.45,+$G(REACODE),.02),NORM
 I $G(REASCODE) D
 . W ! D PAUSE W "Change Request Reason Sub-Code: ",HIGH,$$GET1^DIQ(52.45,+$G(REASCODE),.01)," - ",$$GET1^DIQ(52.45,+$G(REASCODE),.02),NORM
 ;
 W ! D PAUSE W "Note to Provider: " F I=1:1 Q:'$D(REATXT(I))  W !,HIGH,REATXT(I),NORM
 ;
 W ! D LISTMEDS
 ;
 I ($G(PNCOMM)'="")!($G(RESEND))!($G(SELCTREC)="R") W ! D PAUSE W "VA Progress Note Comment: ",!,HIGH,PNCOMM,NORM,!
 ;
 S XX="",$P(XX,$S($D(IOUON):" ",1:"-"),81)="" W $G(IOUON),XX,$G(IOUOFF)
 Q
 ;
PAUSE ; Decides whether to pause the listing or not
 N XX,I,Y,X
 S LINE=LINE+1
 S Y=$S($G(IOSL):IOSL,1:24)-3 I (LINE#Y) Q
 W "Press Return to continue" R X:60
 F I=1:1:26 W $C(8)
 S $P(XX," ",26)="" W XX
 F I=1:1:26 W $C(8)
 Q
