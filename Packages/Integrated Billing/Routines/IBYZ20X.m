IBYZ20X ;ALB/CPM - X-REF CLAIMS IN FILE #399 ;4/17/97  14:35
 ;;FOR USE ONLY AT VAMC POPLAR BLUFF (#647)
 ;
 ; This routine will find and re-cross reference claims in
 ; file #399, starting with claims entered on or around 12/1/96.
 ;
 ;
 ; - check DUZ
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must also be defined to run this routine.",! Q
 ;
 ; - find the starting point to examine receivables
 S IBAR=0,IBSTD=2961114
 F  S IBAR=$O(^DGCR(399,"APD",IBSTD,0)) Q:IBAR  S IBSTD=$$FMADD^XLFDT(IBSTD,1) Q:IBSTD>2970101
 I 'IBAR W !!,"I can't find a starting point!  Call Chris." G Q
 ;
 ; - explain job
 D INTRO
 ;
 ; - go on?
 S DIR(0)="Y",DIR("A")="Do you want to queue this job now"
 W !! D ^DIR K DIR I 'Y G Q
 ;
 ; - queue the job
 W !!,"Good.  Now please enter the date and time to execute this job...",!
 S ZTRTN="DQ^IBYZ20X",ZTIO="",ZTSAVE("IBAR")=""
 S ZTDESC="IB - RE-CROSS REFERENCE CLAIMS IN FILE #399"
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"")
Q K X,X1,Y,DIRUT,DUOUT,DTOUT,DIROUT,IBAR,IBSTD,ZTSK,ZTRTN,ZTIO,ZTDESC
 Q
 ;
 ;
INTRO ; Introductory Text
 N IBI,IBN,IBX
 S IBN=$S($P($G(^VA(200,DUZ,.1)),"^",4)]"":$P(^(.1),"^",4),1:$P(^(0),"^"))
 W !!,"Hello ",IBN,",",!
 F IBI=1:1 S IBX=$P($T(INTRTXT+IBI),";;",2,999) Q:IBX="$END"  W !,IBX
 Q
 ;
INTRTXT ; Job Description
 ;;This program will allow you to queue a job to fix all claims
 ;;in file #399 which have lost either its 'B' or 'C' cross-reference.
 ;;
 ;;You should queue this job to run after normal business hours.  You
 ;;will receive a mail message when the job has been completed.  This
 ;;program may be re-run at any time.
 ;;$END
 ;
 ;
DQ ; Task entry point.
 S (IBCT,IBCTR,IBCTN,IBCTX)=0
 D NOW^%DTC S IBBEXDT=%
 ;
 ; - examine all receivables in file #430, begining at the 'start point'
 D PROC
 ;
 ; - send a task completion bulletin
 D NOW^%DTC S IBEEXDT=%
 D BULL
 ;
DQQ K IBBEXDT,IBEEXDT,IBCT,IBCTR,IBCTN,IBCTX,IBAR,%
 Q
 ;
 ;
PROC ; Examine receivables from the 'start point' - approximately 12/1/96
 ;
 S IBC=IBAR-1
 F  S IBC=$O(^PRCA(430,IBC)) Q:'IBC  S IBARD=$G(^(IBC,0)) D
 .;
 .S IBCT=IBCT+1
 .;
 .Q:$P(IBARD,"^",2)'=9  ; not a Reimbursable insurance bill
 .;
 .S IBCTR=IBCTR+1
 .;
 .; - if there is no claim (no .01 field), count the AR.
 .I $P($G(^DGCR(399,IBC,0)),"^")="" S IBCTN=IBCTN+1 Q
 .;
 .S IBBN=$P($P(IBARD,"^"),"-",2),DFN=+$P(IBARD,"^",7)
 .;
 .; - re-cross reference the entry if there is no 'B' x-ref in #399
 .I IBBN]"",'$D(^DGCR(399,"B",IBBN,IBC)) D XREF^IBYZ20X1(IBC) Q
 .;
 .; - re-cross reference the entry if there is no 'B' x-ref in #399
 .I DFN,'$D(^DGCR(399,"C",DFN,IBC)) D XREF^IBYZ20X1(IBC)
 ;
 ;
PROCQ K DFN,IBARD,IBC,IBBN
 Q
 ;
 ;
BULL ; Generate the task completion bulletin.
 S XMSUB="Job Completion - Re-Cross Reference Claims in File #399"
 S XMDUZ="INTEGRATED BILLING",XMTEXT="IBT(",XMY(DUZ)=""
 K IBT
 ;
 S IBT(1)="The job to re-cross reference claims in file #399 has completed."
 S IBT(2)=" "
 S Y=IBBEXDT D D^DIQ S IBT(3)="                     Job Start Time: "_Y
 S Y=IBEEXDT D D^DIQ S IBT(4)="                       Job End Time: "_Y
 S IBT(5)=" "
 S IBT(6)="           Total number of receivables checked: "_IBCT
 S IBT(7)="      Number of Reimbursable Ins. AR's checked: "_IBCTR
 S IBT(8)="               AR's with NO claim in file #399: "_IBCTN
 S IBT(9)="          Number of claims re-cross referenced: "_IBCTX
 ;
 D ^XMD
 K IBT,XMSUB,XMTEXT,XMDUZ,XMY,Y
 Q
