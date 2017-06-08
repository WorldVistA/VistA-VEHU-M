ONCOX22 ; GENERATED FROM 'ONCOX2' PRINT TEMPLATE (#1273) ; 01/24/94 ; (continued)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1 D:'(DISTP#100) CSTP
 Q
CSTP I '$D(ZTQUEUED) K DISTOP Q
 Q:$G(DISTOP)=0  S:$G(DISTOP)="" DISTOP=1
 I DISTOP'=1 X DISTOP K:'$T DISTOP S DISTOP=$T Q:'$T
 Q:'$$S^%ZTLOAD
 W:$G(IO)]"" !,"*** TASK "_ZTSK_" STOPPED BY USER - DURING "_$S($D(DPQ):"SORT",1:"PRINT")_" EXECUTION ***",!! S ZTSTOP=1,DN=0 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP)
 S X=$G(^ONCO(160,D0,5,D1,0)) S Y=$P(X,U,3) S Y(0)=Y S Y=$S(Y'="U":Y,1:"Unknown") D:Y?1.N DD^%DT W $E(Y,1,30)
 Q
B2R ;
 S I(101)=6,J(101)=160.041 F D1=0:0 Q:$O(^ONCO(160,D0,6,D1))'>0  X:$D(DSC(160.041)) DSC(160.041) S D1=$O(^(D1)) Q:D1'>0  D:$X>26 T Q:'DN  D C2
 G C2R
C2 ;
 D N:$X>1 Q:'DN  W ?1 W "Type of Alcohol User:  "
 X DXS(9,9) K DIP K:DN Y W X
 W "     Yrs. of Alcohol Use:  "
 S X=$G(^ONCO(160,D0,6,D1,0)) S Y=$P(X,U,2) S Y(0)=Y S:Y="U" Y="Unknown" W $J(Y,3)
 W "     Drinks per-day:  "
 S X=$G(^ONCO(160,D0,6,D1,0)) S Y=$P(X,U,3) S Y(0)=Y S:Y="U" Y="Unknown" W $J(Y,4)
 W "     Yr. Quit Drinking:  "
 S X=$G(^ONCO(160,D0,6,D1,0)) S Y=$P(X,U,4) S Y(0)=Y S Y=$S(Y="U":"Unknown",1:Y) D:Y?1.N DD^%DT W $E(Y,1,30)
 Q
C2R ;
 Q
J1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
