PRCPEPKG ;WISC/RFJ-units per issue ;6 Oct 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
EDIT(V1,V2) ;     |-> called to edit invpt v1, item v2
 I '$D(^PRCP(445,+V1,1,+V2,0)) Q
 N D,DATA,INVPT,ITEMDA,MANSRCE,PRCPLOCK,TYPE,UI,UP,WHSESRCE
 S INVPT=+V1,ITEMDA=+V2,TYPE=$P($G(^PRCP(445,+V1,0)),"^",3)
 I TYPE'="S" S WHSESRCE=$O(^PRC(440,"AC","S",0)) I 'WHSESRCE W !!,"YOU DO NOT HAVE A VENDOR (FILE #440) ENTERED AS A SUPPLY WAREHOUSE.",! Q
 K PRCPLOCK S PRCPLOCK(1)="^PRCP(445,"_INVPT_",1,"_ITEMDA_",0)" D LOCK^PRCPU4(.PRCPLOCK,1,10) I '$D(PRCPLOCK) Q
 ;
 ;     |-> unit of issue (whse) = unit of receipts (whse vendor)
 S MANSRCE=$P($G(^PRC(441,ITEMDA,0)),"^",8)_";PRC(440," S:'MANSRCE MANSRCE=""
 I TYPE="W",+MANSRCE,+MANSRCE=WHSESRCE S DATA=$G(^PRC(441,ITEMDA,2,+MANSRCE,0)) I DATA'="" D
 .   S UP=$$UNITVAL^PRCPUX1($P(DATA,"^",8),$P(DATA,"^",7)," per ")
 .   W !?4,"UNIT per PURCHASE (WHSE VENDOR): ",UP
 .   I UP["?" W !,"The UNIT per PURCHASE in the item master file needs to be correctly entered."
 .   I UP'["?" S UI=$$UNIT^PRCPUX1(INVPT,ITEMDA," per ") I UI'=UP W !?4,"THE UNIT per ISSUE SHOULD EQUAL THE UNIT per PURCHASE."
 .   ;     |-> update issue multiples (field 16,16.5) if warehouse
 .   S D=^PRCP(445,INVPT,1,ITEMDA,0)
 .   W !!?5,"ISSUE MULTIPLE   : ",+$P(D,"^",25) I $P(DATA,"^",11),$P(DATA,"^",11)'=$P(D,"^",25) S $P(D,"^",25)=$P(DATA,"^",11) W ?27,"adjusted to: ",$P(D,"^",25)
 .   W !?5,"MINIMUM ISSUE QTY: ",+$P(D,"^",17) I $P(DATA,"^",12),$P(DATA,"^",12)'=$P(D,"^",17) S $P(D,"^",17)=$P(DATA,"^",12) W ?27,"adjusted to: ",$P(D,"^",17)
 .   S ^PRCP(445,INVPT,1,ITEMDA,0)=D
 L -^PRCP(445,INVPT,1,ITEMDA,0)
 Q
 ;
 ;
EDITUI(V1,V2) ;     |-> edit unit per issue and update
 ;     |-> for invpt=v1, item=v2
 I '$D(^PRCP(445,+V1,1,+V2,0)) Q
 N D,D0,DA,DI,DIC,DIE,DQ,DR,INVPT,ITEMDA,ITEMDATA,PRCPUI,TYPE,UI,X,Y
 S INVPT=+V1,ITEMDA=+V2,TYPE=$P(^PRCP(445,INVPT,0),"^",3),ITEMDATA=^PRCP(445,INVPT,1,ITEMDA,0),PRCPUI=$$UNITVAL^PRCPUX1($P(ITEMDATA,"^",14),$P(ITEMDATA,"^",5)," per ")
 S DA(1)=INVPT,DA=ITEMDA,(DIC,DIE)="^PRCP(445,"_INVPT_",1,",DR="4;4.5;"_$S(TYPE="P":"16;16.5;",1:"") W ! D ^DIE I $D(Y) Q
 S UI=$$UNIT^PRCPUX1(INVPT,ITEMDA," per ") I UI=PRCPUI!(UI["?") Q
 I TYPE'="S" D UPDATE^PRCPEPSU(INVPT,ITEMDA)
 Q
 ;
 ;
UNITISS(V1,V2) ;     |-> main edit program for enter/edit inv item
 ;     |-> v1=invpt, v2=item
 N INVPT,ITEMDA
 S INVPT=+V1,ITEMDA=+V2 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 D EDIT(INVPT,ITEMDA)
 W !!?5,"----- you will now have the option to change the issue units -----"
 D EDITUI(INVPT,ITEMDA)
 Q
