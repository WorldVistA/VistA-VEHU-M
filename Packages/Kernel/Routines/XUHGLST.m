XUHGLST ; GENERATED FROM 'XUHGLST' PRINT TEMPLATE (#848) ; 07/28/93 ; (FILE 3.5, MARGIN=80)
 G BEGIN
D I Y=DITTO(C) S Y="" Q
 S DITTO(C)=Y
 Q
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1
 S X=$S($D(^%ZIS(1,D0,0)):^(0),1:"") W ?0 S Y=$P(X,U,10),C=1 D D W $E(Y,1,30)
 K Y
 Q
HEAD ;
 W !,?0,"*HUNT GROUP"
 W !,"--------------------------------------------------------------------------------",!!
