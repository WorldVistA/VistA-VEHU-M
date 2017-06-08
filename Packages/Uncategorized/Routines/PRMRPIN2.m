PRMRPIN2 ; GENERATED FROM 'PRMR INC PRINT 2633' PRINT TEMPLATE (#233) ; 04/17/89 ; (continued)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1
 S X=$S($D(^PRMQ(513.72,D0,6,D1,0)):^(0),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DIC(49,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
D1R ;
 W ?60 W @IOF K DIP
 K Y,DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
