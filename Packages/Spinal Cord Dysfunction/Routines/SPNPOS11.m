SPNPOS11 ;SD/WDE/Post action for patch 11;11/5/1999
 ;;2.0;Spinal Cord Dysfunction;**11**;01/02/97
EN ;
 ;task the transmission of 154 record with an x to the AAC
 D TASK
 ;set senD alerts to YES
 D SET
 Q
SET ;set send alerts to Yes
 ;    spnmg=the ifn value of the spnl scd coordinator mail group
 S SPNSITE="",SPNSITE=$O(^SPNL(154.91,"B",SPNSITE)) Q:SPNSITE=""
 S SPNIFN="",SPNIFN=$O(^SPNL(154.91,"B",SPNSITE,SPNIFN)) Q:SPNIFN=""
 S DIE=154.91,DR="9///Y",DA=SPNIFN
 D ^DIE
 K DIE,DA,SPNIFN,SPNSITE
 Q
 ;
TASK ;set up task to transmit the x records from 154
 S ZTDESC="Transmit SCD data to the AAC"
 S ZTRTN="EN^SPNXMIT"
 ;set up date/time to run
 D NOW^%DTC S X1=X,X2=1 D C^%DTC S ZTDTH=X_".1900"
 S ZTIO=""
 S ZTSAVE(DUZ)=DUZ D ^%ZTLOAD
 K ZTSK,ZTSAVE,ZTIO,ZTDTH,X,X1,X2,ZTRTN,ZTDESC
 Q
