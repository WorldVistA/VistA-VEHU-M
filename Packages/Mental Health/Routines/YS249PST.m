YS249PST ;BAL/KTL - Patch 249 Post-init ;May 10, 2024@13:55:37
 ;;5.01;MENTAL HEALTH;**249**;Dec 30, 1994;Build 30
 ;
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 Q
 ;
EDTDATE ; date used to update 601.71:18
 ;;3240531.2159
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS249PST")
 D SETCAT("YMRS","Depression/Mood")
 D SETCAT("MOCA_8.1","Cognitive/Learning")
 D SETCAT("MOCA_8.2","Cognitive/Learning")
 D SETCAT("MOCA_8.3","Cognitive/Learning")
 D SETCAT("MOCA BLIND","Cognitive/Learning")
 D SETCAT("PEG","Long COVID")
 D SETCAT("MIDAS","Long COVID")
 D DROPTST("MOCA")
 D DROPTST("MOCA ALT 1")
 D DROPTST("MOCA ALT 2")
 D DROPTST("CEMI")
 D DROPTST("GPCOG")
 D DROPTST("ISMI")
 D DROPTST("COPD")
 D DROPTST("STAI")
 D DROPTST("STMS")
 D DROPTST("ATQ")
 D DROPTST("IJSS")
 D DROPTST("BBHI-2")
 D DROPTST("CESD")
 D BOMCREV
 D UPDURL
 Q
 ;
SETCAT(TEST,CATNM) ; add category to TEST if not already there
 N CAT
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 S CAT=$O(^YTT(601.97,"B",CATNM,0)) QUIT:'CAT
 I $D(^YTT(601.71,TEST,10,"B",CAT))=10 QUIT  ; already there
 ;
 N YTFDA,YTIEN,DIERR
 S YTFDA(601.71101,"+1,"_TEST_",",.01)=CATNM
 D UPDATE^DIE("E","YTFDA","YTIEN")
 I $D(DIERR) D MES^XPDUTL(CATNM_": "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
 ;
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0))
 I +IEN'=0 D
 . S REC(10)="D"
 . S REC(18)=$P($T(EDTDATE+1),";;",2)
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 K REC,IEN
 S IEN=$O(^YTT(601,"B",NAME,0))
 I 'IEN QUIT
 S REC(32)="N"
 D FMUPD^YTXCHGU(601,.REC,IEN)
 Q
 ;
BOMCREV ; Change old BOMC MH Answers (due to changes in Choices) and rescore for revision 2
 N YSARR,YSBOMC
 ;
 ; YSARR(QUESTIONID,OLDCHOICEID)=NEWCHOICEID
 S YSARR(4173,1834)=6093
 S YSARR(4175,1838)=6094
 S YSBOMC=$O(^YTT(601.71,"B","BOMC",0))
 I YSBOMC D ANSREVQUE(YSBOMC,.YSARR,$H,2)
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 ;Z
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS249-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS249-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/p249/?",SPEC("/home/?")="/home/p249/?"  ;In case URL entered home/? Patch 249
 S SPEC("/home/p224/?")="/home/p249/?"  ;Patch 249
 S ENT="" F  S ENT=$O(^TMP($J,"XPAR",ENT)) Q:ENT=""  D
 . S INST=0 F  S INST=$O(^TMP($J,"XPAR",ENT,INST)) Q:+INST=0  D
 .. S VAL=^TMP($J,"XPAR",ENT,INST)
 .. I (VAL["mha.domain.ext/app/home?"!(VAL["mha.domain.ext/app/home/")) D
 ... S TITL=$P(VAL,"="),CMD=$P(VAL,"=",2,99)
 ... S CMD=$$REPLACE^XLFSTR(CMD,.SPEC)
 ... S NEWVAL=TITL_"="_CMD
 ... D BMES^XPDUTL("Updating "_CMD_" for "_ENT)
 ... D EN^XPAR(ENT,PARM,INST,NEWVAL,.ERR)
 K ^TMP($J,"XPAR")
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS249PST")
 Q
 ;
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 ;
 N I,X
 F I=1:1 S X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
 ;
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*249 PEBS-20^04/11/2024@13:27:22
 ;;YS*5.01*249 BRADEN^04/11/2024@13:12:58
 ;;YS*5.01*249 YMRS^04/10/2024@15:20:31
 ;;YS*5.01*249 MOCA_8.1^04/17/2024@15:20:38
 ;;YS*5.01*249 MOCA_8.2^04/17/2024@15:21:06
 ;;YS*5.01*249 MOCA_8.3^04/18/2024@14:50:03
 ;;YS*5.01*249 MOCA BLIND^04/23/2024@13:52:01
 ;;YS*5.01*249 BOMC^04/24/2024@13:25:37
 ;;YS*5.01*249 Q-LES-Q-SF^05/03/2024@15:32:20
 ;;zzzzz
 ;
 Q
 ;
 ;
ANSREVQUE(YSINS,YSARR,YSDTH,YSREV) ; Queue task to correct BOMC Answers and rescore
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 ;
 I '$G(YSINS) QUIT
 I '$D(YSARR) QUIT
 D BMES^XPDUTL("Queueing task to Correct MH Instrument Answers")
 I $G(YSDTH)="" S YSDTH=$H
 S ZTIO=""
 S ZTRTN="ANSREV^YS249PST"
 S ZTDESC="Correct MH Instrument Answers"
 S ZTDTH=YSDTH
 S ZTSAVE("YSINS")=""
 S ZTSAVE("YSARR(")=""
 I $G(YSREV)>0 S ZTSAVE("YSREV")=""
 D ^%ZTLOAD
 I $G(ZTSK) D BMES^XPDUTL("DONE - Task #"_ZTSK)
 I '$G(ZTSK) D BMES^XPDUTL("Unsuccessful queue of MH Instrument Answers job.")
 S ^XTMP("YTS-ANSREV",0)=$$FMADD^XLFDT(DT,365)_U_DT_U_"MH Log Changed Answers"
 Q
 ;
ANSREV ; correct BOMC Answers and rescore
 ; ZEXCEPT: YSARR,YSINS,YSREV,ZTQUEUED,ZTSTOP
 N YSAD,YSADDT,YSCNT
 ;
 S YSCNT=0
 S ^XTMP("YTS-ANSREV",YSINS,"STARTED")=$$NOW^XLFDT
 S YSADDT=+$G(^XTMP("YTS-ANSREV",YSINS,"LAST"))
 F  S YSADDT=$O(^YTT(601.84,"AC",YSINS,YSADDT)) Q:'YSADDT  D  Q:$G(ZTSTOP)
 . S YSAD=0
 . F  S YSAD=$O(^YTT(601.84,"AC",YSINS,YSADDT,YSAD)) Q:'YSAD  D  Q:$G(ZTSTOP)
 . . S YSCNT=YSCNT+1
 . . ; take a "rest" - allow OS to swap out process
 . . I '(YSCNT#1000) D  I $D(ZTQUEUED),$$S^%ZTLOAD("Processing admin #"_YSAD) S ZTSTOP=1 QUIT
 . . . S ^XTMP("YTS-ANSREV",YSINS,"LAST")=$O(^YTT(601.84,"AC",YSINS,YSADDT),-1)
 . . . H 1
 . . D CHK85(YSINS,YSAD,.YSARR)
 ;
 S ^XTMP("YTS-ANSREV",YSINS,"ENDED")=$$NOW^XLFDT
 ;
 ; if revision # is passed in, kick off job to rescore old administrations
 I $G(YSREV)>0 D QTASK^YTSCOREV(YSINS_"~"_YSREV,$H)
 Q
 ;
CHK85(YSINS,YSAD,YSARR) ; See if any answers for this admin need to be changed
 N YSANS,YSNEWCH,YSOLDCH,YSQID,YSREC
 ;
 S YSQID=0
 F  S YSQID=$O(YSARR(YSQID)) Q:'YSQID  D
 . S YSANS=$O(^YTT(601.85,"AC",YSAD,YSQID,""))
 . I 'YSANS QUIT
 . S YSOLDCH=$P($G(^YTT(601.85,YSANS,0)),U,4)
 . I 'YSOLDCH QUIT
 . S YSNEWCH=$G(YSARR(YSQID,YSOLDCH))
 . I YSNEWCH'>0 QUIT
 . ;
 . S ^XTMP("YTS-ANSREV",YSINS,YSANS)=YSOLDCH_U_YSNEWCH
 . S YSREC(4)=YSNEWCH
 . D FMUPD^YTXCHGU(601.85,.YSREC,YSANS)
 Q
 ;
