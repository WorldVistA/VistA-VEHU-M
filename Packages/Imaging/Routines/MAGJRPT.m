MAGJRPT ;WIRMFO/JHC - Display Rad reports ; 10/17/2022
 ;;3.0;IMAGING;**18,101,120,133,341**;Dec 21, 2022;Build 28
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; Reference to EN2^RAUTL20 in ICR #3270
 ; Reference to EN3^RAO7PC3 #2877
 ; Reference to ^RAORD5 #3513
 ; Reference to SVTCOM^RAUTL11 in ICR #3508
 ; Reference to PHARM^RARTUTL in ICR #5946
 ; Reference to RDIO^RARTUTL in ICR #5946
 ;; ISI IMAGING;**99,104,102**
 ; Subroutines for fetching Exam Info for VistaRad Workstation
 ;   RADRPT: Display Radiology Report -- RPC Call: MAGJ EXAM REPORT
 ;        ORD: Display Radiology Requisition -- RPC Call: MAGJ RADORDERDISP
 ;
 Q
ORD(MAGRPTY,DATA) ; Radiology Order Display
 ; RPC Call: MAGJ RADORDERDISP
 ; MAGRPTY holds indirect reference to returned data
 ; 
 S MAGRPTY=$NA(^TMP($J,"WSDAT")) K @MAGRPTY
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJRPT"
 N RARPT,RADFN,RADTI,RACNI,RAPGE,RAX,RAOIFN
 N REPLY,POP,DFN,COMPLIC,XX,HDR,MAGRET,REQONLY,TMPDATA
 N MEDS,RDIOPHARM
 S REPLY="0^4~Attempting to display order info"
 D OPENDEV
 I POP S REPLY="0^4~Unable to open device 'IMAGING WORKSTATION'" G ORDZ
 S RADFN=$P(DATA,U),RADTI=$P(DATA,U,2),RACNI=$P(DATA,U,3)
 S RARPT=+$P(DATA,U,4),REQONLY=+$P(DATA,U,5)
 I RADFN,RADTI,RACNI
 E  S REPLY="0^4~Request Contains Invalid Case Pointer ("_RADFN_" "_RADTI_" "_RACNI_" "_RARPT_")." G ORDZ
 S RAOIFN=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,11)
 I RAOIFN,$D(^RAO(75.1,RAOIFN,0))
 E  S REPLY="0^2~Order Information is NOT Available for this exam." G ORDZ
 ; Check for Database integrity problems ONLY if Req was explicitly
 ; requested (No check for Auto_Display of Req, cuz Exam Open does ck)
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.MAGRET)
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1)),XX=$G(^(2)),HDR=""
 S COMPLIC=$P(XX,U,4)      ;  Complications text
 S MEDS=$P(XX,U,14),RDIOPHARM=$P(XX,U,15)      ;  Medications & RadioPharm indicators
 F I=4,12,9 S HDR=HDR_$P(RADATA,U,I)_"   " ; PtName, Case #, Procedure
 S T=$P(XX,U,8) I T]"" S HDR=HDR_" ("_T_")"  ;  ISI  Modifier
 I REQONLY D CKINTEG(.REPLY,RADFN,RADTI,RACNI,RARPT,RADATA) I REPLY]"" S REPLY="0^7~"_REPLY G ORDZ  ; Database integrity problems
 S TMPDATA=MAGRPTY_"~"_RADTI_"~"_RACNI
 S RAX="",RAPGE=0 D ^RAORD5
 S MAGRPTY=$P(TMPDATA,"~"),RADTI=$P(TMPDATA,"~",2),RACNI=$P(TMPDATA,"~",3)
 D:IO'=IO(0) ^%ZISC
 S @MAGRPTY@(1)="REQ: "_HDR
 D CLEANUP(MAGRPTY) ;  ISI
 D COMMENTS(RADFN,RADTI,RACNI,MAGRPTY,2,COMPLIC,MEDS,RDIOPHARM)
 D TIUNOTE(RARPT,MAGRPTY,10000) ; append TIU note to reply at node 10000
 S REPLY="1^OK"
 K ^TMP($J,"MAGRAEX"),^("RAE2") ;  ISI
ORDZ S @MAGRPTY@(0)=REPLY
 Q
 ;
CLEANUP(MAGRPTY) ; strip extraneous lines of dashes ;  ISI new subrtn
 N HIT,I,X S HIT=0
 S I=20 F  S I=$O(@MAGRPTY@(I)) Q:'I  S X=^(I) D
 . I $L(X,"-")>20 S HIT=HIT+1 K:(HIT>1) @MAGRPTY@(I)
 . E  S HIT=0
 Q
 ;
COMMENTS(RADFN,RADTI,RACNI,MAGRPTY,DNODE,COMPLIC,MEDS,RDIOPHARM) ; add Complications & Tech Comments to output report
 ;  Add Medications and Radiopharmaceuticals information to output
 ;  RADFN, RADTI, & RACNI identify exam
 ;  MAGRPTY is indirect reference wher output lines are to be stored
 ;  DNODE holds reference for starting node for lines of output
 ;  COMPLIC passes in complications data reference
 ;  MEDS passes in Medications indicator
 ;  RDIOPHARM passes in Radiopharmaceuticals reference
 ;
 N QTMP,CT,XX,NOTES,NOTESTAT,T S CT=0  ; ISI begin
 D STATUS^ISIJNOTE(.NOTESTAT,RADFN,RADTI,RACNI)
 S T=+$P(NOTESTAT,U,2) I T D
 . S @MAGRPTY@(DNODE)=" ",CT=CT+.01,@MAGRPTY@(DNODE+CT)="  * See "_T_" NOTE"_$S(T-1:"S",1:"")_" at end of report."
 . S @MAGRPTY@(DNODE)=" ",CT=CT+.01,@MAGRPTY@(DNODE+CT)=" "
 . D NOTE^ISIJNOTE(.NOTES,1_U_RADFN_U_RADTI_U_RACNI_U_RARPT)
 . D NOTEDISP(.NOTES,MAGRPTY,5000)
 . K @NOTES                            ; ISI end
 I +$G(MAGJOB("USER",1))  ; Radiologist  ;  ISI--for RadTech Tool use
 E  I $D(^VA(200,"ARC","T",+DUZ))  ; Rad Tech
 E  Q  ; Don't display for any other user type
 S @MAGRPTY@(DNODE)=" ",CT=CT+.01,@MAGRPTY@(DNODE+CT)="Complications: "_$S(COMPLIC:$P($G(^RA(78.1,+COMPLIC,0)),U),1:"")
 S X=$P(COMPLIC,"~",2)
 I X S CT=CT+.01,@MAGRPTY@(DNODE+CT)="   "_$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"COMP")),U)
 K ^TMP($J,"RAE2") D SVTCOM^RAUTL11(RADFN,RADTI,RACNI)
 S QTMP="^TMP($J,""RAE2"")"
 F  S QTMP=$Q(@QTMP) Q:QTMP=""  Q:QTMP'["RAE2"  I QTMP["TCOM" D
 . S XX=@(QTMP) N HI,TXT,LINE1 S LINE1=0
 . F  Q:XX=""  S HI=$L(XX) S:HI>63 HI=63 F I=HI:-1:0 S:'I XX="" I HI<63!($E(XX,I)=" ") D  Q
 . . S TXT=$S('LINE1:"Tech Comments: ",1:"               ")_$E(XX,1,I),XX=$E(XX,I+1,999),LINE1=1
 . . I XX]"" F I=1:1:999 I $E(XX,I)'=" " S XX=$E(XX,I,999) Q
 . . S CT=CT+.01,@MAGRPTY@(DNODE+CT)=TXT
 K ^TMP($J,"RAE2")
 I +$G(MEDS) D
 . N REF,RAUTOE,RAACNT
 . K ^TMP($J,"RA AUTOE")
 . S REF=RACNI_","_RADTI_","_RADFN_","
 . S RAUTOE=""    ; if defined, directs output to ^TMP
 . S RAACNT=1000  ; init counter for output to ^TMP
 . D PHARM^RARTUTL(REF)  ; get Medications data
 . D PHARMAS("Medications",1001)
 I +$G(RDIOPHARM) D
 . N RAUTOE,RAACNT
 . K ^TMP($J,"RA AUTOE")
 . S RAUTOE=""    ; if defined, directs output to ^TMP
 . S RAACNT=1000  ; init counter for output to ^TMP
 . D RDIO^RARTUTL(RDIOPHARM)  ; get Radiopharm data
 . D PHARMAS("Radiopharmaceuticals",1001)
 I +$G(MEDS)!+$G(RDIOPHARM) D
 . S CT=CT+.001,@MAGRPTY@(DNODE+CT)="  "_$TR($J(" ",66)," ","_")
 . S CT=CT+.001,@MAGRPTY@(DNODE+CT)=" "
 K ^TMP($J,"RA AUTOE")
 Q
 ;
PHARMAS(TITLE,NODE) ; output lines of pharma data
 N LINE
 I $D(^TMP($J,"RA AUTOE",NODE)) D
 . S CT=CT+.001,@MAGRPTY@(DNODE+CT)=" "
 . S CT=CT+.001,@MAGRPTY@(DNODE+CT)=" ------------ "_TITLE_" ------------"
 . S CT=CT+.001,@MAGRPTY@(DNODE+CT)=" "
 . F  S LINE=^TMP($J,"RA AUTOE",NODE) D  S NODE=$O(^TMP($J,"RA AUTOE",NODE)) Q:'NODE
 . . S CT=CT+.001,@MAGRPTY@(DNODE+CT)=LINE
 . Q
 Q
 ;
NOTEDISP(NOTES,MAGRPTY,DNODE) ; output notes ;  ISI new subrtn
 N IP,NOTE,X S NOTE=0
 S DNODE=DNODE+1,@MAGRPTY@(DNODE)="  "
 S DNODE=DNODE+1,@MAGRPTY@(DNODE)="==================================  NOTES  =================================="
 S DNODE=DNODE+1,@MAGRPTY@(DNODE)="  "
 S IP="" F  S IP=$O(@NOTES@(IP)) Q:IP=""  S X=(@NOTES@(IP)) D
 . I X="*NOTES" S NOTE=1 Q
 . I NOTE D
 . . I X="*NOTES_END" S NOTE=0 Q
 . . S DNODE=DNODE+1,@MAGRPTY@(DNODE)=X
 Q
 ;
TIUNOTE(RARPT,MAGRPTY,DNODE) ; FUT-70/IHS append Rad TIU Notes to report
 ; 1/2011--only works at IHS where TIU notes may exist for Radiology exams
 ; test for this by presence of DOCTEXT^BEHOTIU
 ;  RARPT--exam pointer
 ;  MAGRPTY--indirect reference to output file
 ;  DNODE--starting node for lines of output
 ;
 N CT,QTMP,TEXT,XX
 I RARPT,$L(MAGRPTY),DNODE,$L($T(DOCTEXT^BEHOTIU)) D
 . D DOCTEXT^BEHOTIU("TEXT",RARPT_";RARPT(")
 . I $D(TEXT) D
 . . S CT=0,QTMP="TEXT"
 . . S @MAGRPTY@(DNODE)=" "
 . . F  S QTMP=$Q(@QTMP) Q:QTMP=""  S XX=@(QTMP) S CT=CT+.01,@MAGRPTY@(DNODE+CT)=XX
 Q
 ;
OPENDEV ;
 N IOP,%ZIS
 S IOP="IMAGING WORKSTATION",%ZIS=0 D ^%ZIS
 I POP
 E  U IO
 Q
 ;
RADRPT(MAGRPTY,DATA) ; Display rad report; 1st must pass integrity checks
 ; Note: adds an additional line of output for the Report Window header
 ;  RPC is MAGJ EXAM REPORT
 ;
 ; MAGRPTY holds $NA reference to  return message; references to it use subscript indirection
 ;
 S MAGRPTY=$NA(^TMP($J,"MAGJRADRPT")) K @MAGRPTY
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJRPT"
 N RARPT,RADATA,MAGDFN,MAGDTI,MAGCNI,X,MAGRET,HDR,REPLY,MAGPRC,COMPLIC,DNODE
 N MEDS,RDIOPHARM
 S MAGDFN=$P(DATA,U),MAGDTI=$P(DATA,U,2),MAGCNI=$P(DATA,U,3),RARPT=+$P(DATA,U,4)
 I '(MAGDFN&MAGDTI&MAGCNI) D  G RPTZ
 . S REPLY="0^4~Request Contains Invalid Case Pointer ("_MAGDFN_" "_MAGDTI_" "_MAGCNI_")."
 D GETEXAM2^MAGJUTL1(MAGDFN,MAGDTI,MAGCNI,"",.MAGRET)
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1)),XX=$G(^(2)),HDR=""
 S COMPLIC=$P(XX,U,4)  ;  Complications text
 S MEDS=$P(XX,U,14),RDIOPHARM=$P(XX,U,15)      ;  Medications & RadioPharm indicators
 F I=4,12,9 S HDR=HDR_$P(RADATA,U,I)_"   "
 S T=$P(XX,U,8) I T]"" S HDR=HDR_" ("_T_")"  ;  ISI  Modifier
 D CKINTEG(.REPLY,MAGDFN,MAGDTI,MAGCNI,RARPT,RADATA)
 I REPLY]"" S REPLY="0^7~"_REPLY G RPTZ  ; DB integ problem
 D EN3^RAO7PC3(MAGDFN_"^"_MAGDTI_"^"_MAGCNI)
 I '$D(^TMP($J,"RAE3")) S REPLY="0^4~No report on file." G RPTZ
 D COMMENTS(MAGDFN,MAGDTI,MAGCNI,MAGRPTY,2,COMPLIC,MEDS,RDIOPHARM)
 S MAGPRC=$O(^TMP($J,"RAE3",MAGDFN,MAGCNI,"")),I=0,DNODE=2
 F  S I=$O(^TMP($J,"RAE3",MAGDFN,MAGCNI,MAGPRC,I)) Q:'I  D
 . S DNODE=DNODE+1
 . S @MAGRPTY@(DNODE)=$G(^TMP($J,"RAE3",MAGDFN,MAGCNI,MAGPRC,I))
 S DNODE=DNODE+1,@MAGRPTY@(DNODE)=" " ;  ISI
 S DNODE=DNODE+1,@MAGRPTY@(DNODE)="** END REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")_" **" ;  ISI
 D TIUNOTE(RARPT,MAGRPTY,10000) ; append TIU note to reply at node 10000
 S REPLY="1^1~Radiology Report"
RPTZ S @MAGRPTY@(0)=REPLY
 I +$G(@MAGRPTY@(0)) S @MAGRPTY@(1)="RPT: "_HDR ; if a report exists, add header line to output
 K ^TMP($J,"MAGRAEX"),^("RAE3")
 Q
 ;
CKINTEG(REPLY,RADFN,RADTI,RACNI,RARPT,RADATA) ; check integrity between Exam, Report, and Image Group Headers
 ; This subroutine is used by other vrad programs
 ;
 N IEN,MAGIEN,MIXEDUP,X,CKDFN,CKACN
 S MIXEDUP=0,REPLY=""
 I RARPT D  G CK2:MIXEDUP
 . S X=$G(^RARPT(RARPT,0)),CKDFN=$P(X,U,2),CKACN=$P(X,U,4)
 . I CKDFN'=RADFN S MIXEDUP=1_U_+CKDFN Q
 . I $G(RADATA)]"" D
 . . I $P(RADATA,U,8)'=CKACN D
 . . . N MAGPSET,RAPRTSET,ACN,OK S OK=0
 . . . S RAPRTSET=0 D EN2^RAUTL20(.MAGPSET) I RAPRTSET D
 . . . . N I,T  ; P133 mod for MAGPSET Data ex.--Old= 256^154^190^4  SSAN= 660-080504-256^154^190^4
 . . . . S I=0 F  S I=$O(MAGPSET(I)) Q:'I  S T=$P(MAGPSET(I),U) I $P(T,"-",$L(T,"-"))=CKACN S OK=1 Q
 . . . I 'OK S MIXEDUP=5_U_CKACN_U_$P(RADATA,U,8)
 I $D(^RARPT(+RARPT,2005)) S IEN=0 D  G CK2:MIXEDUP
 . F  S IEN=$O(^RARPT(RARPT,2005,IEN)) Q:'IEN  S MAGIEN=+$G(^(IEN,0)) D  Q:MIXEDUP
 . . S X=$P($G(^MAG(2005,MAGIEN,0)),U,7) I X'=RADFN S MIXEDUP=2_U_+X Q
 . . S X=$P($G(^MAG(2005,MAGIEN,2)),U,7) I X'=RARPT S MIXEDUP=3_U_+X Q
CK2 I 'MIXEDUP Q  ; no problems detected
 I +MIXEDUP=1!(+MIXEDUP=2) D  Q
 . S X=$$PNAM^MAGJEX1($P(MIXEDUP,U,2))
 . I +MIXEDUP=1 S REPLY="The Exam file for this exam has patient "_$$PNAM^MAGJEX1(RADFN)_"; the corresponding Report file has patient "_X_".  This is a serious problem--immediately report it to Radiology management and Imaging support!"
 . I +MIXEDUP=2 S REPLY="This exam is registered for "_$$PNAM^MAGJEX1(RADFN)_"; however, it is linked to images for patient "_X_".  This is a serious problem--immediately report it to Radiology management and Imaging support staff!"
 I +MIXEDUP=3 D  Q
 . N T S T=$P(MIXEDUP,U,2) S:'T T="Missing Link"
 . S REPLY="This exam is linked to Report entry #"_RARPT_", but some of its images may be linked to Report entry #"_T_".  This is a potentially serious problem--immediately report it to Radiology management and Imaging support staff!"
 I +MIXEDUP=4 D  Q
 . N T S T=$P(MIXEDUP,U,2) S:'T T="Missing Reference"
 . S X=" ("_RARPT_" and "_T_" )"
 . S REPLY="This exam has problems in the Radiology Report file, with two different report entries referenced"_X_".  This is a potentially serious problem--immediately report it to Radiology management and Imaging support staff!"
 I +MIXEDUP=5 D  Q
 . N T S X=$P(MIXEDUP,U,2) S:X="" X="Missing"
 . S T=$P(MIXEDUP,U,3) S:T="" T="Missing"
 . S X=" ("_X_" and "_T_") "
 . S REPLY="This exam has problems in the Radiology files, with two different Case Numbers referenced"_X_".  This is a potentially serious problem--immediately report it to Radiology management and Imaging support staff!"
 Q
 ;
ERR ;
 S @MAGRPTY@(0)="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
END ;
