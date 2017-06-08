PRCPEITC ;WISC/RFJ-average and last cost edit ;31 Jan 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
COSTEDIT(V1,V2) ;     |-> edit average and last cost for invpt v1 and item v2
 N %,D0,DA,DI,DIC,DIE,DQ,DR,DZ,COST,D,DATA,INVPT,ITEMDA,STRING,TYPE,X,Y
 S INVPT=+V1,ITEMDA=+V2,DATA=$G(^PRCP(445,INVPT,1,ITEMDA,0)) I DATA="" Q
 S TYPE=$P(^PRCP(445,INVPT,0),"^",3)
 S DA(1)=INVPT,DA=ITEMDA,(DIC,DIE)="^PRCP(445,"_INVPT_",1,",DR="4.7LAST COST;"_$S(TYPE="W":"",1:"4.8AVERAGE COST") D ^DIE K DIC,DIE,DA,DR
 I TYPE'="P" Q
 S DATA=^PRCP(445,INVPT,1,ITEMDA,0),COST=+$J($P(DATA,"^",7)*$P(DATA,"^",22),0,2)
 I COST'=+$P(DATA,"^",27) S $P(^PRCP(445,INVPT,1,ITEMDA,0),"^",27)=COST W !!?5,"Total Inventory Item Value Adjusted from ",+$P(DATA,"^",27),"  to  ",COST
 Q
