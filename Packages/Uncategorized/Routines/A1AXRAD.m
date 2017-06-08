A1AXRAD ; GENERATED FROM 'A1AX PRAD' PRINT TEMPLATE (#108) ; 01/28/88 ; (FILE 11830, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(108,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 S X="RECOMMENDATION STATUS AND ACTION PLAN REPORT" W #,?(IOM-$L(X))\2,X K DIP
 W ?11 S $P(A1AXSL,"=",44)="" W !,?(IOM-$L(A1AXSL))\2,A1AXSL K DIP
 W ?22 S A1AXO=^DIZ(11830,D0,"O") S A1AXO=$P(^DIZ(11831,+A1AXO,0),"^",1) K DIP
 W ?33 X DXS(1,9) K DIP
 W ?44 S $P(A1AXL,"=",IOM)="" K DIP
 S I(1)="""P""",J(1)=11830.01 F D1=0:0 Q:$N(^DIZ(11830,D0,"P",D1))'>0  X:$D(DSC(11830.01)) DSC(11830.01) S D1=$N(^(D1)) Q:D1'>0  D:$X>55 T Q:'DN  D A1
 G A1R
A1 ;
 W ?55 S A1AXD=^DIZ(11830,D0,0),A1AXDT=$E(A1AXD,4,5)_"/"_$E(A1AXD,6,7)_"/"_$E(A1AXD,2,3) K DIP
 W ?66 W !,"REVIEW DATE: ",A1AXDT W ?(IOM-$L(A1AXDP)),A1AXDP K DIP
 D T Q:'DN  W ?4 W !,"VAMC: ",A1AXF K DIP
 W ?15 W !,"REVIEWER: ",A1AXO K DIP
 W ?26 X DXS(2,9) K DIP
 S I(2)="""S""",J(2)=11830.02 F D2=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2))'>0  X:$D(DSC(11830.02)) DSC(11830.02) S D2=$N(^(D2)) Q:D2'>0  D:$X>37 T Q:'DN  D A2
 G A2R
A2 ;
 W ?37 W !!,A1AXL K DIP
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,0)):^(0),1:"") S X="SERVICE: "_$S('$D(^DIZ(11835,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP W X
 W ?11 W !,A1AXL K DIP
 W ?22 X DXS(3,9) K DIP
 W ?33 W !,A1AXL K DIP
 S I(3)="""R""",J(3)=11830.03 F D3=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3))'>0  X:$D(DSC(11830.03)) DSC(11830.03) S D3=$N(^(D3)) Q:D3'>0  D:$X>44 T Q:'DN  D A3
 G A3R
A3 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0)):^(0),1:"") D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,8)
 S I(4)=1,J(4)=11830.05 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,1,D4))'>0  S D4=$N(^(D4)) D:$X>10 T Q:'DN  D A4
 G A4R
A4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,1,D4,0)):^(0),1:"") S DIWL=10,DIWR=42 D ^DIWP
 Q
A4R ;
 D 0^DIWW K DIP
 S I(4)=10,J(4)=11830.09 F D4=0:0 Q:$N(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,10,D4))'>0  S D4=$N(^(D4)) D:$X>44 NX^DIWW D B4
 G B4R
B4 ;
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,10,D4,0)):^(0),1:"") S DIWL=46,DIWR=78 D ^DIWP
 Q
B4R ;
 D A^DIWW
 S X=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,11)):^(11),1:"") D T Q:'DN  W ?79 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D T Q:'DN  W ?94 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,11)):^(11),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP W X
 D T Q:'DN  W ?112 S DIP(1)=$S($D(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,11)):^(11),1:"") S X=$P(DIP(1),U,3) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP W X
 Q
A3R ;
 Q
A2R ;
 Q
A1R ;
 D T Q:'DN  W ?2 K A1AXL,A1AXO,A1AXB,A1AXF,A1AXD,A1AXDT,A1AXPD,A1AXSL K DIP
 K Y,DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
