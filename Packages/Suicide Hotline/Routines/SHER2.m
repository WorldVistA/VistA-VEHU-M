QIP3POL1 ;B'HAM ISC/SAB,WRT-QUIC Poly-Pharmacy/Outpatient ; [ 10/25/93  9:46 AM ]
V ;;2.1;**1**;;SEP 28,1993
 D INTRO^QIP3POL2 S QFLG=0
NUM K DIR S DIR("B")=8,DIR(0)="N^5:25:0",DIR("A")="Select number of active medications to be used"
 S DIR("?",1)="Enter a number between five (5) and twenty five (25) of RXs you want to",DIR("?",2)="screen.  Eight (8) is the default for QUIC survey reporting.  The resulting"
 S DIR("?",3)="report will show all outpatients with RXs greater than the number selected.",DIR("?")=" " D ^DIR G:$D(DTOUT)!$D(DUOUT) EX
 S QIPNUM=+Y K DIR,QIPD F Q=0:0 W !!,"Do you want to print the support data" S %=2 D YN^DICN Q:%  I %Y["?" W !!?5,"'Y' for YES to print support data",!?5,"'N' for NO to print only summary report"
 S QIPRI=$S(%=1:1,1:"") G:%=-1 EX
 D ONEDT^QIPEXTU3 G:$D(DIRUT) EX S QIPDT=QIPADT
DEV W ! K %ZIS,IO("Q"),IOP,ZTSK S QIPION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G EX
 S QIPVAMC=$G(QIPVAMC)
 I $D(IO("Q")) K IO("Q") S ZTSAVE("QIPVAMC")="",ZTSAVE("QIPNUM")="",ZTSAVE("QIPRI")="",ZTSAVE("QIPDT")="",ZTDESC="QIP POLYPHARMACY REPORT",ZTRTN="EN^QIP3POL1" D ^%ZTLOAD D HOME^%ZIS K ZTSK S QFLG=1 G EX
EN ;enter here from taskman
 D NOW^%DTC S Y=% X ^DD("DD") S RT=Y
 K ^TMP($J) S (PG,QIPT1,QIPT11,QFLG)=0,QIPDTQ=QIPDT,QIPDT0=QIPDT-1
 ;
PLOOP ; get patients
 F QIPDFN=0:0 S QIPDFN=$O(^PS(55,QIPDFN)) Q:'QIPDFN  I $O(^PS(55,QIPDFN,"P","A",QIPDT0)) S QIPT1=QIPT1+1,QIPRXCT=0,QIPRLCT=0 F QIPDT=QIPDT0:0 S QIPDT=$O(^PS(55,QIPDFN,"P","A",QIPDT)) Q:'QIPDT  D RXLOOP
 D SUM G:QFLG EX
OUT D HDR G:QFLG EX
 W !!,"[23] What percent of active outpatients are receiving more than "_QIPNUM,!,"medications?",!!?5,"# of outpatients",!?5,"on >"_QIPNUM_" medications",?30,"total # outpatients",?55,"percent"
 W !?5,"------------------",?30,"-------------------",?55,"-------"
 W !!?11,QIPT11,?36,QIPT1,?55,$S(QIPT1:$J(QIPT11/QIPT1*100,3,2),1:0)
 W:$E(IOST)'="C" @IOF
EX I $E(IOST)="C"&('QFLG) S DIR(0)="E" W !! D ^DIR K DIR
 K ^TMP($J),%,%I,%T,C,QIPN,I,J,%,QIPION,DTOUT,DUOUT,POP,QIPD,QIPDFN,QIPDRG,QIPDRUG,QIPDT,QIPDT0,QIPDTQ,QIPRX,QIPRXCT,QIPRXN,QIPT1,QIPT11,%Y,QIPRI,Q,X,Y,ZTDESC,ZTRTN,ZTSAVE
 K PG,RT,DIR,DIRUT,QIPNUM,ORD,QIPRLCT,QIPGN,QIPVAGN,RUNDT,BEGDT,SS,JJ,QFLG,VA,VADM,VAERR,DFN
 D ^%ZISC K TAB,TB1,TB3,TB4,ZTSK S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
RXLOOP ; got patient - get Rxs
 F QIPRXN=0:0 S QIPRXN=$O(^PS(55,QIPDFN,"P","A",QIPDT,QIPRXN)) Q:'QIPRXN  I 134'[$E(+$P($G(^PSRX(QIPRXN,0)),"^",15)) S QIPRX=^PSRX(QIPRXN,0),QIPDRG=+$P(QIPRX,"^",6) I $D(^PSDRUG(QIPDRG,0)) S QIPDRUG=^(0) I $P(QIPDRUG,"^",3)'["S" D GET
 Q
 ;
GET ; got drug in QIPDRUG check data
 S DFN=QIPDFN D DEM^VADPT
 S QIPN=VADM(1)_"^"_QIPDFN
 I $D(^TMP($J,"QIPN",QIPN,$P(QIPDRUG,"^"))) Q
 S QIPRXCT=QIPRXCT+1 ; one more rx
 S QIPDRUG=$P(QIPDRUG,"^",2) ; CLASS
 S:'$D(^TMP($J,"QIPN",QIPN,0)) ^TMP($J,"QIPN",QIPN,0)="0^"_VA("PID")
 S $P(^TMP($J,"QIPN",QIPN,0),"^")=$P(^TMP($J,"QIPN",QIPN,0),"^")+1 D ^QIP3POL2
 S ^TMP($J,"QIPN",QIPN,$P(^PSDRUG(QIPDRG,0),"^"),0)=$P(^PSRX(QIPRXN,0),"^")
 Q
SUM ;output of detailed data
 ; REORDER ^TMP TO SORT IN DESCENDING ORDER BY NUMBER OF SCRIPTS
 S QIPN="" F  S QIPN=$O(^TMP($J,"QIPN",QIPN)) Q:QIPN=""  S ORD=999-$P(^TMP($J,"QIPN",QIPN,0),"^",3) S:$G(QIPRI) ^TMP($J,ORD,QIPN)="" I $P(^TMP($J,"QIPN",QIPN,0),"^",3)>QIPNUM S QIPT11=QIPT11+1
 Q:'$G(QIPRI)
 D HDR,HDR1
 F ORD=0:0 S ORD=$O(^TMP($J,ORD)) Q:'ORD  D SUM1 Q:QFLG
 W:'$G(QIPD) !!!?15,"**** NO OUTPATIENTS FOUND ON THIS DAY ****"
 Q
SUM1 S QIPN="" F  S QIPN=$O(^TMP($J,ORD,QIPN)) Q:QIPN=""  I $P(^TMP($J,"QIPN",QIPN,0),"^",3)>QIPNUM S QIPD=1 D:$Y+5>IOSL HDR,HDR1 Q:QFLG  W !,$P(QIPN,"^"),?50,$P(^TMP($J,"QIPN",QIPN,0),"^",2),?70,$P(^(0),"^",3) D OUT1 Q:QFLG  W !
 Q
OUT1 S QIPDRG=0 F J=0:0 S QIPDRG=$O(^TMP($J,"QIPN",QIPN,QIPDRG)) Q:QIPDRG=""  D:$Y+5>IOSL HDR,HDR1 Q:QFLG  W !?5,$P(^TMP($J,"QIPN",QIPN,QIPDRG,0),"^"),?20,QIPDRG
 Q
HDR ; HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S TAB=(80-$L($G(QIPVAMC)))/2,TB1=(80-$L("QUALITY IMPROVEMENT REPORT: POLY-PHARMACY/OUTPATIENT"))/2,Y=QIPDTQ X ^DD("DD") S TB3=(80-$L("AS OF "_Y))/2,TB4=(80-$L("DATE PRINTED: "_RT))/2
 U IO S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !?TAB,$G(QIPVAMC),?72,"PAGE "_PG,!?TB1,"QUALITY IMPROVEMENT REPORT: POLY-PHARMACY/OUTPATIENT ",!?TB3,"AS OF " S Y=QIPDTQ X ^DD("DD") W Y,!?TB4,"DATE PRINTED: "_RT,!
 F Q=1:1:80 W "-"
 Q
HDR1 Q:QFLG  W !,"OUTPATIENT NAME",?50,"PID",?64,"TOTAL MEDS FOUND",!?5,"RX NUMBER",?20,"DRUG",! F Q=1:1:80 W "="
 Q
