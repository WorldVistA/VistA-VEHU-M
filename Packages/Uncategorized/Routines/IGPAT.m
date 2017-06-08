IGPAT ; GENERATED FROM 'IGPAT' PRINT TEMPLATE (#904) ; 03/12/90 ; (FILE 2, MARGIN=132)
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
 W ?0 I '$D(IGPAT) S IGPAT=1 W ?112 K DIP,Y
 S X=$S($D(^DPT(D0,0)):^(0),1:"") D N:$X>0 W ?0,$E($P(X,U,1),1,30)
 D N:$X>30 W ?30,$E($P(X,U,9),1,9)
 D N:$X>39 W ?39 S DIP(1)=$S($D(^DPT(D0,.36)):^(.36),1:"") S X=$P(DIP(1),U,1),X=X K DIP,Y W $E(X,1,1)
 S X=$S($D(^DPT(D0,.3)):^(.3),1:"") D N:$X>40 W ?40 S Y=$P(X,U,2) W:Y]"" $J(Y,3,0)
 D N:$X>43 W ?43 S DIP(1)=$S($D(^DPT(D0,.31)):^(.31),1:"") S X=$P(DIP(1),U,11),X=X K DIP,Y W $E(X,1,1)
 D N:$X>44 W ?44 S DIP(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(DIP(1),U,5),X=X K DIP,Y W $E(X,1,1)
 S X=$S($D(^DPT(D0,.11)):^(.11),1:"") D N:$X>45 W ?45,$E($P(X,U,6),1,5)
 D N:$X>50 W ?50 S DIP(1)=$S($D(^DPT(D0,.11)):^(.11),1:"") S X=$P(DIP(1),U,7),X=X K DIP,Y W $E(X,1,3)
 S I(1)="""DA""",J(1)=2.95 F D1=0:0 Q:$N(^DPT(D0,"DA",D1))'>0  X:$D(DSC(2.95)) DSC(2.95) S D1=$N(^(D1)) Q:D1'>0  D:$X>55 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$S($D(^DPT(D0,"DA",D1,0)):^(0),1:"") D N:$X>53 W ?53 S Y=$P(X,U,1) D DT
 S X=$S($D(^DPT(D0,"DA",D1,1)):^(1),1:"") D N:$X>73 W ?73 S Y=$P(X,U,1) D DT
 Q
A1R ;
 S I(1)="""S""",J(1)=2.98 F D1=0:0 Q:$N(^DPT(D0,"S",D1))'>0  X:$D(DSC(2.98)) DSC(2.98) S D1=$N(^(D1)) Q:D1'>0  D:$X>95 T Q:'DN  D B1
 G B1R
B1 ;
 D N:$X>93 W ?93 S Y=D1 D DT
 D N:$X>113 W ?113 S DIP(1)=$S($D(^DPT(D0,"S",D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X K DIP,Y W $E(X,1,3)
 Q
B1R ;
 D N:$X>116 W ?116 W "X"
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
