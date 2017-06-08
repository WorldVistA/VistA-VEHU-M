IBYZ20V3 ;ALB/CPM - LOCATE/BILL PRESCRIPTIONS (REPORT) ; 24-MAR-97
 ;;FOR USE ONLY IN THE VHA CHICAGO HEALTHCARE SYSTEM
 ;
 ;
 ; Print the detail reports for both the billed and 'set' rx's.
 S (IBQ,IBPAG)=0
 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 D DET("SET"),DET("BILL"):'IBQ
 K IBPAG,IBQ,IBRUN,%,IBH,IBNAM,IBRXN,IBREF
 Q
 ;
 ;
DET(IBSUB) ; Print the detailed report.
 ;  Input:   IBSUB  --  "BILL": rx's which were billed
 ;                      "SET": rx's which were set up to be billed
 D HDET
 I '$D(^TMP($J,"IBYZ20V",IBSUB)) W !!,"There were no prescriptions filled in this date range which ",$S(IBMODE="S":"need to be ",1:"were "),$S(IBSUB="SET":"set up for billing.",1:"billed.") G DETQ
 ;
 S IBNAM="" F  S IBNAM=$O(^TMP($J,"IBYZ20V",IBSUB,IBNAM)) Q:IBNAM=""  D  Q:IBQ
 .S (IBH,IBRXN)="" F  S IBRXN=$O(^TMP($J,"IBYZ20V",IBSUB,IBNAM,IBRXN)) Q:IBRXN=""  D  Q:IBQ
 ..S IBREF="" F  S IBREF=$O(^TMP($J,"IBYZ20V",IBSUB,IBNAM,IBRXN,IBREF)) Q:IBREF=""  S IBXX=$G(^(IBREF)) D  Q:IBQ
 ...;
 ...I $Y>(IOSL-2) D PAUSE Q:IBQ  D HDET S IBH=0
 ...;
 ...W ! I 'IBH W $P(IBNAM,"@@"),?27,$P(IBNAM,"@@",2) S IBH=1
 ...;
 ...W ?34,IBRXN,?47,$S(IBREF:"Refill #"_IBREF,1:"Orig Fill")
 ...W ?58,$$DAT1^IBOUTL(+IBXX),?69,$P(IBXX,"^",2)
 ...W ?93,"$",$J(+$P(IBXX,"^",3),0,2)
 ;
 I 'IBQ D PAUSE
DETQ Q
 ;
 ;
HDET ; Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,"Prescriptions Which ",$S(IBMODE="S":"Need to be",1:"Were"),$S(IBSUB="SET":" Set up to be",1:"")," Billed"
 W ?60,"Run Date: ",IBRUN,?120,"Page: ",IBPAG
 W !,"Detailed Report for Prescriptions Filled in the Period "_$$DAT1^IBOUTL(IBBDT)_" to "_$$DAT1^IBOUTL(IBEDT)
 W !,"Patient",?27,"SSN",?34,"Rx#",?47,"Orig/Ref",?58,"Fill Date",?69,"Pharmacy",?93,"Cost"
 W !,$$DASH(IOM),!
 Q
 ;
 ;
DASH(X) ; Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; Page break
 Q:$E(IOST,1,2)'="C-"
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
