IG6 ; GENERATED FROM 'IG2QA' PRINT TEMPLATE (#901) ; 11/15/04 ; (FILE 2, MARGIN=226)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(901,"DXS")
 S I(0)="^DPT(",J(0)=2
 W ?0 I '$D(IG2QA) S IG2QA=1 W ?220 K DIP K:DN Y
 S X=$G(^DPT(D0,0)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,30)
 D N:$X>30 Q:'DN  W ?30 S DIP(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(DIP(1),U,3) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W $E(X,1,8)
 S X=$G(^DPT(D0,0)) D N:$X>38 Q:'DN  W ?38,$E($P(X,U,9),1,9)
 D N:$X>47 Q:'DN  W ?47 S DIP(1)=$S($D(^DPT(D0,.15)):^(.15),1:"") S X=$P(DIP(1),U,2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W $E(X,1,8)
 D N:$X>55 Q:'DN  W ?55 S DIP(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(DIP(1),U,1),X=X K DIP K:DN Y W $E(X,1,1)
 S X=$G(^DPT(D0,.3)) D N:$X>56 Q:'DN  W ?56 S Y=$P(X,U,2) W:Y]"" $J(Y,3,0)
 D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^DIC(45.82,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,12)
 S X=$G(^DPT(D0,.36)) D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DIC(8,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>101 Q:'DN  W ?101 S DIP(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(DIP(1),U,1),X=X K DIP K:DN Y W $E(X,1,1)
 D N:$X>102 Q:'DN  W ?102 S DIP(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(DIP(1),U,2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W $E(X,1,8)
 S I(1)="""DE""",J(1)=2.001 F D1=0:0 Q:$O(^DPT(D0,"DE",D1))'>0  X:$D(DSC(2.001)) DSC(2.001) S D1=$O(^(D1)) Q:D1'>0  D:$X>112 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^DPT(D0,"DE",D1,0)) D N:$X>110 Q:'DN  W ?110 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 D N:$X>130 Q:'DN  W ?130 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 S I(2)=1,J(2)=2.011 F D2=0:0 Q:$O(^DPT(D0,"DE",D1,1,D2))'>0  X:$D(DSC(2.011)) DSC(2.011) S D2=$O(^(D2)) Q:D2'>0  D:$X>142 T Q:'DN  D A2
 G A2R
A2 ;
 D N:$X>140 Q:'DN  W ?140 S DIP(1)=$S($D(^DPT(D0,"DE",D1,1,D2,0)):^(0),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W $E(X,1,8)
 Q
A2R ;
 Q
A1R ;
 S I(1)="""S""",J(1)=2.98 F D1=0:0 Q:$O(^DPT(D0,"S",D1))'>0  X:$D(DSC(2.98)) DSC(2.98) S D1=$O(^(D1)) Q:D1'>0  D:$X>150 T Q:'DN  D B1
 G B1R
B1 ;
 D N:$X>148 Q:'DN  W ?148 S Y=D1 D DT
 S X=$G(^DPT(D0,"S",D1,0)) D N:$X>168 Q:'DN  W ?168 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 D N:$X>188 Q:'DN  W ?188 S DIP(1)=$S($D(^DPT(D0,"S",D1,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X K DIP K:DN Y W $E(X,1,1)
 Q
B1R ;
 S I(1)=.372,J(1)=2.04 F D1=0:0 Q:$O(^DPT(D0,.372,D1))'>0  X:$D(DSC(2.04)) DSC(2.04) S D1=$O(^(D1)) Q:D1'>0  D:$X>191 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^DPT(D0,.372,D1,0)) D N:$X>189 Q:'DN  W ?189 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DIC(31,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>219 Q:'DN  W ?219 S Y=$P(X,U,2) W:Y]"" $J(Y,4,0)
 D N:$X>223 Q:'DN  W ?223 S DIP(1)=$S($D(^DPT(D0,.372,D1,0)):^(0),1:"") S X=$P(DIP(1),U,3),X=X K DIP K:DN Y W $E(X,1,1)
 Q
C1R ;
 D N:$X>224 Q:'DN  W ?224 W "X"
 K Y
 Q
HEAD ;
 W !,"----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",!!
