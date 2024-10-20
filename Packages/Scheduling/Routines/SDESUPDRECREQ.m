SDESUPDRECREQ ;ALB/LAB,KML,MGD -  ;July 19, 2022
 ;;5.3;Scheduling;**803,805,809,820**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to $$LKUP^XPDKEY is supported by IA #1367
 ; Reference to OWNSKEY^XUSRB is supported by IA #3277
 ;
 ;INPUT:
 ;   RECALLIEN - sent for UPDATE of RECALL REQUEST only(Required for Update) IEN pointer to RECALL REMINDERS
 ;   DFN - (required) DFN Pointer to PATIENT file
 ;   ACCNO - (optional) Accession # (free-text 1-25 characters)
 ;   SDCMT - (optional) COMMENT (free-text 1-80 characters)
 ;   FASTING - (required) FAST/NON-FASTING  valid values:  FASTING,NON-FASTING,NONE
 ;   APPTP - (required) Test/App pointer to RECALL REMINDERS APPT TYPE file 403.51
 ;   RRPROVIEN - (required) Provider - Pointer to RECALL REMINDERS PROVIDERS file 403.54
 ;   CLINIEN - (required) Clinic pointer to HOSPITAL LOCATION file
 ;   APPTLEN - (optional) Length of Appointment  numeric between 10 and 120
 ;   DATE - (required) Recall Date in ISO8601 format (no time).  e.g., CCYY-MM-DD
 ;   RECPPDT- (optional) Recall Date (Per patient) in ISO8601 format (no time)  e.g., CCYY-MM-DD
 ;   DAPTDT- (optional) Date Reminder Sent in ISO8601 format (no time)  e.g., CCYY-MM-DD
 ;   USERIEN- (optional) User Who Entered Recall pointer to NEW PERSON file; default to current user
 ;   SECPDT- (optional) Second Print Date in ISO8601 format (no time) e.g., CCYY-MM-DD
 ;   SDENTDT - (optional) Date recall entered in ISO8601 format  e.g., CCYY-MM-DD)
 ;   EAS- (optional) EAS Tracking Number
 ;
 ;RETURN:
 Q
 ;
CREATERECREQ(RETN,DFN,ACCNO,SDCMT,FASTING,APPTP,RRPROVIEN,CLINIEN,APPTLEN,DATE,RECPPDT,DAPTDT,USERIEN,SECPDT,SDENTDT,EAS) ;CREATE recall request
 N POP,SDRECREQ,RECALLIEN,SDCREATE,SDFDA,SDMSG,SDIEN
 S RECALLIEN="+1",SDCREATE=1
 S POP=0
 D VALIDATE
 I POP D BLDJSON
 Q:POP
 D DATACONV
 D BLDREC
 D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 I $D(SDMSG) S NUM=134 D CALLERROR,BLDJSON Q
 S SDRECREQ("RecallReqCreate","IEN")=SDIEN(1)
 D BLDJSON
 Q
 ;
UPDRECALLREQ(RETN,RECALLIEN,DFN,ACCNO,SDCMT,FASTING,APPTP,RRPROVIEN,CLINIEN,APPTLEN,DATE,RECPPDT,DAPTDT,USERIEN,SECPDT,EAS) ;update recall request
 N POP,SDRECREQ,SDFDA,SDMSG,SDIEN
 S POP=0,SDCREATE=0
 D VALIDATE
 I POP D BLDJSON
 Q:POP
 D DATACONV
 D BLDREC
 D FILE^DIE(,"SDFDA","SDMSG")
 I $D(SDMSG) S NUM=134 D CALLERROR,BLDJSON Q
 S SDRECREQ("RecallReqEdit","IEN")=RECALLIEN
 D BLDJSON
 Q
 ;
DATACONV ;make any data conversion changes
 S APPTLEN=$G(APPTLEN) I APPTLEN'="" S:((+APPTLEN<10)!(+APPTLEN>120)) APPTLEN=""
 S RECPPDT=$G(RECPPDT) S RECPPDT=$$ISOTFM^SDAMUTDT(RECPPDT) I RECPPDT=-1 S RECPPDT=""  ;VSE-2396
 S DAPTDT=$G(DAPTDT) S DAPTDT=$$ISOTFM^SDAMUTDT(DAPTDT) I DAPTDT=-1 S DAPTDT=""  ;VSE-2396
 S USERIEN=$G(USERIEN) I (USERIEN="")!('$D(^VA(200,+USERIEN))) S USERIEN=DUZ
 S SECPDT=$G(SECPDT) I SECPDT'="" S SECPDT=$$ISOTFM^SDAMUTDT(SECPDT) I SECPDT=-1 S SECPDT="" ;;VSE-2396
 S EAS=$G(EAS)
 S SDCMT=$TR($G(SDCMT),"^"," ")
 Q
 ;
VALIDATE ;validate input parameters
 N NUM
 I $G(RECALLIEN)="" S POP=1,NUM=16 D CALLERROR Q
 I (RECALLIEN'="+1")&('$D(^SD(403.5,+RECALLIEN))) S POP=1,NUM=17 D CALLERROR Q
 I '+$G(DFN) S POP=1,NUM=1 D CALLERROR Q
 I '$D(^DPT(+DFN,0)) S POP=1,NUM=2 D CALLERROR Q
 S FASTING=$G(FASTING)
 I FASTING="" S POP=1,NUM=141 D CALLERROR Q
 S FASTING=$S($$UP^XLFSTR(FASTING)="FASTING":"f",$$UP^XLFSTR(FASTING)="NON-FASTING":"n",$$UP^XLFSTR(FASTING)="F":"f",$$UP^XLFSTR(FASTING)="N":"n",FASTING="@":"@",1:138)
 I FASTING=138 S POP=1,NUM=138 D CALLERROR
 Q:POP
 S APPTP=$G(APPTP) I '(+APPTP) s POP=1,NUM=139 D CALLERROR Q
 I '$D(^SD(403.51,+APPTP)) S POP=1,NUM=132 D CALLERROR Q
 ;check provider (required)
 I '+$G(RRPROVIEN) S POP=1,NUM=137 D CALLERROR Q
 I +RRPROVIEN I '$D(^SD(403.54,+RRPROVIEN)) S POP=1,NUM=131 D CALLERROR Q
 ;check that user has the correct security key
 S NUM=$$KEY(RECALLIEN) I NUM S POP=1 D CALLERROR Q
 ;check Clinic (required)
 S CLINIEN=$G(CLINIEN)
 I '+CLINIEN S POP=1,NUM=18 D CALLERROR Q
 I +CLINIEN I '$D(^SC(+CLINIEN)) S POP=1,NUM=19 D CALLERROR Q
 ;check Recall Date (required)
 S DATE=$G(DATE) I DATE="" S POP=1,NUM=140 D CALLERROR Q
 S DATE=$$ISOTFM^SDAMUTDT(DATE) I DATE=-1 S POP=1,NUM=133 D CALLERROR Q  ;VSE-2396
 S SDENTDT=$G(SDENTDT)
 I (SDCREATE)&($G(SDENTDT)'="") S SDENTDT=$$ISOTFM^SDAMUTDT(SDENTDT)  ;VSE-2396
 I (SDENTDT=-1)!(SDENTDT="") S SDENTDT=DT ;
 ;validate EAS
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL(EAS)
 I EAS=-1 S POP=1,NUM=142 D CALLERROR
 Q
 ;
CALLERROR ;calls json error logic if error encountered
 D ERRLOG^SDESJSON(.SDRECREQ,NUM)
 Q
 ;
BLDREC ;build and file record
 S SDFDA=$NA(SDFDA(403.5,RECALLIEN_",")) ;recall
 S SDFDA(403.5,RECALLIEN_",",.01)=DFN
 S:$G(ACCNO)'="" SDFDA(403.5,RECALLIEN_",",2)=$E(ACCNO,1,25)
 S:SDCMT'="" SDFDA(403.5,RECALLIEN_",",2.5)=$E(SDCMT,1,80)
 S SDFDA(403.5,RECALLIEN_",",2.6)=FASTING
 S SDFDA(403.5,RECALLIEN_",",3)=APPTP
 S SDFDA(403.5,RECALLIEN_",",4)=RRPROVIEN
 S SDFDA(403.5,RECALLIEN_",",4.5)=CLINIEN
 S:APPTLEN'="" SDFDA(403.5,RECALLIEN_",",4.7)=APPTLEN
 S SDFDA(403.5,RECALLIEN_",",5)=DATE
 S:RECPPDT'="" SDFDA(403.5,RECALLIEN_",",5.5)=RECPPDT
 S:DAPTDT'="" SDFDA(403.5,RECALLIEN_",",6)=DAPTDT
 S SDFDA(403.5,RECALLIEN_",",7)=USERIEN
 S:SDCREATE SDFDA(403.5,RECALLIEN_",",7.5)=SDENTDT ;only add if creating new record, cannot edit
 S:SECPDT'="" SDFDA(403.5,RECALLIEN_",",8)=SECPDT
 S:EAS'="" SDFDA(403.5,RECALLIEN_",",100)=EAS
 Q
 ;
BLDJSON ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDRECREQ,.RETN,.JSONERR)
 Q
 ;
KEY(RECALLIEN) ;check that user has the correct SECURITY KEY
 ;INPUT:
 ; RECALLIEN - Pointer to RECALL REMINDERS file 403.5
 ;RETURN
 ;  0=User has the correct SECURITY KEY
 ;  135=error number - user does not have correct security keys
 N KEY,KY,RET,SDPRV,SDFLAG
 S RET=135
 S (SDPRV,KEY,SDFLAG)="" S SDPRV=$P($G(^SD(403.5,+RECALLIEN,0)),U,5) D
 .I SDPRV="" S RET=0
 .I SDPRV'="" S KEY=$P($G(^SD(403.54,SDPRV,0)),U,7) D
 ..I KEY="" S RET=0 Q
 ..N VALUE
 ..S VALUE=$$LKUP^XPDKEY(KEY) K KY D OWNSKEY^XUSRB(.KY,VALUE,DUZ)
 ..I $G(KY(0))'=0 S RET=0
 Q RET
 ;
