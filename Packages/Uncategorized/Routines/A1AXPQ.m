A1AXPQ ; GENERATED FROM 'A1AX PINQ' PRINT TEMPLATE (#1466) ; 06/10/88 ; (FILE 11830, MARGIN=132)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1466,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(1,9.2) S X=X_Y K DIP W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^DIZ(11830,D0,"F")):^("F"),1:"") S X="VAMC FACILITY: "_$S('$D(^DIZ(11837,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^DIZ(11830,D0,"O")):^("O"),1:"") S X="REVIEWER: "_$S('$D(^DIZ(11831,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP W X
 W ?11 W !,"ENTERING PERSON: " W:$D(^DIZ(11830,D0,"US")) ?18,^("US") K DIP
 D N:$X>0 Q:'DN  W ?0 X DXS(2,9.2) S X=X_Y K DIP W X
 S I(1)="""P""",J(1)=11830.01 F D1=0:0 Q:$N(^DIZ(11830,D0,"P",D1))'>0  X:$D(DSC(11830.01)) DSC(11830.01) S D1=$N(^(D1)) Q:D1'>0  D:$X>11 T Q:'DN  D A1
 G A1R^A1AXPQ1
A1 ;
 D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,0)):^(0),1:"") S X="TYPE OF PROGRAM: "_$S('$D(^DIZ(11832,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP W X
 D N:$X>2 Q:'DN  W ?2 X DXS(3,9) K DIP W X
 S I(2)="""S""",J(2)=11830.02 F D2=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2))'>0  X:$D(DSC(11830.02)) DSC(11830.02) S D2=$N(^(D2)) Q:D2'>0  D:$X>13 T Q:'DN  D A2
 G A2R^A1AXPQ1
A2 ;
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,0)):^(0),1:"") S X="SERVICE: "_$S('$D(^DIZ(11835,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP W X
 D N:$X>4 Q:'DN  W ?4 X DXS(4,9) K DIP W X
 S I(3)="""R""",J(3)=11830.03 F D3=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3))'>0  X:$D(DSC(11830.03)) DSC(11830.03) S D3=$N(^(D3)) Q:D3'>0  D:$X>15 T Q:'DN  D A3
 G A3R^A1AXPQ1
A3 ;
 D N:$X>6 Q:'DN  W ?6 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0)):^(0),1:"") S X="RECOMMEND NO: "_$P(DIP(1),U,1) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(5,9) K DIP W X
 S I(4)=14,J(4)=11830.11 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,14,D4))'>0  X:$D(DSC(11830.11)) DSC(11830.11) S D4=$N(^(D4)) Q:D4'>0  D:$X>17 T Q:'DN  D A4
 G A4R
A4 ;
 D N:$X>8 Q:'DN  W ?8 X DXS(6,9.2) S X=X_$P($P(DIP(2),$C(59)_$P(DIP(1),U,1)_":",2),$C(59),1) K DIP W X
 Q
A4R ;
 D N:$X>6 Q:'DN  W ?6 X DXS(7,9) K DIP W X
 D N:$X>6 Q:'DN  W ?6 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0)):^(0),1:"") S X="STANDARD REF: "_$P(DIP(1),U,4) K DIP W X
 D N:$X>6 Q:'DN  W ?6 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,11)):^(11),1:"") S X="PARAPHRASED RECOMMEND: "_$P(DIP(1),U,5) K DIP W X
 D N:$X>6 Q:'DN  W ?6 W "RECOMMENDATION: "
 S I(4)=1,J(4)=11830.05 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,1,D4))'>0  S D4=$N(^(D4)) D:$X>24 T Q:'DN  D B4
 G B4R
B4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,1,D4,0)):^(0),1:"") S DIWL=1,DIWR=130 D ^DIWP
 Q
B4R ;
 D A^DIWW
 D N:$X>6 Q:'DN  W ?6 X DXS(8,9) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(9,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 W "APPEAL RESULT:"
 S I(4)=4,J(4)=11830.07 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,4,D4))'>0  S D4=$N(^(D4)) D:$X>22 T Q:'DN  D C4
 G C4R
C4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,4,D4,0)):^(0),1:"") S DIWL=1,DIWR=130 D ^DIWP
 Q
C4R ;
 D A^DIWW
 D N:$X>6 Q:'DN  W ?6 X DXS(10,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(11,9.2) S X=X_$P($P(DIP(2),$C(59)_$P(DIP(1),U,3)_":",2),$C(59),1) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(12,9.2) S X=X_$P($P(DIP(2),$C(59)_$P(DIP(1),U,3)_":",2),$C(59),1) K DIP W X
 D N:$X>6 Q:'DN  W ?6 X DXS(13,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>6 Q:'DN  W ?6 W "CO COMMENT:"
 S I(4)=3,J(4)=11830.316 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,3,D4))'>0  S D4=$N(^(D4)) D:$X>19 T Q:'DN  D D4
 G D4R
D4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,3,D4,0)):^(0),1:"") S DIWL=1,DIWR=130 D ^DIWP
 Q
D4R ;
 D A^DIWW
 G ^A1AXPQ1
