YS234PST ;BAL/KTL - Patch 234 Post-init ; 06/05/2023
 ;;5.01;MENTAL HEALTH;**234**;Dec 30, 1994;Build 38
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 ; Reference to TIUFLF7 in ICR #5352
 Q
EDTDATE ; date used to update 601.71:18
 ;;3231127.2159
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 N OLD,NEW
 S OLD="MDQ",NEW="ZZMDQ-OLD" D INACT(OLD,NEW)
 D RENAME("VFQ20","LVVFQ")
 D CHGCAT("Depression","Depression/Mood")
 D CHGCAT("Pain / Health","Pain/Health")
 D INSTALLQ^YTXCHG("XCHGLST","YS234PST")
 D SETCAT("EAT-26","Eating/Nutrition")
 ;D SETCAT("ESS","Sleep")
 D SETCAT("MDQ","Depression/Mood")
 D SETCAT("PEG","Pain/Health")
 D SETCAT("BAM-C-CBT-SUD","Addiction-SUD")
 D SETCAT("BAM-R-CSG-SUD","Addiction-SUD")
 D SETCAT("BAM-IOP-CSG-SUD","Addiction-SUD")
 D SETCAT("CMAI","General Symptoms")
 D SETCAT("CMAI","Cognitive/Learning")
 D SETCAT("LVVFQ","General Symptoms")
 D SETCAT("LVVFQ","Screening")
 D SETCAT("PSEQ-2","Pain/Health")
 D SETCAT("NPI-Q","General Symptoms")
 ;D DROPTST("MMPI2")
 D ADDNOTE("LVVFQ")  ;Add TIU TITLE and CONSULT NOTE TITLE
 D SETNAT("LVVFQ","Y")
 D DROPTST("MCMI3")
 D DROPTST("ASSIST-NIDA")
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
SETNAT(NAME,NAT) ; SET NATIONAL FLAG
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S NAT=$G(NAT) Q:"YN"'[NAT
 S REC(19)=NAT
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
ADDNOTE(NAME) ; Add default note for this instrument
 N IEN,NOTE,CSLT,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 Q:$P($G(^YTT(601.71,IEN,2)),U,2)'="Y"       ; must be operational
 ;Q:$P($G(^YTT(601.71,IEN,8)),U,9)>0          ; note title already there
 S NOTE=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH DIAGNOSTIC STUDY NOTE","TL")
 S CSLT=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH CONSULT NOTE","TL")
 S:CSLT=0 CSLT=+$$DDEFIEN^TIUFLF7("MH CONSULT NOTE","TL")
 S:NOTE=0 NOTE="@"
 S:CSLT=0 CSLT="@"
 ;I 'NOTE,'CSLT QUIT                          ; neither title found
 S REC(28)="Y"
 S REC(29)=NOTE
 S REC(30)=CSLT
 D FMSAVE^YTXCHGI(1,601.71,.REC,IEN)                 ; FMSAVE in case dry run
 D LOG^YTXCHGU("info","Linked note title.")
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS234PST")
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
 S ^XTMP("YS234-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS234-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/c/?",SPEC("/home/?")="/home/c/?"  ;In case URL entered home/? Patch 234
 S SPEC("/home/a/?")="/home/c/?"  ;Patch 234
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
 ;;YS*5.01*234 MDQ^06/29/2023@12:28:56
 ;;YS*5.01*234 BAM-C-CBT-SUD^07/11/2023@12:14:57
 ;;YS*5.01*234 BAM-R-CSG-SUD^07/12/2023@00:03:16
 ;;YS*5.01*234 BAM-IOP-CSG-SUD^07/27/2023@16:57:29
 ;;YS*5.01*234 CMAI^08/02/2023@12:53:58
 ;;YS*5.01*234 PEG^08/02/2023@14:27:01
 ;;YS*5.01*234 LVVFQ^08/07/2023@23:37:21
 ;;YS*5.01*234 MINICOG^08/15/2023@12:06:32
 ;;YS*5.01*234 PSEQ-2^08/24/2023@15:36:43
 ;;YS*5.01*234 NPI-Q^08/26/2023@01:03:01
 ;;YS*5.01*234 EAT-26^08/29/2023@23:17:52
 ;;YS*5.01*234 AUDC^08/30/2023@00:12:52
 ;;YS*5.01*234 PC-PTSD-5^09/12/2023@13:03:46
 ;;YS*5.01*234 WBS_V2^10/18/2023@12:02:43
 ;;YS*5.01*234 D.ERS^10/27/2023@14:43:17
 ;;zzzzz
 ;
 Q
 ;;YS*5.01*234 ESS^06/29/2023@12:29:33
