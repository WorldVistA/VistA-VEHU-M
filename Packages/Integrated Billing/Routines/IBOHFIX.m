IBOHFIX ;ALB/EMG - CLEAN UP ROUTINE FOR PATCH IB*2*95 ; 26-OCT-98
 ;;2.0; INTEGRATED BILLING ;**95**; 21-MAR-94
 ;
 ;
 ;  1)  The routine will list all billable charges from the 
 ;      INTEGRATED BILLING ACTION file (#350) which have a 
 ;      status of INCOMPLETE or COMPLETE.
 ;
 ;        o  STATUS (#.05) is INCOMPLETE (coded value is 1)
 ;        o  STATUS (#.05) is COMPLETE (coded value is 2)
 ;
 ;
 ; check site parameter
 S IBPAR=$P(^IBE(350.9,1,1),"^",20)
 I 'IBPAR W !!,"Cannot proceed!  The field HOLD MT BILLS W/INS (#1.2) must be set to 'YES'",!,"in your IB SITE PARAMETERS file (#350.9).",! G END
 ;
 N IBFIX,IBPOST S IBPOST=0
 D DT^DICRW,HOME^%ZIS
 W !!,?5,"********************************************************************"
 W !,?5,"* This CLEAN-UP option is associated with patch IB*2*95 and should",?72,"*",!,?5,"* be deleted after all related IB Actions are processed.",?72,"*"
 W !,?5,"********************************************************************"
 W !!!,"Select the Action you want to perform:"
 W !!,"   1. List all INTEGRATED BILLING ACTIONS with a status of INCOMPLETE."
 W !,"   2. List all INTEGRATED BILLING ACTIONS with a status of COMPLETE/"
 W !,"      PENDING AR."
 W !,"   3. Repost INTEGRATED BILLING ACTIONS with a status of COMPLETE/"
 W !,"      PENDING AR and pass these charges to AR.",!
 ;
 S DIR(0)="LO^1:3:0"
 S DIR("A")="Select action",DIR("B")="1",DIR("?",1)="  Enter '1' or '2' to print reports.",DIR("?")="  Enter '3' to process 'COMPLETE' IB Actions to AR."
 D ^DIR K DIR G:$D(DIRUT) END S IBFIX=+Y
 ;
 I IBFIX<3 W !!!,"Please select a device to print the list of charges.  The report",!,"only requires 80 columns for the output.",!
 ;
 I IBFIX=3 D PROC
 G:IBFIX<1 END
 ;
 W:IBPOST !!,"Reposting IB Actions is CPU intensive.  Queue to run after working hours!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBOHFIX",ZTDESC="CLEAN-UP FOR PATCH IB*2*95",ZTSAVE("IB*")="" D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.") K IO("Q") D HOME^%ZIS G END
 ;
DQ U IO
 N IBQUIT,IBPAGE,IBNOW,IBLINE,IBCRT,IBBOT,IBN,DFN,IBNAME
 S (IBPAGE,IBCRT,IBQUIT)=0,IBBOT=5 I $E(IOST,1,2)="C-" S IBCRT=1,IBBOT=7
 S IBLINE="",$P(IBLINE,"-",IOM+1)=""
 ;
 I IBCRT W @IOF
 D:IBPOST LIST,REPOST,LOOP,END
 D:'IBPOST LIST,LOOP,END
 Q
 ;
LOOP ;begin print process
 D HDR Q:IBQUIT
 I '$D(^TMP($J,"IBFIX")) W !!,?5,"*** There are NO RECORDS to print. ***",!! Q
 S IBNAME="" F  S IBNAME=$O(^TMP($J,"IBFIX",IBNAME)) Q:IBNAME=""!(IBQUIT)  S DFN=0 F  S DFN=$O(^TMP($J,"IBFIX",IBNAME,DFN)) Q:'DFN!(IBQUIT)  D
 . D PRNTPAT Q:IBQUIT  S IBN=0 F  S IBN=$O(^TMP($J,"IBFIX",IBNAME,DFN,IBN)) Q:'IBN!(IBQUIT)  D
 ..D PRNTCHG:'IBQUIT
 Q
 ;
PRNTPAT ; print patient info
 S IBPT=$$PT^IBEFUNC(DFN)
 W !!,$P(IBPT,"^")_" ("_$P(IBPT,"^",3)_")"
 Q
 ;
PRNTCHG ; print IB Action info
 N IBND,IBND1,IBACT,IBTYPE,IBCHG,IBSTAT,IBNOW,IBFDT,IBFR,IBTO
 S IBND=$G(^IB(IBN,0))
 S IBND1=$G(^IB(IBN,1))
 S IBACT=+IBND
 S IBFDT=$P(IBND,"^",14)
 S IBFR=$$DAT1^IBOUTL($S(IBFDT:IBFDT,1:$P(IBND1,"^",2)))
 S IBTO=$$DAT1^IBOUTL($P(IBND,"^",15))
 S IBTYPE=$E($P(IBND,"^",8),1,18)
 S IBCHG=$J(+$P(IBND,"^",7),9,2)
 S IBSTAT=$P(^IBE(350.21,+$P(IBND,"^",5),0),"^")
 W !,IBACT,?14,IBFR,?24,IBTO,?34,IBTYPE,?54,IBSTAT,?70,IBCHG
 I $Y>(IOSL-5) D HDR
 Q
 ;
 ;
LIST ; Find INCOMPLETE and COMPLETE charges from file #350.
 K ^TMP($J)
 N DFN,IBTYP,IBCOST,IBPT
 S (IBPAGE,IBQUIT)=0
 S:IBPOST IBFIX=2
 S IBN=0 F  S IBN=$O(^IB("AC",IBFIX,IBN)) Q:'IBN  D
 .S IBND=$G(^IB(IBN,0)),IBACT=+$P(IBND,"^",3) Q:IBACT=0
 .Q:$P(IBND,"^",5)'=IBFIX
 .Q:$P(^IBE(350.1,IBACT,0),"^",5)>3
 .S DFN=$P(IBND,"^",2)
 .Q:'DFN
 .S IBPT=$P($$PT^IBEFUNC(DFN),"^")
 .S IBCOST=$P(IBND,"^",7) Q:'IBCOST
 .Q:$P(IBND,"^",4)["405:"
 .Q:$P(IBND,"^",4)=""
 .S ^TMP($J,"IBFIX",IBPT,DFN,IBN)=""
 .Q
 Q
 ;
HDR ; Print report page header.
 ;
 Q:IBQUIT
 I IBCRT,$Y>1 D  Q:IBQUIT
 .F  Q:$Y>(IOSL-3)  W !
 .N T R "    Press RETURN to continue",T:DTIME I '$T!(T["^") S IBQUIT=1 Q
 S IBPAGE=IBPAGE+1 W @IOF,"INTEGRATED BILLING Clean-up for Patch IB*2*95     ","   Page: ",IBPAGE,!,IBLINE
 W !,"Name",!,"Action ID",?14,"Bill Fr",?24,"Bill To",?34,"Charge Type",?54,"Status",?72,"Charge",!,IBLINE,!
 Q
 ;
 ;
REPOST ; attempt to repost charge to Filer
 N IBATYP,IBDUZ
 S IBNAME="" F  S IBNAME=$O(^TMP($J,"IBFIX",IBNAME)) Q:IBNAME=""!(IBQUIT)  S DFN=0 F  S DFN=$O(^TMP($J,"IBFIX",IBNAME,DFN)) Q:'DFN!(IBQUIT)  D
 . S IBN=0 F  S IBN=$O(^TMP($J,"IBFIX",IBNAME,DFN,IBN)) Q:'IBN!(IBQUIT)  D
 ..N IBND,DFN,IBATYP,IBNOS,IBSEQNO
 ..D NOW^%DTC S IBNOW=%
 ..S IBND=$G(^IB(IBN,0))
 ..S IBNOS=IBN
 ..S DFN=$P(IBND,"^",2)
 ..S IBATYP=$P(IBND,"^",3)
 ..S IBSEQNO=$P(^IBE(350.1,IBATYP,0),"^",5)
 ..S IBDUZ=DUZ
 ..I DFN,IBSEQNO,IBDUZ,IBNOS D ^IBAFIL
 ..Q
 .Q
 Q
 ;
PAUSE S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
PROC W !!,"This selection will attempt to process the IB actions with a status of",!,"COMPLETE.  Some of these IB Actions will be placed ON HOLD with the ON HOLD"
 W !,"DATE set to TODAY, while other IB Actions will be passed to AR and patients",!,"will be billed IMMEDIATELY.",!!
 S DIR(0)="Y",DIR("A")="Are you SURE you want to process these actions",DIR("B")="NO"
 S DIR("?")="Enter 'Y' or 'YES' to update and pass these charges, or 'N', or '^' to quit."
 D ^DIR K DIR S IBPOST=+Y I 'Y!($D(DIRUT))!($D(DUOUT)) S IBFIX=-1 W "   << Nothing updated. >>",!
 Q
 ;
END K ^TMP($J)
 K IBPAR,Y
 Q
 ;
 ;end IBOHFIX
