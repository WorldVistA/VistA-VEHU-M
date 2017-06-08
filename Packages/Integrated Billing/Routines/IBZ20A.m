IBZ20A ;ALB/CPM - FIND REFILLS IN CLAIMS TRACKING ; 24-FEB-95
 ;;NOT for General Distribution.
 ;
 ;  This routine will be distributed by the Medical Center Mgmt
 ;  Support team to sites who have experienced problems with the
 ;  autobilling of prescription refills after the installation
 ;  of Outpatient Pharmacy v6.0.  The updated routine IBTRKR31,
 ;  which will eventually be patched, must accompany IBZ20A*.
 ;
EN ; Routine entry point
 S X=$O(^VA(200,+$G(DUZ),0))
 I X']""!($G(DUZ(0))'="@") W !!?3,"Please set the variable DUZ to a valid entry in the NEW PERSON file,",!?3,"and set the variable DUZ(0) to ""@"" before you continue." G ENQ
 ;
 I $G(^PS(59.7,1,49.99))<6 W !!,"You haven't installed Outpatient Pharmacy v6.0 yet!" G ENQ
 I '$P($G(^IBE(350.9,1,6)),"^",4) W !!,"Tracking of Prescription Refills is currrently turned off!" G ENQ
 ;
 ; - check PSO v6
 S IBV6=$P($G(^PS(59.7,1,49.99)),"^",2)
 I 'IBV6 W !!,"You haven't installed Outpatient Pharmacy v6.0 yet!" G ENQ
 ;
 ; - check for non-billable reason of OTHER
 S IBRMARK=$O(^IBE(356.8,"B","OTHER",0))
 I 'IBRMARK W !!,"You don't have the Non-Billable Reason 'OTHER' defined in your system!" G ENQ
 ;
 ; - check for tracking type of rx refill
 S IBETYP=$O(^IBE(356.6,"AC",4,0))
 I 'IBETYP W !!,"You don't have the CLAIMS TRACKING TYPE of PRESCRIPTION REFILL defined!" G ENQ
 ;
 ; - report introduction
 W !?6,"This report is designed to help sites complete autobilling of"
 W !?6,"prescription refills which were captured in Claims Tracking"
 W !?6,"while Outpatient Pharmacy v5.6 was installed, but autobilled"
 W !?6,"after the installation of v6.0.  The autobiller proceeded to"
 W !?6,"flag these refills as non-billable, using the Reason Not Billable"
 W !?6,"of 'OTHER.'"
 ;
 W !!?6,"You may use this report to identify these refills in Claims Tracking,"
 W !?6,"and then to delete the Reason Not Billable.  Deleting the reason will"
 W !?6,"re-set the Earliest Autobill Date in Claims Tracking, and then the"
 W !?6,"autobiller will again attempt to create bills for these subscriptions."
 ;
 W !!?6,"In order for the autobiller to not re-flag these refills as not"
 W !?6,"billable, you must be sure that you have the updated version of"
 W !?6,"IBTRKR31 (which should have been sent to you) before you run this"
 W !?6,"routine in the 'delete' mode.  When selecting a date range for"
 W !?6,"refills, your end date must be prior to the v6.0 install date, because"
 W !?6,"those refills which were filled after the v6.0 installation should"
 W !?6,"be properly tracked and billed by the system."
 ;
 W !!?6,"Outpatient Pharmacy v6.0 Installation Date: ",$$DAT2^IBOUTL(IBV6)
 ;
 ; - make sure date range is prior to OPT v6
 D DATE^IBOUTL
 I IBBDT<1!(IBEDT<1) G ENQ
 I IBEDT'<IBV6 W !!,"The End Date must be prior to the Outpatient Pharmacy v6.0 install date!" G ENQ
 ;
 ; - allow them to run a report without deleting the RNB
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D HLP^IBZ20A"
 S DIR("A")="Do you want to delete the Reason Not Billable for the refills"
 W ! D ^DIR K DIR S IBDEL=+Y I $D(DIRUT)!$D(DTOUT) G ENQ
 ;
 ; - get device and go
 W !!,"Please note that this output requires only 80 columns.",!
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="^IBZ20A1",ZTDESC="IB - FIND RX REFILLS IN CLAIMS TRACKING"
 .F I="IBBDT","IBEDT","IBDEL","IBV6","IBRMARK","IBETYP" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q")
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK
 ;
 U IO D ^IBZ20A1
 ;
ENQ D ^%ZISC
 K IBBDT,IBEDT,IBRMARK,IBDEL,IBV6,IBRMARK,IBETYP
 Q
 ;
 ;
HLP ; Reader Help.
 W !!,"When you first run this report, you should answer 'NO' so you can generate"
 W !,"a list of all Rx refill Claims Tracking entries which need to have the"
 W !,"Reason Not Billable (of OTHER) deleted, so the autobiller may try to bill"
 W !,"these refills again.  Once you've reviewed the initial report and are"
 W !,"content that the report is picking up all appropriate CT entries, you"
 W !,"can rerun the report and answer 'YES.'  You will get the same report,"
 W !,"but in the process the RNB for the CT entries will be deleted."
 Q
