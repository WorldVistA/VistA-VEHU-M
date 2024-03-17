PSOERPC0 ;BIRM/MFR - All Patients (Patient Centric) eRx Queue - ListManager ;09/28/22
 ;;7.0;OUTPATIENT PHARMACY;**700,750**;DEC 1997;Build 6
 ;
 ;Menu option entry point
 N MBMSITE,PSOSTFLT,PSOHDSTS,PSOCCRST,PSOSRTBY,PSORDER,PSOCSGRP,PSOLKBKD,PSOCSERX,PSOCSSCH,PSOCSGRP,PSOMAXQS
 N GRPLN,DIC,DFN,GRPLN,HIGHLN,LASTLINE,VALMCNT,PTMTCHLN,PRMTCHLN,DRMTCHLN,PATFLTR,VPATFLTR,DOBFLTR,MATFLTR,PSONEXTP
 N DIR,Y,DIRUT,DIROUT,CODE,DIRUT,DTOUT,PSOVIEW,PSOCSSCH,PSOCSERX,PSOQUIT,REDTFLTR,PRVFLTR,DRGFLTR
 N RESETLBD,PSOCLNC,PSORFRSH,IDX
 ;
 ; MBMSITE indicates whether it's an MbM site or not, RESETLBD indicates whether the Look Back Days should be reset
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0),RESETLBD=1
 ;
 ;Review/Clean-up Locks (e.g.,Session crased and ^XTMP global remained)
 D REVLOCKS^PSOERPC2
 ;
 ;Division Selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 ;
 ;Clinic Selection (MbM Sites Only)
 S PSOCLNC=+$$GET1^DIQ(59,PSOSITE,10,"I")
 I $G(MBMSITE) D  I $G(PSOQUIT) G EXIT
 . W ! K DIC
 . S DIC(0)="AEMQ",DIC=44,DIC("S")="I '$P($G(^(""I"")),U,1)!$P($G(^(""I"")),U,2)"
 . S DIC("A")="eRx Clinic (Optional): "
 . I $G(PSOCLNC) S DIC("B")=$$GET1^DIQ(44,PSOCLNC,.01)
 . D ^DIC I Y="^"!$D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 . I $G(Y)>0 S PSOCLNC=+Y
 ;
 I '$$CHKKEY^PSOERX(DUZ) D  G EXIT
 . W !,"You do not have the appropriate key to access this option." S DIR(0)="E" D ^DIR K DIR
 ;
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) D MSG^PSODPT G EXIT
 D:'$D(PSOPINST) INST^PSOORFI2 I $G(PSOIQUIT) K PSOIQUIT G EXIT
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 I 'PSNPINST W !,"NPI Institution must be defined to continue." S DIR(0)="E" D ^DIR K DIR G EXIT
 ;
STS ; Status Selection Prompt
 K DIR S DIR(0)="SO^"
 I '$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)) S DIR(0)=DIR(0)_"A:All;N:New;I:In Progress;W:Wait;"
 S DIR(0)=DIR(0)_"H:Hold;C:CCR;WP:Workload Processing"
 S DIR("B")=$S($D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)):"WP",1:"A")
 S DIR("?")=" "
 S IDX=0
 I '$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)) D
 . S IDX=IDX+1,DIR("?",IDX)="     All - View all patients with actionable prescriptions"
 . S IDX=IDX+1,DIR("?",IDX)="     New - View patients with prescriptions in the 'NEW' status"
 . S IDX=IDX+1,DIR("?",IDX)="     In Process - View patients with prescriptions in the 'IN PROCESS' status"
 . S IDX=IDX+1,DIR("?",IDX)="     Wait - View patients with prescriptions in the 'WAIT' status"
 S IDX=IDX+1,DIR("?",IDX)="     Hold - View patients with prescriptions in the 'HOLD' status"
 S IDX=IDX+1,DIR("?",IDX)="     CCR - View patients with prescriptions in the 'CCR' status"
 S IDX=IDX+1,DIR("?",IDX)="     Workload Processing - Process New prescriptions for one patient at a"
 S IDX=IDX+1,DIR("?",IDX)="                           time using FIFO (First In First Out) method"
 D ^DIR I $D(DIRUT)!$D(DIROUT) G EXIT
 S PSOSTFLT=Y,PSOQUIT=0
 I PSOSTFLT="WP" D MATFLTR I '$G(MATFLTR) G STS
 I PSOSTFLT="H" D
 . K DIR S DIR(0)="SO^S:SINGLE CODE;A:ALL HOLD CODES",DIR("B")="A"
 . S DIR("?")=" ",DIR("?",1)="  Single code - Allows selection of a single hold code",DIR("?",2)="  All Hold Codes - Selects all available hold codes"
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I Y="S" S PSOHDSTS=$P($$HLDSTS^PSOERPC1(),U) I PSOHDSTS="" S PSOQUIT=1 Q
 . I Y="A" S PSOHDSTS="ALL"
 I PSOSTFLT="C" D
 . K DIR S DIR("B")="A",DIR(0)="SO^S:SINGLE CODE;A:ALL CCR CODES"
 . S DIR("?")=" ",DIR("?",1)="  Single code - Allows selection of a single CCR code",DIR("?",2)="  All CCR Codes - Selects all available CCR codes"
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I Y="S" S PSOCCRST=$P($$CCRSTS^PSOERPC1("RXN^RXD^RXR^RXE^RXF^CAO^CAH^CAP^CAR^CAX^CAF^CXD^CXN^CXV^CXY^CXE"),U) I PSOCCRST="" S PSOQUIT=1 Q
 . I Y="A" S PSOCCRST="ALL"
 I PSOQUIT G STS
 ;
EN ; - Entry point for the PC Action in the RX View
 ; Loading User's preferences
 D LOAD^PSOERPR0
 ;
 I PSOSTFLT="WP" D
 . D NEXTPAT
 E  W !,"Please wait..." D EN^VALM("PSO ERX ALL PATIENTS QUEUE")
 ;
 G EXIT
 ;
LMHDR ; ListMan Header Code
 D SHOW^VALM,HDR^PSOERPC0
 I $G(MBMSITE) S XQORM("B")="Next Screen"
 S XQORM("#")=$O(^ORD(101,"B","PSO ERX ALL PATIENTS SELECT",""))_"^1:"_VALMCNT
 S XQORM("??")="D HELP^VALM2,HDR^PSOERPC0"
 Q
 ;
HDR      ; - Builds the Header section
 D HDR^PSOERPC1
 Q
 ;
INIT ; - Populates the Body section for ListMan
 N LOCKPATS,PAT
 K ^TMP("PSOERPC0",$J),^TMP("PSOERPCS",$J),^TMP("PSOERPAT",$J)
 S PAT=0 F  S PAT=$O(^XTMP("PSOERXLOCK",PAT)) Q:'PAT  S LOCKPATS(PAT)=+$G(^XTMP("PSOERXLOCK",PAT))
 D SETSORT^PSOERPC1,SETLINE
 S:$G(VALMSG)="" VALMSG="Select the entry # to view or ?? for more actions"
 Q
 ;
SETLINE ; - Setting Listman line
 N ERXPAT,PATIEN,X1,POS,SORTORD,GROUP,CSERX
 K ^TMP("PSOERPC0",$J)
 I '$D(^TMP("PSOERPCS",$J)) D  Q
 . F I=1:1:6 S ^TMP("PSOERPC0",$J,I,0)=""
 . S ^TMP("PSOERPC0",$J,7,0)="               No patients with actionable prescriptions found."
 . S VALMCNT=1
 ;
 ; - Resetting list to NORMAL video attributes
 D RESET^PSOERUT0()
 K GRPLN,PTMTCHLN,PRMTCHLN,DRMTCHLN
 ;
 ; - Building the list (line by line)
 S (GROUP,SEQ)="",LINE=0,SORTORD=$S(PSORDER="A":1,1:-1)
 F  S GROUP=$O(^TMP("PSOERPCS",$J,GROUP)) Q:GROUP=""  D
 . I GROUP'="ALL" D
 . . N LBL,POS,X
 . . S LBL=$S(GROUP="NON-CS":"NON-",1:"")_"CONTROLLED SUBSTANCE Rx's"
 . . S POS=41-($L(LBL)\2) S X="",$P(X," ",81)="",$E(X,POS,POS-1+$L(LBL))=LBL
 . . S LINE=LINE+1,^TMP("PSOERPC0",$J,LINE,0)=X,GRPLN(LINE)=LBL
 . S ERXPAT="" F  S ERXPAT=$O(^TMP("PSOERPCS",$J,GROUP,ERXPAT),SORTORD) Q:ERXPAT=""  D
 . . S PATIEN=$G(^TMP("PSOERPCS",$J,GROUP,ERXPAT,"PATIEN"))
 . . S Z=$G(^TMP("PSOERPCS",$J,GROUP,ERXPAT)),SEQ=SEQ+1
 . . S X1=SEQ_$S($P(Z,"^",11):"]",1:".")
 . . S $E(X1,$S(SEQ>999:6,1:5))=$E($P(Z,"^",1),1,$S(SEQ>999:23,1:24)),$E(X1,30)=$P(Z,"^",2),$E(X1,41)=$$SSN^PSOERUT($P(Z,"^",3))
 . . S $E(X1,54)=$J(+$P(Z,"^",4),3),$E(X1,58)=$J(+$P(Z,"^",5),2),$E(X1,61)=$J(+$P(Z,"^",6),2)
 . . S $E(X1,64)=$J(+$P(Z,"^",7),2),$E(X1,67)=$J(+$P(Z,"^",8),2),$E(X1,70)=$J(+$P(Z,"^",9),3)
 . . S $E(X1,74)=$J(+$P(Z,"^",10),3)
 . . S $E(X1,78)=$J($P(Z,"^",5)+$P(Z,"^",6)+$P(Z,"^",7)+$P(Z,"^",8)+$P(Z,"^",9)+$P(Z,"^",10),3)
 . . S LINE=LINE+1,^TMP("PSOERPC0",$J,LINE,0)=X1,^TMP("PSOERPC0",$J,SEQ,"PATIEN")=PATIEN
 . . I $D(LOCKPATS(PATIEN)) S HIGHLN(LINE)=1
 ;
 ; - Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 D VIDEO^PSOERPT1()
 S VALMCNT=+$G(LINE)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
LBD ; - Change Look Back Days Parameter Action
 D FULL^VALM1 S VALMBCK="R"
 W ! K DIR,DIRUT,DIROUT,SAVEX
 S DIR(0)="52.351,1",DIR("B")=PSOLKBKD
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S PSOLKBKD=Y,RESETLBD=0 D REF S VALMBG=1
 Q
 ;
SQ ; - Search Queue Entry Point
 D FULL^VALM1 S VALMBCK="R"
 N DIR,DUOUT,DIRUT,Y,X,ERXIEN,CHANGE,ERXPTIEN,PSOFPICK
 S CHANGE=0
REP ; - Repeat Prompt for additional filters
 K DIR S DIR("?",1)="Choose one or multiple filter criteria(s) to sort the current list."
 S DIR("?",2)="To remove an existing filter type ^#, where '#' is filter number below."
 S DIR("?")=" "
 S DIR("A")="SEARCH BY"
 S DIR(0)="SO^1:ERX PATIENT" I $D(PATFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$EPATFLST^PSOERUT(44)_")"_IOINORM
 S DIR(0)=DIR(0)_";2:ERX DATE OF BIRTH" I $G(DOBFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$FMTE^XLFDT(DOBFLTR,"2Z")_")"_IOINORM
 S DIR(0)=DIR(0)_";3:ERX REFERENCE NUMBER"
 S DIR(0)=DIR(0)_";4:VISTA RX #"
 S DIR(0)=DIR(0)_";5:VISTA PATIENT" I $D(VPATFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$VPATFLST^PSOERUT(44)_")"_IOINORM
 S DIR(0)=DIR(0)_";6:MATCH STATUS" I $G(MATFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$MATCHLBL^PSOERPC2(MATFLTR)_")"_IOINORM
 W !!,IOINHI,"NOTE: Only patients with actionable records are captured with this search.",IOINORM
 W !,IOINHI,"      Non-Actionable records can be searched through the SQ action under Rx",IOINORM
 W !,IOINHI,"      List View.",IOINORM
 D ^DIR
 I X'="^",X?1"^".N D  G REP
 . K:X="^1" PATFLTR,VPATFLTR K:X="^2" DOBFLTR K:X="^5" PATFLTR,VPATFLTR K:X="^6" MATFLTR
 . S CHANGE=1
 I $D(DUOUT)!($D(DIRUT)) D:CHANGE REF S:CHANGE VALMBG=1 Q
 S PSOFPICK=+$G(Y)
 I PSOFPICK=1 D EPATFLTR S CHANGE=1 G REP
 I PSOFPICK=2 D DOBFLTR S CHANGE=1 G REP
 I PSOFPICK=3 D ERXFLTR G:'$G(ERXFLTR) REP D  I '$G(CHANGE) Q
 . ; - Entering the eRx Record
 . D EN^PSOERX1(ERXFLTR)
 . ; - Unlocking the eRx Patient
 . S ERXPTIEN=$$GET1^DIQ(52.49,ERXFLTR,.04,"I") Q:'ERXPTIEN
 . D UL^PSOERX1A(ERXPTIEN)
 . S CHANGE=1
 I PSOFPICK=4 D RXFLTR G:'$G(ERXFLTR) REP D  I '$G(CHANGE) Q
 . ; - Entering the eRx Record
 . D EN^PSOERX1(ERXFLTR)
 . ; - Unlocking the eRx Patient
 . S ERXPTIEN=$$GET1^DIQ(52.49,ERXFLTR,.04,"I") Q:'ERXPTIEN
 . D UL^PSOERX1A(ERXPTIEN)
 . S CHANGE=1
 I PSOFPICK=5 D VPATFLTR S CHANGE=1 G REP
 I PSOFPICK=6 D MATFLTR S CHANGE=1 G REP
 D REF S VALMBG=1
 Q 
 ;
VPATFLTR ; - VistA Patient Filter
 N DIR,PAT,XX,RANGE,COMSEG,I,J,VPAT,EPAT,DIRUT,DIROUT,QUIT
REP1 ; - Repeat VistA Patient Prompt
 S DIR(0)="F^3:30",DIR("A")="VISTA PATIENT NAME"
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 D FIND^DIC(2,"","@;.01;.03;.114;.115;IX","",X,,"B","","","PATLST")
 I '$D(PATLST("DILIST",2)) W !,"No VistA Patient found",$C(7) K PATLST G REP1
 ;
 D PATLHDR("V")
 S (QUIT,CNT)=0 K DIRUT,DTOUT
 S PAT="" F  S PAT=$O(PATLST("DILIST","ID",PAT)) Q:'PAT  D  I QUIT Q
 . W !,PAT,".",?4,$E(PATLST("DILIST","ID",PAT,.01),1,30),?35,PATLST("DILIST","ID",PAT,.03)
 . I PATLST("DILIST","ID",PAT,.114)'="" D
 . . W ?47,$E(PATLST("DILIST","ID",PAT,.114),1,20),"-",$$STATEABB^PSOERUT(2,PATLST("DILIST",2,PAT))
 . W ?71,$$FMTE^XLFDT($$LASTREDT^PSOERUT("AVPAT",PATLST("DILIST",2,PAT)),"2Z")
 . S CNT=CNT+1
 . I CNT>18,$O(PATLST("DILIST","ID",PAT)),$Y>(IOSL-4) D
 . . K DIR S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DIROUT) S QUIT=1 Q
 . . W @IOF D PATLHDR("V")
 ;
 K DIR S DIR("A")="SELECT (1-"_+$G(PATLST("DILIST",0))_"): "
 S DIR(0)="LA^1:"_+$G(PATLST("DILIST",0)) W ! D ^DIR I $D(DIRUT)!$D(DIROUT) G REP1
 S RANGE=X
 ;
 K VPATFLTR,PATFLTR
 F I=1:1:$L(RANGE,",") D
 . S COMSEG=$P(RANGE,",",I)
 . F J=+COMSEG:1:$S(COMSEG["-":$P(COMSEG,"-",2),1:+COMSEG) D
 . . S VPAT=+$G(PATLST("DILIST",2,J)) I 'VPAT Q
 . . S VPATFLTR(VPAT)=""
 . . S EPAT=0 F  S EPAT=$O(^PS(52.49,"AVPAT",VPAT,EPAT)) Q:'EPAT  D
 . . . S PATFLTR(EPAT)=""
 ;
 I '$D(PATFLTR) W !!,"There are no eRx Patients associated with the VistA Patient(s) selected.",$C(7) K VPATFLTR G REP1
 Q
 ;
EPATFLTR ; - eRx Patient Filter
 N DIR,PAT,XX,RANGE,COMSEG,I,J,RECDAT,DIRUT,DIROUT,QUIT
REP2 ; - Repeat eRx Patient Prompt
 S DIR(0)="F^3:30",DIR("A")="ERX PATIENT NAME"
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 D FIND^DIC(52.46,"","@;.01;.08;3.3;3.4;IX","",X,,"B","","","PATLST")
 I '$D(PATLST("DILIST",2)) W !,"No eRx Patient found" K PATLST G REP2
 ;
 W ! D PATLHDR("E")
 S (QUIT,CNT)=0 K DIRUT,DTOUT
 S PAT="" F  S PAT=$O(PATLST("DILIST","ID",PAT)) Q:'PAT  D  I QUIT Q
 . W !,PAT,".",?4,$E(PATLST("DILIST","ID",PAT,.01),1,30)
 . I PATLST("DILIST","ID",PAT,.08)'="" D
 . . S X=PATLST("DILIST","ID",PAT,.08) D ^%DT W ?35,$$FMTE^XLFDT(Y,"5Z")
 . I PATLST("DILIST","ID",PAT,3.3)'="" D
 . . W ?47,$E(PATLST("DILIST","ID",PAT,3.3),1,20)_"-"_$$STATEABB^PSOERUT(52.46,PATLST("DILIST",2,PAT))
 . S RECDAT=$O(^PS(52.49,"PAT2",PATLST("DILIST",2,PAT),999999999),-1)
 . I RECDAT W ?71,$$FMTE^XLFDT(RECDAT\1,"2Z")
 . S CNT=CNT+1
 . I CNT>18,$O(PATLST("DILIST","ID",PAT)),$Y>(IOSL-4) D
 . . K DIR S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DIROUT) S QUIT=1 Q
 . . W @IOF D PATLHDR("E")
 ;
 K DIR S DIR("A")="SELECT (1-"_+$G(PATLST("DILIST",0))_"): "
 S DIR(0)="LA^1:"_+$G(PATLST("DILIST",0)) W ! D ^DIR I $D(DIRUT)!$D(DIROUT) G REP2
 S RANGE=X
 ;
 K PATFLTR
 F I=1:1:$L(RANGE,",") D
 . S COMSEG=$P(RANGE,",",I)
 . F J=+COMSEG:1:$S(COMSEG["-":$P(COMSEG,"-",2),1:+COMSEG) D
 . . I '$D(PATLST("DILIST",2,J)) Q
 . . S PATFLTR(PATLST("DILIST",2,J))=""
 Q
 ;
PATLHDR(PATTYP) ; - Prints the Patient List Header
 ;Input: Patient Type - "V": VistA Patient | "E": eRx Patient
 N XX W !?73,"LAST",!,"#",?4,$S(PATTYP="E":"ERX",1:"VISTA")_" PATIENT NAME",?35,"DOB",?47,"CITY",?71,"REC.DATE"
 S $P(XX,"-",80)="" W !,XX
 Q
 ;
DOBFLTR ; - DOB Filter
 N DIR,Y,X
 I $G(DOBFLTR) S DIR("B")=$$FMTE^XLFDT(DOBFLTR,"2Z")
 S DIR(0)="DA^:"_DT_":EX",DIR("A")="Date of Birth (DOB): "
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S DOBFLTR=Y
 Q
 ;
MATFLTR ; - Match Status Filter
 N DIR,Y,X
 S DIR("A")="MATCH STATUS"
 S DIR(0)="SO^1:"_$S($G(MBMSITE):"PATIENT FAIL - ",1:"")_"PATIENT NOT MATCHED"
 S DIR(0)=DIR(0)_";2:"_$S($G(MBMSITE):"PROVIDER FAIL - ",1:"")_"PROVIDER NOT MATCHED"
 S DIR(0)=DIR(0)_";3:"_$S($G(MBMSITE):"DRUG FAIL - ",1:"")_"DRUG NOT MATCHED"
 S DIR(0)=DIR(0)_";4:"_$S($G(MBMSITE):"BASIC - ",1:"")_"PATIENT, PROVIDER AND DRUG MATCHED"
 I $G(PSOSTFLT)="WP" S DIR(0)=DIR(0)_";5:ALL (NO FILTERS)",DIR("B")=5
 W ! D ^DIR I $D(DUOUT)!($D(DIRUT)) Q
 S MATFLTR=Y
 Q
 ;
ERXFLTR() ; - eRx ID Filter
 N DIC,Y,DTOUT,DUOUT,QUIT,ERXID,ERXPTIEN
 K ERXFLTR
 W ! S DIC="52.49",DIC(0)="QEA",DIC("A")="ERX REFERENCE NUMBER: "
 S QUIT=0
 F  D  Q:QUIT
 . D ^DIC I $D(DTOUT)!$D(DUOUT)!'Y!(X="") S QUIT=1 Q
 . S ERXID=+Y
 . I 'ERXID W !,"This prescription is not an eRx prescription." Q
 . I '$G(MBMSITE),$$GET1^DIQ(52.49,ERXID,24.1,"I")'=PSNPINST  D  Q
 . . W !!,"eRx belongs to a different Division: "_$$GET1^DIQ(52.49,ERXID,24.1),!,$C(7)
 . S ERXPTIEN=+$$GET1^DIQ(52.49,ERXID,.04,"I")
 . ; - Locking the eRx Patient
 . I '$$LOCK^PSOERPC1(ERXPTIEN) D  Q
 . . W !!,"The patient for this eRx is currently locked by "_$$GET1^DIQ(200,+$G(^XTMP("PSOERXLOCK",ERXPTIEN)),.01)_".",!,$C(7) H 1
 . S ERXFLTR=ERXID,QUIT=1
 Q
 ;
RXFLTR() ; - Rx # Filter
 N DIC,Y,DTOUT,DUOUT,QUIT,ERXID,ERXPTIEN
 K ERXFLTR
 W ! S DIC="52",DIC(0)="QEAM",DIC("A")="VISTA Rx #: "
 S QUIT=0
 F  D  Q:QUIT
 . D ^DIC I $D(DTOUT)!$D(DUOUT)!'Y!(X="") S QUIT=1 Q
 . S ERXID=$$ERXIEN^PSOERXUT(+Y)
 . I 'ERXID W !,"This prescription is not an eRx prescription." Q
 . I '$G(MBMSITE),$$GET1^DIQ(52.49,ERXID,24.1,"I")'=PSNPINST  D  Q
 . . W !!,"eRx belongs to a different Division: "_$$GET1^DIQ(52.49,ERXID,24.1),!,$C(7)
 . S ERXPTIEN=+$$GET1^DIQ(52.49,ERXID,.04,"I")
 . ; - Locking the eRx Patient
 . I '$$LOCK^PSOERPC1(ERXPTIEN) D  Q
 . . W !!,"The patient for this eRx is currently locked by "_$$GET1^DIQ(200,+$G(^XTMP("PSOERXLOCK",ERXPTIEN)),.01)_".",!,$C(7) H 1
 . S ERXFLTR=ERXID,QUIT=1
 Q
 ;
RF ; - Remove All Filters
 K PATFLTR,VPATFLTR,DOBFLTR,MATFLTR D REF S VALMBG=1
 Q
 ;
CS ; - Group/Un-group Controlled Substances
 S PSOCSGRP=$S($G(PSOCSGRP):0,1:1) D REF
 Q
 ;
CV ; - Change View
 D EN^PSOERPR0 I $G(PSORFRSH) D REF S VALMBG=1
 S VALMBCK="R"
 Q
 ;
SORT(FIELD) ; - Sort entries by FIELD
 I PSOSRTBY=FIELD S PSORDER=$S(PSORDER="A":"D",1:"A")
 E  S PSOSRTBY=FIELD,PSORDER="A"
 D REF
 Q
 ;
SEL ; - Process selection of one entry
 N PSOSEL,ERXPTIEN,TMPLKBKD
 S VALMBCK="R" K PSONEXTP
 S PSOSEL=+$P(XQORNOD(0),"=",2) I 'PSOSEL S VALMSG="Invalid selection!",VALMBCK="R" Q
 S ERXPTIEN=$G(^TMP("PSOERPC0",$J,PSOSEL,"PATIEN")) I 'ERXPTIEN S VALMSG="Invalid selection!",VALMBCK="R" Q
 ; - Locking the eRx Patient
 I '$$LOCK^PSOERPC1(ERXPTIEN) Q
 D  ; - Entering the Single Patient View (Protecting Preference Parameters)
 . N PSOSRTBY,PSORDER,PSOCSGRP,PSOALLST
 . S TMPLKBKD=PSOLKBKD D LST^PSOERPT0(ERXPTIEN)
 . I $G(RESETLBD) S PSOLKBKD=TMPLKBKD
 ; - Unlocking the eRx Patient
 D UL^PSOERX1A(ERXPTIEN)
 I $G(PSORFRSH) D REF
 Q
 ;
NEXTPAT ; Automatically Selects the Next Patient
 N ERXPTIEN,NEXTPAT
 S VALMBCK="R",NEXTPAT=0
 ; - Locking the eRx Patient
 F  S ERXPTIEN=$$NEXTPAT^PSOERPC1(NEXTPAT) Q:'ERXPTIEN  Q:$$LOCK^PSOERPC1(ERXPTIEN)  D
 . S NEXTPAT=ERXPTIEN I PSOSTFLT="WP" K ^XTMP("PSOERXWP",ERXPTIEN,DUZ)
 I 'ERXPTIEN Q
 D  ; - Entering the Single Patient View (Protecting Preference Parameters)
 . N PSOSRTBY,PSORDER,PSOCSGRP,PSOALLST
 . D LST^PSOERPT0(ERXPTIEN)
 ; - Unlocking the eRx Patient
 D UL^PSOERX1A(ERXPTIEN)
 Q
 ;
RX ; - Switch to Rx View
 D EN^PSOERRX0 S VALMBCK="Q"
 Q
 ;
REF ; - Screen Refresh
 W ?65,"Please wait..." D INIT,HDR,REVLOCKS^PSOERPC2 S VALMBCK="R"
 S PSORFRSH=0
 Q
 ;
EXIT ; - exit code
 K ^TMP("PSOERPC0",$J),^TMP("PSOERPCS",$J),^TMP("PSOERPAT",$J)
 D FULL^VALM1
 Q
