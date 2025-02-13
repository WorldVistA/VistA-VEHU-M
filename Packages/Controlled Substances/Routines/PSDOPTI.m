PSDOPTI ;BIR/LTL - Review OP Transactions by Inventory Type ; 29 Aug 94
 ;;3.0;CONTROLLED SUBSTANCES;**18,55,72**;13 Feb 97;Build 9
 ;
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to DD(58.81 and ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 ;References to ^PSI(58.16 are covered by DBIA213
 ;References to ^PSRX( are covered by DBIA986
 S CNT=0 W !!,"You may select one, several, or ^ALL Inventory Types."
 N PSDI S PSDI=0
INV F  S DIC="^PSI(58.16,",DIC(0)="AEQ",DIC("A")="Please Select Inventory Type: " W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('CNT) END Q:Y<0  S PSDI(+Y)=$P(Y,U,2),CNT=CNT+1
 I X="^ALL" F  S PSDI=$O(^PSI(58.16,PSDI)) Q:'PSDI  S PSDI(PSDI)=$P($G(^PSI(58.16,PSDI,0)),U)
 S CNT=0 W !!,"Now, you may select one, several, or ^ALL drugs."
CHKD F  S DIC="^PSD(58.8,+PSDLOC,1,",DIC(0)="AEQ",DIC("A")="Please Select "_PSDLOCN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)" W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('CNT) END Q:Y<0  D
 .I '$O(^PSD(58.81,"F",+Y,0)) W !!,"There have been no transactions for this drug.",!! Q
 .S PSD(1)=0 F  S PSD(1)=$O(^PSD(58.8,PSDLOC,1,+Y,2,PSD(1))) S:$D(PSDI(+PSD(1))) PSD(2)=PSD(1) Q:$G(PSD(2))!('PSD(1))
 .I '$G(PSD(2)) W !!,"Not in selected Inventory Type(s)",!! Q
 .S PSD=$P($G(^PSDRUG(+Y,0)),U),CNT=CNT+1
 .S PSD=$S(PSD]"":PSD,1:"UNKNOWN DRUG #"_+Y)
 .S ^TMP("PSD",$J,PSDI(PSD(2)),PSD,+Y)="" K PSD
 I X="^ALL" F  S PSDU=$O(^PSD(58.8,+PSDLOC,1,PSDU)) Q:'PSDU  D
 .Q:'$O(^PSD(58.81,"F",PSDU,0))
 .S PSD(1)=0 F  S PSD(1)=$O(^PSD(58.8,PSDLOC,1,PSDU,2,PSD(1))) S:$D(PSDI(+PSD(1))) PSD(2)=PSD(1) Q:$G(PSD(2))!('PSD(1))
 .Q:'$G(PSD(2))
 .S PSD=$P($G(^PSDRUG(PSDU,0)),U)
 .S PSD=$S(PSD]"":PSD,1:"UNKNOWN DRUG #"_PSDU)
 .S ^TMP("PSD",$J,PSDI(PSD(2)),PSD,PSDU)="" K PSD
 S DIR(0)="S^1:Sort by Rx #;2:Sort by Date Posted"
 S DIR("A")="Within Drug, Sort by",DIR("B")=1
 S DIR("?")="For each drug, do you want the transactions listed in the order they were posted or by Rx #?"
 D ^DIR K DIR G:$D(DIRUT) END I Y=1 S PSDI=1 G ^PSDOPTX
 S DIR(0)="D^2910501:NOW:AEPT",DIR("A")="Beginning date@time",DIR("?")="I will list Outpatient transactions for your selected drug(s) within your selected date@time range" W ! D ^DIR G:Y<1 END
 S (PSDT,PSDTB)=Y,PSDTB(2)=Y(0),DIR(0)="D^"_PSDT_":NOW:AEPT"
 S DIR("A")="Ending date@time"
 W ! D ^DIR K DIR G:Y<1 END S PSDTB(1)=Y,PSDTB(3)=Y(0)
 S:'$P(PSDTB(1),".",2) PSDTB(1)=PSDTB(1)+.999999
 S Y=$P($G(^PSD(58.8,+PSDLOC,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
DEV ;asks device and queuing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDOPTI",ZTDESC="Drug OP transaction review" D SAVE D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
START ;compiles and prints output
 U IO N LN,PSDR,PG S (PG,PSDOUT)=0 D HEADER S (PSD,PSDU)=0
 F  S PSD=$O(^TMP("PSD",$J,PSD)) Q:PSD']""  F  S PSDU=$O(^TMP("PSD",$J,PSD,PSDU)) Q:PSDU']""  S PSDU(1)=$O(^TMP("PSD",$J,PSD,PSDU,0)) D  G:PSDOUT END S PSDT=PSDTB,PSDT(1)=0
LOOP .F  S PSDT=$O(^PSD(58.81,"ACT",PSDT)) W:$E(IOST)="C" "." Q:'PSDT!(PSDT>PSDTB(1))  D:$D(^PSD(58.81,"ACT",PSDT,PSDLOC))&($O(^PSD(58.81,"ACT",PSDT,PSDLOC,0))=PSDU(1))&($O(^PSD(58.81,"ACT",PSDT,PSDLOC,+PSDU(1),6,0)))  Q:PSDOUT
 ..S PSDR(3)=+$O(^PSD(58.81,"ACT",PSDT,PSDLOC,+PSDU(1),6,0))
 ..S PSDR(2)=$G(^PSD(58.81,PSDR(3),0))
 ..S PSDR(4)=$G(^PSD(58.81,PSDR(3),6))
 ..D:$Y+6>IOSL HEADER Q:PSDOUT
 ..S PSDT(1)=$G(PSDT(1))+1 W:PSDT(1)=1 !,PSDU,?60,PSD,!
 ..S Y=$E($P(PSDR(2),U,4),1,12) X ^DD("DD") W !,Y,?19
 ..S DFN=$P($G(^PSRX(+$P(PSDR(4),U),0)),U,2)
 ..N C S Y=DFN,C=$P(^DD(58.81,73,0),U,2) D Y^DIQ
 ..W $P(PSDR(4),U,5),?28,Y
 ..D PID^VADPT6 W " ("_VA("BID")_")",?60
 ..I $P(PSDR(4),U,2) S Y=$P($G(^PSRX(+$P(PSDR(4),U),1,+$P(PSDR(4),U,2),0)),U,18) X ^DD("DD") W Y
 ..I $P(PSDR(4),U,4) S Y=$P($G(^PSRX(+$P(PSDR(4),U),"P",+$P(PSDR(4),U,4),0)),U,19) X ^DD("DD") W Y
 ..I '$P(PSDR(4),U,2)&('$P(PSDR(4),U,4)) S Y=$P($G(^PSRX(+$P(PSDR(4),U),2)),U,13) X ^DD("DD") W Y
 ..W !,"Qty: ",$P(PSDR(2),U,6),"  Bal: ",$P(PSDR(2),U,10)-$P(PSDR(2),U,6),?22,"RPH=> ",$P($G(^VA(200,+$P(PSDR(2),U,7),0)),U),?60
 ..W $S($P(PSDR(4),U,2):"Refill #"_$P(PSDR(4),U,2),$P(PSDR(4),U,4):"Partial #"_$P(PSDR(4),U,4),1:"Original")
 ..W !,LN,!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 D KVAR^VADPT K IO("Q"),VA("PID"),VA("BID"),^TMP("PSD",$J)
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !,"Outpatient Activity from ",PSDTB(2)," to ",PSDTB(3),?70,"PAGE: ",PG,!,LN,!,"Date Posted",?19,"Rx#",?28,"Patient",?60,"Date Released",!,LN W:$G(PSDT(1)) !,PSDU," (continued)",!
 Q
SAVE ;save queued variables
 S ZTSAVE("^TMP(""PSD"",$J,")=""
 S (ZTSAVE("PSDT"),ZTSAVE("PSDTB"),ZTSAVE("PSDTB("),ZTSAVE("PSDLOC"))=""
 Q
