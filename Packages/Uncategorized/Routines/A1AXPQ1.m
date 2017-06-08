A1AXPQ1 ; GENERATED FROM 'A1AX PINQ' PRINT TEMPLATE (#1466) ; 06/10/88 ; (continued)
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
 D N:$X>6 Q:'DN  W ?6 X DXS(14,9.2) S X=X_$P($P(DIP(2),$C(59)_$P(DIP(1),U,3)_":",2),$C(59),1) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(15,9.2) S X=X_$P($P(DIP(2),$C(59)_$P(DIP(1),U,1)_":",2),$C(59),1) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(16,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 W "RD COMMENT:"
 S I(4)=6,J(4)=11830.323 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,6,D4))'>0  S D4=$N(^(D4)) D:$X>19 T Q:'DN  D E4
 G E4R
E4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,6,D4,0)):^(0),1:"") S DIWL=1,DIWR=130 D ^DIWP
 Q
E4R ;
 D A^DIWW
 D N:$X>6 Q:'DN  W ?6 W "ACTION PLAN:"
 S I(4)=10,J(4)=11830.09 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,10,D4))'>0  S D4=$N(^(D4)) D:$X>20 T Q:'DN  D F4
 G F4R
F4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,10,D4,0)):^(0),1:"") S DIWL=1,DIWR=130 D ^DIWP
 Q
F4R ;
 D A^DIWW
 D N:$X>6 Q:'DN  W ?6 X DXS(17,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(18,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(19,9.2) S X=X_$P($P(DIP(2),$C(59)_$P(DIP(1),U,2)_":",2),$C(59),1) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(20,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,11)):^(11),1:"") S X="RESPONSIBLE PERSON: "_$P(DIP(1),U,4) K DIP W X
 W ?17 X DXS(21,9) K DIP
 Q
A3R ;
 Q
A2R ;
 Q
A1R ;
 K Y,DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
