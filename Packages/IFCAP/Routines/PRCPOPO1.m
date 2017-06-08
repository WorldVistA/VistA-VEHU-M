PRCPOPO1 ;WISC/RFJ-actual posting of distribution order ;28 Sep 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
POST ;     |-> start posting
 ;     |-> overpost=1 to post in negative; overpost=0 to backorder
 N %,CONV,DATAITEM,DATAORD,ITEMDA,PRIORDNO,PRCPID,PRCPOPO1,QTY,SECORDNO,TOTCOST,X,XH,XP,Y
 W !!,"Posting Distribution Order..."
 S PRIORDNO=0 I $P(^PRCP(445,PRCP("I"),0),"^",6)="Y" S PRIORDNO=$$ORDERNO^PRCPUTR(PRCP("I"))
 S SECORDNO=0 I $P(^PRCP(445,SECONDA,0),"^",6)="Y" S SECORDNO=$$ORDERNO^PRCPUTR(SECONDA)
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"POST",ITEMDA)) Q:'ITEMDA  S QTY=^(ITEMDA) I QTY D
 .   S DATAORD=^PRCP(445.3,ORDERNO,1,ITEMDA,0),DATAITEM=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   ;     |-> only post up to the quantity on hand (if overpost'=1)
 .   I '$G(OVERPOST),QTY>$P(DATAITEM,"^",7) S QTY=$P(DATAITEM,"^",7) I QTY<0 S QTY=0
 .   S TOTCOST=$J(QTY*$P(DATAORD,"^",3),0,2)
 .   ;
 .   ;     |-> decrement qty ordered and create backorder if necessary
 .   S $P(DATAORD,"^",2)=$P(DATAORD,"^",2)-QTY D
 .   .   I $P(DATAORD,"^",2)>0 S $P(DATAORD,"^",4)=$P(DATAORD,"^",2),^PRCP(445.3,ORDERNO,1,ITEMDA,0)=DATAORD Q
 .   .   D DELITEM(ORDERNO,ITEMDA)
 .   ;
 .   I 'QTY Q
 .   ;
 .   ;     |-> update primary
 .   K PRCPOPO1 S PRCPOPO1("QTY")=-QTY,PRCPOPO1("INVVAL")=-TOTCOST,PRCPOPO1("SELVAL")=-TOTCOST,PRCPOPO1("OTHERPT")=SECONDA
 .   D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"R",PRIORDNO,.PRCPOPO1)
 .   ;
 .   ;     |-> update secondary
 .   K PRCPOPO1 S PRCPOPO1("QTY")=QTY*$P($$GETVEN^PRCPUVEN(SECONDA,ITEMDA,PRCP("I")_";PRCP(445,",1),"^",4)
 .   S PRCPOPO1("INVVAL")=TOTCOST,PRCPOPO1("SELVAL")=TOTCOST,PRCPOPO1("OTHERPT")=PRCP("I")
 .   D ITEM^PRCPUUIP(SECONDA,ITEMDA,"RC",SECORDNO,.PRCPOPO1)
 W !,"Posting Completed !"
 ;
 ;     |-> remove items from order with 0 qty
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERNO,1,ITEMDA)) Q:'ITEMDA  I $P($G(^(ITEMDA,0)),"^",2)'>0 D DELITEM(ORDERNO,ITEMDA)
 ;
 I '$O(^PRCP(445.3,ORDERNO,1,0)) W !!,"Removing Distribution Order..." D DELORD(ORDERNO)
 ;     |-> set to backordered
 I $D(^PRCP(445.3,ORDERNO,0)) S $P(^(0),"^",6)="B" D
 .   W !!,"The Distribution Order is now BACKORDERED!"
 .   S XP="  Would you like to make this order a FINAL and REMOVE it from",XP(1)="  the system",XH="  Enter 'YES' to remove this order from the system.",XH(1)="  Enter 'NO' or '^' to leave it as backordered.",%=2
 .   D YN^PRCPU4 I %=1 D CANCEL
 Q
 ;
 ;
DELITEM(V1,V2) ;     |-> remove item v2 from order v1
 I '$D(^PRCP(445.3,+V1,1,+V2,0)) Q
 N %,DA,DIC,DIK,X,Y
 S DA(1)=+V1,DA=+V2,DIK="^PRCP(445.3,"_V1_",1," D ^DIK Q
 ;
 ;
DELORD(V1) ;     |-> remove order v1
 I '$D(^PRCP(445.3,+V1,0)) Q
 N %,DA,DIC,DIK,X,Y
 S DA=+V1,DIK="^PRCP(445.3," D ^DIK Q
 ;
 ;
CANCEL ;     |-> cancel order and remove it from the system
 W !!?2,"Decrementing Due-Outs in the Primary and Due-Ins in the Secondary..."
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERNO,1,ITEMDA)) Q:'ITEMDA  S QTY=$P(^(ITEMDA,0),"^",2) I QTY D
 .   I $D(^PRCP(445,PRCP("I"),1,ITEMDA,0)) S %=$P(^(0),"^",20)-QTY S:%<0 %=0 S $P(^(0),"^",20)=%
 .   I $D(^PRCP(445,SECONDA,1,ITEMDA,0)) S %=$P(^(0),"^",8)-QTY S:%<0 %=0 S $P(^(0),"^",8)=%
 W !?2,"Deleting Distribution Order..." D DELORD(ORDERNO) W " Finished !"
 Q
