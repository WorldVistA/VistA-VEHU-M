IBYZ20L ;ALB/CPM - REACTIVATE INACTIVE RX COPAY EXEMPTIONS ; 02-DEC-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**20**; 21-MAR-94
 ;
 ; This routine will check all Billing Patient exemptions in
 ; file #354 and check that the actual exemption record in file
 ; #354.1 (upon which the Billing Patient [current] exemption
 ; is based) is an active exemption.  If the associated exemption
 ; in #354.1 is determined, but found to be inactive, it will be
 ; reactivated.  The bug which incorrectly inactivated these
 ; exemptions is fixed with patch IB*2*20.
 ;
 ; The routine will count the number of exemptions that were
 ; activated and report that number to the user in a mailman message.
 ;
 ;
 ; - check DUZ
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must also be defined to run this routine.",! Q
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
 S ZTRTN="DQ^IBYZ20L",ZTIO="",ZTDESC="IB - REACTIVATE INACTIVE RX COPAY EXEMPTIONS"
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"")
Q K X,Y,DIRUT,DUOUT,DTOUR,DIROUT,ZTSK
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
 ;;This routine will check the 'current' Pharmacy copayment exemption
 ;;status of all veterans as it is stored in the BILLING PATIENT (#354)
 ;;file.  The check will be made by finding the associated exemption
 ;;in the BILLING EXEMPTIONS (#354.1) file.  Due to a bug which is
 ;;fixed with patch IB*2*20, some of these associated exemptions
 ;;may have been inactivated, which would cause the supported calls
 ;;DISP^IBARXEU and $$RXST^IBARXEU to return incorrect results.
 ;;
 ;;You have several thousand entries in #354 to be checked so this
 ;;routine may run for several minutes.  You should queue this
 ;;routine to run during off-hours.  The routine will re-activate,
 ;;if necessary, the associated exemption in #354.1 upon which the
 ;;current exemption in #354 is based.  I'll send you a mail
 ;;message when the job is completed which will include the total
 ;;number of exemptions which were re-activated.
 ;;$END
 ;
 ;
 ;
DQ ; Queued entry point to start the job.
 ;
 D NOW^%DTC S IBBDT=%
 ;
 D CHK ;  Check current exemptions and re-activate if necessary
 ;
 D NOW^%DTC S IBEDT=%
 ;
 D MAIL ; Send a bulletin with the results
 K IBCNT,IBBDT,IBEDT
 Q
 ;
 ;
CHK ; Check and reactivate rx copay exemptions, if necessary.
 S (DFN,IBCNT)=0
 F  S DFN=$O(^IBA(354,DFN)) Q:'DFN  S IBBP=$G(^(DFN,0)) I IBBP D
 .S IBDT=$P(IBBP,"^",3)  Q:'IBDT
 .S IBSTAT=$P(IBBP,"^",4),IBEXREA=$P(IBBP,"^",5)
 .;
 .S (IBG,IBB)=0
 .S IBXX=0 F  S IBXX=$O(^IBA(354.1,"APIDT",DFN,1,-IBDT,IBXX)) Q:'IBXX  D
 ..S IBD=$G(^IBA(354.1,IBXX,0)) Q:'IBD
 ..I DFN=$P(IBD,"^",2),IBSTAT=$P(IBD,"^",4),IBEXREA=$P(IBD,"^",5) D
 ...I '$P(IBD,"^",10) S IBB=IBXX
 ...I $P(IBD,"^",10) S IBG=1
 .;
 .I IBB,'IBG S IBCNT=IBCNT+1 D FIX
 ;
 K DFN,IBBP,IBDT,IBSTAT,IBEXREA,IBXX,IBD,IBB,IBG
 Q
 ;
FIX ; Inactive all exemptions and reactivate the valid exemption.
 ;  Required input variables:
 ;     DFN  --  Pointer to the patient in file #2
 ;    IBDT  --  The date on which to inactivate all exemptions
 ;     IBB  --  Pointer to the exemption in file #354.1 which
 ;              needs to be reactivated.
 ;
 D INACT^IBAUTL7(IBDT)
 S DIE="^IBA(354.1,",DA=IBB,DR=".1////1" D ^DIE K DIE,DA,DR
 Q
 ;
MAIL ; Send the bulletin
 S XMSUB="Job Completion - Reactivate Inactive Rx Copay Exemptions"
 S XMDUZ="INTEGRATED BILLING",XMTEXT="IBT(",XMY(DUZ)=""
 ;
 K IBT
 S IBT(1)="The job to reactivate inactive exemptions in file #354.1 has completed."
 S IBT(2)=" "
 S Y=IBBDT D D^DIQ S IBT(3)="Job Start Time: "_Y
 S Y=IBEDT D D^DIQ S IBT(4)="  Job End Time: "_Y
 S IBT(5)=" "
 S IBT(6)="Number of exemptions reactivated: "_IBCNT
 ;
 D ^XMD
 K IBT,XMSUB,XMTEXT,XMDUZ,XMY,Y
 Q
