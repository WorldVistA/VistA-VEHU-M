PRCPWPOQ ;WISC/RFJ-enter quantity to post ;17 July 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
QTYD ;     |-> enter quantity to distribute
 S PRCPQTYD=0
 W !,$J("QUANTITY ON-HAND:",30),$J(PRCPQOH,7),!,$J("QUANTITY ORDERED:",30),$J(+$P(PRCPX,"^",2),7),!,$J("QUANTITY DISTRIBUTED:",30),$J(+$P(PRCPX,"^",12),7),!
 I $P(PRCPX,"^",14)="" W $J("QUANTITY OUTSTANDING:",30),$J(PRCPOUT,7) K ^TMP($J,"NOPOST",PRCPLIDA)
 E  W !?5,"ITEM IS CANCELLED",$S($P(PRCPX,"^",14)["S":" AND SUBSTITUTED WITH LINE #(S): "_$P($P(PRCPX,"^",14),",",2,99),1:""),!?5,"YOU CAN ONLY SUBSTITUTE FOR THIS ITEM." G SUBST^PRCPWPOS
QTY W !,$J("Enter QUANTITY to POST:",30),$J(PRCPQTY,7),"// " R X:DTIME I '$T!(X["^") W "  *** NOT POSTING THIS ITEM! ***" S PRCPFLAG=1 Q
 S:X="" X=PRCPQTY S X=$TR(X,"canelsubti","CANELSUBTI") I $E(X)="C" W $P("CANCEL",X,2,3) G CANCEL
 I $E(X)="S" W $P("SUBSTITUTE",X,2,3) G SUBST^PRCPWPOS
 I +X'=X!(X>999999)!(X<0)!(X?.E1"."3N.N) W !,"ENTER THE QUANTITY TO DISTRIBUTE FROM 0 TO ",PRCPQOH
 I  W ",",!,"ENTER 'CANCEL' TO CANCEL THE ITEM WHICH WILL CANCEL THE OUTSTANDING ISSUES,",!,"ENTER 'SUBSTITUTE' TO SUBSTITUTE THE ITEM." G QTY
 I X>PRCPOUT W !,"*** WARNING: THIS IS GREATER THAN THE QUANTITY OUTSTANDING ***",!
 I X>PRCPQOH W !,"*** ERROR: THIS IS GREATER THAN THE QUANTITY ON HAND: ",PRCPQOH," ***" G QTYD
 W "   *** POSTING ",X," ***" S PRCPQTYD=X Q
 ;
 ;
CANCEL S PRCPFLAG=1 I $P(PRCPX,"^",14)["C" W !,"ITEM HAS ALREADY BEEN CANCELLED." Q
 S XP="    ARE YOU SURE YOU WANT TO CANCEL THIS ITEM",XH="    ENTER 'YES' TO SET THE OUTSTANDING ISSUES TO ZERO, 'NO' OR '^' TO FORGET IT.",%=1 W ! D YN^PRCPU4 I %'=1 W !,"    OK, I WILL NOT CANCEL THIS ITEM." Q
CANCELIT ;     |-> cancel the item without asking
 S ^TMP($J,"POST",PRCPLIDA)=0,X=^PRCS(410,PRCPDA,"IT",PRCPLIDA,0),%=$P(X,"^",2)-$P(X,"^",12) S:$P(X,"^",14)'["C" $P(^PRCS(410,PRCPDA,"IT",PRCPLIDA,0),"^",14)="C"_$P(X,"^",14) S:%<0 %=0
 I $D(^PRCP(445,PRCP("I"),1,PRCPITEM,0)) W !?5,"... decrementing due-outs@warehouse by ",% S %=$P(^(0),"^",20)-% S:%<0 %=0 S $P(^(0),"^",20)=%
 I $D(^PRCP(445,PRCPSRC1,1,PRCPITEM,7,PRCPDA,0)) W !?5,"... decrementing due-ins @primary   by ",$P(^(0),"^",2) D KILLTRAN^PRCPUTRA(PRCPSRC1,PRCPITEM,PRCPDA)
 W !?5,"*** OUTSTANDING ISSUES ARE ZERO.  ITEM HAS BEEN CANCELLED! ***" Q
