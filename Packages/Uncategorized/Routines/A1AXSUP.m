A1AXSUP ; GENERATED FROM 'A1AX PSU' PRINT TEMPLATE (#1461) ; 06/10/88 ; (FILE 11830, MARGIN=132)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1461,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S DIWF="W"
 W ?0 W # D ^%D K DIP
 W ?11 X DXS(1,9) K DIP
 W ?22 X DXS(2,9) K DIP
 W ?33 S $P(A1AXL,"=",IOM+1)="" K DIP
 W ?44 S (RS,RS1)="" K DIP
 S I(1)="""P""",J(1)=11830.01 F D1=0:0 Q:$N(^DIZ(11830,D0,"P",D1))'>0  X:$D(DSC(11830.01)) DSC(11830.01) S D1=$N(^(D1)) Q:D1'>0  D:$X>55 T Q:'DN  D A1
 G A1R
A1 ;
 W ?55 X DXS(3,9) K DIP
 W ?66 X DXS(4,9) K DIP
 W ?77 S RS=RS_"^" K DIP
 Q
A1R ;
 W ?88 X DXS(5,9) K DIP
 W ?99 W !,"CONTINGENCY REQUIREMENTS: " K DIP
 W ?110 X DXS(6,9) K DIP
 W ?121 X DXS(7,9) K DIP
 D T Q:'DN  W ?2 W !,A1AXL K DIP
 W ?13 X DXS(8,9) K DIP
 S I(1)="""P""",J(1)=11830.01 F D1=0:0 Q:$N(^DIZ(11830,D0,"P",D1))'>0  X:$D(DSC(11830.01)) DSC(11830.01) S D1=$N(^(D1)) Q:D1'>0  D:$X>24 T Q:'DN  D B1
 G B1R
B1 ;
 S I(2)="""S""",J(2)=11830.02 F D2=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2))'>0  X:$D(DSC(11830.02)) DSC(11830.02) S D2=$N(^(D2)) Q:D2'>0  D:$X>24 T Q:'DN  D A2
 G A2R
A2 ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,0)):^(0),1:"") S X="SERVICE: "_$S('$D(^DIZ(11835,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP W X
 W ?11 W !,A1AXL K DIP
 S I(3)="""R""",J(3)=11830.03 F D3=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3))'>0  X:$D(DSC(11830.03)) DSC(11830.03) S D3=$N(^(D3)) Q:D3'>0  D:$X>22 T Q:'DN  D A3
 G A3R
A3 ;
 D T Q:'DN  D N D N W ?0 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S X=X_"   REC. NO.: "_$P(DIP(1),U,1) K DIP W X
 W ?11 W ?20,"("_$P(^DIZ(11832,+^DIZ(11830,D0,"P",D1,0),0),"^",1)_")"  K DIP
 D N:$X>4 Q:'DN  W ?4 X DXS(9,9) K DIP W X
 D N:$X>28 Q:'DN  W ?28 X DXS(10,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>54 Q:'DN  W ?54 X DXS(11,9.2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S Y=X,X=DIP(1),X=X S X=X_Y K DIP W X
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,11)):^(11),1:"") S X="PARAPHRASED RECOMMENDATION: "_$P(DIP(1),U,5) K DIP W X
 W ?15 W !,?4,"FACILITY ACTION PLAN: " K DIP
 S I(4)=10,J(4)=11830.09 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,10,D4))'>0  S D4=$N(^(D4)) D:$X>26 T Q:'DN  D A4
 G A4R
A4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,10,D4,0)):^(0),1:"") S DIWL=5,DIWR=130 D ^DIWP
 Q
A4R ;
 D A^DIWW
 Q
A3R ;
 Q
A2R ;
 Q
B1R ;
 K Y,DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
