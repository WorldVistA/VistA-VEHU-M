AOVTIU1 ;ELZ/VAPA tiu utility routine  12/9/97
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
 ;
UMED(DFN,TARGET) ; -- entry point for Unit Dose Object
 N LINE,DA,UD,HEAD
 K @TARGET
 D ENHS^PSJEEU0
 S UD="" F  S UD=$O(^UTILITY("PSG",$J,UD)) Q:UD=""  S UD(0)=^(UD) D
 . Q:$E($P(UD(0),U,5))'="A"
 . S HEAD="DRUG                             DOSAGE          SIG"
 . D SET(TARGET,$P(UD(0),U,3),$P(UD(0),U,6),$P(UD(0),U,8)_" "_$P($P(UD(0),U,7),";",3),,33,23)
 . W "."
 I $G(@TARGET@(1,0))="" S LINE=1,@TARGET@(1,0)="No Unit Dose Medications"
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q "~@"_$NA(@TARGET)
 ;
IMED(DFN,TARGET) ; -- entry point for iv meds Object
 N LINE,DA,IV,HEAD
 K @TARGET
 D ENHS^PSJEEU0
 S IV="" F  S IV=$O(^UTILITY("PSIV",$J,IV)) Q:IV=""  S IV(0)=^(IV,0) D
 . Q:$E($P(IV(0),U,4))'="A"
 . F DA="A","S" S IV(DA)=$G(^UTILITY("PSIV",$J,IV,DA,1))
 . Q:IV("A")=""
 . S HEAD="DRUG                DOSAGE"
 . D SET(TARGET,$P(IV("A"),U),$P(IV("A"),U,2),,"In: "_$P($P(IV("S"),U),";",2)_" "_$P(IV("S"),U,2),20)
 . S LINE=LINE+1
 . S DA="" F DA(0)=1:1:34 S DA=DA_" "
 . S @TARGET@(LINE,0)=DA_$P(IV(0),U,5)_" "_$P(IV(0),U,6)
 . W "."
 I $G(@TARGET@(1,0))="" S LINE=1,@TARGET@(1,0)="No IV Medications"
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q "~@"_$NA(@TARGET)
 ;
OMED(DFN,TARGET) ; -- entry point for Outpatient rx Object
 N LINE,DA,RX,DAT
 K @TARGET
 S LINE=0
 D ^PSOHCSUM
 S RX="" F  S RX=$O(^TMP("PSOO",$J,RX)) Q:RX=""  D
 . F DA=0,1 S RX(DA)=^TMP("PSOO",$J,RX,DA)
 . Q:$E($P(RX(0),U,5))'="A"&($E($P(RX(0),U,5))'="S")
 . Q:$E($P(^PSDRUG(+$P(RX(0),U,3),0),U,2))="X"
 . I RX(1)'="" S DA=RX(1) D WRT^GMTSPSO(.DA) S RX(1)=DA
 . S LINE=LINE+1,@TARGET@(LINE,0)=$E($P($P(RX(0),U,3),";",2),1,80)
 . S LINE=LINE+1,@TARGET@(LINE,0)="   "_$TR($E(RX(1),1,77),"*")
 . W "."
 I LINE=0 S LINE=1,@TARGET@(1,0)="No Outpatient Medications"
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q "~@"_$NA(@TARGET)
 ;
SET(TARGET,DRUG,DOSE,SIG,IN,SIZE,SS) ; -- set temp global for tiu meds
 N DAT
 D:$G(@TARGET@(1,0))=""&($D(HEAD)) HEAD
 S DAT=$$SPACE($P(DRUG,";",2),SIZE)
 S DAT=DAT_$$SPACE(DOSE,14)
 S:$D(SIG) DAT=DAT_"  "_$$SPACE(SIG,SS)
 S:$D(IN) DAT=DAT_$$SPACE(IN,35)
 S LINE=LINE+1
 S @TARGET@(LINE,0)=DAT
 Q
HEAD ; -- sets temp global header for tiu meds
 S @TARGET@(1,0)=HEAD,LINE=1
 Q
SPACE(A,B) ; -- function to make A a totoal of B spaces
 F  Q:$L(A)>B  S A=A_" "
 Q $E(A,1,B)
 ;
PROB(DFN,TARGET) ; -- called by the object to produce active problems
 ;  I used the call documented as a DBI Agreement that was
 ;  made between Controlled Subscri and the Problem List Package
 ;  in the technichal manual v2.0 page 41 problem list
 ;
 N DATA,I
 D ACTIVE^GMPLUTL(DFN,.DATA)
 I DATA(0) F I=1:2:DATA(0) D
 . S DATA=$$SPACE($P(DATA(I,1),U,2),40)
 . S @TARGET@(I,0)=DATA_$P($G(DATA(I+1,1)),U,2)
 . W "."
 E  S DATA(0)=1,@TARGET@(1,0)="No Active Problems on record"
 S @TARGET@(0)="^^"_DATA(0)_"^"_DATA(0)_"^"_DT_"^^"
 Q "~@"_$NA(@TARGET)
LAB(DFN,TEST,RANGE,NULL) ; -- Entry point called by lab tiu objects for
 ; individual lab tests only.
 ;         DFN = patient's ien
 ;        TEST = ien of lab test in file 60
 ;       RANGE = date range in format nY, nM, nW, nD ; default is 6M
 ;        NULL = Text to be return if nothing found (optional)
 ;
 N AOVLAB,LRDFN,GMTS1,X2,GMTS2,GMTSI,MAX
 K ^TMP("LRS",$J)
 S AOVLAB=$G(^LAB(60,TEST,0))
 Q:AOVLAB="" "Lab test error ien="_TEST
 S LRDFN=$G(^DPT(DFN,"LR"))
 Q:'LRDFN $$SPACE("No Labs for this patient",35)
 D GMTSSET,^GMTSLRSE
 Q:'$D(^TMP("LRS",$J)) $S($D(NULL):NULL,1:$$SPACE("No "_$P(AOVLAB,U)_" in the last "_RANGE,35))
 S AOVLAB=0,AOVLAB=$O(^TMP("LRS",$J,1,AOVLAB)),AOVLAB=^(AOVLAB)
 S TEST=$$SPACE($P(AOVLAB," "),9) ; date of test
 S TEST=TEST_$$SPACE($P($P(AOVLAB,U,3),";",2),19) ; name of test
 ;I +$P(AOVLAB,U,4)'=0 S TEST=TEST_$$SPACE($J($P(AOVLAB,U,4),6,2),6)
 ;E  S TEST=TEST_$$SPACE($P(AOVLAB,U,4),6) ; used for test results
 S TEST=TEST_$$SPACE($J($P(AOVLAB,U,4),6,2),6)
 ; **replaced above lab =0 not using any plain text at this time
 ; **not working.
 S TEST=TEST_$$SPACE($P(AOVLAB,U,5),1)
 W "."
 K ^TMP("LRS",$J)
 Q TEST
GMTSSET ; -- sets up required variables for health summary calls
 I '$D(RANGE) S RANGE="6M"
 S GMTS1=9999999-(DT+1) ;reverse date time first date
 S X2=+RANGE*$S(RANGE["Y":365,RANGE["M":31,RANGE["W":7,RANGE["D":1,1:1)*-1
 S X1=DT D C^%DTC
 S GMTS2=9999999-$P(X,".") ;reverse dt/tm last date
 S GMTSI=1,MAX=1
 Q
REST ; -- one time to convert unsigned and send alert
 S GMRDA=0 F  S GMRDA=$O(^GMR(121,GMRDA)) Q:GMRDA<1  D
 . F A=0,5 S GMRDA(A)=$G(^GMR(121,GMRDA,A))
 . Q:'$P(GMRDA(0),U,2)
 . Q:$P($G(^DPT($P(GMRDA(0),U,2),0)),U,21)
 . S TIUDA=$G(^GMR(121,"CNV",GMRDA)) Q:'TIUDA
 . Q:$P(GMRDA(5),U)
 . Q:'$P(GMRDA(5),U,2)
 . F A=0,12 S TIUDA(A)=$G(^TIU(8925,TIUDA,A))
 . Q:$P(TIUDA(0),U,5)'=6
 . Q:$P(TIUDA(12),U,8)
 . S DIE=8925,DR="1208///`"_$P(GMRDA(5),U,2),DA=TIUDA D ^DIE
 . D SEND^TIUALRT(TIUDA)
 . W "."
 Q
DEL(TIUDA) ;
 N DIR,X,Y,REASON,DIRUT,OTHER,XMSUB,XMZ,XMDUZ,%,XMY,DAT
 D FULL^VALM1
 W !,"This will send a request for deletion of this document"
 W !,"to Medical Information Service."
 S DIR(0)="S^1:ENTERED ON WRONG PATINET;2:DUPLICATE NOTE;3:MAJOR REVISION NEEDED;4:OTHER"
 S DIR("A")="REASON FOR REQUEST" D ^DIR Q:$D(DIRUT)  S REASON=Y
 I REASON=4 D   Q:$D(DIRUT)
 . S DIR(0)="F^3:75",DIR("A")="SPECIFY OTHER REASON"
 . D ^DIR S OTHER=Y
 W !,"ARE YOU READY TO RELEASE THIS REQUEST: " S %=1 D YN^DICN Q:%'=1
 F DAT=0,12 S DAT(DAT)=$G(^TIU(8925,TIUDA,DAT))
 S DAT(2)=$S($P(DAT(0),U,2):$G(^DPT($P(DAT(0),U,2),0)),1:"")
 S XMSUB="TIU NOTE DELETION REQUEST",XMDUZ=DUZ D XMZ^XMA2
 S ^XMB(3.9,XMZ,2,1,0)="A TIU note has been requested to be deleted"
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="         IEN: "_TIUDA
 S ^XMB(3.9,XMZ,2,4,0)="Patient Name: "_$P(DAT(2),U)
 S ^XMB(3.9,XMZ,2,5,0)="         SSN: "_$P(DAT(2),U,9)
 S ^XMB(3.9,XMZ,2,6,0)="Date of Note: "_$$FMTE^XLFDT(+DAT(12))
 S ^XMB(3.9,XMZ,2,7,0)="      Reason: "_$S(REASON=1:"ENTERED ON WRONG PATIENT",REASON=2:"DUPLICATE NOTE",REASON=3:"MAJOR REVION NEEDED",1:"OTHER")
 S ^XMB(3.9,XMZ,2,8,0)=""
 S ^XMB(3.9,XMZ,2,9,0)=$G(OTHER)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^9^9^"_DT
 S XMY("G.TIU DELETION REQUEST")=""
 D ENT1^XMD
 Q
RXTODAY(DFN,TARGET) ; -- entry point for Outpatient rx Object issued today
 N LINE,DA,RX,DAT
 K @TARGET
 S LINE=0
 D ^PSOHCSUM
 S RX="" F  S RX=$O(^TMP("PSOO",$J,RX)) Q:RX=""  D
 . F DA=0,1 S RX(DA)=^TMP("PSOO",$J,RX,DA)
 . Q:$E($P(RX(0),U,5))'="A"&($E($P(RX(0),U,5))'="S")
 . Q:$E($P(^PSDRUG(+$P(RX(0),U,3),0),U,2))="X"
 . Q:+RX(0)'=DT
 . I RX(1)'="" S DA=RX(1) D WRT^GMTSPSO(.DA) S RX(1)=DA
 . S LINE=LINE+1,@TARGET@(LINE,0)=$E($P($P(RX(0),U,3),";",2),1,80)
 . S LINE=LINE+1,@TARGET@(LINE,0)="   "_$TR($E(RX(1),1,77),"*")
 . W "."
 I LINE=0 S LINE=1,@TARGET@(1,0)="No Outpatient Medications issued today"
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q "~@"_$NA(@TARGET)
FIX ;
 N DFN,A,TYPE,DR,DIE,DA
 S DFN=$G(^ZZED("TIU")) F  S DFN=$O(^TIU(8925,DFN)) Q:DFN<1  D
 . F A=0,12,13 S DFN(A)=$G(^TIU(8925,DFN,A))
 . Q:+DFN(0)=1
 . Q:$P(DFN(13),U,3)'="U"
 . S TYPE=$P(DFN(12),U,5) S:TYPE TYPE=$P($G(^SC(TYPE,0)),U,3)
 . S DR=$P(DFN(0),U,3)
 . I DR,TYPE'="W" S DR=+$G(^AUPNVSIT(DR,0)) D:DR
 . . S DR="1301///"_DR,DIE="^TIU(8925,",DA=DFN
 . . D ^DIE
 . I $P(DFN(12),U,2),'$P(DFN(12),U,4),$P(DFN(0),U,5)=5 D
 . . S DR="1204////"_$P(DFN(12),U,2),DIE="^TIU(8925,",DA=DFN
 . . D ^DIE D SEND^TIUALRT(DFN)
 . S ^ZZED("TIU")=DFN W "."
