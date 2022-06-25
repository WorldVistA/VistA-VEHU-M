YTQRQAD7 ;BAL/KTL - RESTful Calls to handle MHA Web RPCs ; 7/19/2021
 ;;5.01;MENTAL HEALTH;**181**;Dec 30, 1994;Build 39
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ;
 ; Routine ICR
 ; Name                                      ICR#
 ; -------------------------------------    -----
 ; SUPPORTED PARAMETER TOOL ENTRY POINTS    2263
 ;
 ;User Preferences
 ;Instrument Admin COMMENT retrieval
GETASMTP(ARGS,RESULTS) ; Given user DUZ get last Assignment Preferences
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB LAST ASSIGN SET","{}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETASMTP(ARGS,DATA) ; Set a User's last Assignment Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB LAST ASSIGN SET","/api/mha/assignmentparam/pref/",.HTTPREQ)
 Q YSRET
GETIFAV(ARGS,RESULTS) ; Given user DUZ get Instrument Favorites
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB FAV INST","{""favlist"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETIFAV(ARGS,DATA) ; Set a User's Instrument Favorites
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB FAV INST","/api/mha/instrument/lists/fav/userfav/",.HTTPREQ)
 Q YSRET
GETGRAPH(ARGS,RESULTS) ; Given user DUZ get Graphing Preferences
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB GRAPH PREFS","{""graphprefs"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETGRAPH(ARGS,DATA) ; Set a User's Graphing Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB GRAPH PREFS","/api/mha/instrumentgraph/prefs/",.HTTPREQ)
 Q YSRET
GETSPCLG(ARGS,RESULTS) ; Given user DUZ get Special Report Graph Report Preferences
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB SPECIAL GRAPH RPT","{""graphprefs"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETSPCLG(ARGS,DATA) ; Set a User's Special Report Graph Report Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB SPECIAL GRAPH RPT","/api/mha/instrumentgraph/prefs/",.HTTPREQ)
 Q YSRET
SETPARAM(YSPNAM,RETURL,HTTPREQ)  ;Set Parameter
 ; Assignment Parameters=YS MHA_WEB LAST ASSIGN SET
 ; Favorite Instruments=YS MHA_WEB FAV INST
 ; Batteries=YS MHA_WEB BATTERIES
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 ; Return Success or Failure URL string
 N II,CNT,YSPDEF,YSDUZ
 N FDA,IENS,FDAIEN,YSMSG,YSJSON
 N YSINST
 I '$D(HTTPREQ) Q RETURL_"NODATA"
 S CNT=0
 ;In the DATA array the body starts after the first line
 S II=2 F  S II=$O(HTTPREQ(II)) Q:II=""  D
 . Q:$TR(HTTPREQ(II)," ")=""
 . S CNT=CNT+1,YSJSON(CNT)=HTTPREQ(II)
 S YSPDEF=$O(^XTV(8989.51,"B",YSPNAM,""))
 I YSPDEF="" Q RETURL_"ERR_param_not_defined"
 S YSINST=1
 S YSDUZ=DUZ_";VA(200,"
 D EN^XPAR(YSDUZ,YSPDEF,YSINST,.YSJSON,.YSMSG)
 Q RETURL_"OK"
GETPARAM(YSPNAM,DFLT,YSWPARR)  ;Get Parameter
 N YSDUZ,YSWDGT
 K JSONOUT
 S YSWDGT=1
 S YSDUZ=DUZ_";VA(200,"
 D GETWP^XPAR(.YSWPARR,YSDUZ,YSPNAM,YSWDGT)
 I '$D(YSWPARR) D
 . S YSWPARR(1,0)=DFLT  ;Need to define Default
 I $D(YSWPARR)=1,($G(YSWPARR)="") D  ;Parameter for User exists but it is empty
 . S YSWPARR(1,0)=DFLT  ;Need to define Default
 Q
GETBAT(ARGS,RESULTS) ; Given user DUZ get Instrument Batteries
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB BATTERIES","{""batteries"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETBAT(ARGS,DATA) ; Set a User's Instrument Batteries
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB BATTERIES","/api/mha/instrument/lists/batteries/userbat/",.HTTPREQ)
 Q YSRET
LOADCOM(ARGS,RESULTS) ;Get Comments for an Instrument Admin and load them for display
 N YSADMIN,YSARR,I,CRLF
 S CRLF=$C(10)
 S YSADMIN=$G(ARGS("adminId"))
 I '$D(^YTT(601.84,YSADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_YSADMIN) QUIT
 D GETCOM^YTQRQAD3(.YSARR,YSADMIN)
 I '$D(YSARR) S RESULTS("text","\",1)="" Q
 S I="" F  S I=$O(YSARR(I)) Q:I=""  D
 . S RESULTS("text","\",I)=YSARR(I)_CRLF
 Q
AINSTS(SETID,IARR)  ; Assignment Instrument Status check for Deletion
 ; Pre-validated Assignment ID passed in
 ; Return IARR by Assignment Instrument Index (e.g. IARR(instnum)=0)
 ;        0=Complete
 ;        1=Incomplete
 ;        2=Not allowed
 ; Return IARR(instnum,"ADMINID")=MH ADMINISTRATION IEN for reference
 ; Overall Delete SETID status
 ;        IARR("STAT")="OK","NOTOK","NOTALLOWED"
 N ASSGN,INST,ISCMPLT,AOK,MGR,YSADMIN,X0
 S MGR=$$ISMGR^YTQRIS()
 S ASSGN="YTQASMT-SET-"_SETID,IARR("STAT")="OK"
 S INST=0 F  S INST=$O(^XTMP(ASSGN,1,"instruments",INST)) Q:+INST=0  D
 . S YSADMIN=$G(^XTMP(ASSGN,1,"instruments",INST,"adminId"))
 . I +YSADMIN=0 S IARR(INST)=1 Q
 . S IARR(INST,"ADMINID")=YSADMIN
 . S X0=$G(^YTT(601.84,YSADMIN,0)) I X0="" S IARR(INST)=1 Q
 . S ISCMPLT=$P(X0,U,9)
 . I ISCMPLT="Y" S IARR(INST)=0,IARR("STAT")="NOTOK" Q
 . I MGR!(DUZ=$P(X0,U,6))!(DUZ=$P(X0,U,7)) S IARR(INST)=1 I 1
 . E  S IARR(INST)=2,IARR("STAT")="NOTALLOWED"
 Q
