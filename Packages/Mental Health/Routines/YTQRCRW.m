YTQRCRW ;SLC/KCM - MH Clinical Reminder Dialog Web Calls ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**223**;Dec 30, 1994;Build 22
 ;
 ; REST Calls re-routed here if assignmentId matches GUID pattern
 ;
 ; ^XTMP(YTQCPRS-guid,1,property)=ASSIGNMENT property value
 ; ^XTMP(YTQCPRS-guid,1,"instrument",n,property)=specific instrument values
 ; ^XTMP(YTQCPRS-guid,3,testId,property)=ADMIN property value (replace 601.94)
 ; ^XTMP(YTQCPRS-guid,3,testId,"answers",n,property)=response value for admin
 ; ^XTMP(YTQCPRS-guid,"hwnd")=client windows handle
 ; ^XTMP(YTQCPRS-HWND,hwnd,dfn,testName)=guid^date  ; INDEX for patient/session
 ;
GETASMT ;(ARGS,RESULTS) -- from ASMTBYID^YTQRQAD1
 ; web: GET /api/mha/assignment/:assignmentId?36ANP 
 ; get assignment from staging by GUID
 ; ARGS("assignmentId")=GUID
 N NODE,TEST,I
 S NODE="YTQCPRS-"_$G(ARGS("assignmentId"))
 I '$D(^XTMP(NODE)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . S TEST=$G(^XTMP(NODE,1,"instruments",I,"id"))
 . I 'TEST S TEST=$O(^YTT(601.71,^XTMP(NODE,1,"instruments",I,"name"),0))
 . S ^XTMP(NODE,1,"instruments",I,"progress")=$$PROGRESS(NODE,TEST)
 M RESULTS=^XTMP(NODE,1)
 Q
DELASMT ; (ARGS) -- from DELTEST^YTQRQAD1
 ; web: DELETE /api/mha/assignment/:assignmentId/:instrument/:delfrmassign
 ; remove an instrument from an assignment
 ; if delfrmassign=NO just reset the admin (progress=0, adminId=null)
 ; ARGS("assignmentId")=GUID
 ; ARGS("instrument")=instrument name (optionally can be IEN)
 ; ARGS("delfrmassign")=YES or NO (default=YES)
 N NODE,DFA,TSTLST,I,TEST
 S NODE=$G(ARGS("assignmentId"))
 I $D(^XTMP(NODE))<10 D SETERROR^YTQRUTL(404,"Assignment not found") QUIT
 S DFA=$G(ARGS("delfrmassign")) S:DFA'="NO" DFA="YES"
 S TSTLST=$G(ARGS("instrument"))
 I '$L(TSTLST) D SETERROR^YTQRUTL(404,"Instrument for deletion not sent") QUIT
 F I=1:1:$L(TSTLST,",") S TEST=$P(TSTLST,",",I) D RMVTEST(NODE,TEST,DFA)
 Q
 ;
RMVTEST(NODE,TEST,DFA) ; remove a test from an assignment
 ; DFA="YES" means delete from assignment
 N TESTNM,I,DFN
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) Q:'TEST
 I 'TEST D SETERROR^YTQRUTL(404,"Instrument not found") QUIT
 S TESTNM=$P(^YTT(601.71,TEST,0),U)
 K ^XTMP(NODE,3,TEST) ; remove administration data
 S I=1 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NODE,1,"instruments",I,"name")'=TESTNM QUIT
 . ; delete or reset named instrument (based on DFA)
 . I DFA="YES" K ^XTMP(NODE,1,"instruments",I) I 1
 . E  S ^XTMP(NODE,1,"instruments",I,"adminId")="null",^("complete")="false",^("progress")=0
 ; delete assignment if empty
 I $D(^XTMP(NODE,1,"instruments"))<10 D
 . S DFN=+$G(^XTMP(NODE,1,"patient","dfn"))
 . N HWND S HWND=$G(^XTMP(NODE,"hwnd"),0)
 . K ^XTMP(NODE),^XTMP("YTQCPRS-HWND",HWND,DFN,TESTNM)
 Q
GETADM ;(ARGS,RESULTS) -- from GETADM^YTQRQAD2
 ; web: GET /api/mha/instrument/admin/:adminId?36ANP1"-".N
 ; get the current state (answers) for an administration
 ; ARGS("adminId")=GUID-TestIEN
 N GUID,TEST,NODE,I
 S GUID=$P(ARGS("adminId"),"-",1,5)
 S TEST=$P(ARGS("adminId"),"-",6)
 S NODE="YTQCPRS-"_GUID
 I '$D(^XTMP(NODE,3,TEST)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("adminId")) QUIT
 M RESULTS=^XTMP(NODE,3,TEST)
 S I=0 F  S I=$O(RESULTS("answers",I)) Q:'I  D
 . I $G(RESULTS("answers",I,"value"))="NOT ASKED" S RESULTS("answers",I,"value")="null"
 S RESULTS("progress")=$$PROGRESS(NODE,TEST)
 Q
POSTADM ;(ARGS,DATA) -- from SAVEADM^YTQRQAD2
 ; web: POST /api/mha/instrument/admin
 ; return adminId = GUID-TestIEN, save responses in temporary space
 N GUID,NODE,TEST,ADMIN,SAVE,I
 S GUID=$G(DATA("assignmentId")),NODE="YTQCPRS-"_GUID
 I '$D(^XTMP(NODE,1)) D SETERROR^YTQRUTL(404,"Not Found: "_GUID) QUIT ""
 S TEST=+$G(DATA("instrumentId"))
 I 'TEST D SETERROR^YTQRUTL(500,"Answers not saved") QUIT ""
 S ADMIN=GUID_"-"_TEST
 K ^XTMP(NODE,3,TEST)
 S ^XTMP(NODE,3,TEST,"adminId")=ADMIN
 S ^XTMP(NODE,3,TEST,"complete")=$G(DATA("complete"),"false")
 S ^XTMP(NODE,3,TEST,"instrumentId")=TEST
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NODE,1,"instruments",I,"id")'=TEST QUIT
 . S ^XTMP(NODE,1,"instruments",I,"adminId")=ADMIN
 N QID,VAL,SEQ,QTOT,QANS
 S (SEQ,QTOT,QANS)=0
 S I=0 F  S I=$O(DATA("answers",I)) Q:'I  D
 . S QID=DATA("answers",I,"id")
 . M VAL=DATA("answers",I,"value")
 . QUIT:$E(QID)'="q"  ; skip intros, sections
 . I $G(VAL)="null" S VAL="NOT ASKED"
 . S QTOT=QTOT+1 I VAL'="NOT ASKED" S QANS=QANS+1
 . S SEQ=SEQ+1
 . S ^XTMP(NODE,3,TEST,"answers",SEQ,"id")=QID
 . M ^XTMP(NODE,3,TEST,"answers",SEQ,"value")=VAL
 Q "/api/mha/instrument/admin/"_ADMIN
 ;
PROGRESS(NODE,TEST) ; return progress for TEST at NODE
 N I,QTOT,QANS,TESTNM,PERCENT
 S TESTNM=$P(^YTT(601.71,TEST,0),U)
 S (I,QTOT)=0 F  S I=$O(^YTT(601.76,"AC",TEST,I)) Q:'I  S QTOT=QTOT+1
 S (I,QANS)=0 F  S I=$O(^XTMP(NODE,3,TEST,"answers",I)) Q:'I  I ^(I,"value")'="NOT ASKED" S QANS=QANS+1
 S PERCENT=$S(QTOT>0:+$P(((QANS/QTOT)*100)+.5,"."),1:0)
 I $G(^XTMP(NODE,3,TEST,"complete"))="true" S PERCENT=100
 I $E(TESTNM,1,4)="CAT-"!($E(TESTNM,1,4)="CAD-") D
 . N CATINVW S CATINVW=$O(^YTT(601.71,"B","CAT-CAD Interview",0))
 . I $G(^XTMP(NODE,1,"catInfo","credentials","interviewID")) S PERCENT=10
 . I $G(^XTMP(NODE,3,CATINVW,"complete"))="true" S PERCENT=100
 Q PERCENT
