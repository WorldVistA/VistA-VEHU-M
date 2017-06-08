A1AXSCN ;SLL/ALB ISC; FLAG SCREEN;5/15/88
 ;;VERSION 1.0
 ;
 I DUZ(2)>999&(DUZ(2)<10000) K X W !,"FOR FACILITY USE ONLY" Q
 S $P(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0),"^",3)=$P(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0),"^",2),$P(^(0),"^",5)=DT
 S A1AXO=$P(^DIZ(11831,+^DIZ(11830,D0,"O"),0),"^",1)
 G @A1AXO
JCAHO ;
 I X'="C"&(X'="+")&(X'="R")&(X'="RC")&(X'="U")&(X'="N")&(X'="M") K X D WR
 Q
CAP ;
 I X'="PH1"&(X'="PH2") K X D WR
 Q
SERP ;
 I X'="R"&(X'="C1")&(X'="C2")&(X'="C3") K X D WR
 Q
ACS ;
GAO ;
IG ;
MEDIPRO ;
OSHA ;
OTHER ;
SPG ;
 K X W !,"You are being reviewed by "_A1AXO_", no flag allowed!"
 Q
WR ;
 W !,"You are being reviewed by "_A1AXO_", enter the appropriate flag!"
 Q
