SDV51PT ;ALB/MJK,MC - SD POST-INIT FOR VERSION 5.1 DRIVER ;7/5/91  09:55
 ;;MAS VERSION 5.1;
EN I DGVCUR<5.01
 D DIS
 Q
 ;
DIS ;disability condition file stuff for aids related
 W !!," >>> Will now edit your Disability Condition file...",!
 S (DIE,DIC)="^DIC(31,",DIC(0)="MZ" F X=6351,6352,6353 D ^DIC I Y>0 S SDDIS=Y(0,0),DA=+Y,DR="3////CHRONIC DISEASE, UNSPECIFIED" D ^DIE,DISM
 K DA,DE,DIC,DIE,DQ,DR,SDDIS,X,Y Q
DISM W !," ... Sensitive condition print name added for '",SDDIS,"'",!?15,"disability condition ..." Q
