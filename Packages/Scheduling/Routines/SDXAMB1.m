SDXAMB1 ; GENERATED FROM 'SD-AMB-PROC-DISPLAY' PRINT TEMPLATE (#800) ; 06/24/93 ; (continued)
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
 S X=$S($D(^SD(409.72,D0,0)):^(0),1:"") D N:$X>2 Q:'DN  W ?2 S Y=$P(X,U,1) D DT
 D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^SD(409.81,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>54 Q:'DN  W ?54 S %=$O(^SD(409.82,"AIVDT",+$P(^SD(409.72,D0,0),U,4),(9999998-$S($D(SDEFDT):SDEFDT,1:^(0))))) S X=$S('%:0,$D(^SD(409.82,+$O(^(%,0)),0)):$P(^(0),U,3),1:0) S X=$J(X,0,2) W:X'?."*" $J(X,11,2) K Y(409.72,203)
 S X=$S($D(^SD(409.72,D0,0)):^(0),1:"") D N:$X>68 Q:'DN  W ?68 S Y=$P(X,U,6) W:Y]"" $J(Y,10,2)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
