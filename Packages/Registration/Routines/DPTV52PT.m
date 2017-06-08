DPTV52PT ;ALB/MTC - DPT POST INIT FOR VERSION 5.2 ; 7/6/92
 ;;5.2;PATIENT FILE;;JUL 29,1992
 ;
 I DGVCUR<5.11 D DPTFIX,CLINQ
 Q
 ;
DPTFIX ;delete fields .094, .095, .098 and .099 from the PATIENT file DD
 ;run through all patients and set pieces to null
 ;also sets the 4th and 5th pieces of the .3 node to "" for insurance
 ;and remove the *DATE EMBOSSED multiple (#39) along with data.
 ;
 W !!,">>> Removing fields .094 (*SENSITIVITY), .095 (*PSEUDO-PATIENT), .098 (*EMPLOYEE)",!?3,"and .099 (*ADDITIONAL NON-VET ELIG.?) from the PATIENT file..."
 S DIK="^DD(2,",DA(1)=2 F DA=.094,.095,.098,.099 I $D(^DD(2,DA,0)) W !,"   ...",$P(^(0),"^",1)," deleted" D ^DIK
 W !!,">>> Removing the *DATE EMBOSSED multiple from the PATIENT file..."
 S DIU=2.39,DIU(0)="S" D EN^DIU2 ;delete multiple
 ;
 W !!,">>> Please be patient...removing data for these fields from the PATIENT file,"
 W !,"    Converting all DOMICILLIARY eligibilities, and removing bad scheduling",!,"    nodes from the PATIENT file..."
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  W:'(DFN#100) "." D FIXMORE
 ;
 K DA,DFN,DGDOM,DIK,DIU
 Q
 ;
FIXMORE ;set pieces to null, kill of stray nodes
 ;
 N DGX
 I $D(^DPT(DFN,0)) S $P(^(0),"^",13,14)="^",$P(^(0),"^",17)=""
 I $D(^DPT(DFN,.02)) K ^(.02)
 I $D(^DPT(DFN,.3)) S $P(^(.3),"^",4,5)="^"
 I $D(^DPT(DFN,39)) K ^(39)
 ;
 ;if designee street 1 more than 30 characters, set to 30
 I $D(^DPT(DFN,.34)) S X=$P(^(.34),"^",3) I $L(X)>30 S DIE="^DPT(",DA=DFN,DGX=$E(X,1,30),DR=".343////^S X=DGX" D ^DIE K DA,DIE,DR
 ;
 ;populate new 'flat' ELIGIBLE FOR MEDICAID field with disposition data
 I '$D(^DPT(DFN,.38)) S X=$O(^DPT(DFN,"DIS",0)),X=$G(^(+X,0)) I X S ^DPT(DFN,.38)=+$P(X,"^",12)_"^"_+X
 ;
 Q
 ;
CLINQ ; tag to queue clinic workload report clean-up
 W !!,">>> Queuing Clinic Workload Report clean-up."
 D NOW^%DTC
 S ZTIO="",ZTDTH=%H,ZTRTN="CLINCLN^DPTV52PT",ZTDESC="MAS v5.2 Post-Init Job."
 D ^%ZTLOAD,^%ZISC
 K ZTDTH,ZTRTN,ZTDESC,ZTIO
 Q
 ;
CLINCLN ; find and clean-up corrupt nodes from clinic workload report
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . F DGDATE=2871001:0 S DGDATE=$O(^DPT(DFN,"S",DGDATE)) Q:'DGDATE  F X=0:0 S X=$O(^DPT(DFN,"S",DGDATE,X)) Q:'X  I X>99,(X<1000),(^(X)=0) K ^(X)
 D IMDONE
 K DA,DFN,DGDATE,DGX,DIK,DIU
 Q
 ;
IMDONE ; generate mailman message when clinic workload clean-up is complete
 N DGCW
 S XMDUZ=.5,XMY(DUZ)="",XMY(.5)="",DGCW(1)="Clean-up of corrupt nodes from the Clinic Workload Report is completed.",XMTEXT="DGCW(",XMSUB="DPT POST-INIT JOB COMPLETE"
 D ^XMD
 K XMY,XMTEXT,XMSUB
 Q
 ;
