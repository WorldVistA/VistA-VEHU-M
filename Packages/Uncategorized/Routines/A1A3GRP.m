A1A3GRP ;ALB/RMO - CLEAN-UP AMB PROC GROUPS FOR TEST SITES ; 31 JUL 89
 ;
SET ;W !,"Group Name",?40,"Inactive Amb Proc",!,"------------",?40,"-----------------"
 F DGI=0:0 S DGI=$O(^SD(409.3,DGI)) Q:'DGI  S DGNM=$S($D(^(DGI,0)):$P(^(0),"^",1),1:"UNKNOWN") F DGCPT=0:0 S DGCPT=$O(^SD(409.3,DGI,"C",DGCPT)) Q:'DGCPT  D CHKCPT
 ;
Q K DGCPT,DGI,DGNM
 Q
 ;
CHKCPT I $S('$D(^ICPT(DGCPT,"SD")):1,^("SD"):0,1:1) W !,"Inactive ",$S($D(^ICPT(DGCPT,0)):$P(^(0),"^",1),1:"UNKNOWN") S DA(1)=DGI,DA=DGCPT,DIE="^SD(409.3,"_DA(1)_",""C"",",DR=".01///@" D ^DIE K DE,DQ,DIE,DR W !," deleted from group ",DGNM
 Q
