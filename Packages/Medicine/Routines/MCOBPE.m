MCOBPE ; GENERATED FROM 'MCARPULMBRPR' PRINT TEMPLATE (#2096) ; 07/22/97 ; (FILE 699, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(2096,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 S DIP(1)=$S($D(^MCAR(699,D0,0)):^(0),1:"") S X="APPOINTMENT DATE/TIME: "_$P(DIP(1),U,1) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>39 Q:'DN  W ?39 W "MEDICAL PATIENT: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SIGNS AND SYMPTOMS: "
 S I(1)=3,J(1)=699.18 F D1=0:0 Q:$O(^MCAR(699,D0,3,D1))'>0  X:$D(DSC(699.18)) DSC(699.18) S D1=$O(^(D1)) Q:D1'>0  D:$X>26 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(699,D0,3,D1,0)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.5,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COUGH: "
 S I(1)=10,J(1)=699.0206 F D1=0:0 Q:$O(^MCAR(699,D0,10,D1))'>0  X:$D(DSC(699.0206)) DSC(699.0206) S D1=$O(^(D1)) Q:D1'>0  D:$X>13 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(699,D0,10,D1,0)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.5,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
B1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PNEUMONIA: "
 S I(1)=11,J(1)=699.0207 F D1=0:0 Q:$O(^MCAR(699,D0,11,D1))'>0  X:$D(DSC(699.0207)) DSC(699.0207) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(699,D0,11,D1,0)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.83,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
C1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "DISEASE FOLLOWUP: "
 S I(1)=5,J(1)=699.35 F D1=0:0 Q:$O(^MCAR(699,D0,5,D1))'>0  X:$D(DSC(699.35)) DSC(699.35) S D1=$O(^(D1)) Q:D1'>0  D:$X>24 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(699,D0,5,D1,0)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.84,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
D1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "FOLLOWUP DEVICE OR THERAPY: "
 S I(1)=6,J(1)=699.36 F D1=0:0 Q:$O(^MCAR(699,D0,6,D1))'>0  X:$D(DSC(699.36)) DSC(699.36) S D1=$O(^(D1)) Q:D1'>0  D:$X>34 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(699,D0,6,D1,0)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.85,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
E1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "OTHER FOLLOWUP DEVICE/THERAPY: "
 S X=$G(^MCAR(699,D0,12)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INDICATED THERAPY: "
 S I(1)=2,J(1)=699.17 F D1=0:0 Q:$O(^MCAR(699,D0,2,D1))'>0  X:$D(DSC(699.17)) DSC(699.17) S D1=$O(^(D1)) Q:D1'>0  D:$X>25 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^MCAR(699,D0,2,D1,0)) S DIWL=1,DIWR=55 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.6,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
F1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "BRONCHOSCOPIST: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(699,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 S DIWL=1,DIWR=55 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?25 S MCFILE=699 D DISP^MCMAG K DIP K:DN Y
 W ?36 K MCFILE K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
