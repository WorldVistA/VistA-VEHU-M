PSOREJP3 ;ALB/SS - Third Party Reject Display Screen - Comments ;10/27/06
 ;;7.0;OUTPATIENT PHARMACY;**260,287,289,290,358,359,385,403,421,427,448,482,512,528,544**;DEC 1997;Build 19
 ;Reference to GETDAT^BPSBUTL supported by IA 4719
 ;Reference to COM^BPSSCRU3 supported by IA 6214
 ;Reference to IEN59^BPSOSRX supported by IA 4412
 ;Reference to GETPL59^BPSPRRX5 supported by IA 6939
 ;Reference to GETRTP59^BPSPRRX5 supported by IA 6939
 ;
COM ; Builds the Comments section in the Reject Information Screen.
 ; The following variables are assumed to exist:
 ;   RX - Pointer to file# 52, Prescription.
 ;   FILL - Pointer to the Refill sub-file of the Prescription.
 ;   REJ - Pointer to the Reject Info sub-file of the Prescription.
 ;
 N PSOARRAY,PSOCNT,PSOCOM,PSODATA,PSODATE,PSODATE1,PSODFN,PSOLAST,PSOPC
 N PSOPFLAG,PSOSTATUS,PSOSTR,PSOTEMP,PSOUSER,PSOX,PSOY,X
 ;
 ; MRD;PSO*7*448 - This patch added the ability for an OPECC to flag a
 ; comment on a BPS Transaction as being for pharmacy.  A comment so
 ; flagged will appear on the Reject Information Screen intermingled
 ; with any other comments on the Prescription.  All the comments will
 ; be sorted in reverse chronological order.
 ;
 ; COM^BPSSCRU3 populates the array PSOTEMP with all the comments from
 ; the BPS Transaction corresponding to the Prescription and Refill.
 ; Any of those comments with the Pharmacy flag set to '1' will be
 ; added to the array PSOARRAY.
 ;
 D COM^BPSSCRU3(RX,FILL,,.PSOTEMP)  ; IA 6214.
 ;
 S PSODATE=0
 F  S PSODATE=$O(PSOTEMP(PSODATE)) Q:'PSODATE  D
 . S PSOX=0
 . F  S PSOX=$O(PSOTEMP(PSODATE,PSOX)) Q:'PSOX  D
 . . ;
 . . ; If the Pharmacy flag is set, then add this comment to the
 . . ; array PSOARRAY to be displayed.
 . . ;
 . . S PSOPFLAG=$P(PSOTEMP(PSODATE,PSOX),U)
 . . I 'PSOPFLAG Q
 . . S PSOCOM=$P(PSOTEMP(PSODATE,PSOX),U,2)
 . . S PSOUSER=$P(PSOTEMP(PSODATE,PSOX),U,3)
 . . S PSOUSER=$$GET1^DIQ(200,PSOUSER,.01)
 . . S PSOY=$$FMTE^XLFDT(PSODATE)
 . . S PSOCOM=PSOY_" (OPECC) - "_PSOCOM_" ("_PSOUSER_")"
 . . S PSOY=$G(PSOARRAY(PSODATE))+1
 . . S PSOARRAY(PSODATE)=PSOY
 . . S PSOARRAY(PSODATE,PSOY)=PSOCOM
 . . Q
 . Q
 ;
 ; Pull comments from the Reject sub-file of the Prescription and
 ; add to the array PSOARRAY.
 ;
 S PSOX=0
 F  S PSOX=$O(^PSRX(RX,"REJ",REJ,"COM",PSOX)) Q:'PSOX  D
 . S PSODATE=$$GET1^DIQ(52.2551,PSOX_","_REJ_","_RX,.01,"E")
 . S PSOUSER=$$GET1^DIQ(52.2551,PSOX_","_REJ_","_RX,1)
 . S PSOCOM=$$GET1^DIQ(52.2551,PSOX_","_REJ_","_RX,2)
 . S PSOCOM=PSODATE_" - "_PSOCOM_" ("_PSOUSER_")"
 . S PSODATE=$$GET1^DIQ(52.2551,PSOX_","_REJ_","_RX,.01,"I")
 . S PSOY=$G(PSOARRAY(PSODATE))+1
 . S PSOARRAY(PSODATE)=PSOY
 . S PSOARRAY(PSODATE,PSOY)=PSOCOM
 . Q
 ;
 ; At this point, all of the comments to be displayed are in the array
 ; PSOARRAY, sorted by date/time.  If that array is empty, then skip
 ; down to PTC.  Otherwise, loop through the comments backwards to
 ; display in reverse chronological order.
 ;
 I '$O(PSOARRAY("")) G PTC
 D SETLN^PSOREJP1()
 D SETLN^PSOREJP1("COMMENTS - REJECT",1,1)
 ;
 S PSODATE=""
 F  S PSODATE=$O(PSOARRAY(PSODATE),-1) Q:'PSODATE  D
 . S PSOX=""
 . F  S PSOX=$O(PSOARRAY(PSODATE,PSOX),-1) Q:'PSOX  D
 . . ;
 . . ; Use ^DIWP utility to put comment into scratch global array,
 . . ; with lines broken apart intelligently.
 . . ;
 . . N %,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z
 . . K ^UTILITY($J,"W")
 . . S X=PSOARRAY(PSODATE,PSOX)
 . . S DIWL=1
 . . S DIWR=78
 . . D ^DIWP
 . . ;
 . . ; Loop through the scratch array and add each line to the ^TMP
 . . ; global to be displayed on the screen.
 . . ;
 . . S PSOLAST=0
 . . F PSOY=1:1 Q:('$D(^UTILITY($J,"W",1,PSOY,0)))  D
 . . . S PSOCOM=$G(^UTILITY($J,"W",1,PSOY,0))
 . . . ;
 . . . ; If this line is the last of this comment, and this is the
 . . . ; last comment, then Set PSOLAST=1 to make this line underlined
 . . . ; on the screen.
 . . . ;
 . . . I '$D(^UTILITY($J,"W",1,PSOY+1)),$O(PSOARRAY(PSODATE,PSOX),-1)="",$O(PSOARRAY(PSODATE),-1)="" S PSOLAST=1
 . . . ;
 . . . ; Use SETLN^PSOREJP1 to add line to ^TMP array to be displayed to screen.
 . . . ;
 . . . D SETLN^PSOREJP1($S(PSOY=1:"- ",1:"  ")_PSOCOM,0,PSOLAST,1)
 . . . Q
 . . Q
 . Q
 ;
PTC ; Patient Comments
 ;
 K PSOARRAY
 ;
 ; Get Patient ID - If no Patient Comments on file, Quit
 S PSODFN=$$GET1^DIQ(52,RX,2,"I")
 I '$D(^PS(55,PSODFN,"PC")) Q
 ;
 ; Loop through Patient Comments - Add ACTIVE Comments to PSOAR array
 S PSODATE=""
 S PSOCNT=0
 K PSOAR
 F  S PSODATE=$O(^PS(55,PSODFN,"PC","B",PSODATE)) Q:PSODATE=""  D
 . S PSOPC=""
 . F  S PSOPC=$O(^PS(55,PSODFN,"PC","B",PSODATE,PSOPC)) Q:PSOPC=""  D
 . . K PSODATA
 . . D GETS^DIQ(55.17,PSOPC_","_PSODFN_",",".01;1;2;3","IE","PSODATA")
 . . ; 
 . . ; Only display ACTIVE Patient Comments
 . . S PSOSTATUS=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",2,"I"))
 . . I PSOSTATUS'="Y" Q
 . . ;
 . . S PSODATE1=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",.01,"E"))
 . . S PSOUSER=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",1,"E"))
 . . S PSOCOM=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",3,"E"))
 . . S PSOSTR=PSODATE1_" - "_PSOCOM_" ("_PSOUSER_")"
 . . S PSOCNT=PSOCNT+1
 . . S PSOARRAY(PSOCNT)=PSOSTR
 ;
 ; If PSOAR array exists, display Active Patient Comments
 I $D(PSOARRAY) D
 . D SETLN^PSOREJP1("COMMENTS - PATIENT",1,1)
 . ;
 . ; Loop through PSOAR in reverse order to display Patient
 . ; Comments in reverse chronological order
 . S PSOCNT=""
 . F  S PSOCNT=$O(PSOARRAY(PSOCNT),-1) Q:PSOCNT=""  D
 . . ;
 . . ; Use ^DIWP to display Patient Comments with proper
 . . ; line breaking
 . . N %,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z
 . . K ^UTILITY($J,"W")
 . . S X=PSOARRAY(PSOCNT)
 . . S DIWL=1
 . . S DIWR=78
 . . D ^DIWP
 . . ;
 . . S PSOLAST=0
 . . F PSOY=1:1 Q:('$D(^UTILITY($J,"W",1,PSOY,0)))  D
 . . . S PSOCOM=$G(^UTILITY($J,"W",1,PSOY,0))
 . . . ;
 . . . ; Looping through the array in reverse order means PSOCNT=1
 . . . ; will be the last comment to display. If the last line of the 
 . . . ; last comment is being displayed, set PSOLAST=1 to underline
 . . . ; the comment on the screen.
 . . . ;
 . . . I '$D(^UTILITY($J,"W",1,PSOY+1)),PSOCNT=1 S PSOLAST=1
 . . . ;
 . . . ; Use SETLN^PSOREJP1 to add line to ^TMP array to be displayed to screen.
 . . . ;
 . . . D SETLN^PSOREJP1($S(PSOY=1:"- ",1:"  ")_PSOCOM,0,PSOLAST,1)
 ;
 K ^UTILITY($J,"W")
 ;
 Q
 ;
ADDCOM ; - Add comment worklist action
 N DIR,PSO55,PSCOM,PSOCOMTYPE
 D FULL^VALM1
 ;
 S DIR(0)="S^R:Reject;P:Patient Billing"
 S DIR("A")="Comment Type"
 S DIR("?",1)="The Reject Comment only displays for the specific reject."
 S DIR("?")="The Patient Billing Comment displays on all rejects for the patient."
 D ^DIR
 I $D(DIRUT) S VALMBCK="R" Q
 S PSOCOMTYPE=Y
 ;
 I PSOCOMTYPE="P",'$D(^XUSEC("PSO EPHARMACY SITE MANAGER",DUZ)) D  S VALMBCK="R" Q
 . W !,"Patient Billing Comments require Pharmacy Key (PSO EPHARMACY SITE MANAGER)"
 . D WAIT^VALM1
 ;
 S PSCOM=$$COMMENT("Comment: ",150)
 ;
 ; Save Reject Type Comment
 I PSOCOMTYPE="R",$L(PSCOM)>0,PSCOM'["^" D
 . D SAVECOM(RX,REJ,PSCOM) ;save the comment
 . D INIT^PSOREJP1 ;update screen
 ; Save Patient Billing Type Comment
 I PSOCOMTYPE="P",$L(PSCOM)>0,PSCOM'["^" D
 . S PSO55=$$GET1^DIQ(52,RX,2,"I")
 . D ADDPC^PSOPTC0(PSCOM,PSO55)
 . D INIT^PSOREJP1
 S VALMBCK="R"
 Q 
 ;
 ;Enter a comment
 ;PSOTR  -prompt string
 ;PSMLEN -maxlen
 ;returns:
 ; "^" - if user chose to quit 
 ; "" - nothing entered or input has been discarded
 ; otherwise - comment's text
COMMENT(PSOTR,PSMLEN) ;*/
 N DIR,DTOUT,DUOUT,PSQ
 I '$D(PSOTR) S PSOTR="Comment "
 I '$D(PSMLEN) S PSMLEN=150
 S DIR(0)="FA^1:150"
 S DIR("A")=PSOTR
 S DIR("?")="Enter a free text comment up to 150 characters long."
 S PSQ=0
 F  D  Q:+PSQ'=0
 . W ! D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S PSQ=-1 Q
 . I $L(Y)'>PSMLEN S PSQ=1 Q
 . W !!,"Enter a free text comment up to 150 characters long.",!
 . S DIR("B")=$E(Y,1,PSMLEN)
 Q:PSQ<0 "^"
 Q:$L(Y)=0 ""
 S PSQ=$$YESNO("Confirm","YES")
 I PSQ=-1 Q "^"
 I PSQ=0 Q ""
 Q Y
 ;
 ; Ask
 ; Input:
 ;  PSQSTR - question
 ;  PSDFL - default answer
 ; Output: 
 ; 1 YES
 ; 0 NO
 ; -1 if cancelled
YESNO(PSQSTR,PSDFL) ; Default - YES
 N DIR,Y,DUOUT
 S DIR(0)="Y"
 S DIR("A")=PSQSTR
 S:$L($G(PSDFL)) DIR("B")=PSDFL
 W ! D ^DIR
 Q $S($G(DUOUT)!$G(DUOUT)!(Y="^"):-1,1:Y)
 ;
 ;Save comment
SAVECOM(PSRXIEN,PSREJIEN,PSCOMNT,DATETIME,USER) ;
 N PSREC,PSDA,PSERR
 I '$G(DATETIME) D NOW^%DTC S DATETIME=%
 I '$G(USER) S USER=DUZ
 D INSITEM(52.2551,PSRXIEN,PSREJIEN,DATETIME)
 S PSREC=$O(^PSRX(PSRXIEN,"REJ",PSREJIEN,"COM","B",DATETIME,0))
 I PSREC>0 D
 . S PSDA(52.2551,PSREC_","_PSREJIEN_","_PSRXIEN_",",1)=USER
 . S PSDA(52.2551,PSREC_","_PSREJIEN_","_PSRXIEN_",",2)=$G(PSCOMNT)
 . D FILE^DIE("","PSDA","PSERR")
 Q
 ;
 ;/**
 ;PSSFILE - subfile# (52.2551) for comment
 ;PSIEN - ien for file in which the new subfile entry will be inserted
 ;PSVAL01 - .01 value for the new entry
INSITEM(PSSFILE,PSIEN0,PSIEN1,PSVAL01) ;*/
 N PSSSI,PSIENS,PSFDA,PSER
 S PSIENS="+1,"_PSIEN1_","_PSIEN0_","
 S PSFDA(PSSFILE,PSIENS,.01)=PSVAL01
 D UPDATE^DIE("","PSFDA","PSSSI","PSER")
 I $D(PSER) D BMES^XPDUTL(PSER("DIERR",1,"TEXT",1))
 Q
 ;
PRINT(RX,RFL) ; Print Label for specific Rx/Fill
 I '$G(RX) Q
 I $G(RFL)="" Q
 ;
 ; Some of these variables are used by LBL^PSOLSET but they are newed here
 N PPL,PSOSITE,PSOPAR,PSOSYS,PSOBARS,PSOBAR0,PSOBAR1,PSOIOS,PSOBFLAG,PSOCLBL
 N PSOQUIT,PSOPIOST,PSOLTEST,PSOTLBL,PSORXT
 N DFN,PDUZ,RXFL,REPRINT,REJLBL,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 N %ZIS,IOP,POP,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,ZTDTH,VAR
 ;
 ; Set the default label printer.  We need to new it so we don't change the value that was
 ;   set by PSOLSET when the user first logged into OP so need to do a bit of work to new it and  
 ;   reset it before the call to LBL^PSOLSET.
 I $G(PSOLAP)]"" S PSOTLBL=PSOLAP N PSOLAP S PSOLAP=PSOTLBL,PSOCLBL=1
 E  N PSOLAP S PSOCLBL=""
 ;
 ; Check if a label has already been printed and set REPRINT flag.
 S REJLBL=0 F  S REJLBL=$O(^PSRX(RX,"L",REJLBL)) Q:'REJLBL  I +$$GET1^DIQ(52.032,REJLBL_","_RX,1,"I")=RFL S REPRINT=1 Q
 ;
 ; Define required variables
 S PSOSITE=+$$RXSITE^PSOBPSUT(RX,RFL),PSOPAR=$G(^PS(59,PSOSITE,1))
 S DFN=$$GET1^DIQ(52,RX,2,"I"),PDUZ=DUZ,PSOSYS=$G(^PS(59.7,1,40.1))
 S PPL=RX I RFL S RXFL(RX)=RFL
 ;
 ; Get label print device and check alignment
 W ! S PSOBFLAG=1 D LBL^PSOLSET I $G(PSOQUIT) Q
 I $G(PSOLAP)="" W $C(7),!!,"No printer defined" K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR Q
 ;
 ; Call %ZIS to get device characteristics w/o reopening the printer. 
 ; We need to do this to check if queuing is forced for this device
 ; Not checking the POP variable.  If we don't get the device here, we will fall through to the 
 ;   foreground process and try again
 S IOP=PSOLAP,%ZIS="QN" D ^%ZIS
 ;
 ; If background printer, queue the job
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^PSOLBL",ZTDTH=$H,ZTIO=PSOLAP
 . F VAR="PSOSYS","DFN","PSOPAR","PDUZ","PCOMX","PSOLAP","PPL","PSOSITE","RXY","PSOSUSPR","PSOBARS","PSOBAR1","PSOBAR0","PSODELE","PSOPULL","PSTAT","PSODBQ","PSOEXREP","PSOTREP","REPRINT" S:$D(@VAR) ZTSAVE(VAR)=""
 . S ZTSAVE("PSORX(")="",ZTSAVE("RXRP(")="",ZTSAVE("RXPR(")="",ZTSAVE("RXRS(")="",ZTSAVE("RXFL(")="",ZTSAVE("PCOMH(")=""
 . S ZTDESC="OUTPATIENT PHARMACY REJECT WORKLIST LABEL PRINT"
 . D ^%ZISC,^%ZTLOAD
 . W !!,"Label ",$S('$D(ZTSK):"NOT ",1:""),"queued to print",! I '$D(ZTSK) W $C(7) K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR
 ;
 ; If we gotten this far, open the device and print the label in the foreground
 ; We also need to preserve the PSORX array, which gets killed by DQ^PSOLBL
 K %ZIS S IOP=PSOLAP D ^%ZIS
 I POP D ^%ZISC W $C(7),!!,"Printer is busy - NO label printed" K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR Q
 K PSORXT M PSORXT=PSORX
 D DQ^PSOLBL,^%ZISC
 K PSORX M PSORX=PSORXT
 Q
 ;
RXINFO(RX,FILL,LINE,REJ) ; Returns header displayable Rx Information
 N TXT,RXINFO,LBL,CMOP,DRG,PSOET
 I LINE=1 D
 . N RXDOS D GETDAT^BPSBUTL(RX,FILL,,.RXDOS) ; Get Date of Service from BPS CLAIM field 401 - PSO*7*421
 . S RXINFO="Rx#      : "_$$GET1^DIQ(52,RX,.01)_"/"_FILL
 . ;cnf, PSO*7*358, add PSOET logic for TRICARE/CHAMPVA non-billable
 . S PSOET=$$PSOET(RX,FILL)
 . S $E(RXINFO,27)="ECME#: "_$S(PSOET:"",1:$$ECMENUM^PSOBPSU2(RX,FILL))
 . S $E(RXINFO,49)="Date of Service: "_$S(PSOET:"",1:$$FMTE^XLFDT(RXDOS)) ; Use DOS from BPS Claims field 401 - PSO*7*421
 I LINE=2 D
 . S DRG=$$GET1^DIQ(52,RX,6,"I"),CMOP=$S($D(^PSDRUG("AQ",DRG)):1,1:0)
 . S RXINFO=$S(CMOP:"CMOP ",1:"")_"Drug",$E(RXINFO,10)=": "_$E($$GET1^DIQ(52,RX,6),1,43)
 . S $E(RXINFO,56)="NDC Code: "_$$GETNDC^PSONDCUT(RX,FILL)
 Q $G(RXINFO)
 ;
FILL ;Fill payable TRICARE or CHAMPVA Rx
 N COM,I,OPNREJ,OPNREJ2,OPNREJ3,DCSTAT,PSOREL
 S:'$G(PSOTRIC) PSOTRIC=$$TRIC^PSOREJP1(RX,FILL,PSOTRIC)  ;cnf, PSO*7*358, add line
 ;cnf, PSO*7*358, don't allow option if TRICARE/CHAMPVA and released, PSOREL is set to the release date
 S PSOREL=0 I PSOTRIC D
 . I 'FILL S PSOREL=+$$GET1^DIQ(52,RX,31,"I")
 . I FILL S PSOREL=+$$GET1^DIQ(52.1,FILL_","_RX,17,"I")
 I PSOREL S VALMSG="Released Rxs may not be filled.",VALMBCK="R" Q
 ;cnf, PSO*7*358, don't allow option if prescription has been discontinued
 ;  12 - DISCONTINUED
 ;  14 - DISCONTINUED BY PROVIDER
 ;  15 - DISCONTINUED (EDIT)
 S DCSTAT=$$GET1^DIQ(52,RX,100,"I")
 I "/12/14/15/"[("/"_DCSTAT_"/") S VALMSG="Discontinued Rxs may not be filled.",VALMBCK="R" Q
 D FULL^VALM1
 I $$CLOSED^PSOREJP1(RX,REJ) D  Q
 . S VALMSG="This Reject is marked resolved!",VALMBCK="R"
 ;cnf, PSO*7*358
 S COM=""
 I 'PSOTRIC&($$STATUS^PSOBPSUT(RX,FILL)'["PAYABLE") S VALMSG="Only Rxs with an E PAYABLE status may be filled.",VALMBCK="R" Q
 I PSOTRIC&($$STATUS^PSOBPSUT(RX,FILL)'["PAYABLE") D FILLTR I $L($G(VALMSG)_$G(VALMBCK)) Q  ;cnf, PSO*7*358
 S:COM="" COM="AUTOMATICALLY CLOSED"  ;cnf, PSO*7*358, add condition
 S (OPNREJ,OPNREJ2,OPNREJ3)=""
 S OPNREJ2=0 F  S OPNREJ2=$O(^PSRX(RX,"REJ",OPNREJ2)) Q:OPNREJ2=""!(OPNREJ2'?1N.N)  S OPNREJ=OPNREJ_","_OPNREJ2
 S OPNREJ=$E(OPNREJ,2,999),OPNREJ2=""
 W !?20,"[Closing all rejections for prescription "_$$GET1^DIQ(52,RX,".01")_":"
 F I=1:1 S OPNREJ2=$P(OPNREJ,",",I) Q:OPNREJ2=""  D
 . S OPNREJ3="",OPNREJ3=$$GET1^DIQ(52.25,OPNREJ2_","_RX,".01")
 . W !?25,OPNREJ3_" - "_$$GET1^DIQ(9002313.93,OPNREJ3,".02")_"..."
 . D CLOSE^PSOREJUT(RX,FILL,OPNREJ2,DUZ,6,COM,"","","","","",1) W "OK]",!,$C(7) H 1  ; pso*7*421 Use 12th param to ignore
 I $$PTLBL^PSOREJP2(RX,FILL) D PRINT(RX,FILL)
 S CHANGE=1   ;cnf, PSO*7*358, remove S VALMBCK="R" so user goes back to selection list
 Q
 ;
PSOCOB(RX,FILL,REJ) ; Returns RXCOB indicator for Worklist
 N DATA1
 D GET^PSOREJU2(RX,FILL,.DATA1,REJ,1)
 I $G(DATA1(REJ,"COB"))="PRIMARY"  Q 1
 I $G(DATA1(REJ,"COB"))=""  Q 1
 Q 2
 ;
DC ;Discontinue TRICARE Rx
 N ACTION S ACTION="D"
 D FULL^VALM1
 S ACTION=$$DC^PSOREJU1(RX,ACTION)
 I ACTION="Q"!(ACTION="^") S VALMSG="NO ACTION TAKEN.",VALMBCK="R" Q
 S CHANGE=1
 Q
 ;
FILLTR ;TRICARE/CHAMPVA specific logic  ;cnf, PSO*7*358
 ;COM is not new'd so the variable can be used in FILL tag
 N CONT,PSOETEC,PSQSTR
 ;
FILLTR2 ;Use for looping if user enters ^ in required comment field  ;cnf, PSO*7*358
 ;
 ;if TRICARE/CHAMPVA, not payable, and no security key, quit
 ;reference to ^XUSEC( supported by IA 10076
 I '$D(^XUSEC("PSO TRICARE/CHAMPVA",DUZ)) S VALMSG="Action Requires <PSO TRICARE/CHAMPVA> security key",VALMBCK="R" Q
 ;
 ;if TRICARE/CHAMPVA, not payable, and user has security key, prompt to continue or not
 S PSQSTR="You are bypassing claims processing. Do you wish to continue"
 S CONT=$$YESNO(PSQSTR,"No")
 I (CONT=-1)!('CONT) S VALMSG="NO ACTION TAKEN.",VALMBCK="R" Q
 ;
 ;check for valid electronic signature
 I '$$SIG^PSOREJU1() S VALMBCK="R" Q                               ;quit if no valid electronic signature
 ;
 ;prompt user for required TRICARE/CHAMPVA Justification
 S COM=$$TCOM(RX,FILL) G:COM="^" FILLTR2                    ;loop back to "continue?" question if ^ entry
 ;
 ;audit log
 S PSOETEC=$$PSOETEC^PSOREJP5(RX,FILL)
 D AUDIT^PSOTRI(RX,FILL,,COM,$S(PSOETEC:"N",1:"R"),$S($G(PSOTRIC)=1:"T",$G(PSOTRIC)=2:"C",1:""))
 Q
 ;
TCOM(RX,RFL) ; - Ask for TRICARE or CHAMPVA Justification
 N COM,DIR,DIRUT,X
 W ! S DIR(0)="F^3:100" S DIR("A")=$$ELIGDISP^PSOREJP1(RX,RFL)_" Justification" D ^DIR
 S COM=X I $D(DIRUT) S COM="^"
 Q COM
 ;
PSOET(RX,FILL) ; Returns flag for TRICARE or CHAMPVA non-billable and no claim submitted
 ; Return 1 if rejection code is eT or eC (pseudo-reject code)
 ;        0 otherwise
 ;
 I '$G(RX) Q 0
 N X,TRIREJCD
 S X=0
 S TRIREJCD=$T(TRIREJCD+1),TRIREJCD=$P(TRIREJCD,";;",2)
 S X=$$FIND^PSOREJUT(RX,$G(FILL),,TRIREJCD,1) ; PSO*7*421 - Pass indicator to ignore ECME status
 Q X
 ;
TRIREJCD ;TRICARE or CHAMPVA Reject Code, non-billable Rx   ;cnf, PSO*7*358
 ;;eT,eC;;TRICARE or CHAMPVA pseudo reject codes referenced in ^PSOREJP3, ^PSOREJU4
 Q
 ;
SEND(OVRCOD,CLA,PA,PSOET) ; - Sends Claim to ECME and closes Reject
 ; Input:  OVRCOD - Up to three ~-pieces, and each populated would be
 ;              Reason for Service Code ^ Prof Srvc Cd ^ Result of Srvc Cd
 ;         CLA - Submission Clarification Code #1 ~ SCC #2 ~ SCC #3 
 ;         PA - Prior Auth Type ^ Prior Auth Number 
 ;         PSOET - 1 if eT/eC pseudo-reject on claim
 N ALTXT,COM,DIR,PSO59,PSOCOB,PSOETEC,PSOPLAN,PSORTYPE,RESP,SMA
 N DIWF,DIWL,DIWR,X
 S DIR(0)="Y",DIR("A")="     Confirm",DIR("B")="YES"
 S DIR("A",1)="     When you confirm, a new claim will be submitted for"
 S DIR("A",2)="     the prescription and this REJECT will be marked"
 S DIR("A",3)="     resolved."
 S DIR("A",4)=" "
 W ! D ^DIR K DIR I $G(Y)=0!$D(DIRUT) S VALMBCK="R" Q
 S SMA=0 I $G(OVRCOD)]"",$G(CLA)]"",$G(PA)]"" S SMA=1
 S ALTXT=""
 I 'SMA D
 . S ALTXT="REJECT WORKLIST"
 . S:$G(OVRCOD)'="" ALTXT=ALTXT_"-DUR OVERRIDE CODES("_$TR(OVRCOD,"^","/")_")"
 . S:$G(CLA)]"" ALTXT=ALTXT_"-(CLARIF. CODE="_CLA_")"
 . S:$G(PA)]"" ALTXT=ALTXT_"-(PRIOR AUTH.="_$TR(PA,"^","/")_")"
 ;
 S PSOCOB=$$PSOCOB^PSOREJP3(RX,FILL,REJ)
 S PSO59=$$IEN59^BPSOSRX(RX,FILL,PSOCOB)
 S PSOPLAN=$$GETPL59^BPSPRRX5(PSO59)  ; IA 6939
 S PSORTYPE=$$GETRTP59^BPSPRRX5(PSO59)  ; IA 6939
 ; Check for Tricare/Champva Non-Billable eT,eC pseudo reject set PSOETEC=1
 S PSOETEC=""
 I ($D(^PSRX(RX,"REJ","B","eT")))!($D(^PSRX(RX,"REJ","B","eC"))) S PSOETEC=1
 ;
 D ECMESND^PSOBPSU1(RX,FILL,,$S($G(PSOET):"RSNB",1:"ED"),$$GETNDC^PSONDCUT(RX,FILL),,,$G(OVRCOD),,.RESP,,ALTXT,$G(CLA),$G(PA),PSOCOB,,PSOPLAN,PSORTYPE)
 ;If PSOETEC=1 RESP will exist because its a Non-Billable Rx, do not Quit continue processing
 I PSOETEC'=1 I $G(RESP) D  Q
 . W !!?10,"Claim could not be submitted. Please try again later!"
 . I $P(RESP,"^",2)="" S X="Reason: UNKNOWN"
 . E  S X="Reason: "_$P(RESP,"^",2)
 . S DIWF="W"
 . S DIWL=11
 . S DIWR=75
 . D ^DIWP
 . D ^DIWW
 . W $C(7)
 . H 2
 ;
 ; Get the ePharmacy Response Pause and hang for that amount of time (default is 2 if not set)
 N PAUSE,IEN5286
 I $G(PSOSITE)="" N PSOSITE S PSOSITE=$$RXSITE^PSOBPSUT(RX,FILL)
 S IEN5286=$O(^PS(52.86,"B",+PSOSITE,""))
 S PAUSE=$$GET1^DIQ(52.86,IEN5286_",",6)
 I PAUSE="" S PAUSE=2
 I PAUSE H PAUSE
 ;
 I $$PTLBL^PSOREJP2(RX,FILL) D PRINT(RX,FILL)
 N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,FILL,PSOTRIC)
 I $$GET1^DIQ(52,RX,100,"I")=5&(PSOTRIC) D
 . Q:$$STATUS^PSOBPSUT(RX,FILL)'["PAYABLE"
 . N XXX S XXX=""
 . W !,"This prescription can be pulled early from suspense or the label will print"
 . W !,"when PRINT FROM SUSPENSE occurs.",!
 . R !,"Press enter to continue... ",XXX:60
 I $D(PSOSTFLT),PSOSTFLT'="B" S CHANGE=1
 Q
