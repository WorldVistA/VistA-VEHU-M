MCOBGN ; GENERATED FROM 'MCARGINONBRPR' PRINT TEMPLATE (#2095) ; 07/22/97 ; (FILE 699, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(2095,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "APPT DATE/TIME: "
 S X=$G(^MCAR(699,D0,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) D DT
 D N:$X>39 Q:'DN  W ?39 W "MEDICAL PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "ENDOSCOPIST: "
 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "NON-ENDOSCOPIC PROCEDURE: "
 S I(1)=18,J(1)=699.59 F D1=0:0 Q:$O(^MCAR(699,D0,18,D1))'>0  X:$D(DSC(699.59)) DSC(699.59) S D1=$O(^(D1)) Q:D1'>0  D:$X>32 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(699,D0,18,D1,0)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.88,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(699,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUBJECTIVE: "
 S I(1)=20,J(1)=699.66 F D1=0:0 Q:$O(^MCAR(699,D0,20,D1))'>0  S D1=$O(^(D1)) D:$X>18 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(699,D0,20,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "OBJECTIVE: "
 S I(1)=21,J(1)=699.67 F D1=0:0 Q:$O(^MCAR(699,D0,21,D1))'>0  S D1=$O(^(D1)) D:$X>17 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(699,D0,21,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "ASSESSMENT: "
 S I(1)=22,J(1)=699.68 F D1=0:0 Q:$O(^MCAR(699,D0,22,D1))'>0  S D1=$O(^(D1)) D:$X>18 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(699,D0,22,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PLANNED: "
 S I(1)=23,J(1)=699.69 F D1=0:0 Q:$O(^MCAR(699,D0,23,D1))'>0  S D1=$O(^(D1)) D:$X>15 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(699,D0,23,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
E1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 S X=$G(^MCAR(699,D0,.2)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=69 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?71 S MCFILE=699 D DISP^MCMAG K DIP K:DN Y
 D ^DIWW
 D T Q:'DN  W ?2 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
