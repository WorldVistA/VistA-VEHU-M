PRCATP31 ; GENERATED FROM 'PRCA VENDOR PROFILE' PRINT TEMPLATE (#769) ; 03/30/98 ; (continued)
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
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "TRANSACTIONS: "
 W ?16 D EN2^PRCADR K DIP K:DN Y
 W ?27 Q:$D(PRCA("HALT"))  W "" K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "BILL RESULTING FROM: "
 W ?23 X DXS(1,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "Date"
 D N:$X>11 Q:'DN  W ?11 W "Description"
 D N:$X>34 Q:'DN  W ?34 W "Quantity"
 D N:$X>45 Q:'DN  W ?45 W "Units"
 D N:$X>53 Q:'DN  W ?53 W "Cost"
 D N:$X>63 Q:'DN  W ?63 W "Total Cost"
 D N:$X>0 Q:'DN  W ?0 W "============================================================================"
 S I(1)=101,J(1)=430.02 F D1=0:0 Q:$O(^PRCA(430,D0,101,D1))'>0  X:$D(DSC(430.02)) DSC(430.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>78 T Q:'DN  D A1
 G A1R^PRCATP32
A1 ;
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9) K DIP K:DN Y W X
 S X=$G(^PRCA(430,D0,101,D1,0)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^PRCD(420.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,5)
 G ^PRCATP32
