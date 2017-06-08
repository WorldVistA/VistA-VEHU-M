ZLVTEST    ;LV/PB - Create Test data for Recall, EWL, NEAR
 ;;1.0;LongView Scheduling;**1**;JUL 9, 2013;Build 11
 ;This routine has multiple RPCs to create test data for the mobile Scheduling apps
 ;
 ;DO NOT DISTRIBUTE TO THE VA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ;
RECALL(RESULTS,DFN,CLINIC,RECALLDT,PTRECDT,PROVIDER,LEN,FAST,TEST,USER,COMMENT) ; adds new patients to the Recall List
 ; Input parameter is the Patient DFN
 S RESULTS(0)=1
 I $G(DFN)="" S RESULTS(0)="0^DFN is not defined" Q
 I '$D(^DPT(DFN,0)) S RESULTS(0)="0^Not a patient in this system." Q
 I $G(CLINIC)="" S RESULTS(0)="0^Clinic not provided." Q
 I '$D(^SC(CLINIC,0)) S RESULTS(0)="0^Clinic not in the Hospital Location File." Q
 I ($G(RECALLDT)=""!($G(RECALLDT)'>DT)) S RESULTS(0)="0^Provider Recall date not provided." Q
 I ($G(PTRECDT)=""!($G(PTRECDT)'>DT)) S RESULTS(0)="0^Patient recall date not provided." Q
 I ($G(PROVIDER)=""!('$D(^VA(200,$G(PROVIDER),0)))) S RESULTS(0)="0^Provider IEN not provided." Q
 I $G(LEN)'>0 S RESULTS(0)="0^Appointment length not provided." Q
 I $G(FAST)="" S RESULTS(0)="0^FAST code not provided." Q
 I $G(TEST)'>0 S RESULTS(0)="0^TEST code not provided." Q
 I ($G(USER)'>0!('$D(^VA(200,$G(USER),0)))) S RESULTS(0)="0^User IEN not provided." Q
 D CHK I ERR=1 S RESULTS(0)="0^Duplicate Recall List Entry" Q
 S (DIC,DIE)="^SD(403.5,",DIC(0)="Z",X=DFN,DLAYGO=403.5 D FILE^DICN S NUM=+Y
 S DA=NUM,DR="4.5////"_$G(CLINIC)_";4////"_$G(PROVIDER)_";3////"_$G(FAST)_";4.7////"_$G(LEN)_";5////"_$G(RECALLDT)_";7////"_$G(PTRECDT)_";2.5////"_$G(COMMENT)_";3////"_$G(TEST)_";7////"_$G(USER)
 D ^DIE
 ;S DA=NUM,DR="[SDRR RECALL CARD ADD]",DIE("NO^")="Not Allowed" D ^DIE
 I $D(DTOUT) D DELETE
 K DIC,DIE,DR,D0,DA,DLAYGO,NUM,PROV,X,Y,Z,OK,RDT,DIR,DTOUT
 Q
DELETE ;delete new incomplete record and display message
 S DIK=DIE
 D ^DIK K DIK
 S RESULTS(0)="0^All required data was not provided. Recall was not created!"
 Q
NEAR(RESULTS,DFN) ;Put a patient on the near list
 ;use only for testing purposes.
 S RESULTS(0)=1
 I $G(DFN)="" S RESULTS(0)="0^DFN IS REQUIRED" Q
 I '$D(^DPT($G(DFN),0)) S RESULTS(0)="0^NOT A PATIENT" Q
 D NOW^%DTC S REQDT=$$FMADD^XLFDT(%,30,0,0,0)
 S DA=DFN,DIE="^DPT(",DR="1010.157////1;1010.159////1;1010.1511////"_REQDT_";1010.161////@;1010.162////@;1010.163////@;1010.164////@"
 D ^DIE
 K DFN,%,REQDT,DIE,DA,DR
 S RESULTS(0)=1
 Q
GETPAT(RESULTS) ; Gets a list of outpatients
 S XX=0,CNT=0 F  S XX=$O(^DPT(XX)) Q:XX'>0  D
 .K PAT,FNAME
 .S PAT=$P(^DPT(XX,0),"^"),FNAME=$P(PAT,",",2)
 .I (($G(FNAME)="PATIENT")!($G(FNAME)="OUTPATIENT")) S RESULTS(CNT)=XX_"^"_$G(PAT),CNT=CNT+1
 Q
CHK ; checks to see if the patient is on the recall list for the clinic and provider date
 S ERR=0
 S XX=0 F  S XX=$O(^SC(403.5,"B",DFN,XX)) Q:XX'>0  D
 .S NODE=$G(^SC(403.5,XX,0))
 .I ($P(NODE,"^",2)=CLINIC&$P(NODE,"^",6)=RECALLDT&$P(NODE,"^",5)=PROVIDER) S ERR=1
 Q
NEWEWL(RV,SDWLD) ; ZLV EWL NEW
 I $G(SDWLD)="" S RV(0)="0^SDWLD List missing." Q
 S SDWLD("WLTYPE")=$P($G(SDWLD),"^",1)
 S SDWLD("PATIENT")=$P($G(SDWLD),"^",2)
 S SDWLD("INSTITUTION")=$P($G(SDWLD),"^",3)
 S SDWLD("WAITFOR")=$P($G(SDWLD),"^",4)
 S SDWLD("PRIORITY")=$P($G(SDWLD),"^",5)
 S SDWLD("REQBY")=$P($G(SDWLD),"^",6)
 S SDWLD("PROVIDER")=$P($G(SDWLD),"^",7)
 S SDWLD("SCPRCNT")=$P($G(SDWLD),"^",8)
 S SDWLD("SCPRIORITY")=$P($G(SDWLD),"^",9)
 S SDWLD("DSRDDT")=$P($G(SDWLD),"^",10)
 S SDWLD("CMNTS")=$P($G(SDWLD),"^",11)
 S SDWLD("ENRSTAT")=$P($G(SDWLD),"^",12)
 S SDWLD("ENRDU")=$P($G(SDWLD),"^",13)
 S SDWLD("ENRDF")=$P($G(SDWLD),"^",14)
 S SDWLD("TICKLER")=$P($G(SDWLD),"^",15)
 S SDWLD("CHDCLINP")=$P($G(SDWLD),"^",16)
 I SDWLD("PATIENT")'>0 S RV(0)="0^INVPARAM PATIENT" Q
 I SDWLD("INSTITUTION")'>0 S RV(0)="0^INVPARAM INSTITUTION" Q
 I SDWLD("WLTYPE")="" S RV(0)="0^INVPARAM WLTYPE" Q
 I SDWLD("PRIORITY")="" S RV(0)="0^INVPARAM PRIORITY" Q
 I SDWLD("DSRDDT")="" S RV(0)="0^INVPARAM SDRDD" Q
 I SDWLD("WLTYPE")=3,SDWLD("WLTYPE")=4 D
 .K ERR
 .I SDWLD("REQBY")'=1,$G(SDWL("REQBY"))'=2 S ERR=1
 I ERR=1 K ERR S RV(0)="0^INVPARAM REQBY" Q
 I $G(SDWLD("WLTYPE"))'>0 S RV(0)="0^INVPARAM WLTYPE" Q
 I $G(SDWLD("WLTYPE"))>5 S RV(0)="0^INVPARAM WLTYPE" Q
 S XX=$G(SDWLD("PATIENT")) I '$D(^DPT(XX,0)) K XX S RV(0)="0^INVPARAM PATIENT" Q
 S XX=$G(SDWLD("INSTITUTION")) I '$D(^DIC(4,XX,0)) K XX S RV(0)="0^INPARAM INSTITUTION" Q
 I $G(SDWLD("PRIORITY"))'="A",$G(SDWLD("PRIORITY"))'="F" S RV(0)="0^INVPARAM PRIORITY" Q
 I $G(SDWLD("WLTYPE"))=3 D
 .K ERR
 .I ($G(SDWLD("REQBY"))'=1&($G(SDWLD("REQBY"))'=2)) S ERR=1
 I $G(SDWLD("WLTYPE"))=4 D
 .K ERR
 .I ($G(SDWLD("REQBY"))'=1&($G(SDWLD("REQBY"))'=2)) S ERR=1
 I $G(ERR)=1 K ERR S RV(0)="0^INVPARAM REQUEST BY" Q
 N STATUS,RESULT S STATUS=$$NEW^SDWLAPI1(.RESULT,.SDWLD)
 I 'STATUS S RV=-1
 I $G(STATUS) S RV(0)=1
 ;D MERGE^SDMRPC(.RV,.RESULT)
 Q
