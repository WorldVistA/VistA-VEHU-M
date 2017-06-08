IG11 ; GENERATED FROM 'IG41C' PRINT TEMPLATE (#903) ; 03/12/90 ; (FILE 41.3, MARGIN=41)
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
 W ?0 I '$D(IG41C) S IG41C=1 W ?35 K DIP,Y
 S X=$S($D(^DG(41.3,D0,0)):^(0),1:"") D N:$X>0 W ?0 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>30 W ?30 S DIP(1)=$S($D(^DG(41.3,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X K DIP,Y W $E(X,1,1)
 D N:$X>31 W ?31 S DIP(1)=$S($D(^DG(41.3,D0,0)):^(0),1:"") S X=$P(DIP(1),U,4) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP,Y W $E(X,1,8)
 D N:$X>39 W ?39 W "X"
 K Y
 Q
HEAD ;
 W !,"-----------------------------------------",!!
