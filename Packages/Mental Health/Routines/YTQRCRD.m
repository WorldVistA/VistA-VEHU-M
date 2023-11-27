YTQRCRD ;SLC/KCM - MH Clinical Reminder Dialog DLL Calls ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**223**;Dec 30, 1994;Build 22
 ;
 ; passed in RPC, YTQRRPC style:
 ;  REQ(1)=command
 ;  REQ(n)=name=value
 ;
 ;  RSP(n)=return value(s)
 ;
DLL(YTQRRSP,REQ) ; Controller for patient select screen
 N I,CMD,PARAMS
 S CMD=$G(REQ(1))
 S I=1 F  S I=$O(REQ(I)) Q:'I  S PARAMS($P(REQ(I),"="))=$P(REQ(I),"=",2,99)
 ;
 ; switch on CMD
 ; ---------------------------------
 ; setupStaging ==> guid      {DLL - ShowInstrument begin}
 I CMD="setupStaging" D  G OUT
 . D SETUP(.YTQRRSP,$$VAL("test"),$$VAL("dfn"),$$VAL("ordBy"),$$VAL("loc"),$$VAL("hwnd"))
 ; ---------------------------------
 ; getResults ==>             {DLL - ShowInstrument end}
 I CMD="getResults" D  G OUT
 . D GETRSLT(.YTQRRSP,$$VAL("test"),$$VAL("guid"))
 ; ---------------------------------
 ; commitAdmin ==>            {DLL - SaveInstrument}
 I CMD="commitAdmin" D  G OUT
 . D COMMIT(.YTQRRSP,$$VAL("test"),$$VAL("dfn"),$$VAL("ordBy"),$$VAL("admBy"),$$VAL("admDt"),$$VAL("loc"),$$VAL("hwnd"))
 ; ---------------------------------
 ; clearStaging ==>           {DLL - RemoveTempVistaFile}
 I CMD="clearStaging" D  G OUT
 . D CLEAR(.YTQRRSP,$$VAL("dfn"),$$VAL("test"),$$VAL("hwnd"))
 ; ---------------------------------
 ; else
 S YTQRRSP(1)="Error: command not found"
 ;
OUT ; end of switch statement
 Q
 ;
VAL(X) ; return value from request
 ; expects PARAMS ( with special handling for HWND)
 I X="hwnd" N V S V=$TR($P($G(PARAMS(X)),"."),"-","") S:'$L(V) V=0 Q V
 Q $G(PARAMS(X))
 ;
 ; -- calls from Delphi DLL
 ;
 ; ^XTMP(YTQCPRS-guid,1,property)=ASSIGNMENT property value
 ; ^XTMP(YTQCPRS-guid,1,"instrument",n,property)=specific instrument values
 ; ^XTMP(YTQCPRS-guid,3,testId,property)=ADMIN property value (replace 601.94)
 ; ^XTMP(YTQCPRS-guid,3,testId,"answers",n,property)=response value for admin
 ; ^XTMP(YTQCPRS-guid,"hwnd")=client windows handle
 ; ^XTMP(YTQCPRS-HWND,hwnd,dfn,testName)=guid^date  ; INDEX for patient/session
 ;
SETUP(RSP,TESTNM,DFN,ORDBY,LOC,HWND) ; set up assignment for reminder dialog
 ;    DLL: ShowInstrument begin - initiate instrument web page
 ;         (testNm,DFN,OrdByNm,OrdBy,AdmByNm,AdmBy,LocNm,LocIEN,AllReq)
 ;  input: testName, DFN, orderedBy, interviewer, location, handle
 ; output: URL with GUID
 ;
 N DATA,TEST,GUID
 ; check to see if there is already a current assignment and use that
 S GUID="" I $L(HWND),+DFN,$L(TESTNM) D  I $L(GUID) QUIT
 . S GUID=$G(^XTMP("YTQCPRS-HWND",HWND,DFN,TESTNM))
 . I $L(GUID),($P(GUID,U,2)=DT) S GUID=$P(GUID,U) I 1
 . E  S GUID=""  ; needed if DT doesn't match
 . I $L(GUID) S RSP(1)="URL="_$$GET^XPAR("SYS","YSCPRS DLL URL",1,"Q")_GUID
 ;
 ; otherwise create a new assignment in staging area
 N RPRIV,HOLDER
 I 'DFN!'ORDBY S RSP(1)="ERROR: missing required fields" QUIT
 S TEST=$O(^YTT(601.71,"B",TESTNM,0)) I 'TEST S RSP(1)="ERROR: test not found" QUIT
 S RPRIV=$P($G(^YTT(601.71,TEST,2)),U)
 I $L(RPRIV) D  I '$G(HOLDER(0)) QUIT
 . D OWNSKEY^XUSRB(.HOLDER,RPRIV,ORDBY)
 . I 'HOLDER(0) S RSP(1)="ERROR: orderer lacks the proper key"
 D DEM^VADPT I $G(VAERR) S RSP(1)="ERROR: missing patient info" QUIT
 S DATA("patient","dfn")=DFN
 S DATA("patient","name")=VADM(1)
 S DATA("patient","pid")="xxx-xx-"_VA("BID")
 S DATA("patient","ssn")=DATA("patient","pid")
 S DATA("orderedBy")=ORDBY
 S DATA("interview")=ORDBY
 S DATA("date")=$$NOW^XLFDT()
 S DATA("adminDate")=$$FMTE^XLFDT(DATA("date"),"5DZ")
 S DATA("location")=+LOC       ; strips the trailing "V", if there
 S DATA("appSrc")="cprs-web-dll"
 S DATA("questionMode")="all"  ; tells web app this is CPRS-CR DLL
 S DATA("entryMode")="cprs"    ; tells web app this is CPRS-CR DLL
 S DATA("catInfo")="null"
 S DATA("instruments",1,"id")=TEST
 S DATA("instruments",1,"name")=TESTNM
 S DATA("instruments",1,"printTitle")=$P(^YTT(601.71,TEST,0),U,3)
 S DATA("instruments",1,"restartDays")=$P($G(^YTT(601.71,TEST,8)),U,7)
 S DATA("instruments",1,"adminId")="null"
 S DATA("instruments",1,"replace")="null"
 S DATA("instruments",1,"complete")="false"
 S DATA("instruments",1,"progress")=0
 D KVA^VADPT
 ;
 N TRYS,NODE,DONE
 S DONE=0 F TRYS=1:1:30 D  Q:DONE  ; (This should really work the first time)
 . S GUID=$$GUID4
 . S NODE="YTQCPRS-"_GUID
 . L +^XTMP(NODE):DILOCKTM E  QUIT
 . I $D(^XTMP(NODE)) L -^XTMP(NODE) QUIT  ; already used, so unlock & retry
 . S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"MH DLL Assignment",DONE=1
 . L -^XTMP(NODE)
 S DATA("id")=GUID
 I 'DONE S RSP(1)="ERROR: failed to find GUID" QUIT
 S ^XTMP("YTQCPRS-HWND",0)=^XTMP(NODE,0)_" Index"
 S ^XTMP("YTQCPRS-HWND",HWND,DFN,TESTNM)=GUID_U_DT
 S ^XTMP(NODE,"hwnd")=HWND
 M ^XTMP(NODE,1)=DATA
 S RSP(1)="URL="_$$GET^XPAR("SYS","YSCPRS DLL URL",1,"Q")_GUID
 Q
GUID4() ; return a type 4 GUID (random)
 N C,D,X,N ; C=ceiling, D=dash, X=uuid, N=integer 
 S C=4294967295,D="-",X=""
 F N=1:1:4 S X=X_$TR($J($$CNV^XLFUTL($R(C),16),8)," ",0)
 S $E(X,13)=4,N=$R(4),$E(X,17)=$S(N=0:8,N=1:9,N=2:"A",1:"B")
 Q $E(X,1,8)_D_$E(X,9,12)_D_$E(X,13,16)_D_$E(X,17,20)_D_$E(X,21,32)
 ;
GETRSLT(RSP,TESTNM,GUID) ; get status and results for reminder dialog test invocation
 ;    DLL: ShowInstrument end - web page completed, return result
 ;  input: TESTNM, GUID
 ; output: status, scale=score..., questions...
 ; faComplete, faIncomplete, faCancelled, faNotStarted
 N NODE,TEST,QCNT,I
 S NODE="YTQCPRS-"_GUID
 S TEST=+$O(^YTT(601.71,"B",TESTNM,0))
 I 'TEST S RSP(1)="CANCELLED^" QUIT
 S (I,QCNT)=0 F  S I=$O(^YTT(601.76,"AC",TEST,I)) Q:'I  S QCNT=QCNT+1
 I '$D(^XTMP(NODE)) D  QUIT
 . S RSP(1)="CANCELLED^"_TESTNM_U_QCNT
 I '$D(^XTMP(NODE,3,TEST)) D  QUIT
 . S RSP(1)="NOT STARTED^"_TESTNM_U_QCNT
 I $G(^XTMP(NODE,3,TEST,"complete"))'="true" D  QUIT
 . S RSP(1)="INCOMPLETE^"_TESTNM_U_QCNT_U_$$SKIPSTR(NODE,TEST)
 I $L($P($G(^YTT(601.71,TEST,2)),U)) D  QUIT
 . S RSP(1)="COMPLETE^"_TESTNM_U_QCNT_"^*Restricted instrument. No results are reported here."
 ;
 ; -- score completed, non-restricted instrument
 N ANSWERS,SCORES
 M ANSWERS=^XTMP(NODE,3,TEST,"answers")
 I $P($G(^YTT(601.71,TEST,8)),U,3)="Y" D               ; legacy scoring
 . N ADFN,AUSER
 . S ADFN=^XTMP(NODE,1,"patient","dfn")
 . S AUSER=^XTMP(NODE,1,"orderedBy") S:'AUSER AUSER=DUZ
 . D LEGACY^YTSCOREX(TESTNM,ADFN,AUSER,.ANSWERS,.SCORES)
 E  D CALC^YTSCOREX(TEST,.ANSWERS,.SCORES)             ; normal scoring
 S RSP(1)=$$CPRSSTR^YTSCOREX(TEST,.ANSWERS,.SCORES)
 Q
SKIPSTR(NODE,TEST) ; return a string of skipped question identifiers
 N I,QSTN,CTXT,DLIM,X
 S X=""
 S I=0 F  S I=$O(^XTMP(NODE,3,TEST,"answers",I)) Q:'I  D  Q:$L(X)>200
 . I $G(^XTMP(NODE,3,TEST,"answers",I,"value"))="NOT ASKED" D
 . . S QSTN=+$P($G(^XTMP(NODE,3,TEST,"answers",I,"id")),"q",2)
 . . S CTXT=$O(^YTT(601.76,"AF",TEST,QSTN,0))
 . . S DLIM=$P(^YTT(601.76,CTXT,0),U,5)
 . . I $L(DLIM) S X=X_DLIM_", "
 Q X
 ;
COMMIT(RSP,TESTNM,DFN,ORDBY,ADMBY,ADMDT,LOC,HWND) ; save completed administration
 ;    DLL: SaveInstrument(testNm,DFN,OrdBy,AdmBy,AdmDate,LocIEN)
 ;  input: testName, DFN, orderedBy, interviewer, location, adminDate
 ;         (use DFN + TESTNM to find the GUID)
 ;         need to set adminDate so it syncs with the visit
 ;         update ordBy, admBy, loc if necessary
 ; output: returnStatus
 ;
 N GUID,NODE,TEST,DATA,ADMIN
 I '$L(DFN)!'$L(ORDBY)!'$L(ADMBY)!'$L(ADMDT)!'$L(LOC) D  QUIT
 . S RSP(1)="ERROR: required fields are missing"
 S GUID=$P($G(^XTMP("YTQCPRS-HWND",HWND,DFN,TESTNM)),U)
 S NODE="YTQCPRS-"_GUID
 S TEST=+$O(^YTT(601.71,"B",TESTNM,0))
 I '$D(^XTMP(NODE,3,TEST,"answers")) S RSP(1)="ERROR: answers not found" QUIT
 I ^XTMP(NODE,1,"patient","dfn")'=DFN S RSP(1)="ERROR: patient mis-match" QUIT
 S ^XTMP(NODE,1,"date")=ADMDT,^("adminDate")=""  ; force visit date from CPRS
 S ^XTMP(NODE,1,"orderedBy")=ORDBY
 S ^XTMP(NODE,1,"interview")=ADMBY
 S ^XTMP(NODE,1,"location")=+LOC
 M DATA=^XTMP(NODE,3,TEST)
 S DATA("source")="cprs-web-dll"
 S DATA("assignmentId")=$P(DATA("adminId"),"-",1,5)
 K DATA("adminId") ; so it doesn't get confused with "real" adminId
 S ADMIN=$$QASAVE^YTQRQAD2(.DATA)
 I 'ADMIN S RSP(1)="ERROR: admin not created" QUIT
 S RSP(1)=ADMIN
 N YSDATA,YS
 K ^TMP($J,"YSCOR")
 S YS("AD")=ADMIN
 D SCORSAVE^YTQAPI11(.YSDATA,.YS)
 I $G(YSDATA(1))="[ERROR]" S RSP(1)="ERROR: "_$G(YSDATA(2)) QUIT
 I $G(^TMP($J,"YSCOR",1))="[ERROR]" S RSP(1)="ERROR: "_$G(^(2)) QUIT
 D CLEARTST(DFN,TESTNM,HWND)
 Q
 ;
CLEAR(RSP,DFN,TESTNM,HWND) ; remove test data from reminder dialog temporary space
 ;    DLL: RemoveTempVistaFile(testNm, DFN)
 ;  input: testName, DFN, handle
 ;         remove all for DFN if testName=""
 ;         otherwise remove testName for DFN
 S RSP(1)="OK"
 N GUID,X
 I $L(TESTNM) D CLEARTST(DFN,TESTNM,HWND) QUIT
 ; clear all scratch instruments for this session if TESTNM=""
 S X="" F  S X=$O(^XTMP("YTQCPRS-HWND",HWND,DFN,X)) Q:'$L(X)  D
 . D CLEARTST(DFN,X,HWND)
 Q
CLEARTST(DFN,TESTNM,HWND) ; for DFN/HWND session, remove specific TESTNM
 N GUID,NODE,I,TEST
 S GUID=$P($G(^XTMP("YTQCPRS-HWND",HWND,DFN,TESTNM)),U) Q:'$L(GUID)
 S NODE="YTQCPRS-"_GUID
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NODE,1,"instruments",I,"name")'=TESTNM QUIT
 . K ^XTMP(NODE,1,"instruments",I)                 ; remove TESTNM assignment
 . S TEST=$O(^YTT(601.71,"B",TESTNM,0)) Q:'TEST
 . K ^XTMP(NODE,3,TEST)                            ; remove TESTNM answer set
 . K ^XTMP("YTQCPRS-HWND",HWND,DFN,TESTNM)         ; remove index node
 I '$D(^XTMP(NODE,1,"instruments")) K ^XTMP(NODE)  ; no tests remaining
 Q
