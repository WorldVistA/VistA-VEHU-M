PRCPSPD2 ;WISC/AKS-disassemble set packs for secondaries (cont) ;5 May 92
 ;;4.0;IFCAP;;9/23/93
SEC ; Update secondary inventory location.
 I $G(ORDERNO) K PRCPSPD2 S PRCPSPD2("QTY")=-PRCPQTY,(PRCPSPD2("SELVAL"),PRCPSPD2("INVVAL"))=PRCPCOST D ADDTRAN^PRCPUTR(PRCP("I"),PRCPITEM,"S",ORDERNO,.PRCPSPD2) K PRCPSPD2
 S $P(^(0),U,7)=$P(^PRCP(445,PRCP("I"),1,PRCPITEM,0),U,7)-PRCPQTY
 S PRCPAVG=+$P(Y(0),U,22),PRCPCOST=$S($P(Y(0),U,15)>PRCPAVG:$P(Y(0),U,15),1:PRCPAVG),PRCPUI=$P(Y(0),U,5),PRCPUI=$S($D(^PRCD(420.5,+PRCPUI,0)):$P(^(0),U),1:""),PRCPUR=$S($P(Y(0),U,14):$P(Y(0),U,14)_"/",1:"")_PRCPUI
 Q
W W $C(7),!!,"Enter the quantity "_$S(SLCT=2:"UNUSED",1:"USED")_" for this item (number between 1 and 999999)"
 W !!,"This will decrement the 'quantity on hand' for the Set/Pack specified by 1.",!
 W "It will decrement 'used quantity' from the  items making up the Set/Pack from the secondary location." Q
WD S Z3="",$P(Z3," ",31)=""
 S Z1=$E(PRCPDESC,1,30),Z2=$E(PRCPDESC,31,60) S:$L(Z1)'=30 Z1=Z1_$E(Z3,1,30-$L(Z1))
 W $E("     ",$L(X),5) S ZX=$X+1 W Z1_"     NSN: "_$P(Z,U,5) W:Z2'="" !,?ZX,Z2 K Z,ZX,Z1,Z2,Z3 Q
