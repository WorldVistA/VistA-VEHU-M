YTQRQAD4 ;ISP/MJB - RESTful Calls to handle MHA lists ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**158,178,182,181**;Dec 30, 1994;Build 39
 ;
 ; ICR #4290 READ OF CLINICAL REMINDER INDEX (PXRMINDX)
 ; Reference to ORQQCN API supported by DBIA #1671
 ;
GETLIST(ARGS,RESULTS) ; GET LIST OF INSTRUMENTS FOR PATIENT
 N LST,TST,I,NM,TEST,DFN,SRISK
 N ADMINDT,ADMINID,CMPL,CNT,HIT,PAT,G,YSIENS,YSDATA,N,STR,ERRLST,ERRSTR
 N ADMINAR,XDT,SAVEDT
 S NM="",N=0
 K ^TMP("YTQ-JSON",$J) S CNT=0
 D SETRES("{""instruments"":[")
 S HIT=""
 S DFN=+$G(ARGS("dfn"))
 D UPDTSRFL  ; Get list of instruments for patient and update Suicide Risk Flag
 I DFN'?1N.NP D SETERROR^YTQRUTL(404,"Bad Patient ID: "_DFN) QUIT
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Patient Not Found: "_DFN) QUIT
 F  S NM=$O(^YTT(601.84,"C",DFN,NM)) Q:'NM  D
 .S G=$G(^YTT(601.84,NM,0))
 .I G="" S ERRLST(NM)="" Q  ;-->out
 .S CMPL=$P(G,U,9) I CMPL="Y" D
 ..S ADMINDT=$P(G,U,4) Q:ADMINDT=""
 ..S ADMINAR(-ADMINDT,NM)=""
 S XDT="" F  S XDT=$O(ADMINAR(XDT)) Q:XDT=""  D
 .S NM="" F  S NM=$O(ADMINAR(XDT,NM)) Q:NM=""  D
 ..S STR=""
 ..S G=$G(^YTT(601.84,NM,0))
 ..S TST=$P(G,U,3)
 ..S CMPL=$P(G,U,9) I CMPL="Y" D 
 ...S NAME=$P($G(^YTT(601.71,TST,0)),U,1)
 ...S ADMINID=$P(G,U,1),ADMINDT=$P(G,U,4),PAT=$P(G,U,2)
 ...S SAVEDT=$P(G,U,5)
 ...S SRISK=$P(G,U,14) I SRISK="" S SRISK=0
 ...S STR="{""adminId"":"""_ADMINID_""", ""instrumentName"":"""_NAME_""" , ""instrumentIen"":"""_TST_""" , ""completeDate"":"""_$$FMTE^XLFDT(ADMINDT)
 ...S STR=STR_""" , ""administrationDate"":"""_$$FMTE^XLFDT(ADMINDT)_""" , ""saveDate"":"""_$$FMTE^XLFDT(SAVEDT)_""" , ""suicideRisk"":"""_SRISK_""" },"
 ..I STR]"" S HIT=1 D SETRES(STR)
 I $D(ERRLST) D  Q
 . S (ERRSTR,NM)="" F  S NM=$O(ERRLST(NM)) Q:NM=""  D
 .. S ERRSTR=ERRSTR_NM_", "
 . S ERRSTR=$E(ERRSTR,1,$L(ERRSTR)-2)
 . D SETERROR^YTQRUTL(404,"Instrument not found: "_ERRSTR)
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
SETRES(STR) ;
 S CNT=CNT+1,^TMP("YTQ-JSON",$J,CNT,0)=STR
 Q
 ;
GETLOCS(ARGS,RESULTS) ; get list of hospital locations
 ; C=Clinics, Z=Other, screened by $$ACTLOC
 ; .Y=returned list, ORFROM=text to $O from, DIR=$O direction.
 N I,IEN,CNT,LCNT,STR,LOC,HIT,DIR,ORFROM
 N ROOT,LROOT
 S HIT=0,CNT=0,DIR=1,ORFROM=""
 S ROOT=$$UP^XLFSTR($G(ARGS("locmatch"))),LROOT=$L(ROOT)
 S ORFROM=ROOT
 D SETRES("{""locations"":[")
 S I=0,LCNT=99999  ;Return all locs for now
 ;F  Q:I'<LCNT  S ORFROM=$O(^SC("B",ORFROM),DIR) Q:ORFROM=""  D  ; IA# 10040.
 F  Q:I'<LCNT  S ORFROM=$O(^SC("B",ORFROM),DIR) Q:ORFROM=""  Q:$E(ORFROM,1,LROOT)'=ROOT  D  ; IA# 10040.
 .S IEN="" F  S IEN=$O(^SC("B",ORFROM,IEN),DIR) Q:'IEN  D
 ..Q:("C"'[$P($G(^SC(IEN,0)),U,3)!('$$ACTLOC(IEN)))
 ..S STR="{""locId"": """_IEN_""", ""locName"": """_ORFROM_"""},",HIT=IEN
 ..D SETRES(STR)
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last ","
 I HIT=0 D SETRES("{}")  ;Empty set, should not happen
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 ; IA# 10040.
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
GETCATA(DOCNAME,RESULTS) ; set ^TMP with contents of the document named and categories
 N CNT,HIT,NMB,NAME,IENI,IENC,CATN,XSTR,STAFF,OP,RPRIV,GPNOT,ALWN
 K ^TMP("YTQ-JSON",$J)
 S CNT=0,NMB="",NAME="",HIT=""
 D SETRES("{""Instruments"":[")
 S (IENI,NAME)=""
 F  S NAME=$O(^YTT(601.71,"B",NAME)) Q:NAME=""  D
 . S HIT=1
 . S IENI="" S IENI=$O(^YTT(601.71,"B",NAME,IENI))
 . S OP=$P(^YTT(601.71,IENI,2),"^",2)
 . I OP'="Y" Q
 . I $E(NAME,1,7)="CAT-CAD" Q  ;only used for interview
 . I $$GET^XPAR("ALL","YSCAT DISABLED",1,"Q") Q:$E(NAME,1,4)="CAT-"  Q:$E(NAME,1,4)="CAD-"
 . ;I '$D(^YTT(601.71,IENI,10,"B")) Q
 . S STAFF=$P($G(^YTT(601.71,IENI,9)),U,4)
 . S STAFF=$S(STAFF="Y":"true",1:"false")
 . S RPRIV=$$RSTRCT(IENI)  ;Added R PRIVILEGE flag
 . S GPNOT=$$GENNOT(IENI)  ;Added GENERATE PNOTE flag
 . S ALWN=$$ALWN2^YTQRQAD3(IENI)  ;Added ALLOWNOTE function call
 . S STR="{""instrumentName"":"""_NAME_""", ""staffOnly"":"""_STAFF_""" , ""allowNote"":"""_ALWN_""" , ""instrumentCategory"": ["
 . S IENC=""
 . I '$D(^YTT(601.71,IENI,10,"B")) D
 .. S CATN=""
 .. S XSTR="{""categoryName"":"""_CATN_"""}"
 .. D SETRES(STR)
 . I $D(^YTT(601.71,IENI,10,"B")) D
 .. F  S IENC=$O(^YTT(601.71,IENI,10,"B",IENC)) Q:'IENC  D
 ... S CATN=""
 ... S CATN=^YTT(601.97,IENC,0)
 ... S XSTR="{""categoryName"":"""_CATN_"""},"
 ... S STR=STR_XSTR
 .. S STR=$E(STR,1,$L(STR)-1)
 .. D SETRES(STR)
 . ;I CATN'="" S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 . D SETRES("]},")  ;Close of the multiple Category, and Close off the Instrument - add comma for next Instrument
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
RSTRCT(IENI) ;Return KEY if Restricted Instrument (R Privilege)
 N RKEY,N2
 S RKEY=""
 S N2=$G(^YTT(601.71,IENI,2)),RKEY=$P(N2,U)
 Q RKEY
 ;
GENNOT(IENI) ;Return GPNOT=Yes,generate progress note or No, don't generate
 N GNOT,N8
 S N8=$G(^YTT(601.71,IENI,8)),GNOT=$P(N8,U,8)
 S GNOT=$S(GNOT="Y":"Yes",1:"No")
 Q GNOT
 ;
ASMTID5(ARGS,RESULTS) ; get assignments identified by patient id with list of instruments and last complete date
 N ASMT,PID,PTNAME,LAST,ORDBY,I,CATHIT
 N TST,NM,TEST,TSTIEN,DATA,STAFF,ENTRY,PROG,EXPDT
 N ADMINDT,ADMINID,CMPL,PAT,G,YSIENS,YSDATA,N,ASMTID
 S NM="",N=0
 S ASMT="",ORDBY=""
 K ^TMP("YTQ-JSON",$J) S CNT=0
 S DFN=+$G(ARGS("dfn"))
 D SETRES("{""patientAssignments"":[")
 S HIT=""
 F  S ORDBY=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY)) Q:'ORDBY  D
 .F  S ASMT=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)) Q:'ASMT  D
 ..S ENTRY=$G(^XTMP("YTQASMT-SET-"_ASMT,1,"entryMode"))
 ..S STR="{""assignmentId"":"""_ASMT_""" , ""entryMode"":"""_ENTRY_""", ""instruments"": ["
 ..;S STR="{""assignmentId"":"""_ASMT_""" , ""instruments"": ["
 ..S I="",CATHIT=0 F  S I=$O(^XTMP("YTQASMT-SET-"_ASMT,1,"instruments",I)) Q:'I  D
 ...;S STR="{""assignmentId"":"""_ASMT_""" , ""instruments"": ["
 ...K DATA
 ...M DATA=^XTMP("YTQASMT-SET-"_ASMT,1,"instruments",I)
 ...S NAME=$G(DATA("name"))
 ...S TSTIEN=$G(DATA("id"))
 ...S CMPL=$G(DATA("complete"))
 ...S ASMTID=$G(DATA("adminId"))
 ...I ASMTID,'$D(^YTT(601.84,ASMTID)) D RMVTEST^YTQRQAD1(ASMT,NAME) Q
 ...I ASMTID,'$$CHKADM(ASMTID,NAME,DFN) D RMVTEST^YTQRQAD1(ASMT,NAME) Q  ;MH ADMIN exists but was reused by diff Patient/Instrument
 ...S PROG=$$PROGRESS^YTQRQAD1(ASMTID,TSTIEN,ASMT) ;ASMTID=adminId??
 ...I PROG="" S PROG=0
 ...;S PROG=$G(DATA("progress")) ; Add Progess col to results
 ...S EXPDT=$P(^XTMP("YTQASMT-SET-"_ASMT,0),U) ; Add Expiration dt
 ...D ASMTIDA(DFN,.ARRAY)
 ...S (ADMINID,ADMINDT)="",STAFF="false"
 ...S ADMINID=$O(ARRAY(ADMINID),-1) I $G(ADMINID)'="" S ADMINDT=$O(ARRAY(ADMINID,"")),STAFF=$O(ARRAY(ADMINID,ADMINDT,""))
 ...S XSTR="{""instrumentName"":"""_NAME_""",""lastDone"":"""_$$FMTE^XLFDT($P(ADMINDT,"."))_""",""adminId"":"""_ADMINID_""",""instrumentComplete"":"""_CMPL_""",""staffOnly"":"_STAFF
 ...S XSTR=XSTR_", ""progress"": """_PROG_""",""expDt"":"""_$$FMTE^XLFDT($P(EXPDT,"."))_"""},"
 ...S STR=STR_XSTR,CATHIT=1
 ..I '$D(^XTMP("YTQASMT-SET-"_ASMT)) Q  ;Assignment could have been deleted if RMVTEST was last/only test in assignment
 ..I $D(^XTMP("YTQASMT-SET-"_ASMT,1,"instruments")) S HIT=1
 ..D SETRES(STR)
 ..I CATHIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 ..D SETRES("]},")  ;Close of the multiple Category, and Close off the Instrument - add comma for next Instrument
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
CHKADM(YSADMIN,YSNAM,YSDFN) ;Check if Instrument Admin is the same as what is in XTMP
 N STAT,YSIENS,YSARR,YSERR
 I $G(YSNAM)="" S STAT=0 Q STAT
 I +$G(YSDFN)=0 S STAT=0 Q STAT
 I +$G(YSADMIN)=0 S STAT=0 Q STAT
 S STAT=1  ;OK
 S YSIENS=YSADMIN_","
 D GETS^DIQ(601.84,YSIENS,"1;2","EI","YSARR","YSERR")
 I $D(YSERR) S STAT=0 Q STAT
 I $G(YSARR(601.84,YSIENS,2,"E"))'=$G(YSNAM) S STAT=0
 I $G(YSARR(601.84,YSIENS,1,"I"))'=YSDFN S STAT=0
 Q STAT
 ;
ASMTIDA(DFN,ARRAY) ; get assignments identified by patient id
 N ADMINDT,ADMINID,CMPL
 K ARRAY
 S NM="",N=0
 I DFN'?1N.NP S YSDATA(1)="[ERROR]",YSDATA(2)="bad DFN" Q  ;-->out asf 2/22/08
 I '$D(^DPT(DFN,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="no pt" Q  ;-->out
 F  S NM=$O(^YTT(601.84,"C",DFN,NM))  Q:'NM  D
 .S G=$G(^YTT(601.84,NM,0))
 .I G="" S YSDATA(1)="[ERROR]",YSDATA(2)=YSIENS_" bad ien in 84" Q  ;-->out
 .S PAT=$P(G,U,2) Q:PAT'=DFN
 .S TST=$P(G,U,3) Q:TST'=TSTIEN
 .S CMPL=$P(G,U,9) I CMPL="Y" D 
 ..S NAME=$P($G(^YTT(601.71,TST,0)),U,1)
 ..S STAFF=$P($G(^YTT(601.71,TST,9)),U,4) S:STAFF="" STAFF="N"
 ..S STAFF=$S(STAFF="Y":"true",1:"false")
 ..S ADMINID=$P(G,U,1),ADMINDT=$P(G,U,4)
 ..S ARRAY(ADMINID,ADMINDT,STAFF)=""
 Q
 ;
GETCONS(ARGS,RESULTS)   ; Get list of patient consults
 N TYPE,RV,CONS,DT,STAT,LOC,TYPE,LOCA,YSSTAT,HIT,NOCONS
 S YSSTAT="5,6,8,9,15"  ;Pending, Active, Scheduled, Partial Results, Renewed
 K ^TMP("ORQQCN",$J)
 S DFN=+$G(ARGS("dfn")) D LIST^ORQQCN(.RV,DFN,,,,YSSTAT)  ;DBIA 1671 ORQQCN LIST
 K ^TMP("YTQ-JSON",$J) S CNT=0
 D SETRES("{""consults"":[")
 S HIT="",NOCONS=""
 S IEN=0 F  S IEN=$O(^TMP("ORQQCN",$J,"CS",IEN)) Q:'IEN!NOCONS  D
 .S DATA=^TMP("ORQQCN",$J,"CS",IEN,0)
 .I DATA["PATIENT DOES NOT HAVE ANY" S NOCONS=1 Q
 .S HIT=1
 .S CONS=$P(DATA,U,1)
 .S DT=$P(DATA,U,2)
 .S STAT=$P(DATA,U,3)
 .S LOC=$P(DATA,U,4)
 .S TYPE=$P(DATA,U,5)
 .S LOCA=$P(DATA,U,6)
 .S STR="{""Consult"":"""_CONS_""", ""ConsultDate"":"""_$$FMTE^XLFDT($P(DT,"."))_""", ""Status"":"""_STAT_""", ""Clinic"":"""_LOC_""",""Type"":"""_TYPE_"""},"
 .D SETRES(STR)
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
ASMTSTAF(ARGS,RESULTS) ; get assignment identified by assignmentId
 N ASMT,INTE,ORBY,LOCA,INTV,ORDBY,LOC,CON,DAT,CONTX,CONA,ADMINDT
 N YSARR,II,DATA
 S ASMT="YTQASMT-SET-"_$G(ARGS("assignmentId"))
 I '$D(^XTMP(ASMT)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 M DATA=^XTMP("YTQASMT-SET-"_$G(ARGS("assignmentId")))
 S INTE=$G(DATA(1,"interview"))
 S ORBY=$G(DATA(1,"orderedBy"))
 S LOCA=$G(DATA(1,"location"))
 S CONA=$G(DATA(1,"consult"))
 S DFN=$G(DATA(1,"patient","dfn"))
 ;Now XLAT pointers to JSON data var_"Name"
 S INTV=$P($G(^VA(200,INTE,0)),U,1)
 S ORDBY=$P($G(^VA(200,ORBY,0)),U,1)
 S LOC=$P($G(^SC(LOCA,0)),U,1)
 S ADMINDT=$G(DATA(1,"adminDate"))
 S RESULTS("interviewName")=INTV
 S RESULTS("orderedbyName")=ORDBY
 S RESULTS("locationName")=LOC
 S RESULTS("adminDate")=ADMINDT
 S RESULTS("consultName")=""  ;initialize consultName
 D LIST^ORQQCN(.RV,DFN)
 S IEN="" F  S IEN=$O(^TMP("ORQQCN",$J,"CS",IEN)) Q:'IEN  D
 .S DAT=^TMP("ORQQCN",$J,"CS",IEN,0)
 .S CON=$P(DAT,U,1) Q:CON'=CONA  D  I CON=CONA S CONTX=$P(DAT,U,7)
 .S RESULTS("consultName")=CONTX
 M RESULTS=^XTMP(ASMT,1)
 K ^TMP("YTQ-JSON",$J)
 D ENCODE^XLFJSON("RESULTS","YSARR")
 S II=0 F  S II=$O(YSARR(II)) Q:II=""  D
 . S ^TMP("YTQ-JSON",$J,II,0)=YSARR(II)
 K RESULTS
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ; 
UPDTSRFL ;
 ; ICR #4290 READ OF CLINICAL REMINDER INDEX (PXRMINDX) 
 ;   Set index for 601.84 MH ADMINISTRATIONS
 ;      X(1)=Patient X(2)=Instrument X(3)=Date Given
 ;      ^PXRMINDX(601.84,"IP",X(2),X(1),X(3),DA)=""
 ;      ^PXRMINDX(601.84,"PI",X(1),X(2),X(3),DA)=""
 ;
 ; Loop through ^PXRMINDX(601.84,"PI",X(1),X(2) to get list of completed instruments
 ; that are associated with the patient
 ;
 N INSTIEN,TEMP,SRCALL
 S INSTIEN=""
 F  S INSTIEN=$O(^PXRMINDX(601.84,"PI",DFN,INSTIEN)) Q:INSTIEN=""  D  ;Get list of instrument IENs for patient
 . S TEMP=$G(^YTT(601.71,INSTIEN,9))
 . S TEMP(1)=$P(TEMP,U,5),TEMP(2)=$P(TEMP,U,6) ;Get Suicide Tag & routine
 . I TEMP(1)'="",(TEMP(2)'="") D
 . . S SRCALL="D "_TEMP(2)_U_TEMP(1)
 . . X SRCALL
 Q
 ;
