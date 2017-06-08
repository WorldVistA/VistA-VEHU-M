PRCPRPIC ;WISC/AKS-set/pack picking ticket ;30 Nov 92
 ;;4.0;IFCAP;;9/23/93
 ;
 N ITEMDES,ITEMNO,K,M,N,PICKQTY,PITEM,PQTY,PSTO,STOR,X,LN,P,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,UI,UOI,PM
DEVICE K %ZIS S %ZIS("A")="PRINT PICKING TICKET ON DEVICE: ",%ZIS("B")="",%ZIS="Q" D ^%ZIS K %ZIS Q:POP
 I $D(IO("Q")) S ZTDESC="Set Pack Picking Ticket",ZTRTN="RPT1^PRCPRPIC",ZTSAVE("PRCP*")="",ZTSAVE("NSETS")="",ZTSAVE("ITEMDA")="",ZTDTH="",ZTSAVE("ZTREQ")="@",ZTSAVE("CASE")="" D ^%ZTLOAD K ZTSK,IO("Q") Q
 I IO=IO(0) W !,"YOU CANNOT PRINT THE PICKING TICKET ON YOUR TERMINAL.",!,"IF YOU DO NOT WANT TO PRINT THE PICKING TICKET, PRESS '^'.",! G DEVICE
 D RPT1,^%ZISC K ^TMP("PRCPMAIN",$J) Q
RPT1 U IO S PAGE=1 D:'CASE HDR D:CASE HDR1 S M=0,K=1 F  S M=$O(^PRCP(445,PRCP("I"),1,ITEMDA,8,M)) Q:'M  D
 .   S PITEM=+^PRCP(445,PRCP("I"),1,ITEMDA,8,M,0),PQTY=$P(^(0),U,2),PSTO=$$STORAGE^PRCPESTO(PRCP("I"),PITEM) S:PSTO="?" PSTO=" " S UI=$$UNIT^PRCPUX1(PRCP("I"),PITEM,"/")
 .   S ^TMP("PRCPMAIN",$J,PSTO,K)=PITEM_U_$S($D(^PRCP(445,PRCP("I"),1,PITEM,6)):^(6),1:$P(^PRC(441,PITEM,0),U,2))_U_(NSETS*$P(^PRCP(445,PRCP("I"),1,ITEMDA,8,PITEM,0),U,2))_U_UI,K=K+1
 S N="" F  S N=$O(^TMP("PRCPMAIN",$J,N)) Q:N=""  S P=0 F  S P=$O(^TMP("PRCPMAIN",$J,N,P)) Q:P=""  S LN=^(P),STOR=N,ITEMNO=$P(LN,U),ITEMDES=$P(LN,U,2),PICKQTY=$P(LN,U,3),UOI=$E($P(LN,U,4),1,8) D
 .   D:$Y>(IOSL-6) PAGE I $D(X) Q:X["^"
 .   W !!,$J(STOR,13),"   ",$J(ITEMNO,6)," ",$E(ITEMDES,1,32)_$J("",32-$L(ITEMDES))," "_$J(PICKQTY,6),"  ",UOI_$J("",8-$L(UOI)),"  ","______"
 .   D:((IO=IO(0))&($Y>(IOSL-6))) PAGE I $D(X) Q:X["^"
 Q
PAGE Q:'$G(^TMP("PRCPMAIN",$J,N,P+1))  S PAGE=PAGE+1 W:PAGE>1 @IOF D:'CASE HDR D:CASE HDR1 Q
HDR W !,?14,"SET/PACK PICKING TICKET FOR "_$P($P(^PRCP(445,PRCP("I"),0),U),"-",2)_" INVENTORY LOCATION",?81,"PAGE ",PAGE
 W !,?19,"ASSEMBLE ",NSETS," '",$S($D(^PRCP(445,PRCP("I"),1,ITEMDA,6)):^(6),1:$P(^PRC(441,ITEMDA,0),U,2))_"' SET/PACKS"
 W !!,"Storage Location",?17,"Item#",?32,"Item Name",?58,"QTY.",?66,"U/I",?72,"Quantity"
 W !,?73,"Picked"
 Q
HDR1 W !,"CASE NUMBER  NAME  REVISION DATE",?81,"PAGE ",PAGE,!
 W !,"TIME: ____________ SUPPLIES PULLED BY: _____________     DATE: _________",!
 W !,"INSTRUMENTS PULLED BY: _____ ROOM: ___  CART SENT TO TO O.R. (DATE & TIME): ___",!
 W !,"CASE SCHEDULED: _________________________________________",!
 W !,"CASE PULLED: ____________________________________________",!
 W !,"INSTRUMENTS THAT NEED TO BE SAVED FOR THE FOLLOWING CASE:   __________________",!
 W !,"______________________________________________________________________________",!
 W !,"______________________________________________________________________________",!
 W !,"INSTRUMENTS/SUPPLIES/LINEN TO BE ADDED BFORE BEING SENT TO O.R.: _____________",!
 W !,"______________________________________________________________________________",!
 W !,"______________________________________________________________________________",!
 W !,"OF SPECIAL NOTE: _____________________________________________________________",!
 W !,"______________________________________________________________________________",!
 W !,"______________________________________________________________________________",!
 W !,"        LOC          ITEM #        NOMENCLATURE                       QUANTITY RETURNED",!
 Q
