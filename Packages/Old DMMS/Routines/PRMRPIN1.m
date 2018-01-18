PRMRPIN1 ; GENERATED FROM 'PRMR INC PRINT 2633' PRINT TEMPLATE (#233) ; 04/17/89 ; (continued)
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
 D N:$X>16 Q:'DN  W ?16,$E($P(X,U,18),1,40)
 D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,19) D DT
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "PATIENT MENTAL STATUS:"
 S I(1)="""MS""",J(1)=513.7223 F D1=0:0 Q:$N(^PRMQ(513.72,D0,"MS",D1))'>0  X:$D(DSC(513.7223)) DSC(513.7223) S D1=$N(^(D1)) Q:D1'>0  D:$X>24 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$S($D(^PRMQ(513.72,D0,"MS",D1,0)):^(0),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "PATIENT ACTIVITY STATUS:"
 S I(1)="""AS""",J(1)=513.7224 F D1=0:0 Q:$N(^PRMQ(513.72,D0,"AS",D1))'>0  X:$D(DSC(513.7224)) DSC(513.7224) S D1=$N(^(D1)) Q:D1'>0  D:$X>26 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$S($D(^PRMQ(513.72,D0,"AS",D1,0)):^(0),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 Q
B1R ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "FALL FACTOR:"
 S X=$S($D(^PRMQ(513.72,D0,"FF")):^("FF"),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>28 Q:'DN  W ?28,$E($P(X,U,2),1,40)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "MEDICATION ERROR FACTOR:"
 S X=$S($D(^PRMQ(513.72,D0,"ME")):^("ME"),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>28 Q:'DN  W ?28,$E($P(X,U,2),1,40)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "PROTECTIVE MEASURES:"
 S I(1)="""PM""",J(1)=513.7222 F D1=0:0 Q:$N(^PRMQ(513.72,D0,"PM",D1))'>0  X:$D(DSC(513.7222)) DSC(513.7222) S D1=$N(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$S($D(^PRMQ(513.72,D0,"PM",D1,0)):^(0),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 Q
C1R ;
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "EXAMINER AND DATE OF EXAM:"
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,21) S Y=$S(Y="":Y,$D(^DIC(3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,20) D DT
 D N:$X>0 Q:'DN  W ?0 W "EXAMINATION FINDING:"
 S X=$S($D(^PRMQ(513.72,D0,1)):^(1),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SEVERITY OF INJURY:"
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "EXAMINATION PLAN:"
 S X=$S($D(^PRMQ(513.72,D0,1)):^(1),1:"") D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 D T Q:'DN  D N D N D N D N:$X>0 Q:'DN  W ?0 W "SERVICE(S) INVOLVED:"
 S I(1)=6,J(1)=513.722 F D1=0:0 Q:$N(^PRMQ(513.72,D0,6,D1))'>0  X:$D(DSC(513.722)) DSC(513.722) S D1=$N(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D D1
 G D1R^PRMRPIN2
D1 ;
 G ^PRMRPIN2
