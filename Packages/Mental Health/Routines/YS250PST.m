YS250PST ;BAL/KTL - Patch 250 Post-init ;June 25, 2024@13:55:37
 ;;5.01;MENTAL HEALTH;**250**;Dec 30, 1994;Build 26
 ;
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 ; Reference to TIUFLF7 in ICR #5352
 Q
 ;
EDTDATE ; date used to update 601.71:18
 ;;3241009.2159
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS250PST")
 D SETCAT("AAQ-II-7","EBP")
 D SETCAT("ALSFRS-R","ADL/Func Status")
 D SETCAT("ALSFRS-R","Pain/Health")
 D SETCAT("ALSSQOL-SF","Quality of Life")
 D SETCAT("ALSSQOL-SF","Pain/Health")
 D REACTTST("BBHI-2")
 D UPDURL
 D FIXINST
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
REACTTST(NAME) ; Change OPERATIONAL to YES
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0))
 I +IEN'=0 D
 . S REC(10)="Y"
 . S REC(18)=$P($T(EDTDATE+1),";;",2)
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 K REC,IEN
 S IEN=$O(^YTT(601,"B",NAME,0))
 I 'IEN QUIT
 S REC(32)="N"
 D FMUPD^YTXCHGU(601,.REC,IEN)
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 ;Z
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS250-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS250-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/p250/?",SPEC("/home/?")="/home/p250/?"  ;In case URL entered home/? Patch 250
 S SPEC("/home/p249/?")="/home/p250/?"  ;Patch 250
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
FIXINST ; Fix instrument note titles for sites that do not have
 ; MENTAL HEALTH DIAGNOSTIC STUDY NOTE and MENTAL HEALTH CONSULT NOTE
 N YSIEN,NOTE,CSLT,YSOPER,ARRAY,ALTNOTE,ALTCSLT,REC,YSPRIV
 S NOTE=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH DIAGNOSTIC STUDY NOTE","TL")
 S CSLT=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH CONSULT NOTE","TL")
 I NOTE'=0!(CSLT'=0) QUIT  ;Only fix if both note titles are not available
 S ALTNOTE=+$$DDEFIEN^TIUFLF7("MH DIAGNOSTIC STUDY NOTE","TL")
 S ALTCSLT=+$$DDEFIEN^TIUFLF7("MH CONSULT NOTE","TL")
 I 'ALTNOTE!'ALTCSLT QUIT  ;Both must be defined
 S YSIEN=0 F  S YSIEN=$O(^YTT(601.71,YSIEN)) Q:+YSIEN=0  D
 . S YSOPER=$$GET1^DIQ(601.71,YSIEN_",",10,"I")
 . Q:(YSOPER'="Y")
 . S YSPRIV=$$GET1^DIQ(601.71,YSIEN_",",9,"I")
 . Q:YSPRIV'=""
 . K ARRAY
 . D GETS^DIQ(601.71,YSIEN_",","29;30","I","ARRAY")
 . K REC
 . I ARRAY(601.71,YSIEN_",",29,"I")'>0 S REC(29)=ALTNOTE
 . I ARRAY(601.71,YSIEN_",",30,"I")'>0 S REC(30)=ALTCSLT
 . I $D(REC) S REC(28)="Y"
 . Q:'$D(REC)
 . D FMSAVE^YTXCHGI(1,601.71,.REC,YSIEN)                 ; FMSAVE in case dry run
 Q
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS250PST")
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
 ;;YS*5.01*250 AAQ-II-7^07/22/2024@15:38:34
 ;;YS*5.01*250 ALSFRS-R^07/22/2024@15:39:05
 ;;YS*5.01*250 ALSSQOL-SF^07/24/2024@17:53:40
 ;;YS*5.01*250 AUDC^07/19/2024@11:27:45
 ;;YS*5.01*250 BOMC^07/19/2024@11:29:29
 ;;YS*5.01*250 BSS^07/19/2024@11:28:09
 ;;YS*5.01.250 PSS-3 2ND^07/19/2024@11:28:48
 ;;YS*5.01*250 YMRS^07/26/2024@10:12:27
 ;;zzzzz
 ;
 Q
 ;;YS*5.01*250 WHYMPI^07/19/2024@11:30
