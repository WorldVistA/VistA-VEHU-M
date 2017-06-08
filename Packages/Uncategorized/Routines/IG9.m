IG9 ; GENERATED FROM 'IG409E' PRINT TEMPLATE (#902) ; 03/12/90 ; (FILE 409.5, MARGIN=85)
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
 W ?0 I '$D(IG409E) S IG409E=1 W ?79 K DIP,Y
 S X=$S($D(^SDV(D0,0)):^(0),1:"") D N:$X>0 W ?0 S Y=$P(X,U,1) D DT
 D N:$X>20 W ?20 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>50 W ?50 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,10)
 S I(1)="""CS""",J(1)=409.51 F D1=0:0 Q:$N(^SDV(D0,"CS",D1))'>0  X:$D(DSC(409.51)) DSC(409.51) S D1=$N(^(D1)) Q:D1'>0  D:$X>62 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>60 W ?60 S DIP(1)=$S($D(^SDV(D0,"CS",D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X K DIP,Y W $E(X,1,3)
 S X=$S($D(^SDV(D0,"CS",D1,0)):^(0),1:"") D N:$X>63 W ?63 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^DIC(8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,10)
 D N:$X>73 W ?73 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^SD(409.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,10)
 Q
A1R ;
 D N:$X>83 W ?83 W "X"
 K Y
 Q
HEAD ;
 W !,"-------------------------------------------------------------------------------------",!!
