PRSTED3 ; HISC/REL/FPT - T&A Edits ;12/6/93  13:08
 ;;3.5;PAID;;Jan 26, 1995
 S E(1)=0
 F K=24,25,33,43:1:45 S X=$P(C0,"^",K) I X'="" S LAB=$P(T0," ",K-12) D @LAB
 F K=6,7,15,25:1:27,42,45,47:1:57 S X=$P(C1,"^",K) I X'="" S LAB=$P(T1," ",K) D @LAB
 I E(1)>(NOR*10),DUT=1 S ERR=69 D ERR^PRSTED
 G ^PRSTED4
PA ;
PB S E(1)=E(1)+X
 I DUT=2,LAB="PA",X>$P(C0,"^",42) S ERR=70 D ERR^PRSTED
 I DUT=2,LAB="PB",X>$P(C1,"^",24) S ERR=70 D ERR^PRSTED
 I DUT=3,X>400 S ERR=71 D ERR^PRSTED
 I '$P(C1,"^",41) S ERR=72 D ERR^PRSTED
 Q
ON ;
CL I "AN"'[PAY S ERR=73 D ERR^PRSTED
 I PPI'="W",PPI'="Y" S ERR=73 D ERR^PRSTED
 I X>1280 S ERR=74 D ERR^PRSTED
 Q
VC I $P(C1,"^",27)="" S ERR=75 D ERR^PRSTED
VS I LAB="VS",$P(C0,"^",45)="" S ERR=75 D ERR^PRSTED
 I PAY'="U" S ERR=77 D ERR^PRSTED
 Q
YA Q
YD Q
YE Q
DT I $E(X,1,2)<1!($E(X,1,2)>12) S ERR=138 D ERR^PRSTED
 S X1=+$E(X,3,4) I X1<1!(X1>$P("31 29 31 30 31 30 31 31 30 31 30 31"," ",+$E(X,1,2))) S ERR=138 D ERR^PRSTED
 S X1=+$E(X,5,6) I X1'=+$E(PP,2,3),X1'=($E(PP,2,3)+1) S ERR=138 D ERR^PRSTED
 Q
YH Q
SP ; saturday premium pay
SQ I X>320 S ERR=140 D ERR^PRSTED
 I "ABKM"'[PAY S ERR=141 D ERR^PRSTED
 I "AB"[PAY,PPI="" S ERR=149 D ERR^PRSTED
 Q
TF ; travel ot flsa
TG I FLSA'="N" S ERR=142 D ERR^PRSTED
 Q
DA ; hrs excess 8 (day)
DE I "0123456789AGNU"'[PAY S ERR=143 D ERR^PRSTED
 I FLSA'="N" S ERR=144 D ERR^PRSTED
 Q
DB ; hrs excess 8 (two)
DF I "0123456789BGU"'[PAY S ERR=145 D ERR^PRSTED
 I FLSA'="N" S ERR=146 D ERR^PRSTED
 Q
DC ; hrs excess 8 (three)
DG I "0123456789GU"'[PAY S ERR=147 D ERR^PRSTED
 I FLSA'="N" S ERR=148 D ERR^PRSTED
 Q
TA ; travel
 I NOR>0,DUT=1,(X+($P(C1,"^",54)))>(NOR*10) S ERR=95 D ERR^PRSTED
 I "23"[DUT,X>($P(C0,"^",42)+($P(C0,"^",21))) S ERR=94 D ERR^PRSTED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSTED
 I NOR>80,$P(C0,"^",42),X>$P(C0,"^",42) S ERR=92 D ERR^PRSTED
 Q
TB ;
 I NOR>0,DUT=1,($P(C1,"^",15)+X)>(NOR*10) S ERR=95 D ERR^PRSTED
 I "23"[DUT,X>($P(C1,"^",24)+($P(C1,"^",3))) S ERR=94 D ERR^PRSTED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSTED
 I NOR>80,$P(C1,"^",24),X>$P(C1,"^",24) S ERR=92 D ERR^PRSTED
 Q
TC ; training
 I NOR>0,DUT=1,(X+($P(C1,"^",57)))>(NOR*10) S ERR=98 D ERR^PRSTED
 I "23"[DUT,X>($P(C0,"^",42)+($P(C0,"^",21))) S ERR=97 D ERR^PRSTED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSTED
 I NOR>80,$P(C0,"^",42),X>$P(C0,"^",42) S ERR=92 D ERR^PRSTED
 Q
TD ;
 I NOR>0,DUT=1,($P(C1,"^",42)+X)>(NOR*10) S ERR=98 D ERR^PRSTED
 I "23"[DUT,X>($P(C1,"^",24)+($P(C1,"^",3))) S ERR=97 D ERR^PRSTED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSTED
 I NOR>80,$P(C1,"^",24),X>$P(C1,"^",24) S ERR=92 D ERR^PRSTED
 Q
