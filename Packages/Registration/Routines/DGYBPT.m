DGYBPT ;MTC/ALB - Post Init for Generic MAS Patch Package - 10-14-92
 ;;5.2;REGISTRATION;**3**;JUL 29,1992
 ;
 D CENSUS
 Q
 ;
CENSUS ;--- add new census date
 W !!,">>> Updating Census Dates..."
 S X=$O(^DG(45.86,"AC",0)) I X S X=$O(^DG(45.86,"AC",X,0)),DIE="^DG(45.86,",DA=X,DR=".04////0" D ^DIE K DIE,DR,DA
 S DIC="^DG(45.86,",X=2920930,DIC(0)="L" K DD,DO D ^DIC K DIC
 S DIE="^DG(45.86,",DA=+Y,DR=".02////2921113;.03////2921127;.04////1;.05////2911001" D ^DIE K DIE,DR,DA
 Q
 ;
