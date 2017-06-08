RJPTFVAR ;RJ WILM DE; SETS UP SITE SPECIFIC VARIABLES; OCT 21 86
 ;;4.0
 D:'$D(DUZ) DT^DICRW
 I '$D(^DIZ(45.00046,0)) W !,"You do not have a PTF SITE PARAMETERS FILE.  You should run ^RJPTINIT and",!,"make sure the ^DIZ global can be accessed from this CPU." Q
 I '$D(^DIZ(45.00046,1,0)) W !,"You do not have a SITE entry in the first global node." D SET
 S (DIC,DIE)="^DIZ(45.00046,",DIC(0)="QEAM",DR=".01:5",DA=1 D ^DIE
 K DIC,DIE,DR,DA Q
SET W !,"I will set up a PTF SITE Location called HOSPITAL.  You may change this name."
 K ^DIZ(45.00046) S ^DIZ(45.00046,1,0)="HOSPITAL",^DIZ(45.00046,"B","HOSPITAL",1)="",^DIZ(45.00046,0)="PTF SITE PARAMETERS^45.00046^1^1" Q
