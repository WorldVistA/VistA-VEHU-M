A1B2COH ; GENERATED FROM 'A1B2 BILLING DATA HEAD' PRINT TEMPLATE (#1088) ; 01/31/91 ; (FILE 11500.2, MARGIN=80)
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
 S I(100)="^A1B2(11500.1,",J(100)=11500.1 S I(0,0)=D0 S DIP(1)=$S($D(^A1B2(11500.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S X=$S($D(^A1B2(11500.1,D0,0)):^(0),1:"") W ?0,$E($P(X,U,2),1,20)
 W ?22,$E($P(X,U,1),1,10)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 W ?34 W "ADM: "
 S DIP(1)=$S($D(^A1B2(11500.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>54 Q:'DN  W ?54 W " DISCHARGE: "
 S DIP(1)=$S($D(^A1B2(11500.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,6),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
