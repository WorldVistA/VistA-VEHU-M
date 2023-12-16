ISIJFAV ; ISI/JHC - ISIRAD Favorites functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,103,106,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to GETEXAM2^MAGJUTL1 in ICR #7404
 ; Reference to IMGINFO^MAGJUTL2 in ICR #7405
 Q
 ;;
ERR ;
 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ;   rpc ISIJ FAVORITE -- functions to create/update/retrieve Favorites exams
 ;
FAVORITE(MAGGRY,PARAMS,DATA) ;
 ; PARAMS: TXID ^ RADFN ^ RADTI ^ RACNI ^ RARPT
 ;  TXID: Req'd--action to take
 ; DATA--(opt) input array containing Notes text
 ;  Pattern for DATA input & reply is:
 ;   *KEYWORDS
 ;    KEYWORD-1   (place holder required)
 ;    KEYWORD-2   (ditto)
 ;   *KEYWORDS_END
 ;   *NOTES        Start for NOTES
 ;    (0:N lines of text follow)
 ;   *NOTES_END    end for note
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJFAV"
 N COMMA,DASH,EXAMID,EXAMFILE,RACNI,RADFN,RADTI,USERFILE  ; vars global to all program subroutines
 N MAGLST,REPLY,RET,TXID,EXAMIEN,USERIEN
 S REPLY=""
 S USERFILE=23451,EXAMFILE=23451.01,COMMA=",",DASH="-"
 S TXID=+PARAMS,RADFN=+$P(PARAMS,U,2),RADTI=$P(PARAMS,U,3),RACNI=+$P(PARAMS,U,4)
 S MAGLST="ISIJRPC" S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N DIQUIET S DIQUIET=1 D DT^DICRW
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; ICR 65
 E  S REPLY="0^4~Invalid Request; no Exam found for input data ("_PARAMS_")" G FAVORITZ
 S EXAMID=RADFN_DASH_RADTI_DASH_RACNI
 S USERIEN=$$USERIEN(DUZ),EXAMIEN=$S('USERIEN:"",1:$$EXAMIEN(USERIEN,EXAMID))
 I TXID=1 D     ; called from any exam list EXCEPT Fav list
 . I +EXAMIEN S REPLY="^0~View/edit Favorites list entry."  ; not usual, but could happen...
 . E  S REPLY="^0~Add exam to Favorites list."  ;  expected "typical" use of txid=1
 . D FAVGET("@MAGGRY",USERIEN,EXAMIEN)
 . S REPLY=@MAGGRY@(0)_REPLY
 E  I TXID=2 D    ; update new or existing entry; called from Fav DIALOG
 . D FAVUPD(.RET,.USERIEN,.EXAMIEN,.DATA)
 . S REPLY=0_U_RET
 E  I TXID=3 D   ; delete entry; called from Fav LIST
 . I '+EXAMIEN S REPLY="0^3~No Favorites entry exists for this exam.("_PARAMS_")" Q
 . D FAVDEL(.RET,USERIEN,EXAMIEN)
 . S REPLY=0_U_RET
 E  I TXID=4 D   ; get data to populate Fav Dialog; called from Fav LIST
 . I '+EXAMIEN S REPLY="0^4~Problem with Favorites entry for this exam *2 ("_PARAMS_")" Q
 . D FAVGET("@MAGGRY",USERIEN,EXAMIEN)
 . S REPLY=@MAGGRY@(0)_"^0~View/edit Favorites list entry."
 E  S REPLY="0^4~Invalid 'Favorites' Transaction ID ("_$P(PARAMS,U)_")"
 ;
FAVORITZ ;
 S @MAGGRY@(0)=REPLY
 Q
 ;
FAVUPD(RET,USERIEN,EXAMIEN,DATA) ; Update favorite exam info
 N NEWEXAM,ZJ,REPLYTXT
 S RET="",NEWEXAM=0
 I 'USERIEN S USERIEN=$$NEWUSER(DUZ)  ; add this user to Fav file
 I 'EXAMIEN D  Q:'EXAMIEN
 . S EXAMIEN=$$NEWEXAM(USERIEN,EXAMID)  ; add this exam to Fav file
 . I EXAMIEN S NEWEXAM=1
 . E  S RET="4~Problem with adding Favorites entry for this exam *1 ("_PARAMS_")"
 E  D UPDINI(USERIEN,EXAMIEN) ; initialize Keyword & Notes data for existing entry
 D PARSE(.ZJ,"ZJ",USERIEN,EXAMIEN,.DATA) ; load input data into zj array
 I $D(ZJ) D  ; update Keywords & Notes if any
 . D FILE^DIE("","ZJ","RSL")
 . S X=$G(RSL("DIERR",1))
 . I X]""  S RET="4~Problem with adding Favorites entry for this exam *1 ("_PARAMS_")"
 I RET]"" Q
 S REPLYTXT=$S(NEWEXAM:"New exam added to Favorites.",1:"Favorites exam data updated.")
 I $$STSCHECK() S RET="0~"_REPLYTXT
 E  S RET="3~"_REPLYTXT_"  Note--this exam will not be displayed in your Favorites List until it has been interpreted."
 Q
 ;
UPDINI(USERIEN,EXAMIEN) ; Initialize exam fields prior to update; only called if entry exists
 N IENS,KFNUM,ZJ
 S IENS=EXAMIEN_COMMA_USERIEN_COMMA
 F KFNUM=1,2 S ZJ(EXAMFILE,IENS,KFNUM)="@"  ; delete data
 D FILE^DIE("","ZJ","RSL")
 D WP^DIE(EXAMFILE,IENS,3,"","@")
 Q
 ;
PARSE(RET,RETNAM,USERIEN,EXAMIEN,DATA) ;  package input data and format for fileman DBS calls
 ; re RETNAM: the fileman update call for a WP field needs the
 ;            name of the input array at the node defined below
 N IP,IENS,KFNUM,KW,NOTE
 S (KW,NOTE)=0
 S IENS=EXAMIEN_COMMA_USERIEN_COMMA
 S IP="" F  S IP=$O(DATA(IP)) Q:IP=""  S X=DATA(IP) D
 . I X="*KEYWORDS" S KW=1 Q
 . I X="*NOTES" S NOTE=1 Q
 . I KW D
 . . I X="*KEYWORDS_END" S KW=0 Q
 . . I KW>2 Q
 . . S KFNUM=$S(KW=1:1,KW=2:2,1:0)
 . . S RET(EXAMFILE,IENS,KFNUM)=$$STRIP(X) ; remove unwanted characters
 . . S KW=KW+1
 . I NOTE D
 . . I X="*NOTES_END" S NOTE=0 Q
 . . I NOTE=1 S RET(EXAMFILE,IENS,3)=RETNAM_"("_EXAMFILE_","""_IENS_""""_",3)"  ; WP call needs this node
 . . S RET(EXAMFILE,IENS,3,NOTE)=X
 . . S NOTE=NOTE+1
 ;
 Q
NEWUSER(DUZ) ; Create new user entry in Favorites file; only called if not yet defined
 N ZJ,ZJMSG,RSL
 S ZJ(USERFILE,"+1,",.01)=DUZ
 D UPDATE^DIE("","ZJ","RSL")
 Q:$Q RSL(1) Q
 ;
NEWEXAM(USERIEN,EXAMID) ; Create new exam entry in Favorites file; only called if not yet defined
 N ZJ,ZJMSG,RSL
 S ZJ(EXAMFILE,"+1,"_USERIEN_",",.01)=EXAMID
 D UPDATE^DIE("","ZJ","RSL")
 Q:$Q RSL(1) Q
 ;
STSCHECK() ; Flag (=0) if Exam Status not past Examined state; Else=1
 N OK,RADATA,STS,X  ; other vars global to program
 S OK=1
 S RADATA=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 S STS=$P(RADATA,U,3)
 I STS]"" D
 . S X=$$STATUS^ISIJLS1(STS)
 . I X="I"!(X=9) Q  ; Interp/Complete
 . I X=0!(X=1)!(X="W")!(X="R")!(X="E") S OK=0 Q  ; Cancelled/Waiting/Examined,  P106 add "R"
 Q:$Q OK Q
 ;
FAVDEL(RET,USERIEN,EXAMIEN) ; Delete favorite exam entry; only called if entry exists
 N IENS,ZJ
 S IENS=EXAMIEN_COMMA_USERIEN_COMMA
 S ZJ(EXAMFILE,IENS,.01)="@"  ; delete entire exam record
 D FILE^DIE("","ZJ","RSL")
 S X=$G(RSL("DIERR",1))
 I X]"" S RET="4~Problem with deleting Favorites entry for this exam *4 ("_USERIEN_COMMA_EXAMIEN_"). "_X
 E  S RET="0~Favorites entry deleted"
 Q
 ;
FAVGET(RET,USERIEN,EXAMIEN) ; return favorites details
 N DAYCASE,IMGCNT,IENS,IRET,ISS,KEYWD1,KEYWD2,MAGDT,PROC,RADATA,RARPT,ZJ
 K ^TMP($J,"MAGRAEX")
 S (KEYWD1,KEYWD2)=""
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.X)
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1))
 K ^TMP($J,"MAGRAEX")
 S RARPT=$P(RADATA,U,10),DAYCASE=$P(RADATA,U,12),PROC=$P(RADATA,U,9)
 D IMGINFO^MAGJUTL2(RARPT,.Y) S IMGCNT=+$P(Y,U),MAGDT=$P(Y,U,3)
 I MAGDT="" S MAGDT=$P(RADATA,U,7)
 S MAGDT=$$FMTE^XLFDT(MAGDT,"5Z")
 S IRET=0
 S IRET=IRET+1,@RET@(IRET)="Case #^Procedure^Image Date/Time^# Img"
 S IRET=IRET+1,@RET@(IRET)=DAYCASE_U_PROC_U_MAGDT_U_IMGCNT
 ;
 I USERIEN,EXAMIEN D
 . S IENS=EXAMIEN_COMMA_USERIEN_COMMA
 . D GETS^DIQ(EXAMFILE,IENS,"1;2;3","","ZJ")
 . S KEYWD1=$G(ZJ(EXAMFILE,IENS,1)) S:KEYWD1="" KEYWD1=" " ; workaround client bug
 . S KEYWD2=$G(ZJ(EXAMFILE,IENS,2)) S:KEYWD2="" KEYWD2=" " ; ditto
 . S IRET=IRET+1,@RET@(IRET)="*KEYWORDS"
 . S IRET=IRET+1,@RET@(IRET)=KEYWD1
 . S IRET=IRET+1,@RET@(IRET)=KEYWD2
 . S IRET=IRET+1,@RET@(IRET)="*KEYWORDS_END"
 . S IRET=IRET+1,@RET@(IRET)="*NOTES"
 . I $D(ZJ(EXAMFILE,IENS,3))>9 D
 . . S ISS=0
 . . F  S ISS=$O(ZJ(EXAMFILE,IENS,3,ISS)) Q:'ISS  S IRET=IRET+1,@RET@(IRET)=ZJ(EXAMFILE,IENS,3,ISS)
 . S IRET=IRET+1,@RET@(IRET)="*NOTES_END"
 S @RET@(0)=IRET
 ;
 Q
 ;
USERIEN(DUZ) ; Return UserIEN for input duz
 N USERIEN,ZJ
 D FIND^DIC(USERFILE,,"@","OQ",DUZ,,,,,"ZJ")
 S USERIEN=$S(+ZJ("DILIST",0):ZJ("DILIST",2,1),1:"")
 Q:$Q USERIEN Q
 ;
EXAMIEN(USERIEN,EXAMID) ; Return ExamIEN for input exam ID string
 N EXAMIEN,IENS,ZJ
 S IENS=COMMA_USERIEN_COMMA
 D FIND^DIC(EXAMFILE,IENS,"@","O",EXAMID,,,,,"ZJ")
 S EXAMIEN=$S(+ZJ("DILIST",0):ZJ("DILIST",2,1),1:"")
 Q:$Q EXAMIEN Q
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
