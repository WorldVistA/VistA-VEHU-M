PRCPOEN1 ;WISC/RFJ-distribution order enter, edit items ;6 Nov 92
 ;;4.0;IFCAP;**17**;9/23/93
 Q
 ;
 ;
ITEMS(V1) ;     |-> enter and edit items on distribution order v1
 I '$D(^PRCP(445.3,+V1,0)) Q
 N %,BEGINQTY,C,CONV,D,D0,DA,DI,DIC,DIE,DLAYGO,DQ,DR,I,ITEMDA,ORDERNO,ORDRDATA,PRCPSET,PRCPPRIM,PRIMITEM,PRCPSECO,PRIMARY,QTY,SECOITEM,SECOND,UNITCOST,UNITI,UNITR,VDA,VDATA,X,Y
 S ORDERNO=+V1,ORDRDATA=^PRCP(445.3,ORDERNO,0),PRCPPRIM=+$P(ORDRDATA,"^",2),PRIMARY=$$INVNAME^PRCPUX1(PRCPPRIM),PRCPSECO=+$P(ORDRDATA,"^",3),SECOND=$$INVNAME^PRCPUX1(PRCPSECO)
 S:'$D(^PRCP(445.3,ORDERNO,1,0)) ^(0)="^445.37PIA^^"
 F  D  I '$G(ITEMDA) Q
 .   S DIC="^PRCP(445.3,"_ORDERNO_",1,",DIC(0)="QEALMZO",DLAYGO=445.3,(PRCPSET,DIC("S"))="I $D(^PRCP(445,PRCPPRIM,1,+Y,0))",DA(1)=ORDERNO W ! D ^DIC I Y'>0 S ITEMDA=0 Q
 .   S ITEMDA=+Y,PRIMITEM=^PRCP(445,PRCPPRIM,1,ITEMDA,0)
 .   S UNITCOST=+$P(PRIMITEM,"^",22) I $P(PRIMITEM,"^",15)>UNITCOST S UNITCOST=+$P(PRIMITEM,"^",15)
 .   W !!,"Data for PRIMARY inventory point: ",PRIMARY
 .   S UNITI=$$UNIT^PRCPUX1(PRCPPRIM,ITEMDA," per ")
 .   W !?5,"Quantity On-Hand: ",+$P(PRIMITEM,"^",7),?40,"Unit per Issue: ",UNITI
 .   W !?5,"Quantity Due-Out: ",+$P(PRIMITEM,"^",20),!?5,"Quantity Due-In : ",+$P(PRIMITEM,"^",8),!?12,"Unit Cost: ",UNITCOST
 .   I $P(PRIMITEM,"^",25) W !?2,"Required Issue Mult: ",$P(PRIMITEM,"^",25)
 .   I $P(PRIMITEM,"^",17) W !?4,"Minimum Issue Qty: ",$P(PRIMITEM,"^",17)
 .   ;
 .   S SECOITEM=$G(^PRCP(445,PRCPSECO,1,ITEMDA,0))
 .   W !!,"Data for SECONDARY inventory point: ",SECOND
 .   I SECOITEM="" S CONV=1 W !?5,"ITEM NOT STORED IN SECONDARY INVENTORY POINT",!
 .   E  D
 .   .   W !?5,"Quantity On-Hand: ",+$P(SECOITEM,"^",7),?40,"Unit per Issue: ",$$UNIT^PRCPUX1(PRCPSECO,ITEMDA," per ")
 .   .   S VDATA=$$GETVEN^PRCPUVEN(PRCPSECO,ITEMDA,PRCPPRIM_";PRCP(445,",1),UNITR=$$UNITVAL^PRCPUX1(+$P(VDATA,"^",3),$P(VDATA,"^",2)," per "),CONV=$P(VDATA,"^",4)
 .   .   W !?5,"Quantity Due-In : ",+$P(SECOITEM,"^",8),?40,"Unit per Recpt: ",UNITR,!?37,"Conversion Factor: ",CONV
 .   ;
 .   ;     |-> enter data
 .   I '$P(^PRCP(445.3,ORDERNO,1,ITEMDA,0),"^",3) S $P(^(0),"^",3)=UNITCOST
 .   S BEGINQTY=+$P(^PRCP(445.3,ORDERNO,1,ITEMDA,0),"^",2)
 .   S (DIC,DIE)="^PRCP(445.3,"_ORDERNO_",1,",DA(1)=ORDERNO,DA=ITEMDA,DR="1;"_$S(PRCP("DPTYPE")="P":"2;",1:"") D ^DIE
 .   S QTY=+$P(^PRCP(445.3,ORDERNO,1,ITEMDA,0),"^",2)
 .   ;
 .   ;     |-> if status is released and beginning qty '= current qty
 .   ;     |-> update dueins and dueouts
 .   I $P(ORDRDATA,"^",6)'="",BEGINQTY'=QTY D
 .   .   S X=QTY-BEGINQTY
 .   .   W !!,"<*> Updating DUE-OUTS in primary   ",PRIMARY,?60," by ",X
 .   .   I $D(^PRCP(445,PRCPPRIM,1,ITEMDA,0)) D LOCKINPT^PRCPOEN(PRCPPRIM,"P") S %=$P(^(0),"^",20)+X S:%<0 %=0 S $P(^(0),"^",20)=% L -^PRCP(445,PRCPPRIM,1,ITEMDA)
 .   .   S X=X*CONV
 .   .   W !,"<*> Updating DUE-INS  in secondary ",SECOND,?60," by ",X
 .   .   I $D(^PRCP(445,PRCPSECO,1,ITEMDA,0)) D LOCKINPT^PRCPOEN(PRCPSECO,"S") S %=$P(^(0),"^",8)+X S:%<0 %=0 S $P(^(0),"^",8)=% L -^PRCP(445,PRCPSECO,1,ITEMDA)
 .   I QTY=0 D DELITEM^PRCPOPO1(ORDERNO,ITEMDA) W !!,"** ITEM HAS BEEN DELETED FROM THE ORDER **" Q
 .   I QTY<$P(PRIMITEM,"^",17) W !,"WARNING -- THE QUANTITY IS LESS THAN THE MINIMUM ISSUE QUANTITY"
 .   I $P(PRIMITEM,"^",25)>0 S %=QTY/$P(PRIMITEM,"^",25) I $P(%,".",2)>0 W !,"WARNING -- THE QUANTITY IS NOT A CORRECT REQUIRED ISSUE MULTIPLE"
 Q
