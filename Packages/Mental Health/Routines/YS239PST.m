YS239PST ;BAL/KTL - Patch 239 Post-init ;Dec 07, 2023@11:26:22
 ;;5.01;MENTAL HEALTH;**239**;Dec 30, 1994;Build 16
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 Q
EDTDATE ; date used to update 601.71:18
 ;;3231119.2159
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 N OLD,NEW
 D INSTALLQ^YTXCHG("XCHGLST","YS239PST")
 D SETCAT("ASRS-6","Screening")
 D SETCAT("ASRS-6","Cognitive/Learning")
 D SETCAT("WURS-25","Screening")
 D SETCAT("WURS-25","Cognitive/Learning")
 D SETCAT("ASRS","Screening")
 D SETCAT("ASRS","Cognitive/Learning")
 D SETCAT("LEC","Anxiety/PTSD")
 D SETCAT("PCL-5 DAILY","Anxiety/PTSD")
 D SETCAT("PCL-5 DAILY","Frequent MBCs")
 D SETCAT("CDSS","Depression/Mood")
 D SETCAT("CDSS","Screening")
 D SETCAT("CDSS","Psychosis")
 D UPDURL
 Q
 ;
RENAME(OLD,NEW) ; Rename Instrument
 S IEN=$O(^YTT(601.71,"B",OLD,0)) Q:'IEN  ; old name not found
 S REC(.01)=NEW
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
UPDTST(NAME) ; Update Date Edited
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
INACT(OLD,NEW) ; INACTIVATE test left in Development - Change test name *AND* set OPERATIONAL to NO
 N REC,IEN
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN QUIT  ; already updated
 S REC(.01)=NEW
 S REC(10)="N"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 K REC,IEN
 S IEN=$O(^YTT(601,"B",OLD,0))
 I 'IEN QUIT
 S REC(.01)=NEW
 S REC(32)="N"
 D FMUPD^YTXCHGU(601,.REC,IEN)
 Q
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
NEWCAT(CATNM) ; add new category
 I $D(^YTT(601.97,"B",CATNM)) QUIT  ; already there
 N REC
 S REC(.01)=CATNM
 D FMADD^YTXCHGU(601.97,.REC)
 Q
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
DELCAT(TEST,CATNM) ; remove category from test if it is there
 N CAT,DIK,DA
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 S CAT=$O(^YTT(601.97,"B",CATNM,0)) QUIT:'CAT
 S DA=$O(^YTT(601.71,TEST,10,"B",CAT,0)) Q:'DA
 S DA(1)=TEST
 S DIK="^YTT(601.71,"_TEST_",10,"
 D ^DIK
 Q
 ;
CHGCAT(OLD,NEW) ; change category name
 N IEN,REC
 S IEN=$O(^YTT(601.97,"B",OLD,0)) Q:'IEN
 S REC(.01)=NEW
 D FMUPD^YTXCHGU(601.97,.REC,IEN)
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS239PST")
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
UPDURL ; Update GUI TOOLS URL for MHA Web
 ;Z
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS239-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS239-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/p239/?",SPEC("/home/?")="/home/p239/?"  ;In case URL entered home/? Patch 239
 S SPEC("/home/a/?")="/home/p239/?"  ;Patch 239
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
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*239 ASRS^12/14/2023@08:39:55
 ;;YS*5.01*239 ASRS-6^11/17/2023@12:25:55
 ;;YS*5.01*239 CDSS^12/13/2023@14:24:26
 ;;YS*5.01*239 LEC^12/07/2023@11:18:53
 ;;YS*5.01*239 PCL-5 DAILY^12/13/2023@14:25:06
 ;;YS*5.01*239 WURS-25^11/17/2023@12:25:18
 ;;YS*5.01*239 WHYMPI^12/20/2023@13:03:50
 ;;YS*5.01*239 NEW BAM UPDATE^12/28/2023@10:26:47
 ;;zzzzz
 ;
 Q
 ;;YS*5.01*234 ESS^06/29/2023@12:29:33
