PRMRPONY ;GLRISC/JES,GWB,DAD-PRODUCE AUTOMATED INPUT SHEET FOR 10-2633 ; 1/31/89  08:43 ;
 ;VERSION 1.01
 S:'$D(DTIME) DTIME=300 S:DTIME="" DTIME=300
 S (PRMRIT,N)=0,HIT="" F I=0:0 S N=$O(^PRMQ(513.941,N)) Q:N'?1.N  S P=$P(^PRMQ(513.941,N,0),"^",1),ONE=$E(P,1,3),TWO=64,PRMRIT=PRMRIT+1 S:$L(P)=4 TWO=$A($E(P,4)) S PRMRHLD(ONE_TWO)=^PRMQ(513.941,N,0)
 S $P(PRMRL17,"_",17)="_",$P(L22,"_",22)="_",$P(PRMRL33,"_",33)="_",$P(PRMRL45,"_",45)="_"
 S $P(PRMRL53,"_",53)="_",$P(PRMRL58,"_",58)="",$P(PRMRL60,"_",60)="_",$P(PRMRL71,"_",71)="_",$P(PRMRL80,"_",80)="_"
AGAIN ;
 S %ZIS="QM" D ^%ZIS K %ZIS K:POP IO("Q") G:POP Q
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="EN^PRMRPONY",ZTDESC="Incident Reporting Work Sheet" D SAVE,^%ZTLOAD K ZTIO,ZTSK G Q
 G EN
SAVE ;
 S ZTSAVE("PRMRIT")="",ZTSAVE("PRMRHLD(")="",ZTSAVE("PRMRL17")="",ZTSAVE("L22")="",ZTSAVE("PRMRL33")=""
 S ZTSAVE("PRMRL45")="",ZTSAVE("PRMRL53")="",ZTSAVE("PRMRL58")="",ZTSAVE("PRMRL60")="",ZTSAVE("PRMRL71")="",ZTSAVE("PRMRL80")="" Q
EN ;
 D ^PRMRPON1
BADOUT ;
 I '$D(ZTSK) W @IOF X ^%ZIS("C")
 G:$D(ZTSK) Q
OVER ;
 R !!,"ENTER ""^"" TO EXIT, PRESS RETURN TO PRINT ANOTHER WORKSHEET: ",AGAIN:DTIME G:AGAIN="" AGAIN I AGAIN["?" D BADMESS G OVER
 I AGAIN'="^" W *7,*7 D BADMESS G OVER
 Q
BADMESS ;
 W !!,"Enter up-arrow (^) to exit, press return to print another worksheet" H 2 Q
Q ;
 K:$D(ZTSK) ^%ZTSK(ZTSK) W @IOF X ^%ZIS("C")
 K PRMRO,PRMRD,PRMRH,AGAIN,HALF,HIT,HOLDFA,PRMRHLD,HOLDME,HOLDPM,FA,I,II,PRMRIT,PRMRL17,L22,PRMRL33,PRMRL45,PRMRL53,PRMRL58,PRMRL60,PRMRL71,PRMRL80,ME,ONE,P,PLUS,PM,POP,N,TWO,%DT Q
