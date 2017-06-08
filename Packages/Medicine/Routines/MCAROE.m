MCAROE ; GENERATED FROM 'MCARECHO1' PRINT TEMPLATE (#557) ; 01/14/97 ; (FILE 691, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(557,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>49 Q:'DN  W ?49 W "WARD/CLINIC: "
 S X=$G(^MCAR(691,D0,11)) S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>4 Q:'DN  W ?4 W "AGE: "
 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "SEX: "
 X DXS(2,9.3) S DIP(201)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P($P(DIP(202),$C(59)_$P(DIP(201),U,2)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "HT IN: "
 S X=$G(^MCAR(691,D0,13)) S Y=$P(X,U,2) W:Y]"" $J(Y,3,0)
 D N:$X>27 Q:'DN  W ?27 W "WT LBS: "
 S Y=$P(X,U,1) W:Y]"" $J(Y,4,0)
 D N:$X>49 Q:'DN  W ?49 X DXS(3,9.2) S X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W X
 S X=$G(^MCAR(691,D0,13)) S Y=$P(X,U,3) W:Y]"" $J(Y,5,1)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "TEST RESULTS:"
 D N:$X>6 Q:'DN  W ?6 W "M-MODE MEASUREMENTS"
 D N:$X>9 Q:'DN  W ?9 W "LV DIASTOLE: "
 S X=$G(^MCAR(691,D0,4)) W ?0,$E($P(X,U,7),1,6)
 D N:$X>27 Q:'DN  W ?27 W "(40-55mm)"
 D N:$X>44 Q:'DN  W ?44 W "E PNT SEP SPN: "
 W ?0,$E($P(X,U,9),1,6)
 D N:$X>62 Q:'DN  W ?62 W "(0-5mm)"
 D N:$X>9 Q:'DN  W ?9 W "LV SYSTOLE: "
 W ?0,$E($P(X,U,8),1,6)
 D N:$X>27 Q:'DN  W ?27 W "(25-30mm)"
 D N:$X>44 Q:'DN  W ?44 W "LT ATRIUM: "
 W ?0,$E($P(X,U,3),1,6)
 D N:$X>60 Q:'DN  W ?60 W "(25-35mm)"
 D N:$X>9 Q:'DN  W ?9 W "% FRACT SHORT: "
 X ^DD(691,19,9.4) S X=$J(Y(691,19,8),Y(691,19,9),X) S X=$J(X,0,0) W $E(X,1,15) K Y(691,19)
 D N:$X>29 Q:'DN  W ?29 W "(25-45)"
 D N:$X>44 Q:'DN  W ?44 W "AORTIC ROOT: "
 S X=$G(^MCAR(691,D0,4)) W ?0,$E($P(X,U,4),1,6)
 D N:$X>60 Q:'DN  W ?60 W "(20-35mm)"
 D N:$X>9 Q:'DN  W ?9 W "SEPTUM: "
 W ?0,$E($P(X,U,1),1,5)
 D N:$X>28 Q:'DN  W ?28 W "(8-11mm)"
 D N:$X>44 Q:'DN  W ?44 W "RV DIASTOLE: "
 W ?0,$E($P(X,U,5),1,6)
 D N:$X>60 Q:'DN  W ?60 W "(10-25mm)"
 D N:$X>9 Q:'DN  W ?9 W "POST LV WALL: "
 W ?0,$E($P(X,U,2),1,5)
 D N:$X>28 Q:'DN  W ?28 W "(8-11mm)"
 D N:$X>44 Q:'DN  W ?44 W "ANT RV WALL: "
 W ?0,$E($P(X,U,6),1,5)
 D N:$X>62 Q:'DN  W ?62 W "(2-4mm)"
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691,D0,13)):^(13),1:"") S X="LV MASS: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "2-D ECHO MEASUREMENTS"
 D N:$X>9 Q:'DN  W ?9 X DXS(4,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>33 Q:'DN  W ?33 X DXS(5,9.2) S DIP(4)=X S X="",DIP(5)=X S X=1,DIP(6)=X S X="EF: "_DIP(7)_"%",X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W X
 D N:$X>48 Q:'DN  W ?48 X DXS(6,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 X DXS(7,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 X DXS(8,9.3) S X=$S(DIP(3):DIP(4),DIP(5):X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
