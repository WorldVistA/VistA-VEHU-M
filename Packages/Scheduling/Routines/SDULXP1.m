SDULXP1 ; GENERATED FROM 'SDUL LIST TEMPLATE' PRINT TEMPLATE (#1188) ; 06/24/93 ; (continued)
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
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,"EXP")):^("EXP"),1:"") S X="Expand: "_$E(DIP(1),1,245) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ">>>  Caption Name"
 D N:$X>29 Q:'DN  W ?29 W "Column"
 D N:$X>39 Q:'DN  W ?39 W "Width"
 D N:$X>49 Q:'DN  W ?49 W "Caption"
 S I(1)="""COL""",J(1)=409.621 F D1=0:0 Q:$N(^SD(409.61,D0,"COL",D1))'>0  X:$D(DSC(409.621)) DSC(409.621) S D1=$N(^(D1)) Q:D1'>0  D:$X>58 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$S($D(^SD(409.61,D0,"COL",D1,0)):^(0),1:"") D N:$X>5 Q:'DN  W ?5,$E($P(X,U,1),1,20)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,2),1,3)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,3) W:Y]"" $J(Y,3,0)
 D N:$X>49 Q:'DN  W ?49,$E($P(X,U,4),1,30)
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 S X="_",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
