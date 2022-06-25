YTQREST ;SLC/KCM - RESTful API front controller ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**158,178,182,181**;Dec 30, 1994;Build 39
 ;
 ; .HTTPREQ: HTTP-formatted request and JSON body (if present)
 ; .HTTPRSP: HTTP-formatted response and JSON body (if present)
 ;
QADMIN(HTTPRSP,HTTPREQ) ; questionnaire administration resources
 ;;GET /api/mha/getconn/ GETCONN^YTQREST
 ;;GET /api/mha/patient/:dfn/identifiers PID^YTQRQAD
 ;;GET /api/mha/persons/:match PERSONS^YTQRQAD
 ;;GET /api/mha/users/:match USERS^YTQRQAD
 ;;GET /api/mha/instruments/active LSTALL^YTQRQAD
 ;;GET /api/mha/instruments/cprs LSTCPRS^YTQRQAD
 ;;GET /api/mha/instrument/:instrumentName GETSPEC^YTQRQAD
 ;;GET /api/mha/checks/:instrumentName GETCHKS^YTQRQAD2
 ;;POST /api/mha/assignment NEWASMT^YTQRQAD1
 ;;POST /api/mha/assignment/edit/:assignmentId?1.N EDITASMT^YTQRQAD5
 ;;GET /api/mha/assignment/:assignmentId?1.N ASMTBYID^YTQRQAD1
 ;;GET /api/mha/assignment/:assignmentId?1.N/:division ASMTBYID^YTQRQAD1
 ;;GET /api/mha/assignment/graph/:dfn/:instrument GETGRAPH^YTQRQAD5
 ;;DELETE /api/mha/assignment/:assignmentId TRSASMT^YTQRQAD1
 ;;DELETE /api/mha/assignment/:assignmentId/:instrument/:delfrmassign DELTEST^YTQRQAD1
 ;;DELETE /api/mha/assignment/:assignmentId/:instrument DELTEST^YTQRQAD1
 ;;POST /api/mha/instrument/admin SAVEADM^YTQRQAD2
 ;;GET /api/mha/instrument/admin/:adminId?1.N GETADM^YTQRQAD2
 ;;GET /api/mha/instrument/report/:adminId?1.N REPORT^YTQRQAD3
 ;;GET /api/mha/instrument/note/:adminId?1.N GETNOTE^YTQRQAD3
 ;;POST /api/mha/instrument/note SETNOTE^YTQRQAD3
 ;;GET /api/mha/permission/cosign/:adminId/:userId ALWCSGN^YTQRQAD3
 ;;GET /api/mha/instrument/list/:dfn?1.N GETLIST^YTQRQAD4
 ;;GET /api/mha/location/list/:locmatch GETLOCS^YTQRQAD4
 ;;GET /api/mha/category/list GETCATA^YTQRQAD4
 ;;GET /api/mha/assignment/list/:dfn?1.N ASMTID5^YTQRQAD4
 ;;GET /api/mha/consult/list/:dfn?1.N GETCONS^YTQRQAD4
 ;;GET /api/mha/assignment/staff/:assignmentId?1.N ASMTSTAF^YTQRQAD4
 ;;GET /api/mha/assignmentparam/pref GETASMTP^YTQRQAD7
 ;;POST /api/mha/assignmentparam/pref SETASMTP^YTQRQAD7
 ;;GET /api/mha/instrument/lists/fav/userfav GETIFAV^YTQRQAD7
 ;;POST /api/mha/instrument/lists/fav/userfav SETIFAV^YTQRQAD7
 ;;GET /api/mha/instrument/lists/batteries/userbat GETBAT^YTQRQAD7
 ;;POST /api/mha/instrument/lists/batteries/userbat SETBAT^YTQRQAD7
 ;;GET /api/mha/instrument/comments/:adminId?1.N LOADCOM^YTQRQAD7
 ;;POST /api/mha/instrument/comments SETCOM^YTQRQAD3
 ;;GET /api/mha/instrumentgraph/prefs GETGRAPH^YTQRQAD7
 ;;POST /api/mha/instrumentgraph/prefs SETGRAPH^YTQRQAD7
 ;;GET /api/mha/specialgraph/rptpref GETSPCLG^YTQRQAD7
 ;;POST /api/mha/specialgraph/rptpref SETSPCLG^YTQRQAD7
 ;;GET /api/mha/instrument/description/:instrumentName GINSTD^YTQRQAD
 ;;GET /api/mha/assignment/cat/:assignmentId?1.N GCATINFO^YTQRCAT
 ;;POST /api/mha/assignment/cat/:assignmentId?1.N PCATINFO^YTQRCAT
 ;;GET /api/mha/cat/interview/:interviewId GETCATI^YTQRCAT
 ;;POST /api/mha/cat/interview/:interviewId SETCATI^YTQRCAT
 ;;POST /api/wrapper/close WRCLOSE^YTQRQAD
 ;;
 D HANDLE^YTQRUTL("QADMIN^YTQREST",.HTTPREQ,.HTTPRSP)
 Q
 ;Removed from list above 4/30/19
 ;;GET /api/mha/assignment/:lastName/:last4?4N ASMTBYNM^YTQRQAD1
 ;Removed 7/16/20
 ;;GET /api/mha/division/current/ TMPDIV^YTQRQAD
QENTRY(HTTPRSP,HTTPREQ) ; questionnaire entry for patient
 ;;GET /api/mha/patient/:dfn/identifiers PID^YTQRQAD
 ;;GET /api/mha/instrument/:instrumentName GETSPEC^YTQRQAD
 ;;GET /api/mha/checks/:instrumentName GETCHKS^YTQRQAD2
 ;;GET /api/mha/assignment/:assignmentId?1.N ASMTBYID^YTQRQAD1
 ;;GET /api/mha/instrument/admin/:adminId?1.N GETADM^YTQRQAD2
 ;;POST /api/mha/instrument/admin SAVEADM^YTQRQAD2
 ;;GET /api/mha/assignment/cat/:assignmentId?1.N GCATINFO^YTQRCAT
 ;;POST /api/mha/assignment/cat/:assignmentId?1.N PCATINFO^YTQRCAT
 ;;GET /api/mha/cat/interview/:interviewId GETCATI^YTQRCAT
 ;;POST /api/mha/cat/interview/:interviewId SETCATI^YTQRCAT
 ;;
 D HANDLE^YTQRUTL("QENTRY^YTQREST",.HTTPREQ,.HTTPRSP)
 Q
 ; removed
 ;;GET /api/mha/assignment/:lastName/:last4?4N ASMTBYNM^YTQRQAD1
QSETUP(HTTPRSP,HTTPREQ) ; questionnaire setup resources
 Q
REVIEW(HTTPRSP,HTTPREQ) ; results review resources
 Q
ASI(HTTPRSP,HTTPREQ) ; addiction severity index resources
 Q
GETCONN(ARGS,RESULTS) ;Respond to the connection check
 N DATAOUT,ERRARY,JSONOUT
 K ^TMP("YTQ-JSON",$J)
 S DATAOUT("connection","status")="OK"_U_181
 S DATAOUT("connection","datetime")=$$HTE^XLFDT($H,2)
 D ENCODE^VPRJSON("DATAOUT","JSONOUT","ERRARY")
 S ^TMP("YTQ-JSON",$J,1,0)=JSONOUT(1)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
