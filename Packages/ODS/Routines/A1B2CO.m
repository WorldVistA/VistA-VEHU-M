A1B2CO ; GENERATED FROM 'A1B2 BILLING DATA2' PRINT TEMPLATE (#1087) ; 01/31/91 ; (FILE 11500.2, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1087,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S I(100)="^A1B2(11500.1,",J(100)=11500.1 S I(0,0)=D0 S DIP(1)=$S($D(^A1B2(11500.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>4 Q:'DN  W ?4 W "BILLING SPECIALTY:"
 S DIXX(1)="B1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(1,9.2) S X="" S D0=I(0,0)
 G B1R
B1 ;
 I $D(DSC(11500.61)) X DSC(11500.61) E  Q
 W:$X>24 ! S I(100)="^A1B2(11500.61,",J(100)=11500.61
 S X=$S($D(^A1B2(11500.61,D0,0)):^(0),1:"") D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DGCR(399.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,3) W:Y]"" $J(Y,4,0)
 W " Days"
 I '$P(^A1B2(11500.61,D0,0),U,15) W " *INACTIVE*" K DIP K:DN Y
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>4 Q:'DN  W ?4 W "OPERATIONS/PROCEDURES PERFORMED:"
 S DIXX(1)="C1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(2,9.2) S X="" S D0=I(0,0)
 G C1R
C1 ;
 I $D(DSC(11500.62)) X DSC(11500.62) E  Q
 W:$X>38 ! S I(100)="^A1B2(11500.62,",J(100)=11500.62
 S X=$S($D(^A1B2(11500.62,D0,0)):^(0),1:"") D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ICD0(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,6)
 W ?16 X ^DD(11500.62,100.01,9.3) S X=$P(Y(11500.62,100.01,101),U,4) S D0=Y(11500.62,100.01,80) W $E(X,1,30) K Y(11500.62,100.01)
 S X=$S($D(^A1B2(11500.62,D0,0)):^(0),1:"") W ?48 S Y=$P(X,U,3) D DT
 I '$P(^A1B2(11500.62,D0,0),U,15) W " *INACTIVE*" K DIP K:DN Y
 Q
C1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>4 Q:'DN  W ?4 W "DIAGNOSIS:"
 S DIXX(1)="D1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(3,9.2) S X="" S D0=I(0,0)
 G D1R
D1 ;
 I $D(DSC(11500.63)) X DSC(11500.63) E  Q
 W:$X>16 ! S I(100)="^A1B2(11500.63,",J(100)=11500.63
 S X=$S($D(^A1B2(11500.63,D0,0)):^(0),1:"") D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ICD9(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,7)
 W ?17 X ^DD(11500.63,100.01,9.3) S X=$P(Y(11500.63,100.01,101),U,3) S D0=Y(11500.63,100.01,80) W $E(X,1,30) K Y(11500.63,100.01)
 W ?49 I $P(^A1B2(11500.63,D0,0),U,3) W "DXLS: YES" K DIP K:DN Y
 I '$P(^A1B2(11500.63,D0,0),U,15) W " *INACTIVE*" K DIP K:DN Y
 Q
D1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>4 Q:'DN  W ?4 W "ASSOCIATED COSTS:"
 S DIXX(1)="E1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(4,9.2) S X="" S D0=I(0,0)
 G E1R
E1 ;
 I $D(DSC(11500.64)) X DSC(11500.64) E  Q
 W:$X>23 ! S I(100)="^A1B2(11500.64,",J(100)=11500.64
 S X=$S($D(^A1B2(11500.64,D0,0)):^(0),1:"") D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,1) D DT
 W ?22 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 W ?35 S Y=$P(X,U,4) W:Y]"" $J(Y,10,2)
 W ?47,$E($P(X,U,5),1,30)
 I '$P(^A1B2(11500.64,D0,0),U,15) W " *INACTIVE*" K DIP K:DN Y
 Q
E1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
