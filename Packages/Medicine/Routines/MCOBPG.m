MCOBPG ; GENERATED FROM 'MCARPACEGENBRPR' PRINT TEMPLATE (#2099) ; 07/22/97 ; (FILE 698, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(2099,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "DATE OF IMPLANT: "
 S X=$G(^MCAR(698,D0,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) D DT
 D N:$X>39 Q:'DN  W ?39 W "MEDICAL PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="MODEL: "_$S('$D(^MCAR(698.4,+$P(DIP(1),U,3),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="SERIAL NUMBER: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "IMPLANTATION ETIOLOGY: "
 S X=$G(^MCAR(698,D0,0)) S Y=$P(X,U,11) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "NON-MAG RATE AT END-OF-LIFE: "
 S X=$G(^MCAR(698,D0,4)) S Y=$P(X,U,5) W:Y]"" $J(Y,6,1)
 D N:$X>4 Q:'DN  W ?4 W "MAGNET RATE AT END-OF-LIFE: "
 S Y=$P(X,U,6) W:Y]"" $J(Y,6,1)
 D N:$X>4 Q:'DN  W ?4 W "INCIPIENT MALFUNCTION: "
 S X=$G(^MCAR(698,D0,1)) S Y=$P(X,U,6) D DT
 D N:$X>4 Q:'DN  W ?4 W "PACING FAILURE: "
 S I(1)=2,J(1)=698.093 F D1=0:0 Q:$O(^MCAR(698,D0,2,D1))'>0  X:$D(DSC(698.093)) DSC(698.093) S D1=$O(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(698,D0,2,D1,0)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 W ", "
 S Y=$P(X,U,2) D DT
 Q
A1R ;
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(698,D0,1)):^(1),1:"") S X="REASON FOR CHANGE: "_$S('$D(^MCAR(695.8,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 S X=$G(^MCAR(698,D0,.2)) S DIWL=1,DIWR=55 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?25 S MCFILE=698 D DISP^MCMAG K DIP K:DN Y
 W ?36 K MCFILE K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
