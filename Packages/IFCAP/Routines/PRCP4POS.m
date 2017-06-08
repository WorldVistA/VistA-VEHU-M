PRCP4POS ;WISC/RFJ-post init for inventory version 4 ;29 Jun 92
 ;;4.0;IFCAP;;9/23/93
 ;
 ;
START ;start post init
 N DA,DATA,DIK,PRCPX,X
 I '$G(DT) D NOW^%DTC S DT=X
 ;clean up deleted cross references
 W !!,"Cleaning Up Old Cross References..."
 K ^DD(445.3,0,"IX","AE",445.3,.01)
 K ^DD(445.37,0,"IX","AC",445.37,1)
 K ^DD(445.3,.01,1,2)
 K ^DD(445.37,1,1)
 K ^DD(445.2,0,"IX","ABEG",445.2,2.5),^DD(445.2,0,"IX","AC",445.2,4)
 K ^DD(445.2,2.5,1),^DD(445.2,4,1,1)
 ;delete screen
 K ^DD(445.01,22,12),^DD(445.01,22,12.1)
 K ^DD(445.03,.01,12),^DD(445.03,.01,12.1)
 K ^DD(445.122,.01,12),^DD(445.122,.01,12.1)
 K ^DD(445.3,3.5,12),^DD(445.3,3.5,12.1)
 K ^DD(445.3,7,12),^DD(445.3,7,12.1)
 K ^DD(445.37,.01,12),^DD(445.37,.01,12.1)
 ;delete output transform
 K ^DD(446.4,.1,2),^DD(446.4,.1,2.1)
 ;remove old identifiers
 K ^DD(445,0,"ID","Z1")
 K ^DD(445.07,0,"ID","Z1")
 K ^DD(445.121,0,"ID","Z1")
 K ^DD(445.122,0,"ID","Z1")
 K ^DD(445.37,0,"ID","Z1")
 ;
 ;clean up file 445.3
 W !!,"Cleaning Up Distribution Order File (#445.3)..."
 S PRCPX=0 F  S PRCPX=$O(^PRCP(445.3,PRCPX)) Q:'PRCPX  S DATA=$G(^PRCP(445.3,PRCPX,0)) D
 .   I $P(DATA,"^",2)=$P(DATA,"^",3) D DELORD^PRCPOPO1(PRCPX) Q
 .   I $P(DATA,"^",6)="P"!($P(DATA,"^",6)="F") D DELORD^PRCPOPO1(PRCPX) Q
 .   I '$D(^PRCP(445,+$P(DATA,"^",2),0)) D DELORD^PRCPOPO1(PRCPX) Q
 .   I '$D(^PRCP(445,+$P(DATA,"^",3),0)) D DELORD^PRCPOPO1(PRCPX) Q
 ;
 W !!,"Cleaning Up Storage Location File (#445.4)..."
 S PRCPX=0 F  S PRCPX=$O(^PRCP(445.4,PRCPX)) Q:'PRCPX  S DATA=$G(^(PRCPX,0)) I '$D(^PRCP(445,+$P(DATA,"^",2),0)) S DIK="^PRCP(445.4,",DA=PRCPX D ^DIK
 ;
 W !!,"Cleaning Up Group Category File (#445.6)..."
 S PRCPX=0 F  S PRCPX=$O(^PRCP(445.6,PRCPX)) Q:'PRCPX  S DATA=$G(^(PRCPX,0)) I '$D(^PRCP(445,+$P(DATA,"^",2),0)) S DIK="^PRCP(445.6,",DA=PRCPX D ^DIK
 ;
 ;redirect barcode pointers
 S X=$O(^PRCT(446.6,"B","INTERMEC TRAKKER 9440",0)) I X S %=0 F  S %=$O(^PRCT(446.4,%)) Q:'%  I $D(^PRCT(446.4,%,0)) S $P(^(0),"^",9)=X
 S X=$O(^PRCT(446.6,"B","LABEL 3X1/INTERMEC 8646",0)) I X S %=0 F  S %=$O(^PRCT(446.5,%)) Q:'%  I $D(^PRCT(446.5,%,0)) S $P(^(0),"^",6)=X
 ;
 ;recompile print labels
 W !!,"Recompiling Print Labels Entries..."
 F PRCPX="PRIMARY/SECONDARY LABEL","WAREHOUSE LABEL","TEST/LABEL 3X1","EXPENDABLE INVENTORY","RUN IRL PROGRAM" S DA=+$O(^PRCT(446.5,"B",PRCPX,0)) I $D(^PRCT(446.5,DA,0)) D
 .   I PRCPX="TEST/LABEL 3X1",'$D(^PRC(440,0)) Q
 .   W !!,"recompiling ",PRCPX D COMP^PRCTRED
 ;
 ;change barcode routine prcpbar to prcpubar
 S X=0 F  S X=$O(^PRCT(446.4,X)) Q:'X  S %=$P($G(^(X,0)),"^",4) I %["PRCPBAR" S $P(^PRCT(446.4,X,0),"^",4)=$S(%="EN1-PRCPBAR":"PHYSICAL-PRCPUBAR",%="EN2-PRCPBAR":"USAGE-PRCPUBAR",1:"")
 ;
 ;add PRCP options which were deleted from PRC
 N %,ADDOPT,DISPLAY,OPTION,PRCPOPT
 S U="^" F %=1:1 S X=$P($T(OPTION+%),";",3,99) Q:X=""  S OPTION(%)=$O(^DIC(19,"B",$P(X,"^"),0)),DISPLAY(%)=$P(X,"^",2,3)
 S PRCPOPT=$O(^DIC(19,"B","PRCHPM RA MENU",0)) I PRCPOPT F ADDOPT=1,2,3,4 I OPTION(ADDOPT) D ADDOPT(PRCPOPT,OPTION(ADDOPT),+$P(DISPLAY(ADDOPT),"^"))
 S PRCPOPT=$O(^DIC(19,"B","PRCHUSER PPM",0)) I PRCPOPT F ADDOPT=1,2,3,4 I OPTION(ADDOPT) D ADDOPT(PRCPOPT,OPTION(ADDOPT),+$P(DISPLAY(ADDOPT),"^",2))
 S PRCPOPT=$O(^DIC(19,"B","PRCHUSER COORDINATOR",0)) I PRCPOPT,OPTION(5) D ADDOPT(PRCPOPT,OPTION(5),0)
 Q
 ;
 ;
ADDOPT(V1,V2,V3) ;add option da=v2 to menu option da=v1 ; display order=v3
 ;     |-> option is already in the menu
 I $O(^DIC(19,V1,10,"B",V2,0)) Q
 I '$D(^DIC(19,V1,0))!('$D(^DIC(19,V2,0))) Q
 N D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,X,Y
 I '$D(^DIC(19,V1,10,0)) S ^(0)="^19.01PI^^"
 S DIC="^DIC(19,"_V1_",10,",DIC(0)="L",DLAYGO=19,DA(1)=V1,X=V2 S:V3 DIC("DR")="3///"_V3 D FILE^DICN
 Q
 ;
 ;
 ;;option to add ^ display order (prchpm ra menu) ^ display order (prchuser ppm)
OPTION ;;options to add to menus
 ;;PRCP PPM MENU^20^35
 ;;PRCP INVPT PRIMARY ENTER/EDIT$^25^36
 ;;PRCP INVPT WHSE ENTER/EDIT$^30^37
 ;;PRCPW BUILD RIL FROM SO^14^16
 ;;PRCP POSTED DIETETIC REPORT
