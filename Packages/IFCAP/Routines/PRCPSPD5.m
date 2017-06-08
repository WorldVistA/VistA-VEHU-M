PRCPSPD5 ;WISC/AKS-disassemble set packs (cont) ;6 Oct 92
 ;;4.0;IFCAP;;9/23/93
PRIM ; Update primary inventory location.
 I $G(ORDERNO),PRCPQTY K PRCPSPD5 S PRCPSPD5("QTY")=-PRCPQTY,(PRCPSPD5("SELVAL"),PRCPSPD5("INVVAL"))=PRCPCOST,PRCPSPD5("OTHERPT")=$G(PRCPSRC1) D ADDTRAN^PRCPUTR(PRCP("I"),PRCPITEM,"S",ORDERNO,.PRCPSPD5) K PRCPSPD5
 S $P(^(0),U,7)=$P(^PRCP(445,PRCP("I"),1,PRCPITEM,0),U,7)-PRCPQTY
 ;S PRCPAVG=+$P(Y(0),U,22),PRCPCOST=$S($P(Y(0),U,15)>PRCPAVG:$P(Y(0),U,15),1:PRCPAVG),PRCPUI=$P(Y(0),U,5),PRCPUI=$S($D(^PRCD(420.5,+PRCPUI,0)):$P(^(0),U),1:""),PRCPUR=$S($P(Y(0),U,14):$P(Y(0),U,14)_"/",1:"")_PRCPUI
 Q
SEC ; Update secondary inventory location.
 I $G(ORDERNO),PRCPQTY K PRCPSPD5 S PRCPSPD5("QTY")=PRCPQTY,(PRCPSPD5("SELVAL"),PRCPSPD5("INVVAL"))=PRCPCOST,PRCPSPD5("OTHERPT")=PRCP("I") D ADDTRAN^PRCPUTR(PRCPSRC1,PRCPITEM,"S",ORDERNO,.PRCPSPD5) K PRCPSPD5
 S Y(0)=^PRCP(445,PRCPSRC1,1,PRCPITEM,0)
 S PRCPAVG=+$P(Y(0),U,22),PRCPCOST=$S($P(Y(0),U,15)>PRCPAVG:$P(Y(0),U,15),1:PRCPAVG),PRCPUI=$P(Y(0),U,5),PRCPUI=$S($D(^PRCD(420.5,+PRCPUI,0)):$P(^(0),U),1:""),PRCPUR=$S($P(Y(0),U,14):$P(Y(0),U,14)_"/",1:"")_PRCPUI
 ;S PRCPAVG=((PRCPCOST*PRCPQTY)+(PRCPONH*PRCPOAVG))/(PRCPONH+PRCPQTY),PRCPAVG=+$J(PRCPAVG,0,3)
 ;S $P(^PRCP(445,PRCP("I"),1,ITEMDA,0),U,15)=PRCPCOST,$P(^(0),U,22)=PRCPAVG,$P(^(0),U,3)=PRCPDTI
 D COSTCTR^PRCPUCC(PRCPSRC1,PRCP("I"),$P(^PRCP(445,PRCPSRC1,0),U,7),$J(PRCPCOST*PRCPQTY,0,3))
 Q
W W $C(7),!!,"Enter the quantity "_$S(SLCT=2:"UNUSED",1:"USED")_" for this item (number between 1 and 999999)"
 W !!,"This will decrement the 'quantity on hand' for the Set/Pack specified by 1.",!
 W "It will decrement 'used quantity' from the  items making up the Set/Pack from the Primary location and increment the secondary's on hand quantity by the same amount." Q
WD S Z3="",$P(Z3," ",31)=""
 S Z1=$E(PRCPDESC,1,30),Z2=$E(PRCPDESC,31,60) S:$L(Z1)'=30 Z1=Z1_$E(Z3,1,30-$L(Z1))
 W $E("     ",$L(X),5) S ZX=$X+1 W Z1_"     NSN: "_$P(Z,U,5) W:Z2'="" !,?ZX,Z2 K Z,ZX,Z1,Z2,Z3 Q
