PRSTCLS ; HISC/CLS - Close T&L ;7/19/91  13:41
 ;;3.5;PAID;;Jan 26, 1995
TK S PP=$P(^PRST(455,0),"^",3) G:PP<1 EX
 S X="N",%DT="XT" D ^%DT S NOW=+Y K %DT
 S Y=$E(PP,1,3)+1700,PER=$E(PP,4,5) W !!,"This routine will close out Pay Period ",PER,", ",Y," for the timekeeper."
 D PICK^PRSTUTL G:TLIEN<1 EX S TL=$P(^PRST(455.5,TLIEN,0),"^",1)
 I $P(^PRST(455.5,TLIEN,0),"^",3)'="" G EX
 S NN="" F KK=0:0 S NN=$O(^PRST(455,"ATL",TL,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) Q:DFN<1  I $D(^PRST(455,PP,1,DFN,0)) I $P(^(0),"^",2)="" S $P(^PRST(455,PP,1,DFN,0),"^",2)="T",$P(^(2),"^",1,2)=DUZ_"^"_NOW
 S $P(^PRST(455.5,TLIEN,0),"^",3)="T" W "  .. done" G EX
EX K DFN,KK,NN,NOW,OTL,PER,PP,STAT,TL,TLIEN,TLMETH,X,Y Q
