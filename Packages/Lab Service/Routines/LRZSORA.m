LRSORA ;SLC/KCM - HIGH/LOW VALUE REPORT ;2/19/91  11:41 ;
 ;;5.1;LAB;;04/11/91 11:06
MAIN D INIT,GDT,GLRT:'LREND,GLOG:'LREND,GDV:'LREND
RUN D:'LREND MAIN^LRSORA2
STOP D ^%ZISC I $D(LRQUE)#2,$D(ZTSK) D KILL^%ZTLOAD K LRQUE
 K LRA,LRV,LRV2,LREND,LREDT,LRSDT,LRLONG,LRTST,LRTW,W,X,Y,I,J Q
GLRT K LRTST S LRTST=1 F I=0:0 D GTSC Q:'$D(LRTST(LRTST,1))  W ! S LRTST=LRTST+1
 K LRTST(LRTST) S LRTST=LRTST-1 Q
GTSC S LRA=1 F I=0:0 D @$S(LRA=2:"SPEC",LRA=3:"CND",LRA=4:"GV",1:"TST") Q:LRA=0
 Q
TST S DIC="^LAB(60,",DIC(0)="AEMOQ",DIC("S")="I $P(^(0),U,5)[""CH"",""BO""[$P(^(0),U,3)" D ^DIC K DIC
 S LRA=$S(Y>0:2,1:0) S:X["^" LREND=1 I Y>0 S $P(LRTST(LRTST,3),"^",1)=$P($P(^LAB(60,+Y,0),U,5),";",2),$P(LRTST(LRTST,2),"^",1)=$P(Y,"^",2)
 Q
SPEC S DIC="^LAB(61,",DIC(0)="AEMOQ",DIC("A")="Select SPECIMEN/SITE: ANY// " D ^DIC K DIC
 S:Y<1 $P(LRTST(LRTST,3),"^",2)="",$P(LRTST(LRTST,2),"^",2)=""
 S LRA=$S(X["^":1,1:3) I Y>0 S $P(LRTST(LRTST,3),"^",2)=+Y,$P(LRTST(LRTST,2),"^",2)=$P(Y,"^",2)
 Q
CND W !,"Select CONDITION: " R X:DTIME S:'$T X="^" D @$S(X?1.N1":"1.N:"RNG",1:"GC") Q
RNG S LRV=$P(X,":",1),LRV2=$P(X,":",2),LRA=0 S:LRV>LRV2 X=LRV,LRV=LRV2,LRV2=X
 S $P(LRTST(LRTST,2),U,3)="BETWEEN "_LRV_" AND "_LRV2,X=$P(LRTST(LRTST,3),U,1)
 S LRTST(LRTST,1)="I $D(^("_X_")) S LRVX=$P(^("_X_"),U),LRVX=$S(LRVX?1A.E:LRVX,""<>""[$E(LRVX):$E(LRVX,2,$L(LRVX)),1:LRVX) I LRVX>"_LRV_",LRVX<"_LRV2 D ASPC Q
GC S DIC="^DOPT(""DIS"",",DIC(0)="EMQZ",DIC("S")="I $L($P(^(0),U,2))" D ^DIC K DIC
 S LRA=$S(X["^":2,Y<0:3,1:4) D:X["?" HLP1 W:'$L(X) " ??" Q:Y<0
GV W !,"Enter VALUE: " R X:DTIME S:'$T X="^" S LRA=$S(X["^":3,"?"[X:4,1:0) W:X="" " ??" D:X["?" HLP2 Q:LRA
 S $P(LRTST(LRTST,2),"^",3)=$P(Y(0),"^",1)_" "_X
 S LRTST(LRTST,1)="I $D(^("_$P(LRTST(LRTST,3),U)_")) S LRVX=$P(^("_$P(LRTST(LRTST,3),U)_"),U),LRVX=$S(LRVX?1A.E:LRVX,""<>""[$E(LRVX):$E(LRVX,2,$L(LRVX)),1:LRVX) I LRVX"_$P(Y(0),U,2)_$S(X?1A.E:""""_X_"""",1:X) D ASPC Q
ASPC S:$L($P(LRTST(LRTST,3),U,2)) LRTST(LRTST,1)=LRTST(LRTST,1)_",$P(^(0),U,5)="_$P(LRTST(LRTST,3),U,2) Q
INIT S U="^",LREND=0,LRLONG=0,LRSDT="TODAY",LREDT="T-1",LRTW=.00001 S:'$D(DTIME) DTIME=300
 W !,"SPECIAL REPORT - Search for high/low values" Q
GDT F W=0:0 D SDF,GSD Q:LREND  S LRSDT=Y D GED I Y>0 S LREDT=Y S:LREDT>LRSDT X=LREDT,LREDT=LRSDT,LRSDT=X D CXR Q:Y>0
 K %DT Q
GSD S %DT("A")="Enter START date: ",%DT("B")=LRSDT,%DT="AET" D ^%DT S LREND=Y<1 Q
GED S %DT("A")="Enter END date: ",%DT("B")=LREDT D ^%DT Q
CXR S Y=$E(LREDT,1,3)_"0000" F I=0:0 S Y=$O(^LRO(69,Y)) Q:$D(^LRO(69,Y,1,"AN"))!(Y="")
 I Y>LREDT D DD^LRX W !,"The earliest date in the X-ref is ",Y,".  Long search required.",! D CXR1
 Q
CXR1 F I=0:0 S %=2 W "  OK to continue" D YN^DICN S:%=2!(%<0) LREND=1 S:%=1 LRLONG=1 Q:%  W !,"Enter 'YES' for the long search, 'NO' to exit.",!
 Q
SDF I LRSDT?1.7N S Y=LRSDT D DD^LRX S LRSDT=Y
 I LREDT?1.7N S Y=LREDT D DD^LRX S LREDT=Y
 Q
GLOG S:LRTST=1 LRTST(0)="A" D:LRTST>1 EN^LRSORA1 S:LRTST<1 LREND=1 Q
GDV S %ZIS="Q" D ^%ZIS K %ZIS I POP S LREND=1 Q
 I $D(IO("Q")) K IO("Q") S LRQUE=1,ZTRTN="RUN^LRSORA",ZTDESC="Lab Special Report",ZTSAVE("LR*")="" D ^%ZTLOAD K ZTIO,ZTSAVE,ZTSK,LRQUE S LREND=1
 Q
HLP1 W !,"A VALUE RANGE may also be entered (value:value).",!,"  For Example, 100:200 will search for values between 100 and 200.",! Q
HLP2 W !,"Enter a value for the comparison:  ",$P(LRTST(LRTST,2),U,1)," ",$P(Y(0),U,1)_" _____." Q
XX ;
