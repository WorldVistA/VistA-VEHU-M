ORWDSD1 ;SLC/AGP - Return to Clinic Calls for Windows Dialog ;03/19/2019
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**434,377**;Dec 17, 1997;Build 582
 ;
ODSLCT(LST,DFN,LOC) ; return default lists for dialog
 N ILST S ILST=0
 S ILST=ILST+1,LST(ILST)="~ShortList"  D SHORT
 ;S ILST=ILST+1,LST(ILST)="~Clinic" D CLINIC(.LST,.ILST,DFN,LOC)
 ;S ILST=ILST+1,LST(ILST)="~Provider" D PROVIDER(.LST,.ILST,DFN,LOC)
 ;S ILST=ILST+1,LST(ILST)="~Interval" D INTERVAL(.LST,.ILST,DFN,LOC)
 S ILST=ILST+1,LST(ILST)="~PreReq" D PREREQ(.LST,.ILST,DFN,LOC)
 ;S ILST=ILST+1,LST(ILST)="~Offset" D OFFSET(.LST,.ILST,DFN,LOC)
 S ILST=ILST+1,LST(ILST)="~Info" D INFO(.LST,.ILST,DFN,LOC)
 Q
 ;
CLINIC(LST,ILST,DFN,LOC) ;
 N CLST,CNT,FOUND,LCNT,IEN,NAME,NODE,TMP
 ;
 S NAME="",FOUND=0
 I LOC>0 D
 .S NODE=$G(^SC(LOC,0)) I $P(NODE,U,3)'="C" Q
 .S NAME=$P(NODE,U) I $L(NAME)<3 S TMP=NAME Q
 .S TMP=$E(NAME,1,($L(NAME)-1))
 I $G(TMP)="" Q
 D NEWLOC^ORWU1(.CLST,TMP,1)
 S CNT=0,LCNT=0 F  S CNT=$O(CLST(CNT)) Q:CNT'>0  D
 .S LCNT=CNT
 .I $P(CLST(CNT),U)=LOC,NAME'="" S ILST=ILST+1,LST(ILST)="d"_CLST(CNT),FOUND=1,ILST=ILST+1,LST(ILST)="i"_CLST(CNT) Q
 .S ILST=ILST+1,LST(ILST)="i"_CLST(CNT)
 I FOUND=0,NAME'="" S ILST=ILST+1,LST(ILST)="d"_LOC_U_NAME,ILST=ILST+1,LST(ILST)="i"_LOC_U_NAME
 Q
 ;
GETINFO(LST,HLOCIEN,WHAT) ;
 N CLSTP,CNT,DIV,ENT,ERR,HFAC,ILST,INST,ORPAR
 S DIV=$P($G(^SC(HLOCIEN,0)),U,4)
 ;S:DIV'="" HFAC=$P($G(^DG(40.8,DIV,0)),U,7)
 S CLSTP=$P($G(^SC(HLOCIEN,0)),U,7)
 S ENT="LOC.`"_HLOCIEN
 I +CLSTP>0 S ENT=ENT_U_"CST.`"_CLSTP
 I +DIV>0 S ENT=ENT_U_"DIV.`"_DIV
 S ENT=ENT_U_"SYS"
 I WHAT="INFO" D GETWP^XPAR(.ORPAR,ENT,"OR SD ADDITIONAL INFORMATION",,.ERR)
 I WHAT="PRE" D GETLST^XPAR(.ORPAR,ENT,"OR SD DIALOG PREREQ","N",.ERR)
 S CNT=0,ILST=0 F  S CNT=$O(ORPAR(CNT)) Q:CNT'>0  D
 .I WHAT="INFO" S ILST=ILST+1,LST(ILST)=ORPAR(CNT,0) Q
 .S ILST=ILST+1,LST(ILST)=$P(ORPAR(CNT),U,2)
 Q
 ;
INFO(LST,ILST,DFN,LOC) ;
 N CNT,ENT,ERR,ORPAR,SYSONLY
 I '$$SYSONLY("OR SD ADDITIONAL INFORMATION") Q
 ;D ENVAL^XPAR(.ORPAR,"OR SD ADDITIONAL INFORMATION","",.ERR)
 ;S ENT="" F  S ENT=$O(ORPAR(ENT)) Q:ENT=""!(SYSONLY=0)  S:ENT'["DIC(4.2" SYSONLY=0
 ;I SYSONLY=0 Q
 K ORPAR
 D GETWP^XPAR(.ORPAR,"SYS","OR SD ADDITIONAL INFORMATION",,.ERR)
 S CNT=0 F  S CNT=$O(ORPAR(CNT)) Q:CNT'>0  D
 .S ILST=ILST+1,LST(ILST)="t"_ORPAR(CNT,0)
 Q
 ;
INTERVAL(LST,ILST,DFN,LOC) ;
 S ILST=ILST+1,LST(ILST)="id^Daily"
 S ILST=ILST+1,LST(ILST)="iw^Weekly"
 Q
 ;
OFFSET(LST,ILST,DFN,LOC) ;
 N OFFSET
 S OFFSET=$$GET^XPAR("SYS","OR SD CIDC STOP OFFSET",1,"E")
 I OFFSET'>0 S OFFSET=30
 S ILST=ILST+1,LST(ILST)="i"_OFFSET_U_OFFSET
 Q
PREREQ(LST,ILST,DFN,LOC) ;
 N ORPAR,X
 I '$$SYSONLY("OR SD DIALOG PREREQ") Q
 D GETLST^XPAR(.ORPAR,"SYS","OR SD DIALOG PREREQ","N",.ERR)
 ;D PREREQP^ORCDSD(.PREREQS)
 S X=0 F  S X=$O(ORPAR(X)) Q:X'>0  I $G(ORPAR(X))'="" S ILST=ILST+1,LST(ILST)="i"_$G(ORPAR(X))
 Q
 ;
PROVIDER(LST,ILST,DFN,LOC) ;
 N CNT,PLST
 D NEWPERS^ORWU(.PLST,"",1,"PROVIDER",DT,0,"")
 S CNT=0 F  S CNT=$O(PLST(CNT)) Q:CNT'>0  S ILST=ILST+1,LST(ILST)="i"_PLST(CNT)
 Q
 ;
SHORT ; from DLGSLCT, get short list of med quick orders
 N I,X,TMP
 S X="CSDAM"
 D GETQLST^ORWDXQ(.TMP,X,"iQ")
 S I=0 F  S I=$O(TMP(I)) Q:'I  S ILST=ILST+1,LST(ILST)=TMP(I)
 Q
 ;
RTC ;
 N INT,NUM,PROMPT
 ;S PROMPT=$O(^ORD(101.41,"AB","OR GTX STOP DATE",0))
 ;S ORDIALOG(PROMPT,1)=$$SETSTOP^ORCDSD()
 ;get number of appointments and interval
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX APPT NUM",0))
 S NUM=$G(ORDIALOG(PROMPT,1))
 S PROMPT=$O(^ORD(101.41,"AB","OR GTX SCH INTERVAL",0))
 S INT=$G(ORDIALOG(PROMPT,1))
 ;check that apppointment and interval match
 I NUM>1,INT="" S AUTOACK=0 Q
 I INT'="",NUM=1 S AUTOACK=0 Q
 Q
 ;
SYSONLY(PARAM) ;
 N ERR,SYSONLY
 S SYSONLY=1
 D ENVAL^XPAR(.ORPAR,PARAM,"",.ERR)
 S ENT="" F  S ENT=$O(ORPAR(ENT)) Q:ENT=""!(SYSONLY=0)  S:ENT'["DIC(4.2" SYSONLY=0
 Q SYSONLY
