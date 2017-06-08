PRCATO22 ; GENERATED FROM 'PRCA DISP AUDIT' PRINT TEMPLATE (#779) ; 03/30/98 ; (continued)
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
 D N:$X>53 Q:'DN  W ?53 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,4),DIP(2)=X S X=1,DIP(3)=X S X=4,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,6),DIP(2)=X S X=1,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 S I(2)=1,J(2)=430.22 F D2=0:0 Q:$O(^PRCA(430,D0,101,D1,1,D2))'>0  S D2=$O(^(D2)) D:$X>74 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^PRCA(430,D0,101,D1,1,D2,0)) S DIWL=12,DIWR=78 D ^DIWP
 Q
A2R ;
 D A^DIWW
 Q
A1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
