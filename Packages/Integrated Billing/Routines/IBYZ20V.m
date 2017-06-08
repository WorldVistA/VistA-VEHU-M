IBYZ20V ;ALB/CPM - LOCATE/BILL PRESCRIPTIONS ; 21-MAR-97
 ;;FOR USE ONLY IN THE VHA CHICAGO HEALTHCARE SYSTEM
 ;
 ; This routine has been designed to allow the user to queue
 ; a job to locate or bill prescriptions which were not billed
 ; automatically by the system in real-time when the prescription
 ; was released (for any variety of reasons).  The user may
 ; select a date range in which prescriptions/refills were filled.
 ;
 ; Please note that this routine is currently configured to only
 ; bill prescriptions with a Pharmacy Patient Status of OPT NSC.
 ; Thus, it will not be necessary to determine if any of the
 ; prescriptions that will be analyzed are related to a veteran's
 ; service-connected condition.
 ;
 ;
 ; - check DUZ
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must also be defined to run this routine.",! Q
 ;
 ; - make sure there is a valid pointer to the patient status OPT NSC
 I '$O(^PS(53,"B","OPT NSC",0)) W !!,"You do not have a proper record for the entry OPT NSC in file #53!" Q
 ;
 ; - make sure the Action Type PSO NSC RX COPAY NEW is entry #1
 I '$D(^IBE(350.1,"B","PSO NSC RX COPAY NEW",1)) W !!,"The Action Type 'PSO NSC RX COPAY NEW' in file #350.1 is not entry #1." Q
 ;
 ; - explain job
 D INTRO
 ;
 ; - be sure that the Pharmacy service is right...
 W !!,"First, I need a pointer to your Pharmacy Service."
 W !,"Please enter an appropriate Pharmacy Division from your system:"
 ;S PSOREO=1 D OREO^PSOLSET I '$D(PSOSITE) G Q
 D ^PSOLSET I '$D(PSOSITE) G Q
 S IBSERV=+$P($G(^PS(59,+PSOSITE,"IB")),"^")
 I '$D(^IBE(350.1,"ANEW",IBSERV,1,1))!'$D(^DIC(49,IBSERV,0)) D  G Q
 .W !!,*7,"The Pharmacy SERVICE/SECTION value is incorrect in the Pharmacy Site File.",!!
 ;
 ; - run in scan or bill mode?
 S DIR(0)="SA^S:SCAN;B:BILL",DIR("A")="Run this program in (S)can or (B)ill mode: ",DIR("B")="SCAN"
 W ! D ^DIR K DIR S IBMODE=Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 ;
 ; -  want a detailed report?
 S DIR(0)="Y",DIR("A")="Do you wish to generate a detailed report"
 W ! D ^DIR K DIR S IBRPT=Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 ;
 ; - select report device
 I IBRPT S %ZIS="N",%ZIS("B")="",%ZIS("A")="Select a 132-column report print device: " D ^%ZIS G:POP Q
 ;
 ; - allow user to specify date range
 S DIR(0)="DA^2860101:NOW:EX",DIR("A")="Start with FILL DATE: "
 S DIR("B")="DEC 01, 1996" W ! D ^DIR K DIR S IBBDT=+Y G:'Y Q
 S DIR(0)="DA^"_+Y_":NOW:EX",DIR("A")="     Go to FILL DATE: "
 S DIR("B")="MAR 14, 1997" D ^DIR K DIR S IBEDT=+Y G:'Y Q
 ;
 ; - go on?
 S DIR(0)="Y",DIR("A")="Do you want to queue this job now"
 W !! D ^DIR K DIR I 'Y G Q
 ;
 ; - queue the job
 W !!,"Good.  Now please enter the date and time to execute this job...",!
 S ZTRTN="DQ^IBYZ20V1",ZTDESC="IB - BILL PRESCRIPTIONS"
 S ZTIO=$S(IBRPT:ION,1:"")
 F I="IBBDT","IBEDT","IBMODE","IBRPT","IBSERV"  S ZTSAVE(I)=""
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"")
 ;
Q D HOME^%ZIS
 K IBBDT,IBEDT,IBMODE,IBRPT,IBSERV,X,X1,Y,DIRUT,DUOUT,DTOUT,DIROUT,ZTSK
 K POP,PSOREO,PSOSITE,PSOBAR1,PSOBARS,PSOCLC,PSOCNT,PSODIV,PSODTCUT
 K PSOINST,PSOPAR,PSOPAR7,PSOPRPAS,PSOREO,PSOSITE,PSOSYS
 Q
 ;
 ;
INTRO ; Introductory Text
 N IBI,IBN,IBX
 S IBN=$S($P($G(^VA(200,DUZ,.1)),"^",4)]"":$P(^(.1),"^",4),1:$P(^(0),"^"))
 W !,"Hello ",IBN,",",!
 F IBI=1:1 S IBX=$P($T(INTRTXT+IBI),";;",2,999) Q:IBX="$END"  W !,IBX
 Q
 ;
INTRTXT ; Job Description
 ;;This program allows you to find or bill (the $2.00 copay to)
 ;;prescriptions which weren't billed automatically due to the
 ;;Pharmacy patient status OPT NSC being set to exempt copay
 ;;billing.  You must enter a date range to examine all prescriptions
 ;;and refills which were filled in that range.  You must also
 ;;specify whether to run this program in 'scan' or 'bill' mode.
 ;;Scan mode will not update your system; it is designed to give
 ;;you an indication of the number of prescriptions to be billed.
 ;;Bill mode will actually create charges for all prescriptions
 ;;which need to be billed.
 ;; 
 ;;You must queue this job to run.  In Scan mode the job can be run
 ;;at any time.  When the job is completed, you will receive a mailman
 ;;message which describes the results of the job.
 ;;$END
