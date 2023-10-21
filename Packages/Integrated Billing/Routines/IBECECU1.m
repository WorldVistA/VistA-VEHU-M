IBECECU1 ;BSL/DVA-BILLING  SEND/RECEIVE DFT HL7 MESSAGES PATIENT ACCUMULATOR INTERFACE -  SEND/RECEIVE A DFT UPDATE TO/FROM OTHER SITES ; 08 Jul 2022  9:21 AM
 ;;2.0;INTEGRATED BILLING;**704**;21-MAR-94;Build 49
 ;Per VA Directive 6402, this routine should not be modified.
 ; This routine will manage the 365 Inpatient stay clock
 ;
 ;IA#    Supports
 ;------ -------------------------------------------------
 ; Reference to $STARTMSG^HLOPRS,$$NEXTSEG^HLOPRS,$$GET^HLOPRS in ICR #4718
 ; Reference to $$ADDSEG^HLOAPI,SET^HLOAPI in ICR #4722
 ; Reference to $$SENDONE^HLOAPI1 in ICR #4717
 ; Reference to $$GETDFN^MPIF001 in ICR #2701
 ;
 ; ; ; This will fire off an update (active 365 day clock) entry in file #351,
 ;      - First when a new entry (clock) is started
 ;      - Every quarter when the income amounts are entered
 ;      - then when the Pt is discharged.
 ;Sample message:
 ; MSH|^~\&|IBECEAC-SEND|695^HL7.IVMVEE.DOMAIN.EXT:5127^DNS|IBECEAC-RECV|200CRNR^:^DNS|20211008123507-0500||DFT^P03^DFT_P03|695 1471|T^|2.3|||AL|NE|USA
 ; EVN|P03|20211013143704-0500
 ; PID|1008713999V404928|DRI|^DODMORE MESSAGE
 ; FT1|2|3201101|1|345||||15|3211101
 ; FT2|
 ;
 Q   ;No direct routine calls
 ;
EN(DFN,IBCLDA) ; OUTGOING DFT PRIMARY ENTRY POINT
 ; IBCLDA - IEN FROM 351
 ;CALLED FROM ^IBAUTL3 (CLADD [new] AND CLUPD [updates])
 N X,PARMS,SEG,MSG,VALUE,FIELD,QRYNUM,SERROR,SERR,NAME,ERROR,XXX,WHOTO,IBACBCLK,IBADM,IBDISCH,IBADMIT,IBIEN,IBICN,IBQIEN
 N IBCLDT,IBSTAT,IB901,IB902,IB903,IB904,IBCLDAY,IBCLNDT,IBNADM,IBNAME,IBSITE,IBSOC
 ;
 I $P($G(^IBE(351,IBCLDA,1)),U,5)="" Q
 D INPT^IBECECX1(DFN) ;Get admit/discharge dates
 S NAME=$$GET1^DIQ(2,DFN_",",.01)
 D MSH,PARSE,EVN,PID Q:'IBICN  ;Do not send Message if no Patient ICN
 D FT1,FT2,SEND
 Q
 ;
 ;
MSH ; Build outgoing MSH Segment
 N PARMS K ^TMP("DFT")
 S PARMS("COUNTRY")="USA"
 S PARMS("MESSAGE TYPE")="DFT"
 S PARMS("EVENT")="P03"
 S PARMS("SENDING APPLICATION")="IBECEAC-SEND"
 S PARMS("VERSION")="2.3"
 S PARMS("MESSAGE STRUCTURE")="DFT_P03"
 S MSG="^TMP(DFT"
 S X=$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR)
 Q
EVN ; Build outgoing EVN Segment
 S VALUE="EVN",FIELD=0 D SET^HLOAPI(.SEG,VALUE,FIELD)
 ;S VALUE="P03",FIELD=1 D SET^HLOAPI(.SEG,VALUE,FIELD)   ;We were asked to remove this value until further notice
 D NOW^%DTC S VALUE=$$FMTHL7^XLFDT(%),FIELD=2
 D SET^HLOAPI(.SEG,VALUE,FIELD)
 ;
 S VALUE=IBSTAT,FIELD=3 D SET^HLOAPI(.SEG,VALUE,FIELD)  ;Billing clock status
 S VALUE=1,FIELD=4 D SET^HLOAPI(.SEG,VALUE,FIELD)       ;Number of billing clocks sent (0-3)
 ;
 ;BL;Cerner wants Encounter info sent. VistA is not using it. This is left until Cerner interface
 S VALUE=$G(IBNADM),FIELD=5 D SET^HLOAPI(.SEG,VALUE,FIELD)  ;Number of encounters sent
 S VALUE=$G(IBEVFAC),FIELD=6 D SET^HLOAPI(.SEG,VALUE,FIELD) ;Event Facility
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
PID ; Build outgoing PID Segment
 S VALUE="PID",FIELD=0 D SET^HLOAPI(.SEG,VALUE,FIELD)
 S IBICN=$$ICN^IBARXMU(DFN) Q:'IBICN                  ;Do not send Message if no Patient ICN
 S VALUE=DFN,FIELD=1 D SET^HLOAPI(.SEG,VALUE,FIELD)
 I +IBICN<1 S SERROR="NO PATIENT ICN FOUND",SERR=1
 S VALUE=IBICN,FIELD=2 D SET^HLOAPI(.SEG,VALUE,FIELD)
 S VALUE=NAME,FIELD=4 D SET^HLOAPI(.SEG,VALUE,FIELD)
 ;S VALUE=$P(NAME,",",1),FIELD=2 D SET^HLOAPI(.SEG,VALUE,FIELD,1)
 ;S VALUE=$P(NAME,",",2),FIELD=3 D SET^HLOAPI(.SEG,VALUE,FIELD,2)
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
 ;
FT1 ; Build FT1 Outgoing segment
 D SET^HLOAPI(.SEG,"FT1",0)
 D SET^HLOAPI(.SEG,+IBCLDA,1)   ;file 351 IEN
 D SET^HLOAPI(.SEG,+IBCLDT,2)   ;Billing clock begin date
 D SET^HLOAPI(.SEG,+IBSTAT,3)   ;Billing clock Status
 D SET^HLOAPI(.SEG,+IB901,4)    ;1ST QTR CHARGES
 D SET^HLOAPI(.SEG,+IB902,5)    ;2ND QTR CHARGES
 D SET^HLOAPI(.SEG,+IB903,6)    ;3RD QTR CHARGES
 D SET^HLOAPI(.SEG,+IB904,7)    ;4TH QTR CHARGES
 D SET^HLOAPI(.SEG,+IBCLDAY,8)  ;Number of Inpatient days
 D SET^HLOAPI(.SEG,+IBCLNDT,9)  ;End of 365 day clock
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
FT2 ;BUILD OUTGOING FT2 SEGMENT
 ;FT2 Segment not populated until Cerner interface is designed
 ;D SET^HLOAPI(.SEG,"FT2",0)
 ;S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
 ;
SEND ;SEND MESSAGE AND QUIT
 S WHOTO("RECEIVING APPLICATION")="IBECEAC-RCV"
 S WHOTO("STATION NUMBER")="200DAS"
 S WHOTO("MIDDLEWARE LINK NAME")="IBECEC-DFT"
 S PARMS("SENDING APPLICATION")="IBECEAC-SEND"
 S XXX=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
 Q
 ;
 ;-----------------------------------------------INCOMING DFT ------------------
RECV ; INCOMING DFT PRIMARY ENTRY POINT
 N DFN,IBHDR,IBMSG,SEG,IBSEGT,IBSTAT,IBWHAT,ICN,MSGTYPE,IBIEN,DATEQ,ERR,HLERR,IBAEVNT,IBEVFAC,IBEVOCC,IBQRYS
 N IBI901,IBI902,IBI903,IBI904,IBICKDT,IBICLDAY,IBICLDT,IBICNAL,IBISTAT,IBACTC,IBCKNUM,IBICNUM,IBDA,IBCBDT,IBSNDST,IBDA1
 S ERR=0,IBSTAT=$$STARTMSG^HLOPRS(.IBMSG,HLMSGIEN,.IBHDR)
 S IBIEN=HLMSGIEN
 I 'IBSTAT  S HLERR="Unable to start parse of message" Q
 I "DFT"'[IBHDR("MESSAGE TYPE") Q
 ;
 F  Q:'$$NEXTSEG^HLOPRS(.IBMSG,.SEG)  S IBSEGT=$G(SEG("SEGMENT TYPE")) Q:IBSEGT=""  D
 . I IBSEGT="EVN" D EVNI
 . I IBSEGT="PID" D PIDI
 . I IBSEGT="FT1" D FT1I
 . I IBSEGT="FT2" D FT2I
 Q:'$G(IBICLDT)  ;Quit if no billing clocks returned
 S IBSNDST=$G(IBMSG("HDR","SENDING FACILITY",1))
 S IBDA=";"  F  S IBDA=$O(^IBE(351,"AIVDT",DFN,-IBICLDT,IBDA),-1) Q:'IBDA  Q:$G(IBCBDT)  D
 .S IBCBDT=$$GET1^DIQ(351,IBDA_",",.03,"I")
 .S IBQRYS=$$GET1^DIQ(351,IBDA_",",16,"I")
 .S IBDA1=IBDA
 I $G(IBCBDT)=IBICLDT D UPDATE(IBDA1)  Q  ;Update record if current Billing Clock Start Date matches incoming Billing Clock Start Date
 D NEWREC  ;FILE DATA IN FILE 351
 Q
 ;
EVNI ;Parse Incoming EVN Segment
 S IBAEVNT=$$GET^HLOPRS(.SEG,1,1)   ;Date/time of event
 S IBAEVNT=$$FMTHL7^XLFDT(IBAEVNT)  ;convert date to FM
 S IBACTC=$$GET^HLOPRS(.SEG,2,1)    ;Active billing clock sent
 S IBCKNUM=$$GET^HLOPRS(.SEG,3,1)   ;Number of clocks sent
 S IBICNUM=$$GET^HLOPRS(.SEG,4,1)   ;Number of admit encounters sent
 S IBEVFAC=$$GET^HLOPRS(.SEG,5,1)   ;Event Facility
 Q
 ;
PIDI ;Parse Incoming PID Segment
 S IBICN=$$GET^HLOPRS(.SEG,1,1)     ;Alternate Patient ID (DFN)
 S IBICNAL=$$GET^HLOPRS(.SEG,2,1)   ;Patient ICN
 S DFN=$$GETDFN^MPIF001(IBICNAL)    ;Patient DFN
 S IBNAME=$$GET^HLOPRS(.SEG,4,1)    ;Pt name
 Q
 ;Get data from HL7 message from QRD and DSP
FT1I ;Parse Incoming FT1 Segment, assumes one record only
 ;                                     Get new 365 day clock data
 S IBCLDA=$$GET^HLOPRS(.SEG,1,1)      ;Reference number
 S IBICLDT=$$GET^HLOPRS(.SEG,2,1)     ;Billing clock start date
 S IBICLDT=$$HL7TFM^XLFDT(IBICLDT)    ;convert HL7 date to FM
 S IBISTAT=$$GET^HLOPRS(.SEG,3,1)     ;Status of clock
 S IBI901=$$GET^HLOPRS(.SEG,4,1)      ;1ST QTR CHARGES
 S IBI902=$$GET^HLOPRS(.SEG,5,1)      ;2ND QTR CHARGES
 S IBI903=$$GET^HLOPRS(.SEG,6,1)      ;3RD QTR CHARGES
 S IBI904=$$GET^HLOPRS(.SEG,7,1)      ;4TH QTR CHARGES
 S IBICLDAY=$$GET^HLOPRS(.SEG,8,1)    ;Inpatient Days on the received clock
 S IBICKDT=$$GET^HLOPRS(.SEG,9,1)     ;Clock end date
 S:IBICKDT IBICKDT=$$HL7TFM^XLFDT(IBICKDT)    ;convert HL7 date to FM
 Q
FT2I ;Parse Incoming FT1 Segment,
 ;For future expansion to Cerner
 Q
 ;
PARSE ;  Get the updated clock data to send via DFT
 N IBARRAY,IBERR
 ; Get the values of the new IBE(351)  entry
 D GETS^DIQ(351,IBCLDA_",","**","I","IBARRAY","IBERR")
 S IBSITE=$$SITE^IBATUTL                    ;Site number
 S IBCLDT=IBARRAY(351,IBCLDA_",",.03,"I")   ;Clock start date
 S IBCLDT=$$FMTHL7^XLFDT(IBCLDT)            ;convert HL7 date to FM
 S IBSTAT=IBARRAY(351,IBCLDA_",",.04,"I")   ;Status
 S IB901=IBARRAY(351,IBCLDA_",",.05,"I")    ;1st QTR CHARGES
 S IB902=IBARRAY(351,IBCLDA_",",.06,"I")    ;2nd QTR CHARGES
 S IB903=IBARRAY(351,IBCLDA_",",.07,"I")    ;3rd QTR CHARGES
 S IB904=IBARRAY(351,IBCLDA_",",.08,"I")    ;4th QTR CHARGES
 S IBCLDAY=IBARRAY(351,IBCLDA_",",.09,"I")  ;Number of inpatient days
 S IBCLNDT=IBARRAY(351,IBCLDA_",",.1,"I")   ;End date of the clock
 S IBCLNDT=$$FMTHL7^XLFDT(IBCLNDT)          ;convert HL7 date to FM
 Q
 ;
NEWREC ;Create a new entry in file 351
 L +^IBE(351,0):$G(DILOCKTM,5) Q:'$T
 N DIC,IBFDA,IEN,IENS,X,Y,IEN351,IBDUZ,IBDTUP,IBREASON,DIE,DA,DR
 S DIC="^IBE(351,",DIC(0)=""
 S X=$P(^IBE(351,$P(^IBE(351,0),U,3),0),U,1)+1
 D FILE^DICN S (IENS,IEN)=$P(Y,U,1),DA=$P(Y,U,1) S IENS=IENS_","
 ;IBFDA(FILE#,"IENS",FIELD#)="VALUE"
 I $G(IBICNAL)'="" S DFN=$$GETDFN^MPIF001(IBICNAL)
 I DFN=""  L -^IBE(351,0) Q
 S IBFDA(351,IENS,.02)=DFN
 ;
 ;Need to do aggregation of incoming clock with local data on Query Responses (DSR)
 I $G(IBAGG)=1 D AGGR  ;Has this data been aggregated with local data
 S IBFDA(351,IENS,.03)=$G(IBICLDT)
 S IEN351=0 F  S IEN351=$O(^IBE(351,"ACT",DFN,IEN351)) Q:IEN351=""  D  ;loop through "current" clock xref
 . Q:$G(IBICLNDT)  ;Quit if incoming clock is closed
 . I $$GET1^DIQ(351,IEN351_",",.04,"I")=1 D
 .. S DIE="^IBE(351,",DA=IEN351,DR=".04///3;"
 .. S IBDUZ=$G(DUZ,.5),DR=DR_";13///^S X=IBDUZ"
 .. S IBDTUP=$$NOW^XLFDT,DR=DR_";14///^S X=IBDTUP",DR=DR_";14///^S X=IBDTUP"
 .. I $G(IBCNT) S IBREASON=$S($G(IBSNDST)'="":"Billing Clock update from Sta #"_IBSNDST,1:"Billing Clock update from Query"),DR=DR_";15///^S X=IBREASON"
 .. I '$G(IBCNT) S IBREASON="Billing Clock update from Query"
 .. D ^DIE ;Use fileman to properly delete ACT x-ref
 .. K DIE,DA,DR
 S IBFDA(351,IENS,.04)=$G(IBISTAT)
 S IBFDA(351,IENS,.05)=$G(IBI901)
 S IBFDA(351,IENS,.06)=$G(IBI902)
 S IBFDA(351,IENS,.07)=$G(IBI903)
 S IBFDA(351,IENS,.08)=$G(IBI904)
 S IBFDA(351,IENS,.09)=$G(IBICLDAY)
 S:$G(IBICKDT) IBFDA(351,IENS,.1)=IBICKDT
 S IBFDA(351,IENS,15)=$S($G(IBSNDST)'="":"Billing Clock update from Sta #"_IBSNDST,1:"Billing Clock update from Query")
 S IBFDA(351,IENS,11)=.5
 S IBFDA(351,IENS,12)=$$NOW^XLFDT
 S IBFDA(351,IENS,13)=.5
 S IBFDA(351,IENS,14)=$$NOW^XLFDT
 S IBFDA(351,IENS,16)=1 ;Set query sent field for aggregated date stored
 D FILE^DIE(,"IBFDA","IBERR")
 L -^IBE(351,0)
 Q
 ;
AGGR  ;Data has been aggregated at DAS, but may not have taken into account local data
 ;
 N NODE,IBDA,NODE0,AGG,IBSTDT,IBFLG
 S AGG=0
 ;1. If no active local clock quit 
 ;2. If local active clock and the start dates are not the same, aggregate
 ;3. If local active clock and start dates are the same, and days inpatient are Less than query, aggregate
 ;4. If local active clock and start dates are the same, and days inpatient are greater than query, quit
 ;
 ;get local clock data (#351)
 S NODE=$S(IBICLNDT:-IBICLNDT_.9999,1:-DT_.9999)
 F  S NODE=$O(^IBE(351,"AIVDT",DFN,NODE)) Q:'NODE  Q:$G(IBFLG)  D
 .S IBDA=";" F  S IBDA=$O(^IBE(351,"AIVDT",DFN,NODE,IBDA),-1) Q:'IBDA  I $P(^IBE(351,IBDA,0),U,4),$P(^IBE(351,IBDA,0),U,4)<3 S IBFLG=1 Q
 Q:'$G(IBDA)
 S NODE0=^IBE(351,IBDA,0)
 Q:$P(NODE0,"^",3)<IBICLDT
 S IBSTDT=$P(NODE0,"^",3) ;use earliest billing clock if local
 I $P(NODE0,"^",3)'=IBICLDT S AGG=1
 I $P(NODE0,"^",3)=IBICLDT D
 . I $P(NODE0,"^",9)<IBICLDAY S AGG=1 Q
 Q:'AGG
 I $G(IBICLNDT)<DT ;D MULTCLK - For future Cerner work
 ;Aggregate the incoming clock and the active clock
 S IBICLDAY=IBICLDAY+($P(NODE0,"^",9))
 S IBI901=IBI901+($P(NODE0,"^",5))
 S IBI902=IBI902+($P(NODE0,"^",6))
 S IBI903=IBI903+($P(NODE0,"^",7))
 S IBI904=IBI904+($P(NODE0,"^",8))
 I IBSTDT<IBICLDT S IBICLDT=IBSTDT ;use earliest billing clock if local
 Q
 ;
MULTCLK  ;Need to create multiple clocks - For future Cerner work
 ;If billing clock closed date < today
 ;use the PTF to determine billing days
 ;Q:'IBICLNDT
 ;N IBECDT,IBECDA,IBCLKST,IBCLKED,IBADMIT,IBADM1,IBIEN,IBDISCH
 ;S IBECDT="" F  S IBECDT=$O(^IBE(351,"AIVDT",DFN,IBECDT)) Q:'IBECDT  Q:(IBECDT>IBICLNDT)  D
 ;.S IBECDA=";" F  S IBECDA=$O(^IBE(351,"AIVDT",DFN,IBECDT,IBECDA),-1) Q:'IBECDA  Q:$$GET1^DIQ(351,IBECDA_",",.04,"I")=3  D
 ;..S IBCLKST=$$GET1^DIQ(351,IBECDA_",",.03,"I"),IBCLKED=$$GET1^DIQ(351,IBECDA_",",.1,"I")
 ;..S IBDAY=$$FMDIFF^XLFDT($S(IBCLKED:IBCLKED,1:DT),IBCLKST)+1 S IBMTBC(DFN,IBCLKST)=IBCLKST_U_IBCLKED_U_IBDAY
 ;..I IBCLKST<IBICLNDT,(IBCLKST>IBICLDT) D
 ;...S IBADMIT=-IBECDT_".9999",IBADMIT=$O(^DGPT("AAD",DFN,IBADMIT),-1),IBADM1=IBADMIT I IBADMIT S IBIEN=$O(^DGPT("AAD",DFN,IBADMIT,0)),IBDISCH=$P($G(^DGPT(IBIEN,70)),U)
 ;...;I IBDISCH>IBICLNDT D CHCKDAYS - For future Cerner work
 ;Q
 ;
CHCKDAYS ;Check days for each clock - For future Cerner work
 ;N IBICLDT1
 ;S IBICLDT1=IBICLNDT-.0001 F  S IBICLDT1=$O(^DGPT("AAD",DFN,IBICLDT1)) Q:'IBICLDT1  S IBIEN=$O(^DGPT("AAD",DFN,IBICLDT1,0)),IBADMIT=$P($G(^DGPT(IBIEN,0)),U,2),IBDISCH=$P($G(^DGPT(IBIEN,70)),U) D
 ;.S IBDAYS=$$FMDIFF^XLFDT($S(IBDISCH:IBDISCH,1:DT),IBADMIT)+1 S IBPTF(DFN,IBADMIT)=IBADMIT_U_IBDISCH_U_IBDAYS
 ;Q
 ;
UPDATE(IBDA)  ;Update records when Billing Clock start date is the same
 N DIE,DA,IBDTUP,IBDUZ
 L +^IBE(351,IBDA):$G(DILOCKTM,5) Q:'$T
 S DIE="^IBE(351,",DA=IBDA,DR=".04///^S X=IBISTAT"
 S DR=DR_";.05///"_+IBI901
 S DR=DR_";.06///"_+IBI902
 S DR=DR_";.07///"_+IBI903
 S DR=DR_";.08///"_+IBI904
 S DR=DR_";.09///"_+IBICLDAY
 S:IBICKDT DR=DR_";.1///^S X=IBICKDT"
 S IBDUZ=$G(DUZ,.5),DR=DR_";13///^S X=IBDUZ"
 S IBDTUP=$$NOW^XLFDT,DR=DR_";14///^S X=IBDTUP"
 S IBREASON=$S($G(IBSNDST)'="":"Billing Clock update from Sta #"_IBSNDST,1:"Billing Clock update from Query"),DR=DR_";15///^S X=IBREASON"
 S DR=DR_";16///1" ;Set query sent field for aggregated date stored
 D ^DIE
 L -^IBE(351,DA)
 Q
