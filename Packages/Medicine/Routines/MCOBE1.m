MCOBE1 ; GENERATED FROM 'MCARECGBRPR' PRINT TEMPLATE (#2088) ; 07/22/97 ; (FILE 691.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(2088,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "DATE/TIME: "
 S X=$G(^MCAR(691.5,D0,0)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,1) D DT
 D N:$X>34 Q:'DN  W ?34 W "MEDICAL PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="VENT RATE: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="PR INTERVAL: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="QRS DURATION: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="QT: "_$P(DIP(1),U,7) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMPARISON: "
 S X=$G(^MCAR(691.5,D0,1)) S DIWL=1,DIWR=60 S Y=$P(X,U,1) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INSTRUMENT DX: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=9,J(1)=691.57 F D1=0:0 Q:$O(^MCAR(691.5,D0,9,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.5,D0,9,D1,0)) S DIWL=21,DIWR=78 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.5,D0,.2)):^(.2),1:"") S X="PROCEDURE SUMMARY: "_$P(DIP(1),U,2) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETED BY: "
 S X=$G(^MCAR(691.5,D0,0)) S Y=$P(X,U,13) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 W ?22 S MCFILE=691.5 D DISP^MCMAG K DIP K:DN Y
 W ?33 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
