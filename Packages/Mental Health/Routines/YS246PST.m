YS246PST ;ISP/LMT - Patch 246 Post-Install ;Dec 02, 2025@12:54:58
 ;;5.01;MENTAL HEALTH;**246**;Dec 30, 1994;Build 38
 ;
 ;
 ; Reference to TIUFLF7 in ICR #5352
 ; Reference to ^XWB(8994.5, in ICR #5032
 ; Reference to ^DIC(19, in ICR #10075
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3260810.13
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 ;
 D INSTALLQ^YTXCHG("XCHGLST","YS246PST")
 ;
 D DDNOTE("CCICM20")  ;Add note titles to that were never set up
 D DDNOTE("DDS2")  ;Add note titles to that were never set up
 D DDNOTE("NEWS")  ;Add note titles to that were never set up
 D DDNOTE("PASS-1")  ;Add note titles to that were never set up
 D DDNOTE("PASS-2")  ;Add note titles to that were never set up
 D UPDOP("C-SSRS_V2")
 D DEACTTST("C-SSRS")
 D DEACTTST("EAT-26")
 D DEACTTST("AAQ-2")
 D QUERSTRT  ;Task job to update restart days to 7 for all instruments except 0-day restart
 ;
 D UPDURL  ; Update GUI TOOLS URL for MHA Web
 Q
 ;
UPDOP(NAME) ; Update OPERATIONAL to CLINICAL REMINDER
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0))
 I +IEN'=0 D
 . S REC(10)="C"
 . S REC(18)=$P($T(EDTDATE+1),";;",2)
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
DEACTTST(NAME) ; Change OPERATIONAL to DROPPED
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
DDNOTE(NAME) ; Add default note for this instrument
 N IEN,NOTE,CSLT,REC,ALTNOTE,ALTCSLT
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 I $P($G(^YTT(601.71,IEN,2)),U,2)'?1(1"Y",1"C") QUIT  ; must be operational/clinical reminder
 ;Q:$P($G(^YTT(601.71,IEN,8)),U,9)>0          ; note title already there
 S NOTE=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH DIAGNOSTIC STUDY NOTE","TL")
 S CSLT=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH CONSULT NOTE","TL")
 S ALTNOTE=+$$DDEFIEN^TIUFLF7("MH DIAGNOSTIC STUDY NOTE","TL")
 S ALTCSLT=+$$DDEFIEN^TIUFLF7("MH CONSULT NOTE","TL")
 S:CSLT=0&(ALTCSLT'=0) CSLT=ALTCSLT
 S:NOTE=0&(ALTNOTE'=0) NOTE=ALTNOTE
 I 'NOTE,'CSLT QUIT   ; neither title found
 I NOTE'=0 S REC(29)=NOTE
 I CSLT'=0 S REC(30)=CSLT
 S REC(28)="Y"
 D FMSAVE^YTXCHGI(1,601.71,.REC,IEN)                 ; FMSAVE in case dry run
 D LOG^YTXCHGU("info","Linked note title.")
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS246PST")
 Q
 ;
QUERSTRT ;Task job to update restart days to 7 for all instruments except 0-day restart
 N YSZOTH,YSTASK
 D BMES^XPDUTL("   Tasking job to update restart days...")
 S YSZOTH("ZTDTH")=$H
 S YSTASK=$$NODEV^XUTMDEVQ("UPDRSTRT^YS246PST","YS*5.01*246 Post Install - Update Restart Days",,.YSZOTH,0)
 I YSTASK>0 D MES^XPDUTL("   Task #"_YSTASK)
 I YSTASK<0 D MES^XPDUTL("   Failed to task job.")
 Q
 ;
UPDRSTRT ; Update MH TESTS AND SURVEYS restart days to 7
 N IEN,RSTRT,REC
 N NWRSTRT
 S NWRSTRT=7
 S IEN=0 F  S IEN=$O(^YTT(601.71,IEN)) Q:+IEN=0  D
 . S RSTRT=$P($G(^YTT(601.71,IEN,8)),U,7)
 . Q:RSTRT=0
 . I $P(^YTT(601.71,IEN,0),U)="BPS" S NWRSTRT=90  ;Special if BPS installed.
 . S $P(^YTT(601.71,IEN,8),U,7)=NWRSTRT
 . K REC
 . S REC(18)=$P($T(EDTDATE+1),";;",2)
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 ;Update JSON
 N LC,STR,RST1,NUM,DUN
 N ERRS,CRCCALC,REC
 S IEN=0 F  S IEN=$O(^YTT(601.712,IEN)) Q:+IEN=0  D
 . S DUN=0 K ERRS
 . S LC=0 F  S LC=$O(^YTT(601.712,IEN,1,LC)) Q:+LC=0!DUN  D
 .. S STR=$G(^YTT(601.712,IEN,1,LC,0)) Q:STR=""
 .. Q:STR'["restartDays"
 .. S RST1=$P(STR,": "),NUM=$P($P(STR,": ",2),",")
 .. I NUM=0 S DUN=1 Q
 .. S RST1=RST1_": "_7_", "
 .. S ^YTT(601.712,IEN,1,LC,0)=RST1
 .. D CHKSPEC^YTWJSONE($NA(^YTT(601.712,IEN,1)),.ERRS,.CRCCALC)
 .. I $G(ERRS) S DUN=1 Q
 .. K REC
 .. S REC(.02)=$$NOW^XLFDT
 .. S REC(.03)=CRCCALC
 .. D FMUPD^YTXCHGU(601.712,.REC,IEN)
 .. S DUN=1
 S ZTREQ="@"
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS246-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS246-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/patch246/?",SPEC("/home/?")="/home/patch246/?"  ;In case URL entered home/? Patch 269
 S SPEC("/home/patch269/?")="/home/patch246/?"  ;Patch 246
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
 ;;YS*5.01*246 AUDC^08/10/2026@11:15:28
 ;;YS*5.01*246 CCICM20^04/28/2025@16:14:17
 ;;YS*5.01*246 DDS2^04/28/2025@16:14:31
 ;;YS*5.01*246 MAHC-10^04/02/2026@13:25:43
 ;;YS*5.01*246 NEWS^04/28/2025@16:13:19
 ;;YS*5.01*246 PASS-1^04/28/2025@16:13:46
 ;;YS*5.01*246 PASS-2^04/28/2025@16:14:02
 ;;YS*5.01*246 C-SSRS_V2^08/04/2026@13:36:10
 ;;YS*5.01*246 MOCA_8.1^08/04/2026@13:36:39
 ;;YS*5.01*246 MOCA_8.2^08/04/2026@13:37:08
 ;;YS*5.01*246 MOCA_8.3^08/04/2026@13:37:36
 ;;zzzzz
 ;
 Q
 ;
