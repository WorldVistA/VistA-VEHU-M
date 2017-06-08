ONCOY541 ; GENERATED FROM 'ONCOY54' PRINT TEMPLATE (#1242) ; 12/18/98 ; (continued)
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
 S X=$G(^ONCO(165.5,D0,"BLA2")) S Y=$P(X,U,18) S Y(0)=Y S Y=$P($G(^ONCO(166.13,+Y,0)),U,2) W $E(Y,1,40)
 D N:$X>4 Q:'DN  W ?4 W "Radiation Auxiliary Volume:  "
 S X=$G(^ONCO(165.5,D0,3.1)) S Y=$P(X,U,1) S Y(0)=Y S:Y'="" Y=$P(^ONCO(164.7,Y,0),"^",2) W $E(Y,1,30)
 D N:$X>6 Q:'DN  W ?6 W "Radiation Auxiliary Date:  "
 S X=$G(^ONCO(165.5,D0,3.1)) S Y=$P(X,U,2) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Radiation Therapy to CNS Date:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>44 Q:'DN  W ?44 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W $E(X,1,34)
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "  "
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
