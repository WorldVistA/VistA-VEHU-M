ISIJNOTE ; ISI/JHC - ISIRAD Notes functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**104,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to GETEXAM2^MAGJUTL1 in ICR #7404
 ; Reference to MAGJOBNC^MAGJUTL3 in ICR #7406
 Q
 ;;
ERR ;
 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ;   rpc ISIJ NOTE -- functions to create/retrieve Notes
 ;
NOTE(MAGGRY,PARAMS,DATA) ;
 ;  * this ep also called directly as subroutine by magjrpt for req/rpt display
 ; PARAMS: TXID ^ RADFN ^ RADTI ^ RACNI ^ RARPT ^ FLAG
 ;  TXID: Req'd--action to take
 ;  FLAG: Optional--use to flag RAD-Dept-only note
 ;  DATA--(required for create note) input array containing Notes text
 ;  Pattern for DATA input & reply is:
 ;   *NOTES        Start for NOTES
 ;    (1:N lines of text follow)
 ;   *NOTES_END    end for note
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJNOTE"
 N COMMA,DASH,EXAMID,FILEREF,NOTEMULT,RACNI,RADFN,RADTI,NOTEFILE  ; vars global to all program subroutines
 N FLAG,MAGLST,REPLY,RET,TXID,EXAMIEN,USERIEN,TIMESTMP
 I '$D(MAGJOB("USER")) D MAGJOBNC^MAGJUTL3 ; support non-isirad client calls
 S REPLY=""
 S NOTEFILE=23453,NOTEMULT=23453.01,FILEREF=$NA(^ISI(NOTEFILE))
 S COMMA=",",DASH="-"
 S TXID=+PARAMS,RADFN=+$P(PARAMS,U,2),RADTI=$P(PARAMS,U,3),RACNI=+$P(PARAMS,U,4),FLAG=$P(PARAMS,U,6)
 S MAGLST="ISIJRPC" S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N DIQUIET S DIQUIET=1 D DT^DICRW,NOW^%DTC S TIMESTMP=$E(%,1,12)
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; ICR 65
 E  S REPLY="0^4~Invalid Request; no Exam found for input data ("_PARAMS_")" G NOTEZ
 S EXAMID=$$EXAMID(RADFN,RADTI,RACNI)
 S EXAMIEN=$$EXAMIEN(EXAMID)
 I TXID=1 D  ;  get notes for display
 . I +EXAMIEN S REPLY="0~View Notes."
 . D NOTEGET(.REPLY,"@MAGGRY",EXAMIEN,0,RADFN,RADTI,RACNI)
 . S REPLY=@MAGGRY@(0)_U_REPLY
 E  I TXID=2 D    ; update new or existing entry; called from Notes form
 . D NOTEUPD(.RET,.EXAMIEN,.DATA,RADFN,RADTI,RACNI)
 . S REPLY=0_U_RET
 E  I TXID=3  D STATUS(.REPLY,RADFN,RADTI,RACNI)
 E  S REPLY="0^4~Invalid 'Notes' Transaction ID ("_$P(PARAMS,U)_")"
NOTEZ ;
 S @MAGGRY@(0)=REPLY
 Q
 ;
STATUS(REPLY,RADFN,RADTI,RACNI) ; Return status information for inserting at top of Requisition
 ; EP called by MAGJRPT
 N COMMA,DASH,EXAMID,EXAMIEN,RET,NOTEFILE,NOTEMULT,FILEREF
 S REPLY="0^0~NOTES: n/a",EXAMIEN=""
 S NOTEFILE=23453,NOTEMULT=23453.01,FILEREF=$NA(^ISI(NOTEFILE))
 S COMMA=",",DASH="-"
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) D  ; ICR 65
 . S EXAMID=$$EXAMID(RADFN,RADTI,RACNI)
 . S EXAMIEN=$$EXAMIEN(EXAMID)
 I EXAMIEN D NOTEGET(.REPLY,.RET,EXAMIEN,1,RADFN,RADTI,RACNI)
 Q
 ;
EXAMID(RADFN,RADTI,RACNI) ; calculate examid; printsets share a single examid
 N DASH,PSET,RAPRTSET S DASH="-"
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) D  ; ICR 65
 . D EN2^RAUTL20(.PSET) ; get info re rad PrintSet
 . I RAPRTSET S RACNI=$O(PSET(""))
 Q (RADFN_DASH_RADTI_DASH_RACNI) ; for printsets, only racni varies for the members
 ;
EXAMIEN(EXAMID) ; Return ExamIEN for input examid
 N EXAMIEN,ZJ
 S EXAMIEN="" I EXAMID]"" D
 . D FIND^DIC(NOTEFILE,,"@","OQ",EXAMID,,,,,"ZJ")
 . S EXAMIEN=$S(+ZJ("DILIST",0):ZJ("DILIST",2,1),1:"")
 Q:$Q EXAMIEN Q
 ;
NOTEUPD(RET,EXAMIEN,DATA,RADFN,RADTI,RACNI) ; Update Note
 N NEWEXAM,NOTIEN,NOTETXT,ZJ,REPLYTXT
 S RET="",NEWEXAM=0,NOTETXT=0
 D CHKTXT(.NOTETXT,.DATA)
 I 'NOTETXT S RET="4~Missing Notes text data ("_PARAMS_")" Q
 I 'EXAMIEN D  Q:'EXAMIEN
 . S EXAMIEN=$$NEWEXAM(EXAMID,RADFN,RADTI,RACNI)  ; add this exam to Note file
 . I EXAMIEN S NEWEXAM=1
 . E  S RET="4~Problem with adding Notes entry for this exam *1 ("_PARAMS_")"
 S NOTIEN=$$NEWNOTE(EXAMIEN,TIMESTMP,DUZ,FLAG) ; initialize Notes data
 I 'NOTIEN S RET="4~Problem with adding Notes entry for this exam *2 ("_PARAMS_")" Q
 D ADDNOTES(.ZJ,"ZJ",EXAMIEN,NOTIEN,.NOTETXT) ; load input data into zj array
 I $D(ZJ) D  ; update Notes if any
 . D FILE^DIE("","ZJ","RSL")
 . S X=$G(RSL("DIERR",1))
 . I X]""  S RET="4~Problem with adding Notes entry for this exam *3 ("_PARAMS_")"
 I RET]"" Q
 S REPLYTXT=$S(NEWEXAM:"Note created for exam.",1:"Note added to exam.")
 S RET="0~"_REPLYTXT
 Q
 ;
CHKTXT(NOTETXT,DATA) ;  check for any notes in input data
 ;   NOTETXT: return extracted text, if any
 N IP,NOTE
 S IP="" F  S IP=$O(DATA(IP)) Q:IP=""  S X=DATA(IP) D
 . I X="*NOTES" S NOTE=1 Q
 . I NOTE D
 . . I X="*NOTES_END" S NOTE=0 Q
 . . S X=$$STRIP(X) Q:X=""  ; remove blank lines
 . . S NOTETXT=NOTETXT+1,NOTETXT(NOTETXT)=X
 Q
 ;
ADDNOTES(RET,RETNAM,EXAMIEN,NOTIEN,NOTETXT) ; format notes text data for fileman DBS calls
 ; re RETNAM: the fileman update call for a WP field needs the
 ;            name of the input array at the node defined below
 N IP,IENS
 S IENS=NOTIEN_COMMA_EXAMIEN_COMMA
 F IP=1:1:NOTETXT S X=NOTETXT(IP) D
 . I IP=1 S RET(NOTEMULT,IENS,4)=RETNAM_"("_NOTEMULT_","""_IENS_""""_",4)"  ; WP call needs this node
 . S RET(NOTEMULT,IENS,4,IP)=X
 Q
 ;
NEWEXAM(EXAMID,RADFN,RADTI,RACNI) ; Create new Exam entry in Notes file; only called if not yet defined
 N DAYCASE,DC1,PSET,RADATA,RAPRTSET,ZJ,ZJMSG,RSL
 S ZJ(NOTEFILE,"+1,",.01)=EXAMID
 D UPDATE^DIE("","ZJ","RSL")
 I +RSL(1) D ACNINDX(+RSL(1),RADFN,RADTI,RACNI)
 Q:$Q RSL(1) Q
 ;
ACNINDX(EXAMIEN,RADFN,RADTI,RACNI,KILL) ; update C index by accession number
 ; --> if a printset, index for all pset members
 ; * * This also callable by fileman Index creation * *
 ; KILL--only set by fileman indexer code if deleting entry
 I '(EXAMIEN&RADFN&RADTI&RACNI) Q
 N DAYCASE,DC1,I,NOTEFILE,FILEREF,PSET,RAPRTSET
 S NOTEFILE=23453,FILEREF=$NA(^ISI(NOTEFILE))
 S DAYCASE=$$DAYCASE(RADFN,RADTI,RACNI)
 Q:'DAYCASE
 I +$G(KILL) K @FILEREF@("C",DAYCASE,EXAMIEN)
 E  S @FILEREF@("C",DAYCASE,EXAMIEN)=""
 D EN2^RAUTL20(.PSET) ; get info re rad PrintSet
 I RAPRTSET S I="",DC1=$P(DAYCASE,"-") D
 . F  S I=$O(PSET(I)) Q:'I  S DAYCASE=DC1_"-"_$P(PSET(I),U) D
 . . I +$G(KILL) K @FILEREF@("C",DAYCASE,EXAMIEN)
 . . E  S @FILEREF@("C",DAYCASE,EXAMIEN)=""
 Q
 ;
DAYCASE(RADFN,RADTI,RACNI) ; return daycase
 N RADTE,RACN,DAYCASE
 S DAYCASE="",RADTE=9999999.9999-RADTI
 S RACN=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U)
 I RACN S DAYCASE=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 Q:$Q DAYCASE Q
 ;
NEWNOTE(EXAMIEN,TIMESTMP,DUZ,FLAG) ; Create new Note entry in file; only called if not yet defined
 N ZJ,ZJMSG,RSL
 S ZJ(NOTEMULT,"+1,"_EXAMIEN_",",.01)=TIMESTMP
 S ZJ(NOTEMULT,"+1,"_EXAMIEN_",",2)=DUZ
 S ZJ(NOTEMULT,"+1,"_EXAMIEN_",",3)=FLAG
 D UPDATE^DIE("","ZJ","RSL")
 Q:$Q RSL(1) Q
 ;
NOTEGET(REPLY,RET,EXAMIEN,STATUS,RADFN,RADTI,RACNI) ; return Notes details
 ; STATUS-optional; if true, return status only, no details
 ; package mult notes into one array, formatted per each note...
 ; filter for flagged RAD-Only notes--only rad personnel may view
 N DAYCASE,FLAG,IENS,IRET,ISS
 N NOGO,NOTECT,NOTIEN,NOTWHO,NOTTIME,PROC,RADATA,WHO,ZJ
 K ^TMP($J,"MAGRAEX")
 S STATUS=$G(STATUS,0),NOTECT=0
 S RADATA=$$RADATA(RADFN,RADTI,RACNI)
 S DAYCASE=$P(RADATA,U,12),PROC=$P(RADATA,U,9)
 S IRET=0
 S:'STATUS IRET=IRET+1,@RET@(IRET)="NOTES: "_DAYCASE_"  "_PROC
 ;
 I EXAMIEN D
 . S:'STATUS IRET=IRET+1,@RET@(IRET)="*NOTES"
 . S NOTIEN=0
 . F  S NOTIEN=$O(@FILEREF@(EXAMIEN,1,NOTIEN)) Q:'NOTIEN  D
 . . S IENS=NOTIEN_COMMA_EXAMIEN_COMMA
 . . D GETS^DIQ(NOTEMULT,IENS,"2;3","IE","ZJ")
 . . S FLAG=$G(ZJ(NOTEMULT,IENS,3,"I"))
 . . I FLAG=1 S NOGO=1 D  Q:NOGO  ; indicate or show flagged note only if Rad dept user
 . . . I +$G(MAGJOB("USER",1))!$D(^VA(200,"ARC","T",+DUZ)) S NOGO=0 Q  ; OK if rist or tech
 . . I STATUS S NOTECT=NOTECT+1 Q  ; no details needed
 . . D GETS^DIQ(NOTEMULT,IENS,".01;4","","ZJ")
 . . S NOTWHO=$G(ZJ(NOTEMULT,IENS,2,"E"))
 . . S NOTTIME=$G(ZJ(NOTEMULT,IENS,.01))
 . . S IRET=IRET+1,@RET@(IRET)="     "_NOTTIME_"     "_NOTWHO
 . . I FLAG S IRET=IRET+1,@RET@(IRET)="        << Radiology internal note >>"  ; flagged notes clearly indicated to user
 . . I $D(ZJ(NOTEMULT,IENS,4))>9 D
 . . . S ISS=0
 . . . F  S ISS=$O(ZJ(NOTEMULT,IENS,4,ISS)) Q:'ISS  S IRET=IRET+1,@RET@(IRET)=ZJ(NOTEMULT,IENS,4,ISS)
 . . S IRET=IRET+1,@RET@(IRET)="  "
 . I STATUS S REPLY="0^"_NOTECT_"~NOTES: "_$S('NOTECT:"n/a",1:NOTECT_" note"_$S(NOTECT-1:"s",1:"")_" on file.") ;special format for Status only
 . E  S %H=$H D YX^%DTC S IRET=IRET+1,@RET@(IRET)="** END NOTES "_Y_" **"
 . S:'STATUS IRET=IRET+1,@RET@(IRET)="*NOTES_END"
 E  S REPLY="2~ [ Notes not entered for this exam. ]",@RET@(0)=1 ;  Q  ;
 I IRET=4 D
 . F I=2,3,4 K @RET@(I)
 . S @RET@(0)=1,REPLY="2~ [Notes not available for this exam. ]" ; everything filtered out
 E  S:'STATUS @RET@(0)=IRET
 Q
 ;
RADATA(RADFN,RADTI,RACNI) ; get rad data
 N RADATA
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.X)
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1))
 K ^TMP($J,"MAGRAEX")
 Q:$Q RADATA Q
 ; 
STRIP(X) ; remove up-carets & leading/trailing spaces
 N I,T
 S X=$TR(X,U," ")
 F I=$L(X):-1:0 I $E(X,I)'=" " Q
 S X=$E(X,1,I)
 F I=1:1:$L(X) I $E(X,I)'=" " Q
 S X=$E(X,I,999)
 Q:$Q X Q
 ;
END Q
 ;
