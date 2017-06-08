ECXLARP ;BIR/CML,PTD-Print DSS Lab Tests Names Datasheet (LAR) ; 12/17/96 11:12 [ 02/26/97  2:57 PM ]
 ;;3.0;DSS EXTRACTS;**8,51**;Dec 22, 1997
EN ;entry point from option
 S QFLG=1
 W !!,"This option prints a list of the DSS Lab Tests used for the Lab Results",!,"Extract (LAR).  It will display the local lab data names for each test.",!,"The blood and urine specimens used locally are also listed."
 I '$O(^ECX(727.2,0)) W !!,"The DSS LAB TEST file (#727.2) does not exist on your system!" G QUIT
DEV W !!,"The right margin for this report is 80.",!!
 D EN^XUTMDEVQ("START^ECXLARP","DSS - Print DSS Lab Tests") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
START ;
 S (PG,QFLG,CNT)=0,$P(LN,"-",81)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 S ECLAB="" F  S ECLAB=$O(^ECX(727.2,1,1,"B",ECLAB)) Q:ECLAB=""  Q:QFLG  S ECIEN=0 F  S ECIEN=$O(^ECX(727.2,1,1,"B",ECLAB,ECIEN)) Q:'ECIEN  Q:QFLG  D
 .S CNT=CNT+1 D:$Y+4>IOSL HDR Q:QFLG  W !!,$J(CNT,2),". ",ECLAB D
 ..Q:'$O(^ECX(727.2,1,1,ECIEN,"LOC",0))
 ..S ECLOC=0 F  S ECLOC=$O(^ECX(727.2,1,1,ECIEN,"LOC",ECLOC)) Q:'ECLOC  D:$Y+4>IOSL HDR Q:QFLG  S ECLIEN=+^ECX(727.2,1,1,ECIEN,"LOC",ECLOC,0) W !?9,$P($G(^LAB(60,ECLIEN,0)),U)
 K ECLIEN ;** Variable added to accomodate lack of DINUM on 727.2, P #26
 G:QFLG QUIT
SPEC F ECFLD="BL","UR","FE" D
 .I $O(^ECX(727.2,1,ECFLD,0)) D
 ..D:$Y+4>IOSL HDR Q:QFLG  W !!!,$S(ECFLD="BL":"BLOOD",ECFLD="UR":"URINE",1:"FECES")_" SPECIMEN TOPOGRAPHIES",!,$E(LN,1,27)
 ..S ECIEN=0 F  S ECIEN=$O(^ECX(727.2,1,ECFLD,ECIEN)) Q:'ECIEN  D:$Y+4>IOSL HDR Q:QFLG  W !,$P($G(^LAB(61,ECIEN,0)),U)
QUIT ;
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K %I,CNT,ECFLD,ECIEN,ECLAB,ECLOC,HDT,JJ,LN,PG,QFLG,SS,X,Y,ZTSK
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
HDR ;HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,"DSS Lab Tests Names Datasheet",?72,"Page: ",PG,!,"Printed on ",HDT,!
 W !?5,"DSS LAB TEST NAME",!?9,"LOCAL LAB DATA NAME(S)",!,LN
 Q
