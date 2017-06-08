IGPTF ; GENERATED FROM 'IGPTF' PRINT TEMPLATE (#905) ; 03/12/90 ; (FILE 45, MARGIN=132)
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
 W ?0 I '$D(IGPTF) S IGPTF=1 W ?92 K DIP,Y
 S X=$S($D(^DGPT(D0,0)):^(0),1:"") D N:$X>0 W ?0,$E($P(X,U,3),1,3)
 D N:$X>3 W ?3,$E($P(X,U,5),1,3)
 D N:$X>6 W ?6 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>36 W ?36 S DIP(1)=$S($D(^DGPT(D0,0)):^(0),1:"") S X=$P(DIP(1),U,10),X=X K DIP,Y W $E(X,1,2)
 D N:$X>38 W ?38 S DIP(1)=$S($D(^DGPT(D0,70)):^(70),1:"") S X=$P(DIP(1),U,2),X=X K DIP,Y W $E(X,1,3)
 D N:$X>41 W ?41 S DIP(1)=$S($D(^DGPT(D0,70)):^(70),1:"") S X=$P(DIP(1),U,3),X=X K DIP,Y W $E(X,1,1)
 D N:$X>42 W ?42 S DIP(1)=$S($D(^DGPT(D0,70)):^(70),1:"") S X=$P(DIP(1),U,10),X=X K DIP,Y W $E(X,1,5)
 D N:$X>47 W ?47 S DIP(1)=$S($D(^DGPT(D0,101)):^(101),1:"") S X=$P(DIP(1),U,1),X=X K DIP,Y W $E(X,1,2)
 D N:$X>49 W ?49 S DIP(1)=$S($D(^DGPT(D0,70)):^(70),1:"") S X=$P(DIP(1),U,9),X=X K DIP,Y W $E(X,1,1)
 S X=$S($D(^DGPT(D0,70)):^(70),1:"") D N:$X>50 W ?50 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^DIC(45.6,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>80 W ?80 S DIP(1)=$S($D(^DGPT(D0,0)):^(0),1:"") S X=$P(DIP(1),U,2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP,Y W $E(X,1,8)
 S I(1)="""S""",J(1)=45.01 F D1=0:0 Q:$N(^DGPT(D0,"S",D1))'>0  X:$D(DSC(45.01)) DSC(45.01) S D1=$N(^(D1)) Q:D1'>0  D:$X>90 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>88 W ?88 S DIP(1)=$S($D(^DGPT(D0,"S",D1,0)):^(0),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP,Y W $E(X,1,8)
 Q
A1R ;
 D N:$X>96 W ?96 W "X"
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
