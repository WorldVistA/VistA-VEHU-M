PRCPEINV ;WISC/RFJ-enter, edit inventory point parameters ;24 Dec 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
EDIT ;     |-> called from label primary and whse to edit inventory point
 N %,D,D0,DA,DI,DIC,DIE,DQ,DR,PRCPTYPE,PRCPFLAG,IP,IPNM,INVPTNM,X,Y
 W !?5,"INVENTORY POINT HAS '",+$P($G(^PRCP(445,INVPTDA,1,0)),"^",4),"' ITEMS STORED IN IT."
 S DIE="^PRCP(445,",DA=INVPTDA,DR="[PRCP INVENTORY POINT]",PRCPTYPE=$P(^PRCP(445,DA,0),"^",3),PRCPPRIV=1 D ^DIE K PRCPPRIV,D0,DA,DIC,DIE,DR I $D(Y) Q
 S PRCPTYPE=$P(^PRCP(445,INVPTDA,0),"^",3) Q:"WP"'[PRCPTYPE
 ;     |-> edit control points
 S PRCPFLAG=1,INVPTNM=$$INVNAME^PRCPUX1(INVPTDA) F  D  Q:'$G(PRCPFLAG)
 .   W !!,"Select the CONTROL POINT(s) that should be used when replenishing stock.",!,"Current CONTROL POINT(s) assigned to INVENTORY POINT: ",INVPTNM
 .   S %="" F  S %=$O(^PRC(420,"AE",INVPTDA,PRC("SITE"),%)) Q:'%  W !?5,$P($G(^PRC(420,PRC("SITE"),1,%,0)),"^")
 .   S DIC("W")="W ?32,""  INV.PT: "",$P($G(^PRCP(445,+$P($G(^PRC(420,PRC(""SITE""),1,Y,0)),U,16),0)),U)",DIC="^PRC(420,"_PRC("SITE")_",1,",DA(1)=PRC("SITE"),DIC(0)="QEAMZ"
 .   S DIC("S")=$S(PRCPTYPE="W":"I $P(^(0),U,12)=2,",1:"I $P(^(0),U,12)'=2,")_"$O(^PRC(420,PRC(""SITE""),1,+Y,1,0))" W ! D ^DIC K DA,DIC I Y<1 S PRCPFLAG=0 K:$D(DUOUT)!($D(DTOUT)) PRCPFLAG Q
 .   S DA=+Y,IP=+$P(^PRC(420,PRC("SITE"),1,DA,0),"^",16),IPNM=$$INVNAME^PRCPUX1(IP)
 .   I IP W !!,"WARNING -- THIS CONTROL POINT IS ALREADY ASSIGNED TO: ",IPNM I IP=INVPTDA D  Q
 .   .   S XP="  DO YOU WANT TO REMOVE IT FROM THE CONTROL POINT",XH="  ENTER 'YES' TO REMOVE THE INVENTORY POINT FROM THE CONTROL POINT,",%=1 D YN^PRCPU4 Q:%'=1
 .   .   S DIE="^PRC(420,"_PRC("SITE")_",1,",DA(1)=PRC("SITE"),DR="17///@" D ^DIE K DA,DIE,DR
 .   S XP="  ARE YOU SURE YOU WANT TO ASSIGN INVENTORY POINT "_INVPTNM,XP(1)="  TO THIS CONTROL POINT",XH="  ENTER 'YES' TO ASSIGN THE INVENTORY POINT TO THE CONTROL POINT.",%=$S('IP:1,1:2) D YN^PRCPU4
 .   I %=1 S DIE="^PRC(420,"_PRC("SITE")_",1,",DA(1)=PRC("SITE"),DR="17////"_INVPTDA D ^DIE K DA,DIE,DR
 Q:'$D(PRCPFLAG)
 ;     |-> check who currently distributes to the inventory point
 W !!,"CHECKING INVENTORY POINTS DISTRIBUTING TO '",INVPTNM,"':" W:PRCPTYPE="W" !,"(THERE SHOULD NOT BE ANY)" S DIC("S")=$P($G(^DD(445.03,.01,0)),"^",5,99) I DIC("S")="" K DIC("S")
 S IP=0 F  S IP=$O(^PRCP(445,"AB",INVPTDA,IP)) Q:'IP  S IPNM=$G(^PRCP(445,IP,0)) I IPNM D
 .   W !?5,$P(IPNM,"^"),?40,"TYPE: ",$S($P(IPNM,"^",3)="W":"WAREHOUSE",$P(IPNM,"^",3)="P":"PRIMARY",$P(IPNM,"^",3)="S":"SECONDARY",1:"??")
 .   Q:'$D(DIC("S"))  S DA=IP,X=INVPTDA X DIC("S") K DINUM,DA Q:$D(X)
 .   D DELETE^PRCPEIND(IP,INVPTDA)
 K DIC I PRCPTYPE="P" W !! S IP=0 F  S IP=$O(^PRCP(445,"AC","W",IP)) Q:'IP  S IPNM=$$INVNAME^PRCPUX1(IP) I +IPNM=PRC("SITE") D
 .   I $D(^PRCP(445,IP,2,INVPTDA)) D  Q
 .   .   S XP="THIS PRIMARY INVENTORY POINT '"_INVPTNM_"' IS CURRENTLY DISTRIBUTED",XP(1)="TO BY THE WAREHOUSE INVENTORY POINT '"_IPNM_"'.",XP(2)="  DO YOU WANT TO REMOVE IT AS A WAREHOUSE DISTRIBUTION POINT"
 .   .   S XH="ENTER 'YES' TO REMOVE IT, 'NO' TO LEAVE IT AS A DISTRIBUTION POINT.",%=2 D YN^PRCPU4 Q:%'=1
 .   .   D DELETE^PRCPEIND(IP,INVPTDA)
 .   S XP="WILL THIS PRIMARY INVENTORY POINT '"_INVPTNM_"' BE A",XP(1)="DISTRIBUTION POINT FOR THE WAREHOUSE INVENTORY POINT '"_IPNM_"'",XH="ENTER 'YES' TO ADD THE PRIMARY AS A WAREHOUSE DISTRIBUTION POINT.",%=1 D YN^PRCPU4 Q:%'=1
 .   D ADD^PRCPEIND(IP,INVPTDA)
 Q
 ;
 ;
WHSE ;     |-> warehouse entry point
 N %,INVPTDA,Y
 S %F="S" D ^PRCFSITE Q:'$G(PRC("SITE"))  W !!!,"Station Number: ",PRC("SITE") S INVPTDA=+$$INVPT^PRCPUINV(PRC("SITE"),"W",1,0,"") Q:'INVPTDA
 D EDIT G WHSE
 ;
 ;
PRIMARY ;     |-> primary inventory point enter and edit
 N %,INVPTDA,Y
 S %F="S" D ^PRCFSITE Q:'$G(PRC("SITE"))  W !!!,"Station Number: ",PRC("SITE") S INVPTDA=+$$INVPT^PRCPUINV(PRC("SITE"),"P",1,0,"") Q:'INVPTDA
 D EDIT G PRIMARY
 ;
 ;
ALLPTS ;     |-> called to edit inventory points and distribution points
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N INVPTDA
 S INVPTDA=PRCP("I") D EDIT Q:"WP"'[PRCP("DPTYPE")  W !!!!,"You can now edit the ",PRCP("IN")," distribution inventory points:"
DISTR S INVPTDA=+$$INVPT^PRCPUINV(PRC("SITE"),$S(PRCP("DPTYPE")="W":"P",PRCP("DPTYPE")="P":"S",1:""),1,1,"") Q:'INVPTDA
 I '$D(^PRCP(445,PRCP("I"),2,INVPTDA,0)) S XP="Do you want to add this inventory point as a "_PRCP("IN"),XP(1)="     distribution point",XH="Enter 'YES' to add it as a distribution point, 'NO' or '^' to exit.",%=1 D  G:%'=1 DISTR
 .   D YN^PRCPU4 Q:%'=1
 .   D ADD^PRCPEIND(PRCP("I"),INVPTDA)
 .   S %=1
 D EDIT G DISTR
