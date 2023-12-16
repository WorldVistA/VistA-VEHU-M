ISIDICR1 ; ISI/JHC - RPCs for Dictation ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**102,106,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ;
 Q
 ;
GETDXCOD(MAGRY) ;[RPC: ISI GET RAD DX CODES]
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIDICR1"
 N CT,IEN,MAGLST,REPLY,X
 S DIQUIET=1 D DT^DICRW
 S (CT,IEN)=0,MAGLST="ISIGETDXCOD"
 K MAGRY S MAGRY=$NA(^TMP($J,MAGLST)) K @MAGRY  ; assign MAGRY value
 S REPLY="0^0~Getting Rad Diag Codes"
 F  S IEN=$O(^RA(78.3,IEN)) Q:'IEN  S X=^(IEN,0) I $P(X,U,5)'="Y" D  ; filter Inactives
 . S CT=CT+1,X=IEN_U_$P(X,U),@MAGRY@(CT)=X
 S REPLY="0~Diagnostic codes returned."
 S @MAGRY@(0)=CT-1_U_REPLY
 Q
 ;
 ; RPC: ISIJ GET RAD TECHS
 ;
RADLST(RESULTS) ; Returns list of all Rad Techs at logon Division
 ;  RESULTS results returned here
 ;  array: 
 ;    1st entry   = # lines below ^ code ~ message;  code 0=normal result;  4=error
 ;    2:n entries = IEN ^ Tech Name   --> from file 200
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIDICR1"
 N I,DIVNAME,MAGMSG,MAGTMP,RADCLASS,TNAM,X
 S DT=$$DT^XLFDT  ; Make sure that the actual date is there
 S MAGTMP=$NA(^TMP("ISIRSL",$J))
 K @MAGTMP,RESULTS
 ;
 S DIVNAME=$$GET1^DIQ(4,DUZ(2)_",",.01,"E",,"MAGMSG") ; used for file #200 DIVISION index search
 S RADCLASS="T"  ;  Technologist
 ;
 S X="I $$SCRUSR^ISIDICR1(Y,RADCLASS)"  ; Screening code
 D LIST^DIC(200,,"@;.01","P",,,DIVNAME,"AH",X,,MAGTMP,"MAGMSG") ; ICR # 10060  "AH"=DIVISION index
 S X=$G(@MAGTMP@("DILIST",0))
 I X'>0 S RESULTS(0)="0^4~No Technologists found at logon Site."
 E  D
 . S I=0
 . F  S I=$O(@MAGTMP@("DILIST",I))  Q:'I  D
 . . S X=@MAGTMP@("DILIST",I,0)
 . . S TNAM($P(X,U,2))=X  ; alphabetic ordering
 . S TNAM="",RESULTS(0)=0
 . F  S TNAM=$O(TNAM(TNAM)) Q:TNAM=""  D
 . . S RESULTS(0)=RESULTS(0)+1
 . . S RESULTS(RESULTS(0))=TNAM(TNAM)
 . S RESULTS(0)=RESULTS(0)_U_"0~Rad Techs list"
 . Q
 K @MAGTMP
 Q
 ;
SCRUSR(IEN,RADCLASS) ; Screen logic function
 ; IEN -- entry in the NEW PERSON file (#200)
 ; Return Values:
 ;            0  Skip the record
 ;            1  Get the record
 N DISUSER,IEN1,MAGMSG,OK,SS,TMP,TERMDT
 ;   Radiology classification matches input RADCLASS
 S (IEN1,OK)=0
 F  S IEN1=$O(^VA(200,IEN,"RAC",IEN1))  Q:'IEN1  D  Q:OK
 . I RADCLASS[$P(^VA(200,IEN,"RAC",IEN1,0),U) S OK=1
 Q:'OK 0
 ;   Verify this person allowed at the logon Site DUZ(2)
 D GETS^DIQ(200,IEN,"16*","I","TMP","MAGMSG") ; ICR # 10060
 S OK=0 S SS="" F  S SS=$O(TMP(200.02,SS)) Q:SS=""  I $G(TMP(200.02,SS,.01,"I"))=DUZ(2) S OK=1 Q
 I 'OK Q 0
 ;   Verify the termination date
 S TERMDT=$$GET1^DIQ(200,IEN_",",9.2,"I",,"MAGMSG") ; ICR # 10060
 I TERMDT>0  Q:TERMDT'>DT 0
 ;   Verify the Active status
 S DISUSER=$$GET1^DIQ(200,IEN_",",7,"I",,"MAGMSG") ; ICR # 10060
 I DISUSER>0 Q 0
 Q OK
 ;
 ;
 ; RPC: ISIJ RAD EXAM UPDATE
 ;
UPDEXAM(MAGRY,PARAMS) ; Update exam record
 ; Input PARAMS:  
 ;   TX_CODE ^ Case ID | Tech-1 ^ Tech-2 ^ Tech_Comment  (* Note pipe-delimiter)
 ;     TX_CODE = 1 --> update Tech & Tech Comment
 ;     Case ID: RADFN^RADTI^RACNI^RARPT
 ;     Tech-1 - IEN for the Technologist, or nil--> at least one tech must be passed in
 ;     Tech-2 - IEN for the Technologist, or nil
 ;     Tech_Comment - entered text, or nil
 ; Return in @maggry:
 ;   Code ~ Reply display text
 ;   Reply Code-enumerated values:
 ; 0 - Normal result
 ; 4 - Error result; display Reply text in error message box
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIDICR1"
 N CASEID,CMT,I,ICNT,IENS,IENS7003,MAGLST,PIPE,RADFN,RADTI,RACNI,RAFDA,REPLY,TECHS,X
 S DT=$$DT^XLFDT
 N DIQUIET S DIQUIET=1 D DT^DICRW
 S MAGLST="ISIJRPC" S MAGRY=$NA(^TMP($J,MAGLST)) K @MAGRY
 ;
 S PIPE="|"
 S REPLY=""
 S X=$P(PARAMS,PIPE)
 S TXID=+X,RADFN=+$P(X,U,2),RADTI=$P(X,U,3),RACNI=+$P(X,U,4)
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; ICR 65
 E  S REPLY="4~Invalid Request; no Exam found for input data. ("_PARAMS_") errcode*30a" G UPDEXAMZ
 S CASEID=$P(X,U,2,5)
 I TXID=1
 E  S REPLY="4~Invalid Request; unrecognized input txid. ("_PARAMS_") errcode*30b" G UPDEXAMZ
 S X=$P(PARAMS,PIPE,2)
 S CMT=$P(X,U,3,99)
 F I=1,2 D
 . S T=$P(X,U,I)
 . I T?1.N,+T S TECHS(T)=""
 I $D(TECHS)
 E  S REPLY="4~Invalid Request; must enter TECHNOLOGIST. ("_PARAMS_") errcode*30c" G UPDEXAMZ
 ; validate Tech(s)
 S T=0
 F I=1:1 S T=$O(TECHS(T)) Q:'T  D  I REPLY]"" G UPDEXAMZ
 . I $$SCRUSR^ISIDICR1(T,"T")
 . E  S REPLY="4~Invalid Request; must enter TECHNOLOGIST. ("_PARAMS_") errcode*30d"
 ; file the data
 S IENS7003=$$EXAMIENS^RAMAGU04(CASEID)
 K RAFDA
 S T=0
 F ICNT=1:1 S T=$O(TECHS(T)) Q:'T  D  ; update TECH field
 . S IENS="+"_ICNT_","_IENS7003
 . S RAFDA(70.12,IENS,.01)=T
 D UPDATE^DIE("","RAFDA",,"RAMSG")
 I $G(DIERR) S REPLY="4~Error updating Technologist. errcode*30e" G UPDEXAMZ
 S IENS="+1,"_IENS7003
 K RAFDA
 D NOW^%DTC
 S RAFDA(70.07,IENS,.01)=$E(%,1,12)    ; update Log fields: D/T, Activity code, User, & Comments (if any)
 S RAFDA(70.07,IENS,2)="C"
 S RAFDA(70.07,IENS,3)=DUZ
 I CMT]"" S RAFDA(70.07,IENS,4)=CMT
 D UPDATE^DIE("","RAFDA",,"RAMSG")
 I $G(DIERR) S REPLY="4~Error updating Log file. errcode*30e" G UPDEXAMZ
 S REPLY="0~Exam record updated"
 ;
UPDEXAMZ ;
 S @MAGRY@(0)=REPLY
 Q
 ;
ERR ;
 S @MAGRY@(0)="0^4~ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
END ;
