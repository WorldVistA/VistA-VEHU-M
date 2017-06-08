MBAARPC1 ;OIT-PD/PB - Scheduling RPCs;08/27/2014
 ;;1.0;Scheduling Calendar View;;Aug 27, 2014;Build 52
 ;This routine has multiple RPCs created to support the mobile Scheduling apps
 ;Associated ICRs:
 ;  ICR#
 ;  6053 DPT
 ;  2851 SDAM1
 ;  6044 SC(
 ;  6045 SD(403.5
 ;  6046 SDWL(409.3
 ;  3277 XUSRB
 ;  6063 MBAA RPC REGISTRATION
 ;
GETPEND(RV,DFN,DT) ; Get pending appointments for a patient MBAA RPC: MBAA PATIENT PENDING APPT
 ; input is patient dfn and the date to start the search and go forward
 K RETURN
 I $G(DFN)="" S RV(0)="1^DFN must be defined" Q
 I $G(DT)="" S RV(0)="1^Start date must be defined" Q
 N CNT,SCAP,APP,CLN,%
 S CNT=""
 D GETPND(.APP,DFN,DT)
 F  S CNT=$O(APP(CNT)) Q:CNT=""  D
 . S RETURN(CNT,"COLLATERAL VISIT")=APP(CNT,13)_$C(13)
 . S RETURN(CNT,"APPOINTMENT TYPE")=$$APTYNAME^MBAAMDA2(APP(CNT,9.5))_$C(13)
 . S RETURN(CNT,"LAB")=APP(CNT,2)_$C(13)
 . S RETURN(CNT,"XRAY")=APP(CNT,3)
 . S RETURN(CNT,"EKG")=APP(CNT,4)
 . S %=$$GETCLN^MBAAMAP1(.CLN,APP(CNT,.01))
 . S RETURN(CNT,"CLINIC")=$P(CLN("NAME"),U,2)
 . S %=$$GETSCAP(.SCAP,APP(CNT,.01),DFN,CNT)
 . S RETURN(CNT,"LENGTH OF APP'T")=$G(SCAP("LENGTH"))
 . S RETURN(CNT,"CONSULT LINK")=$G(SCAP("CONSULT"))
 . S RETURN(CNT,"OTHER")=$G(SCAP("OTHER"))
 .; Adding new fields
 . S RETURN(CNT,"CLINIC ID")=APP(CNT,.01)
 . S RETURN(CNT,"CURRENT STATUS")=APP(CNT,100)
 . S RETURN(CNT,"DESIRED APPT DATE")=$G(APP(CNT,127))
 S RETURN=($D(RETURN)>0)
 D MERGE^MBAAMRPC(.RV,.RETURN)
 Q 1
 ;
GETPND(RETURN,PAT,DT) ; Get pending appointments MBAA RPC: MBAA PATIENT PENDING APPT
 N Y,AP
 F Y=DT:0 S Y=$O(^DPT(PAT,"S",Y)) Q:Y'>0  D  ;ICR#: 6053 DPT
 . S AP=^DPT(PAT,"S",Y,0) D
 . . S RETURN(Y,.01)=$P(AP,U,1)
 . . S RETURN(Y,13)=$P(AP,U,11)
 . . S RETURN(Y,9.5)=$P(AP,U,16)
 . . S RETURN(Y,2)=$P(AP,U,3)
 . . S RETURN(Y,3)=$P(AP,U,4)
 . . S RETURN(Y,4)=$P(AP,U,5)
 . . S RETURN(Y,5)=$P(AP,U,4)
 . . S RETURN(Y,10)=$P(AP,U,2)
 . . S RETURN(Y,100)=$P($$STATUS^SDAM1(PAT,Y,+AP,AP),";",3) ;ICR#: 2851 MBAA ACCESS TO SDAM1 API get appointment status
 . . I $P($G(^DPT(PAT,"S",Y,1)),"^")'="" S RETURN(Y,127)=$P($G(^DPT(PAT,"S",Y,1)),"^")
 Q
GETSCAP(RETURN,SC,DFN,SD) ; Get clinic appointment MBAA RPC: MBAA PATIENT PENDING APPT
 N NOD0,CO,TXT
 I '$D(DFN)!(+$G(DFN)'>0) S RETURN=0,TXT(1)="DFN" D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 I '$D(SC)!(+$G(SC)'>0) S RETURN=0,TXT(1)="SC" D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 I '$D(SD)!(+$G(SD)'>0) S RETURN=0,TXT(1)="SD" D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 D GETSCAP^MBAAMDA1(.RETURN,+SC,+DFN,+SD)
 I $D(RETURN) D
 . S NOD0=RETURN(0),CO=$G(RETURN("C"))
 . S RETURN("IFN")=RETURN
 . S RETURN("USER")=$P(NOD0,U,6)
 . S RETURN("DATE")=$P(NOD0,U,7)
 . S RETURN("CHECKOUT")=$P(CO,U,3)
 . S RETURN("CHECKIN")=$P(CO,U,1)
 . S RETURN("LENGTH")=$P(NOD0,U,2)
 . S RETURN("CONSULT")=$P($G(RETURN("CONS")),U)
 . S RETURN("OTHER")=$P($G(NOD0),"^",4)
 Q 1
 ;
PROVCLIN(RESULTS,PROVIDER)    ; Get list of clinics for a provider MBAA RPC: MBAA PROVIDER TO CLINIC
 ; input is provider id (IEN for VA(200))
 K RESULTS
 I $G(PROVIDER)="" S RESULTS(0)="1^Provider IEN is required." Q
 S (CNT,CLIN)=0 F  S CLIN=$O(^SC(CLIN)) Q:CLIN'>0  S PROV=0 F  S PROV=$O(^SC(CLIN,"PR","B",PROV)) Q:PROV'>0  D  ;ICR#: 6044 SC(
 .Q:$P(^SC(CLIN,0),"^",3)'="C"  ;ICR#: 6044 SC(
 .Q:$G(PROV)'=$G(PROVIDER)
 .S CLINNAME=$P(^SC(CLIN,0),"^")  ;ICR#: 6044 SC(
 .S RESULTS(CNT)=CLIN_"^"_CLINNAME,CNT=CNT+1
 .K CLINNAME
 K CLIN,PROV,PROVIDER,CNT
 S:$G(RESULTS(0))="" RESULTS(0)="1^Provider is not assigned to any clinics."
 Q
 ;
REMREC(RESULTS,DFN,CLINIC,PROVIDER,RECALLDT,PTRECDT)  ; Remove a patient from the Recall list MBAA RPC: MBAA REMOVE FROM RECALL LIST
 ; Input Parameters:
 ;   DFN = Patient ID
 ;   Clinic = Clinic ID - IEN from the Hospital Location file (#44)
 ;   PROVIDER = Provider IEN (optional)
 ;   RECALLDT = The recall date requested by the provider 
 ;   PTRECDT = The recall date requested by the patient 
 ;   Either the RECALLDT or the PTRECDT is required.
 ;
 ;   Checks for multiple entries on the recall list that are for the same patient, provider, clinic and recall dates and deletes all
 ; Output:
 ;   If successful:
 ;      RESULTS="1^DELETED" the patient was removed from the recall list for the clinic
 ;   If not successful:
 ;      RESULTS="0^DFN MISSING"
 ;      RESULTS="0^CLINIC ID MISSING"
 ;      RESULTS="0^User doesn't have the provider key."
 ;
 S RESULTS(0)="",OK=0
 I $G(DFN)="" S RESULTS(0)="0^DFN MISSING" Q
 I $G(CLINIC)="" S RESULTS(0)="0^CLINIC ID MISSING" Q
 I '$D(^DPT(DFN,0)) S RESULTS(0)="0^NOT A PATIENT" Q  ;ICR#: 6053 DPT
 I '$D(^SC(CLINIC,0)) S RESULTS(0)="0^NOT A CLINIC" Q  ;ICR#: 6044 SC(
 S (SDPRV,KEY,SDFLAG)="" S SDPRV=$P($G(^SD(403.5,CLINIC,0)),U,5) I SDPRV'="" S KEY=$P($G(^SD(403.54,SDPRV,0)),U,7) D  ;ICR#: 6045 SD(403.5
 .Q:KEY=""
 .N VALUE
 .S VALUE=$$LKUP^XPDKEY(KEY) K KY D OWNSKEY^XUSRB(.KY,VALUE,DUZ)  ;ICR#: 3277 XUSRB
 .I $G(KY(0))=0 S RESULTS(0)="0^User doesn't have the provider key."
 Q:$G(RESULTS(0))'=""
 S IEN=0 F  S IEN=$O(^SD(403.5,"E",CLINIC,IEN)) Q:IEN'>0  D  ;ICR#: 6045 SD(403.5
 .K NODE,PROV,PROVDT,PTDT,DFN1,RESULTS(0),XDFN
 .S NODE=$G(^SD(403.5,IEN,0))  ;ICR#: 6045 SD(403.5
 .S XDFN=$P(NODE,"^")
 .I $G(XDFN)'=DFN S RESULTS(0)="0^PATIENT NOT ON RECALL LIST" Q
 .S PROV=$P(NODE,"^",5),PROVDT=$P(NODE,"^",6),PTDT=$P(NODE,"^",12),DFN1=$P(NODE,"^",1)
 .I $G(PROV)'=$G(PROVIDER) Q  ;S RESULTS(0)="0^PROVIDER DOESN'T MATCH" Q
 .I $G(PROVDT)'=$G(RECALLDT) Q  ;S RESULTS(0)="0^PROVIDER RECALL DATE DOESN'T MATCH" Q
 .;I $G(PTRECDT)'="" I $G(PTDT)'=$G(PTRECDT) S RESULTS(0)="0^PATIENT RECALL DATE DOESN'T MATCH" Q
 .I $G(DFN1)'=$G(DFN) S RESULTS(0)="0^PATIENT MISMATCH" Q
 .S DIK="^SD(403.5,",DA=IEN D ^DIK  ;ICR#: 6045 SD(403.5
 .S OK=1
 I OK=1 S RESULTS(0)="1^DELETED"
 I OK=0 S RESULTS(0)="0^NOT ON RECALL LIST"
 K SDPRV,KEY,SDFLAG,VALUE,IEN,DIK,DA,OK
 Q
UPDTEWL(RESULTS,DFN,SDWLIEN,SDWLDISP,SDWLDATA) ; Update or remove a patient on the EWL MBAA RPC: MBAA REMOVE FROM EWL
 ;Input paramters:
 ;  DFN - Patient DFN
 ;  EWLIEN - for EWL Record to be updated
 ;  DISP - The disposition code of the EWL entry:
 ;    D:DEATH;NC:REMOVED/NON-VA CARE;SA:REMOVED/SCHEDULED-ASSIGNED;CC:REMOVED/VA CONTRACT CARE;NN:REMOVED/NO LONGER NECESSARY;ER:ENTERED IN ERROR;CL:CLINIC CHANGE
 ;  SDWLDATA array:
 ;      $P(1) = SDWLAPPT(1)=SCHEDULED DATE OF APPT
 ;      $P(2) = SDWLAPPT(2)=PTR TO APPT CLINIC (CLINIC WHERE APPT MADE)
 ;      $P(4) = SDWLAPPT(15)=APPOINTMENT INSTITUTION (PTR to Institution File)
 ;      $P(5) = SDWLAPPT(13)=APPT STOP CODE (PTR to file 40.7)
 ;      $P(6) = SDWLAPPT(14)=APPT CREDIT STOP CODE (PTR to file 40.7)
 ;      $P(7) = SDWLAPPT(16)=APPT STATION NUMBER (Free Text) MUST BE AN IEN FROM DIC(4 but is not a ptr field)
 ;      $P(3) = SDWLAPPT(3)=APPT STATUS (Set of codes: 'R' FOR Scheduled/Kept; 
 ;          'I' FOR Inpatient; 
 ;          'NS' FOR No-Show; 
 ;          'NSR' FOR No_Show, Rescheduled; 
 ;          'CP' FOR Canceled by Patient; 
 ;          'CPR' FOR Canceled by Patient, Rescheduled; 
 ;          'CC' FOR Canceled by Clinic; 
 ;          'CCR' FOR Canceled by Clinic, Rescheduled; 
 ;          'NT' FOR No Action Taken; )
 ;Output:
 ;  RESULTS(0)=1 - Successful
 ;  RESULTS(0)="0^DFN is required" - DFN parameter missing
 ;  RESULTS(0)="0^SDWLIEN is required" - SDWLIEN parameter is missing
 ;  RESULTS(0)="0^Patient not on EWL" - Patient is not on the EWL
 ;  RESULTS(0)="0^Disposition is missing."
 ;  RESULTS(0)="0^Disposition is SA but missing Appointment data."
 ;
 S RESULTS(0)=1
 I $G(DFN)="" S RESULTS(0)="0^DFN is required" Q
 I $G(SDWLIEN)="" S RESULTS(0)="0^SDWLIEN is required" Q
 I '$D(^SDWL(409.3,"B",DFN)) S RESULTS(0)="0^Patient not on EWL" Q  ;ICR#: 6046 SDWL(409.3
 I $G(SDWLDISP)="" S RESULTS(0)="0^Disposition is missing." Q
 I ($G(SDWLDISP)="SA"&($G(SDWLDATA)="")) S RESULTS(0)="0^Disposition is SA but missing Appointment data." Q
 I $P(^SDWL(409.3,SDWLIEN,0),"^",17)="C" S RESULTS(0)="0^Patient not on EWL" Q  ;ICR#: 6046 SDWL(409.3
 D PARSE
 I '$$LOCK^MBAAWLAP(.SDWLERR,SDWLIEN) ; W !,"Another User is Editing this Entry. Try Later." Q
 S %=$$DETAIL^MBAAWLAP(.SDWLDATA,SDWLIEN)
 G ENQ:SDWLDISP=""
 D UPDATE(DFN,SDWLIEN,SDWLDISP,.SDWLDATA)
ENQ ; MBAA RPC: MBAA REMOVE FROM EWL
 S %=$$UNLOCK^MBAAWLAP(SDWLIEN)
 Q
UPDATE(SDWLDFN,SDWLIEN,SDWLDISP,SDWLDATA) ;UPDATE EWL ENTRY MBAA RPC: MBAA REMOVE FROM EWL
 N SDWLERR,SDWLAPPT,SDWLTY
 S SDWLTY=$P(SDWLDATA("WLTYPE"),U)
 ;I SDWLDISP="SA","3,4"[SDWLTY S SDWLERR='$$SELAPPT(SDWLIEN,.SDWLDATA,.SDWLAPPT) Q:SDWLERR  ; QUIT OR NOT?
 ;I SDWLDISP="CL" S SDWLERR=$$EN^SDWLE7 Q:SDWLERR  ; OG ; 446
 S %=$$DISP^MBAAWLAP(.SDWLERR,SDWLDFN,SDWLIEN,SDWLDISP,.SDWLAPPT)
 S RETURN(0)=1
 Q
PARSE ; MBAA RPC: MBAA REMOVE FROM EWL
 Q:$G(SDWLDATA)=""
 S SDWLAPPT(1)=$P(SDWLDATA,"^",1),SDWLAPPT(2)=$P(SDWLDATA,"^",2),SDWLAPPT(3)=$P(SDWLDATA,"^",3),SDWLAPPT(15)=$P(SDWLDATA,"^",4)
 S SDWLAPPT(13)=$P(SDWLDATA,"^",5),SDWLAPPT(14)=$P(SDWLDATA,"^",6),SDWLAPPT(16)=$P(SDWLDATA,"^",7)
 Q
