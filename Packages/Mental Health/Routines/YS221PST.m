YS221PST ;BAL/KTL - Patch 221 Post-init  ; February, 27 2023@16:21
 ;;5.01;MENTAL HEALTH;**221**;Dec 30, 1994;Build 11
 ;
EDTDATE ; date used to update 601.71:18
 ;;3230504.1315
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS221PST")
 D RMRSTCT("MHLA")
 D RMRSTCT("MHLB")
 D RMRSTCT("MHLC-C")
 D UPDURL
 Q
 ;
RMRSTCT(NAME) ; Remove restriction on progress note generation
 D RMVRP(NAME)
 D ADDNT(NAME)
 D UPDTST(NAME)
 Q
RMVRP(NAME) ; Remove R PRIV and GENERATE PNOTE=Y
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(9)="@"
 S REC(28)="Y"
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
ADDNT(NAME) ; Add TIU NOTE TITLE
 D ADDNOTE^YTXCHGI(NAME)
 Q
UPDTST(NAME) ; Update Date Edited
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS221-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS221-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/a/?",SPEC("/home/?")="/home/a/?"  ;In case URL entered home/? Patch 208 to 221
 S SPEC("/home/b/?")="/home/a/?"  ;Patch 208 to 221
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
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*221 BSS^05/04/2023@12:16:04
 ;;zzzzz
 Q
