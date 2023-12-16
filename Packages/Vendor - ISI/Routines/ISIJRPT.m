ISIJRPT ; ISI/JHC - ISIRAD Report Entry functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**102,106,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to DAYCASE^MAGJUTL6 in ICR #7407
 ; Reference to File #2006.69 in ICR #7410
 ; 
 Q
 ;
ERR ;
 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ;   rpc ISIJ REPORT ENTER -- initialize report enter window
 ;
RPTOPEN(MAGGRY,PARAMS) ; 
 ;  PARAMS: TXID ^ CASEID [ | CASEID-2 | etc. ] -- (one or more Cases accepted for input)
 ;     TXID: 0: View only; 1: EDIT report; 2: AMEND report
 ;   CASEID: RADFN ^ RADTI ^ RACNI ^ RARPT ("normal" identifier for VistARad)
 ; Reply message:
 ; # Lines to follow (0-n) ^ Reply Code ~ Reply display text
 ;   Reply Code- 0-Normal; 3-Abnormal; 4-Error
 ; Exams List:
 ;   Text | Case ID | "Active" flag ^ DX Code flag ^ Required elements flag ^ Case # ^ CPT ^ Procedure
 ; Report data follows (for Amend pathway & Edit Draft pathways):
 ;   *REPORT        Start for REPORT
 ;    (1:N lines of text follow)
 ;   *REPORT_END    End
 ;   *IMPRESSION    Start
 ;    (1:N lines of text follow)
 ;   *IMPRESSION_END    end
 ;   *DXCODE        Start
 ;    Code ^ Text (1:N lines of follow)
 ;   *DXCODE_END    end
 ;
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJRPT"
 N CASEID,DAYCASE,MAGLST,REPLY,TXID,PIPE
 N RADFN,RADTI,RACNI,RARPT,RASTCAT,RASTORD,REQFLAGS,REQFLG
 N ACTIVE,EDITFLAG,EXAMS,IEXAM,NEXAMS,PSETS,PSETCT
 N LINECT,ICT,OUT,RPTSTAT,STATCT,GETRPT,TXTYPE
 S LINECT=0,REPLY="",TXTYPE="",REQFLAGS=0
 S PIPE="|"
 S TXID=+PARAMS,RADFN=+$P(PARAMS,U,2),RADTI=$P(PARAMS,U,3),RACNI=+$P(PARAMS,U,4)
 S MAGLST="ISIJRPC" S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N DIQUIET S DIQUIET=1 D DT^DICRW
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; ICR 65
 E  S REPLY="0^4~Invalid Request; no Exam found for input data. ("_PARAMS_") errcode*1" G RPTOPENZ
 ;
 ; verify user type is valid for Editing a report
 I +TXID D 
 . I +MAGJOB("USER",1)
 . E  S REPLY="0^4~Only a radiologist may edit a report. ("_PARAMS_") errcode*1a" G RPTOPENZ
 ;
 ; init array of exams to be processed
 S EXAMS(1)="|"_$P($P(PARAMS,PIPE),U,2,5)
 F IEXAM=2:1 S CASEID=$P(PARAMS,PIPE,IEXAM) Q:CASEID=""  D  I REPLY]"" G RPTOPENZ
 . I +CASEID'=RADFN S REPLY="0^4~Invalid Request; multiple exams for different patients. ("_PARAMS_") errcode*2" Q
 . S EXAMS(IEXAM)="|"_CASEID
 S NEXAMS=IEXAM-1
 ;
 I NEXAMS>1  D  I REPLY]"" G RPTOPENZ
 . I "^2^0^"[TXID S REPLY="0^4~Invalid Request; only one exam allowed for View or Amend. ("_PARAMS_") errcode*3" Q
 ;
 ; get all needed data for each exam
 F IEXAM=1:1:NEXAMS S CASEID=$P(EXAMS(IEXAM),PIPE,2) D
 . S $P(EXAMS(IEXAM),PIPE)=$$GETDATA^ISIJRPT2(.CASEID,0)  ; caseid updated if rarpt not available w/ input caseid (Cat. "R" exams)
 . S $P(EXAMS(IEXAM),PIPE,2)=CASEID
 ;
 ; EXAMS(n) = Exam_DATA | dfn^dti^cni^rarpt | ACTIVE_flag ^ EDIT_flag
 ;  Exam_DATA:
 ;    PrtSetCase# ^ PROC ^ DAYCASE ^ RASTNAM ^ CPT  ^ MODIF ^ RASTCAT ^ RPT STATUS ^ DXCODE-IMPRESSION_FLAGS
 ;
 ; get rid of input "duplicate" pset exams, if any
 I NEXAMS>1 D
 . F IEXAM=1:1:NEXAMS S X=$P(EXAMS(IEXAM),PIPE),T=+X D:T
 . . I $D(PSETS(T)) K EXAMS(IEXAM) S NEXAMS=NEXAMS-1 Q
 . . S PSETS(T)=IEXAM
 ;
 ; get display data for printset members of "final" exams list
 S IEXAM=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  I +EXAMS(IEXAM) D  ; printset member
 . S PSETCT=0,EXAMS(IEXAM,PSETCT)=0
 . S T=EXAMS(IEXAM)
 . S DAYCASE=$P(T,U,3)
 . S T=$P(EXAMS(IEXAM),PIPE,2)
 . S RADFN=$P(T,U,1),RADTI=$P(T,U,2),RACNI=$P(T,U,3)
 . S PSETS=$$DAYCASE^MAGJUTL6(RADFN,RADTI,RACNI)  ; list of pset members' acns
 . F I=1:1:$L(PSETS,U) S T=$P(PSETS,U,I) I T'=DAYCASE D  ; n/a for starting case #
 . . S X=$$DAYCASE3^MAGJUTL6(T)  ; get caseid for this pset member
 . . I +X S X=$$GETDATA^ISIJRPT2(X,1),PSETCT=PSETCT+1,EXAMS(IEXAM,PSETCT)=X,EXAMS(IEXAM,0)=PSETCT
 ;
 ; verify individual exams OK to proceed
 S IEXAM=0,GETRPT=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D  I REPLY]"" G RPTOPENZ
 . S X=$P(EXAMS(IEXAM),PIPE),CASEID=$P(EXAMS(IEXAM),PIPE,2)
 . S RASTCAT=$P(X,U,7),RPTSTAT=$P(X,U,8),REQFLG=$P(X,U,9),DAYCASE=$P(X,U,3)
 . ; 1st check if user has required locks
 . D  I REPLY]"" Q
 . . N LOCKSTAT,LTYPE
 . . S LOCKSTAT="",LTYPE=$S(RASTCAT="E":"Exam",1:"Report")
 . . I +TXID S LOCKSTAT=$$LOCKCHK(CASEID,RASTCAT,DAYCASE)
 . . I +LOCKSTAT!(RASTCAT="C"&'TXID) ; ok: Locked, or View a Complete report
 . . E  D  Q  ; got a problem
 . . . I LOCKSTAT="" S REPLY="0^3~"_LTYPE_" not locked; no report entry/edit allowed. errcode*4"
 . . . E  S REPLY="0^3~"_LTYPE_" locked by "_LOCKSTAT_"; no report entry/edit allowed.  errcode*4a"
 . . ;  verify Tx type and Exam Status lines up; set active/editflag values
 . . S STATCT(RASTCAT)=$G(STATCT(RASTCAT))+1  ; count by status code
 . . I RASTCAT="W" S REPLY="0^4~Report entry not supported for Exam Status WAITING. ("_PARAMS_") errcode*7" Q
 . . I RASTCAT="E",(TXID=1) S ACTIVE=1,EDITFLAG=0,TXTYPE="New" Q
 . . I RASTCAT="R",(TXID=1) S ACTIVE=1,EDITFLAG=0,TXTYPE="New" Q
 . . I RASTCAT="I",(TXID=1) S ACTIVE=1,EDITFLAG=$S(RPTSTAT="":0,1:1),TXTYPE=$S(EDITFLAG:"Edit",1:"New") Q  ; assume for  "I": no rpt, or D/PD/R rpt
 . . I RASTCAT="C",'TXID S ACTIVE=-1,EDITFLAG=3,TXTYPE="View" Q  ; view only
 . . I RASTCAT="C",(TXID=2) S ACTIVE=1,EDITFLAG=2,TXTYPE="Amend" Q  ; amend report
 . . S REPLY="0^4~Request ("_$S(TXID=1:"Edit",TXID=2:"Amend",1:"View")_") not supported for this Exam Status code ("_RASTCAT_"); no report entry/edit allowed. ("_PARAMS_") errcode*5" Q
 . S $P(EXAMS(IEXAM),PIPE,3)=ACTIVE_U_EDITFLAG
 . I EDITFLAG,'GETRPT S GETRPT=CASEID  ; report text to return
 . I REQFLAGS<11,+REQFLG S REQFLAGS=$S(REQFLG=11:11,REQFLAGS=REQFLG:REQFLG,1:REQFLAGS+REQFLG)
 ;
 ; verify: multiple exams OK, based on exam/report statuses
 I NEXAMS>1 D  I REPLY]"" G RPTOPENZ  ; if mult exams, statuses must align acceptably
 . S RASTCAT="" F I=0:1 S RASTCAT=$O(STATCT(RASTCAT)) Q:RASTCAT=""
 . I I>1 S REPLY="0^4~Multiple exams with different statuses not allowed. ("_PARAMS_") errcode*6" Q
 . I $D(STATCT("C")) S REPLY="0^4~Multiple exams with status COMPLETE not allowed. ("_PARAMS_") errcode*8" Q
 . I $D(STATCT("E")) Q  ; good to go
 . I $D(STATCT("I")) D  Q:REPLY]""  ; ok if Zero or 1 exam has a ~draft report
 . . S IEXAM=0 N CT
 . . F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D  I REPLY]"" Q  ; allow if only 1 exam has a report (D/PD/R)
 . . . S RPTSTAT=$P($P(EXAMS(IEXAM),PIPE),U,8),T=$S(RPTSTAT="":0,1:1),CT(T)=$G(CT(T))+1
 . . . I $G(CT(1))>1 S REPLY="0^4~Multiple exams with unverified reports not allowed. ("_PARAMS_") errcode*9" Q
 ;
 ; assemble output lines
 S IEXAM=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D
 . S LINECT=LINECT+1,OUT(LINECT)=$$ONELINE(EXAMS(IEXAM),REQFLAGS)
 . S PSETCT=+$G(EXAMS(IEXAM,0)) I PSETCT D  ; printset members
 . . F ICT=1:1:PSETCT D
 . . . I ICT=1 S LINECT=LINECT+1,OUT(LINECT)="    Includes:"_PIPE_PIPE_0_U
 . . . S LINECT=LINECT+1,OUT(LINECT)=$$ONELINE(EXAMS(IEXAM,ICT))
 ; 
 ; get report text, if applicable
 I GETRPT D  I REPLY]"" G RPTOPENZ
 . N ZJ D RPTSTAT^ISIJDCU1(.ZJ,GETRPT,LINECT)
 . I $P($G(ZJ(0)),U)=-1 D  Q:REPLY]""
 . . S LINECT=0,REPLY="0^4~Error occurred: "_ZJ(0)_" ("_PARAMS_") errcode*10"
 . I +ZJ(0) S LINECT=ZJ(0) K ZJ(0) M OUT=ZJ
 ;
RPTOPENZ ;
 I REPLY="" M @MAGGRY=OUT S REPLY=LINECT_U_"0~Report entry results ("_TXTYPE_" report)"
 S @MAGGRY@(0)=REPLY
 Q
 ;
ONELINE(EXAM,REQFLAGS) ; Format output lines--details at rpc entry point
 N X,LINE,T
 N ACTIVE,EDITFLAG
 S REQFLAGS=$G(REQFLAGS)
 S T=$P(EXAM,PIPE,3),ACTIVE=+$P(T,U),EDITFLAG=$P(T,U,2)
 S X=$P(EXAM,PIPE)
 S LINE=$S(+ACTIVE:"",1:"    ")  ; indent text for non-active exam
 I ACTIVE=-1 S ACTIVE=0          ; View-only not really active
 S LINE=LINE_$P(X,U,3)_" ("_$P(X,U,4)_") "_$P(X,U,2) ; Acn, status, proc
 S T=$P(X,U,6) I T]"" S LINE=LINE_" ("_$P(X,U,6)_")" ; modif
 S T=$S(ACTIVE:$P(EXAM,PIPE,2),1:"")          ; caseid string
 S LINE=LINE_PIPE_T_PIPE       ;
 S LINE=LINE_+ACTIVE_U  ; active flag
 S LINE=LINE_REQFLAGS_U_EDITFLAG  ;  Dx Code/Impression required; "active" exam
 I ACTIVE S LINE=LINE_U_$P(X,U,3)_U_$P(X,U,5)_U_$P(X,U,2)  ; Acn, CPT, Proc
 Q LINE
 ;
 ;   rpc ISIJ LOCK REPORT -- lock protection for draft reports entry
 ;
RPTLOCK(MAGGRY,PARAMS) ; Lock or UNlock exams
 ; Locks done here are solely for exams in status "I" or "C"
 ;  PARAMS: TXID ^ CASEID [ | CASEID-2 | etc. ] -- (one or more Cases accepted for LOCK)
 ;     TXID: 1: Lock (1 or more OK);  0: Unlock (UNLOCK only one at a time)
 ;          11: Lock (1 or more OK); 10: Unlock ( ditto )
 ;        * 11 & 10 apply only to Status Code "R" exams
 ;   CASEID: RADFN ^ RADTI ^ RACNI ^ RARPT ("normal" identifier for VistARad)
 ; Reply message:
 ;   Reply Code ~ Reply display text
 ;     Reply Code: 0-Normal; 3-Abnormal; 4-Error
 ; Note re TXID=11--this locks exams of vistarad category "R", which normally
 ;   have no images when initiating the report, and therefore no RARPT entry yet
 ;   the pre-processing detects this state, and calls ^raric to create it
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJRPT"
 N CASEID,DAYCASE,MAGLST,REPLY,TXID,PIPE
 N RADFN,RADTI,RACNI,RARPT,RASTCAT,RASTORD
 N NLOCKS,ACTIVE,EDITFLAG,EXAMS,IEXAM,NEXAMS,PSETS,PSETCT
 N LINECT,ICT,OUT,RPTSTAT,STATCT,GETRPT,LOCKED,CT
 N CREATRPT,RCODE,LOCKEDEX
 S PIPE="|"
 S REPLY="",NLOCKS=0
 S TXID=+PARAMS,RADFN=+$P(PARAMS,U,2),RADTI=$P(PARAMS,U,3),RACNI=+$P(PARAMS,U,4)
 S MAGLST="ISIJRPC" S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N DIQUIET S DIQUIET=1 D DT^DICRW
 I RADFN,RADTI,RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; ICR 65
 E  S REPLY="4~Invalid Request; no Exam found for input data. ("_PARAMS_") errcode*19" G RPTLOCKZ
 I TXID=0!(TXID=1)!(TXID=10)!(TXID=11)
 E  S REPLY="4~Invalid Request; unrecognized input txid. ("_PARAMS_") errcode*19b" G RPTLOCKZ
 S RCODE=0 I TXID=10!(TXID=11) S RCODE=1  ; flag for Status Type "R" management, in case Ex Status not reliable
 I TXID=0!(TXID=10) D  I REPLY]"" G RPTLOCKZ
 . S X=$P(PARAMS,PIPE,2) I X=""
 . E  S REPLY="4~Invalid Request; Unlock only one exam per request. ("_PARAMS_") errcode*20a" G RPTLOCKZ
 ;
 ; EXAMS array contents as described above, except pipe-piece 3 tracks Locks for: Report_Lev ^ Exam_lev
 ; init array of exams to be processed
 S EXAMS(1)="|"_$P($P(PARAMS,PIPE),U,2,5)
 F IEXAM=2:1 S CASEID=$P(PARAMS,PIPE,IEXAM) Q:CASEID=""  D  I REPLY]"" G RPTLOCKZ
 . I +CASEID'=RADFN S REPLY="4~Invalid Request; multiple exams for different patients. ("_PARAMS_") errcode*21" Q
 . S EXAMS(IEXAM)="|"_CASEID
 S NEXAMS=IEXAM-1
 ;
 ; get all needed data for each exam; RARPT will be created if applicable, returned in caseid value
 F IEXAM=1:1:NEXAMS S CASEID=$P(EXAMS(IEXAM),PIPE,2) D  I REPLY]"" G RPTLOCKZ
 . S RARPT=+$P(CASEID,U,4),CREATRPT=0
 . I TXID=11,'RARPT S CREATRPT=1
 . S X=$$GETDATA^ISIJRPT2(.CASEID,0,CREATRPT) ; 1--flag to create rarpt when needed; note .CaseId is updated when rarpt is created
 . I $P(X,U)=-1 S REPLY="4~"_$P(X,U,2,99) Q  ; error detected
 . S $P(EXAMS(IEXAM),PIPE)=X,$P(EXAMS(IEXAM),PIPE,2)=CASEID  ;  store updated caseid in array
 . I CREATRPT,(+$P(CASEID,U,4)) S T=$P(EXAMS(IEXAM),PIPE,3),$P(T,U,2)=1,$P(EXAMS(IEXAM),PIPE,3)=T ; exam lock was opened in getdata; save incase need to unlock  if error
 ;
 ; process UNLOCKs here--only one exam per call allowed
 I TXID=0!(TXID=10) D  G RPTLOCKZ
 . S CASEID=$P(EXAMS(1),PIPE,2),RARPT=$P(CASEID,U,4)
 . I RARPT
 . E  S REPLY="4~Invalid Request; caseid string missing rarpt value. ("_PARAMS_") errcode*22a" Q
 . S X=$P(EXAMS(1),PIPE),DAYCASE=$P(X,U,3),RASTCAT=$P(X,U,7)
 . I "^I^C^"[RASTCAT D  Q:REPLY]""
 . . I TXID=0
 . . E  S REPLY="4~Invalid Request; Exam status must be 'Ready for Interp' for this unlock request. ("_PARAMS_") errcode*22c" Q
 . I RASTCAT="R" D  Q:REPLY]""
 . . I TXID=10
 . . E  S REPLY="4~Invalid Request; Exam status must be Interpreted or Complete for this unlock request. ("_PARAMS_") errcode*22d" Q
 . I $$LOCKCHK(CASEID,RASTCAT,DAYCASE) D  Q
 . . D UNLOCKRP^ISIJRPT2(RARPT)  ; unlock report level
 . . I +RCODE D UNLOCKEX^ISIJRPT2(CASEID)  ; unlock exam level for "R" category exams
 . . S REPLY="0~Exam unlocked."_"-"_RASTCAT_"-"
 . E  S REPLY="4~Invalid Request; exam/report was not locked by user. ("_PARAMS_"-"_RASTCAT_"-"_") errcode*22b"
 ;
 ; process lock request(s)
 ; get rid of input "duplicate" pset exams, if any
 I NEXAMS>1 D
 . F IEXAM=1:1:NEXAMS S X=$P(EXAMS(IEXAM),PIPE),T=+X D:T
 . . I $D(PSETS(T)) K EXAMS(IEXAM) S NEXAMS=NEXAMS-1 Q
 . . S PSETS(T)=IEXAM
 ;
 ; verify user type is valid for doing a lock
 I +MAGJOB("USER",1)
 E  S REPLY="4~Only a radiologist may lock a report. ("_PARAMS_") errcode*21a" G RPTLOCKZ
 ;
 ; verify exam status is valid for doing a lock
 S IEXAM=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D  I REPLY]"" G RPTLOCKZ
 . S X=$P(EXAMS(IEXAM),PIPE),RASTCAT=$P(X,U,7),RPTSTAT=$P(X,U,8)
 . S T=$S(RPTSTAT="":0,1:1),CT(T)=$G(CT(T))+1
 . I $G(CT(1))>1 S REPLY="4~Cannot lock multiple exams having unverified reports. ("_PARAMS_") errcode*23f" Q
 . I RASTCAT]"",("^I^C^R^"[RASTCAT)
 . E  S REPLY="4~Invalid Report Lock request--exam status must be Complete, Ready for Interp, or Interpreted. ("_PARAMS_") errcode*23" Q
 . I RASTCAT="R" D  Q:REPLY]""
 . . I TXID'=11 S REPLY="4~Invalid Report Lock request--Invalid TxID code for 'Ready for Interp' exam. ("_PARAMS_") errcode*23d" Q
 . I TXID=11 D  Q:REPLY]""
 . . I RASTCAT'="R" S REPLY="4~Invalid Report Lock request--TxID code valid only for 'Ready for Interp' exams. ("_PARAMS_") errcode*23e" Q
 . S STATCT(RASTCAT)=$G(STATCT(RASTCAT))+1
 I $G(STATCT("C"))>1!($G(STATCT("C"))&($G(STATCT("I"))!$G(STATCT("R")))) D  G RPTLOCKZ
 . S REPLY="4~Invalid Report Lock request--Complete exam cannot be edited with another exam. ("_PARAMS_") errcode*23a" Q
 I $G(STATCT("R"))&$G(STATCT("I")) D  G RPTLOCKZ
 . S REPLY="4~Invalid Report Lock request--Ready for Interp exam cannot be edited with another exam. ("_PARAMS_") errcode*23c" Q
 ;
 ; make sure not already locked by me
 S IEXAM=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D  I REPLY]"" G RPTLOCKZ
 . S CASEID=$P(EXAMS(IEXAM),PIPE,2)
 . S X=$P(EXAMS(IEXAM),PIPE),RASTCAT=$P(X,U,7),DAYCASE=$P(X,U,3)
 . S T=$$LOCKCHK(CASEID,RASTCAT,DAYCASE)  ; for Category "R" exams, we assume this (report) lock happened only if the Exam lock also succeeded
 . I T S REPLY="4~Invalid Request; exam/report already locked by user. ("_PARAMS_"-"_RASTCAT_"-"_") errcode*23b"
 ;
 ; obtain locks for the active exams
 S IEXAM=0
 F  S IEXAM=$O(EXAMS(IEXAM)) Q:'IEXAM  D  I REPLY]"" G RPTLOCKZ
 . S CASEID=$P(EXAMS(IEXAM),PIPE,2),RARPT=$P(CASEID,U,4)
 . I RCODE D  Q:'LOCKEDEX
 . . S X=$P(EXAMS(IEXAM),PIPE),RASTCAT=$P(X,U,7)
 . . D LOCKEX(CASEID,RASTCAT,.LOCKEDEX)  ; lock at exam level for Category "R" exams only
 . . I LOCKEDEX
 . . E  S REPLY="3~Unable to lock exam for report entry/edit; try again later; code*24a." Q
 . D LOCKRPT(RARPT,.LOCKED)  ; ALL exams require report level lock
 . I LOCKED S $P(EXAMS(IEXAM),PIPE,3)=1_U,NLOCKS=NLOCKS+1
 . E  D  Q
 . . I RCODE D UNLOCKEX^ISIJRPT2(CASEID)  ; undo the exam lock
 . . S REPLY="3~Unable to lock report for entry/edit; try again later; code*24b." Q
 S REPLY="0~Report"_$S(NLOCKS>1:"s",1:"")_" locked for entry/edit."
 ;
RPTLOCKZ ;
 I +REPLY>0 D  ; clear up locks, if need be
 . D UNLOCKEM^ISIJRPT2(RCODE,NLOCKS)
 S @MAGGRY@(0)=REPLY
 Q
 ;
LOCKRPT(RARPT,LOCKED) ; for input rarpt, return success/fail for lock attempt
 S LOCKED=0
 I 'RARPT
 E  D
 . L +^RARPT(RARPT):2  ; this is sufficient to protect all printset members (both ISIRad and roll'n scroll)
 . I  D
 . . S ^TMP("RAD LOCKS","ISI",$J,DUZ,"^RARPT(",RARPT)=$P($G(MAGJOB("USER",1)),U,3)
 . . S LOCKED=1 ; success
 . ;
 Q
 ;
LOCKEX(CASEID,RASTCAT,LOCKED) ; for input caseid, return success/fail for lock attempt
 ;   1) Lock the Exam level--this will persist for the report entry session (protects Tech field update)
 ; Return: Lock successful 0/1
 N RADFN,RADTI,RACNI
 S LOCKED=0
 I RASTCAT="R"
 E  S LOCKED=LOCKED_U_"Invalid exam status for 'R-category' exam lock operation. errcode*25a" Q
 S RADFN=$P(CASEID,U),RADTI=$P(CASEID,U,2),RACNI=$P(CASEID,U,3)
 L +^RADPT(RADFN,"DT",RADTI,"P",RACNI,0):2
 I  S LOCKED=1
 E  S LOCKED=0_U_"Unable to obtain exam lock; errcode*25c"
 Q
 ;
LOCKCHK(CASEID,RASTCAT,DAYCASE) ; does current user have a lock?
 ; Return: 1=Locked by me; nil=not locked; INI[:R] or Text=Locked/Reserved by other
 N OK,RARPT
 S OK="",RARPT=$P(CASEID,U,4)
 I RASTCAT="E" D  ; Should have been locked by "normal" exam lock
 . S X=$$CHKLOCK^MAGJLS2B(RARPT,DAYCASE)
 . S OK=($P(X,U,2)=1)  ; Exam locked by Client
 . I 'OK S OK=$P(X,U)  ; initials of other user, or nil
 E  I RASTCAT]"",("^I^C^R^"[RASTCAT) D  ; lock would be the "report entry" lock per this module
 . L +^RARPT(RARPT,"checklock"):0
 . I  D  L -^RARPT(RARPT,"checklock")
 . . I $D(^TMP("RAD LOCKS","ISI",$J,DUZ,"^RARPT(",RARPT)) S OK=1 ; locked by me
 . . E  S OK="" Q  ; not locked
 . E  S OK="another user"
 Q OK
 ;
READYINT(IMGTYP) ; "Ready for Interpretation" feature enabled? -- P106 enhancement
 ; --> If is enabled for input Type of Imaging, returns field # & data value to stuff into Exam Record
 ; current (perhaps only) user is RTT: called by ISIRAD03
 ; 
 N FIELD,FILE,REPLY,VALUE,X
 S REPLY=""
 S X=$P(^MAG(2006.69,1,"ISI"),U,7,8)
 I +X=$G(IMGTYP) D  ; does apply to this Imaging Type
 . S X=$P(X,U,2)
 . S VALUE=$P(X,";",1),FILE=$P(X,";",2)
 . S FIELD=$S(FILE="RA(78.6,":18,1:"")  ; <*> thus far, we only use #78.6 Camera/Equip/Rm
 . I FIELD=""!(VALUE="") S REPLY="-1^Invalid 'Ready for Interpretation' setting in MAG VISTARAD SITE PARAMETERS file." Q
 . S REPLY=FIELD_U_VALUE
 Q:$Q REPLY Q
 ;
END ;
