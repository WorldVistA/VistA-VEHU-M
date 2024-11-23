YTQEVNT ;SLC/KCM - MHA Protocol Events ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**240**;Dec 30, 1994;Build 10
 ;
 Q
 ; IEN is always the administration IEN in 601.84
 ; TRIGGER identifies where the event was invoked
 ; DFN & TEST identify the patient and instrument for removals
 ;            (since the 601.84 record is no longer available)
 ;
 ; Properties --
 ;    action: update or remove
 ;    object: admin, answers, results, or assessment (for all 3)
 ;   trigger: identifies caller
 ;       ien: pointer to 601.84
 ;       dfn: pointer to 2
 ;      test: short name of instrument
 ;
UPADM(IEN,TRIGGER) ; fire event when administration is updated
 D UPSEND(IEN,TRIGGER,"admin")
 Q
UPANS(IEN,TRIGGER) ; fire event when answers to administration are updated
 D UPSEND(IEN,TRIGGER,"answers")
 Q
UPRSLT(IEN,TRIGGER) ; fire event when results for administration are updated
 D UPSEND(IEN,TRIGGER,"results")
 Q
UPSEND(IEN,TRIGGER,OBJECT) ; do the actual update
 N YTQEVNT,YTQ101,YTQX,X
 I '$G(IEN) QUIT
 S YTQX=$G(^YTT(601.84,IEN,0)) Q:'$L(YTQX)
 I $P(YTQX,U,9)'="Y" QUIT  ; only include completed administrations
 S YTQ101=$$FIND1^DIC(101,"","BX","YTQ EVENT") Q:'YTQ101
 S YTQEVNT("action")="update"
 S YTQEVNT("object")=OBJECT
 S YTQEVNT("trigger")=TRIGGER
 S YTQEVNT("ien")=IEN
 S YTQEVNT("dfn")=$P(YTQX,U,2)
 S YTQEVNT("test")=$P($G(^YTT(601.71,$P(YTQX,U,3),0)),U)
 S X=YTQ101_";ORD(101,"
 D EN^XQOR
 Q 
DELETE(IEN,DFN,TEST,TRIGGER) ; fire event when administration is deleted
 I '$G(IEN) QUIT
 I '$L(TEST) QUIT
 N YTQEVNT,YTQ101,X
 S YTQ101=$$FIND1^DIC(101,"","BX","YTQ EVENT") Q:'YTQ101
 S YTQEVNT("action")="remove"
 S YTQEVNT("object")="assessment"
 S YTQEVNT("trigger")=TRIGGER
 S YTQEVNT("ien")=$G(IEN)
 S YTQEVNT("dfn")=$G(DFN)
 S YTQEVNT("test")=$G(TEST)
 S X=YTQ101_";ORD(101,"
 D EN^XQOR
 Q
 ;
 ; -- test receiver --
 ;
RECEIVE ; YTQ EVENT TEST RECEIVER (save event data in ^XTMP)
 ; store events in sequence by date, example:
 ;   ^XTMP("YTQEVTST-3230919",n,property)=value
 ;   ^XTMP("YTQEVTST-3230919","CNT")=n
 Q:$D(YTQEVNT)<10
 N NOW,TODAY,NODE,CNT
 S NOW=$$NOW^XLFDT,TODAY=$P(NOW,"."),NODE="YTQEVTST-"_TODAY
 I '$D(^XTMP(NODE,0)) S ^XTMP(NODE,0)=$$FMADD^XLFDT(TODAY,1)_U_TODAY_U_"MHA Event Tester"
 S ^XTMP(NODE,"CNT")=$G(^XTMP(NODE,"CNT"))+1,CNT=^("CNT")
 M ^XTMP(NODE,CNT)=YTQEVNT
 S ^XTMP(NODE,CNT,"user")=DUZ
 S ^XTMP(NODE,CNT,"ts")=NOW
 Q
 ;
 ; -- test receiver interactive monitor --
 ;
MONITOR ; for testing events published by MHA
 ; this may be run from the command line to watch events as they are posted
 ; NOTE -- the monitor doesn't support crossing midnight if you are up late
 N NOW,TODAY,NODE,LAST,OUT,CNT,BUF,LOOPS
 W !,"MHA Event Test Monitor -- press Q or spacebar to exit",!
 S NOW=$$NOW^XLFDT,TODAY=$P(NOW,"."),NODE="YTQEVTST-"_TODAY,LOOPS=0
 S LAST=$G(^XTMP(NODE,"CNT"),0)    ; start with most recent update
 S OUT=0 F  D  Q:OUT
 . S CNT=$O(^XTMP(NODE,LAST))
 . I CNT D SHOWEV(NODE,CNT) S LAST=CNT QUIT
 . R BUF:1 I $L(BUF),(" qQ^"[BUF) S OUT=1 QUIT
 . S LOOPS=LOOPS+1 W:LOOPS#8=0 "."
 Q
SHOWEV(NODE,CNT) ; show a single event entry
 ; write timestamp  action object:ien
 ;                  testName for patientName
 ;                  userLastName,initial (invoked from trigger)
 ;09/18/23@18:02:01 remove assessment:2342343  
 ;                  CSI PARTNER VERSION for WINCHESTER,CHARLES EMERSON
 ;                  by JONES,M (invoked from edad)
 N X
 M X=^XTMP(NODE,CNT)
 Q:$D(X)<10
 W !,$$FMTE^XLFDT($G(X("ts")),"2ZS")
 W ?18,$G(X("action"))," ",$G(X("object")),":",$G(X("ien")),!
 W ?18,$G(X("test"))," for ",$P($G(^DPT(+$G(X("dfn")),0)),U),!
 W ?18,"by ",$P($G(^VA(200,+$G(X("user")),0)),U)
 W " (invoked from ",$G(X("trigger")),")",!
 Q
 ;
CLEARALL ; clears all test event nodes in ^XTMP
 S NODE="YTQEVTST-" F  S NODE=$O(^XTMP(NODE)) Q:($E(NODE,1,9)'="YTQEVTST-")  D
 . W !,NODE
 . K ^XTMP(NODE)
 Q
