PRSTHLD ; HISC/WAA - Place record on HOLD ;11/2/89  14:32
 ;;3.5;PAID;;Jan 26, 1995
EN1 ;PUT HOLD ON TIME CARD
 S PP=$P(^PRST(455,0),"^",3)
 S DIC="^PRST(455,PP,1,",DIC(0)="AEQM",DIC("A")="Select EMPLOYEE to Hold: " D ^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) G EX
 S Y=+Y,STAT=$P(^PRST(455,PP,1,Y,0),"^",2)
 I STAT="X" W !,"You can't hold a record that has already been sent.",*7 G EN1
 I STAT="H" W !,"Record is already on HOLD",*7 G EN1
 I STAT'="P" W !,"RECORD must first be verified before it can be placed on hold.",*7 G EN1
 S $P(^PRST(455,PP,1,Y,0),"^",2)="H",^PRST(455,"AH",PP,Y)=""
 W !,"Placed on HOLD"
 G EN1
EN2 ;REMOVE HOLD ON TIME CARD
 S PP=$P(^PRST(455,0),"^",3)
 S DIC="^PRST(455,PP,1,",DIC(0)="AEQM",DIC("A")="Select EMPLOYEE to Release: " D ^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) G EX
 S Y=+Y
 I $P(^PRST(455,PP,1,Y,0),"^",2)'="H" W !,"Record is not on HOLD",*7 G EN2
 S $P(^PRST(455,PP,1,Y,0),"^",2)="P" K ^PRST(455,"AH",PP,Y)
 W !,"Removed from HOLD"
 G EN2
EX K PP,DIC,Y,STAT,DTOUT,DUOUT,%,%H,%W,%Y,DISYS,I,SN,X,Y,Z Q
