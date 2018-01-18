A1A1OIG ;ALB/MLI,MAF - OIG Request for C&P Audit Information ; 15 Jun 94
 ;;Version 2.0
 ;
 ; OIG C&P DATA EXTRACT
 ;
 ; Call tag QUEUE to queue this report to run.
 ;
 ; DO NOT RUN THIS ROUTINE IN TRAINING ACCOUNTS!!!  IT SHOULD ONLY
 ; BE RUN IN YOUR PRODUCTION ACCOUNTS!
 ;
QUEUE ; queue OIG request to run
 ;
 I $G(^VA(200,+$G(DUZ),0))']"" W !!,*7,"The variable DUZ must be set to a valid user number before continuing!!" G QUEUEQ
 W !,"This routine will retrieve demographic data for all inpatients"
 W !,"at 9:00 on the following days " F A1A1X=1,2,3 S Y=$$ASOFDT() X ^DD("DD") W $P(Y,"@") W:A1A1X'=3 ", "
 W ".",!,"This routine should ONLY be run in your production account and"
 W !,"should be run during non-peak hours.",!
 W !!,"First, I'm going to add the OIG mailgroup to your system to allow you to",!,"receive error messages regarding transmission problems to the Q-OIG domain."
 S DIC="^XMB(3.8,",X="OIG",DIC(0)="L" D ^DIC
 W !,"Mail group ",$S($P(Y,"^",3)=1:"added",1:"already exists"),".  Please add members as appropriate.",!
 I $P(Y,"^",3) S DIE=DIC,DA=+Y,DR="4///PU" D ^DIE
 K A1A1X,DA,DIC,DIE,DR,X,Y
 S ZTDESC="A1A1 OIG INPATIENT REQUEST",ZTRTN="EN^A1A1OIG",ZTIO=""
 D ^%ZTLOAD
 I '$G(ZTSK) W !,*7,"Job aborted!"
 I $G(ZTSK) W !,"Task ",ZTSK," has been queued to run."
QUEUEQ K ZTDESC,ZTIO,ZTRTN,ZTSK
 Q
 ;
 ;
EN ; called from queue line - NOT for direct calling
 S A1A1X="" F A1A1X=1,2,3 D EN1
 K A1A1X Q
EN1 K ^TMP("A1A1OIG",$J)
 D NOW^%DTC S A1A1BEG=%
 S (A1A1ADT,VAINDT)=$$ASOFDT() ; date to check admissions as of
 S A1A1SITE=+$P($$SITE^VASITE($P(A1A1ADT,".")),"^",3) ; facility number
 K A1A1BL S $P(A1A1BL," ",20)="" ; blanks
 S A1A1CNT=0
 I A1A1SITE'?3N S A1A1TEXT(1)="Site numbers not defined properly!  The OIG Data Extract did NOT run!" D BULL^A1A1OIG1 G QUIT
 S A1A1WD="" F  S A1A1WD=$O(^DPT("CN",A1A1WD)) Q:A1A1WD=""  D
 .F DFN=0:0 S DFN=$O(^DPT("CN",A1A1WD,DFN)) Q:'DFN  D INPTCK
 F A1A1DT=A1A1ADT:0 S A1A1DT=$O(^DGPM("AMV3",A1A1DT)) Q:'A1A1DT  D
 .F DFN=0:0 S DFN=$O(^DGPM("AMV3",A1A1DT,DFN)) Q:'DFN  D INPTCK
 D MAIL^A1A1OIG1
QUIT K A1A1ADND,A1A1ADT,A1A1BEG,A1A1BL,A1A1CNT,A1A1DT,A1A1DPT,A1A1END,A1A1I,A1A1MSG,A1A1PTF,A1A1SITE,A1A1WD,A1A1X
 K %,DFN,VADMVT,VAINDT,X,Y,^TMP("A1A1OIG")
 Q
 ;
 ;
INPTCK ; check to see if patient was inpatient.  if yes, store for transmission
 N I,X,X1,X2
 I $D(^TMP("A1A1OIG",$J,"DFN",DFN)) Q  ; skip if already got
 F I=0,.29,.3,.31,.36,.362 S A1A1DPT(I)=$G(^DPT(DFN,I))
 I A1A1DPT(0)']"" Q
 D ADM^VADPT2 I 'VADMVT Q  ; get IEN of admission if inpt on date
 S A1A1ADND=$G(^DGPM(VADMVT,0)),A1A1PTF=+$P(A1A1ADND,"^",16)
 I A1A1ADND']"" Q
 S X1=$G(^DIC(42,+$P(A1A1ADND,"^",6),0))
 S X2=$P($G(^DG(40.8,+$P(X1,"^",11),0)),"^",2) I X2']"" S X2=A1A1SITE
 S X=$E(X2_A1A1BL,1,6) ; site/suff
 S X=X_$E($P(A1A1DPT(0),"^",1)_A1A1BL,1,20)_$E($P(A1A1DPT(0),"^",9)_A1A1BL,1,10) ; name_ssn
 S X=X_$$DATE(+A1A1ADND)_$E($P(X1,"^",3)_A1A1BL,1,3) ; adm date_service
 S X1=$O(^DGPT(A1A1PTF,"M","AM",0)),X1=$O(^(+X1,0)),X1=$G(^DGPT(A1A1PTF,"M",+X1,0)) ; 1st 501 mvt
 S X1=$G(^ICD9(+$P(X1,"^",5),0)),X=X_$E($P(X1,"^",1)_A1A1BL,1,7) ; icd9
 S X=X_$E($P($G(^DIC(8,+A1A1DPT(.36),0)),"^",9)_A1A1BL,1,2) ; elig
 S X1=$P(A1A1DPT(.29),"^",12),X=X_$E(X1_A1A1BL,1) ; rated incompetent
 S X=X_$$YN($P(A1A1DPT(.3),"^",1)) ; sc?
 F I=12,13,14 S X=X_$$YN($P(A1A1DPT(.362),"^",I)) ; a&a, hb, pen
 S X1=+$P(A1A1DPT(.31),"^",4) S X=X_$E($S(X1?3N:X1,1:"")_A1A1BL,1,3) ; claims folder location
 S X=X_$E($P(A1A1DPT(.31),"^",3)_A1A1BL,1,10) ; claim number
 S X=X_$E(A1A1ADT,7) ;Date of stay
 S X=X_"#"
 S A1A1CNT=A1A1CNT+1,A1A1MSG=1+(A1A1CNT\200) ; 200 messages/batch
 S ^TMP("A1A1OIG",$J,"TXT",A1A1MSG,A1A1CNT)=X,^TMP("A1A1OIG",$J,"DFN",DFN)=""
 Q
 ;
 ;
DATE(X) ; return in mmddyyyy format
 N Y
 S Y="        "
 I $P(X,".",1)?7N S Y=$E(X,4,5)_$E(X,6,7)_(1700+$E(X,1,3))
 Q Y
 ;
 ;
YN(X) ; returns 1 for YES, 0 for NO, or blank for UNKNOWN or unanswered
 Q $S(X="Y":1,X="N":0,1:" ")
 ;
 ;
ASOFDT() ; return as of date for report
 I A1A1X=1 Q 2940607.0900
 I A1A1X=2 Q 2940608.0900
 I A1A1X=3 Q 2940609.0900
