PRCPEIND ;WISC/RFJ-utility for distribution point edit ;24 Dec 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
DELETE(V1,V2) ;     |-> delete invpt v2 as a distrpt for invpt v1
 I '$D(^PRCP(445,+V1,2,+V2)) Q
 N DA,DIK
 S DIK="^PRCP(445,"_(+V1)_",2,",DA(1)=+V1,DA=+V2 D ^DIK K DIK,DA W ?60,"DELETED"
 Q
 ;
 ;
ADD(V1,V2) ;     |-> add invpt v2 as a distpt for invpt v1
 I '$D(^PRCP(445,+V1,0)) Q
 I '$D(^PRCP(445,+V2,0)) Q
 N D0,DA,DD,DIC,DINUM,DLAYGO,X,Y
 I '$D(^PRCP(445,+V1,2,0)) S ^(0)="^445.03PA^^"
 S DIC="^PRCP(445,"_(+V1)_",2,",DIC(0)="L",DLAYGO=445.03,DA(1)=+V1,(X,DINUM)=+V2 K DD,D0 D FILE^DICN K DA,DLAYGO,DIC,DINUM,X I Y<1 W !,"  UNABLE TO ADD INVENTORY POINT AS A WAREHOUSE DISTRIBUTION POINT."
 Q
