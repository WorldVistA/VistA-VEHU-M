ISIJRPT2 ; ISI/JHC - ISIRAD Report Entry functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**102,106,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to GETEXAM2^MAGJUTL1 in ICR #7404
 ; 
 Q
 ;
GETDATA(CASEID,PRINTSET,SETRARPT) ;
 ;    PRINTSET--flag:   1=printset; not all data needed for these exams
 ;    SETRARPT--flag:   1=Create/set RARPT if not in CaseId--is normal to occur when Locking Category "R" exams
 ;  Return (in RET):
 ;    PrtSetCase# ^ 9.1PROC ^ 12.1DAYCASE ^ 14.1RASTNAM ^ 17.1CPT;
 ;    ^ 8.2MODIF ^ 11.2RASTCAT ^ RPT STATUS ^ DXCODE-IMPRESSION_FLAGS
 ;  Or, RET = -1 ^ message text --> If error detected
 N RADFN,RADTI,RACNI,RARPT,RADTE,RACN,RPTSTAT,RET,ERROR
 N I,ICT,ILEV,N,T,V,PSET,RADAT,RAPRTSET,RASTORD
 S SETRARPT=$G(SETRARPT,0)
 S RADFN=$P(CASEID,U,1),RADTI=$P(CASEID,U,2),RACNI=$P(CASEID,U,3),RARPT=$P(CASEID,U,4)
 S ERROR=""
 I 'RARPT,SETRARPT D  ; Cat "R" exams, no rarpt exists; must create it
 . ; Locking the exam at higher level protects collision for printset members (however unlikely)
 . L +^RADPT(RADFN,"DT",RADTI):2
 . E  S ERROR="-1^Unable to obtain exam lock; errcode*26a" Q
 . S RADTE=$$INVDTE^RAMAGU04(RADTI)
 . S RACN=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U)
 . D CREATE^RARIC
 . I $G(RARPT) S $P(CASEID,U,4)=RARPT  ; a successful call sets Rarpt, so update caseid
 . E  D
 . . S ERROR="-1^Unable to initialize report node for exam lock operation; errcode*26b"
 . . L -^RADPT(RADFN,"DT",RADTI)  ; unlock the exam level
 I ERROR]"" S RET=ERROR Q:$Q RET Q
 ;
 S PRINTSET=$G(PRINTSET,0)
 S ICT=1,$P(RET,U,ICT)=""  ; ICT tracks the piece-number of the data returned in RET
 I 'PRINTSET D  ; get printset indicator
 . D EN2^RAUTL20(.PSET)
 . I RAPRTSET D  ; PSET(RADTI)=Case # (Long or short) ^ ProcIEN ^ rarpt ^ statien
 . . S T=$O(PSET(0)),T=$P(PSET(T),U),$P(RET,U,ICT)=T  ; "top" case # of printset (always the same, no matter which RACNI input)
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.X)
 F I=1,2 S RADAT(I)=$G(^TMP($J,"MAGRAEX",1,I))
 K ^TMP($J,"MAGRAEX")
 I 'RARPT S RARPT=$P(RADAT(1),U,10),$P(CASEID,U,4)=RARPT ; Report Enter rpc: client may not have had the rarpt (Cat. "R" exams)
 S V(1)="9^12^14^17",V(2)="8^11"
 F ILEV=1,2 D
 . F I=1:1:$L(V(ILEV),U) S N=$P(V(ILEV),U,I),T=$P(RADAT(ILEV),U,N) S ICT=ICT+1,$P(RET,U,ICT)=T
 S RPTSTAT=""
 I 'PRINTSET,+RARPT S X=$G(^RARPT(RARPT,0)) I X]"" S RPTSTAT=$P(X,U,5) ; only need for main exam
 S ICT=ICT+1,$P(RET,U,ICT)=RPTSTAT
 S T=$P(RET,U,7) D  ; normalize Ex Status value, if needed (for E & R, nothing to do)
 . I T="D"!(T="T") S $P(RET,U,7)="I"  ; for Dictated/Interpreted/Transcribed
 . I T="" S RASTORD=$P(RADAT(1),U,15),$P(RET,U,7)=$S(RASTORD=9:"C",RASTORD=1:"W",1:0)  ; Complete/Waiting/Cancel
 S X=$$REQFLAGS($P(RADAT(1),U,18))  ; pass Img Type Abb to function
 S ICT=ICT+1,$P(RET,U,ICT)=X  ; see function for description
 Q:$Q RET Q
 ;
REQFLAGS(ABB) ; Calculate DxCode_Required and Impression_Required truth values
 ; input is Type of Imaging Abbreviation (Rad file 79.2)
 ;   --> use this to find the file 72 truth values needed
 ; 11: both required
 ; 10: DxCode required
 ;  1: Impression required
 ;  0: neither required
 N IMGTYP,RAST,RET,T,X,I
 S RET=11 ; default is both Required (DxCode & Impression)
 I ABB]"" D
 . S T=$O(^RA(79.2,"C",ABB,"")) Q:'T
 . S X=$G(^RA(79.2,T,0)) Q:X=""  S IMGTYP=$P(X,U)
 . S RAST=$O(^RA(72,"AA",IMGTYP,9,"")) Q:'RAST  ; Rad "Complete" status for this ImgTyp
 . S T=$G(^RA(72,RAST,.1)) Q:T=""
 . S RET="" F I=5,16 S RET=RET_($P(T,U,I)="Y")
 Q:$Q +RET Q
 ;
UNLOCKEM(RCODE,NLOCKS) ; unlock everything because unable to lock all of them
 N IEXAM,CASEID,RARPT,X
 S IEXAM=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D
 . S CASEID=$P(EXAMS(IEXAM),PIPE,2),RARPT=+$P(CASEID,U,4)
 . S X=$P(EXAMS(IEXAM),PIPE,3)
 . I +X,+NLOCKS D UNLOCKRP(RARPT) I +RCODE D UNLOCKEX(CASEID) Q
 . Q:'RCODE
 . I +$P(X,U,2) D UNLOCKEX(CASEID) ; error occurred somewhere after getexam had locked the exam
 Q
 ;
UNLOCKRP(RARPT) ; unlock this exam
 L -^RARPT(RARPT)
 K ^TMP("RAD LOCKS","ISI",$J,DUZ,"^RARPT(",RARPT)
 Q
 ;
UNLOCKEX(CASEID) ; Unlock EXAM level for Category "R" exams
 N RADFN,RADTI,RACNI
 S RADFN=$P(CASEID,U),RADTI=$P(CASEID,U,2),RACNI=$P(CASEID,U,3)
 L -^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 L -^RADPT(RADFN,"DT",RADTI)  ; covers exams for which rarpt was created--no harm otherwise
 Q
 ;
REMLOCK ;  Remove dangling exam locks; this is run only at Logon
 ; If a recorded lock is found that a new job (logon) can M-Lock
 ; then that is a dangling lock that must be removed
 N CASEID,RARPT,LOCKED,LDUZ,JOB,MELOCK,DAYCASE,QVAR,QSTART,RASTCAT
 S QSTART="^TMP(""RAD LOCKS"",""ISI""",QVAR=QSTART_")"
 F  S QVAR=$Q(@QVAR) Q:QVAR'[QSTART  D  ; loop thru recorded locks
 . S RARPT=+$P(QVAR,",",$L(QVAR,","))
 . S CASEID="^^^"_RARPT,RASTCAT="I",DAYCASE="DUM"
 . S MELOCK=$$LOCKCHK^ISIJRPT(CASEID,RASTCAT,DAYCASE)
 . I MELOCK'="" Q  ; unable to lock--is a good lock
 . S JOB=$P(QVAR,",",3),LDUZ=$P(QVAR,",",4)
 . D LOCKRPT^ISIJRPT(RARPT,.LOCKED) ; 1st lock to me
 . I LOCKED D    ; then clear the lock & global entry
 . . K ^TMP("RAD LOCKS","ISI",JOB,LDUZ,"^RARPT(",RARPT)
 . . D UNLOCKRP(RARPT)
 Q
 ;
END ;
