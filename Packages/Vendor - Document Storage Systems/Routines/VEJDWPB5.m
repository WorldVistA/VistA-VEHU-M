VEJDWPB5 ;WPB/CAM routine modified for dental GUI;8/1/98;7/10/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; RPCs FOR CPRS GUI IMPLEMENTATION ;12/15/97
 ;ORQQPL2;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ; 11/96 ALB/PDR
 ;
 ; -------------- GET HISTORY FOR DETAIL DISPLAY ----------------------
 ;
HIST(RETURN,GMPIFN) ; GET AUDIT HISTORY
 ; taken from EN^GMPLDISP
 N IDT,AIFN,S,DT,TXT,I,L,GMPDT
 S LCNT=0
 I '$D(^GMPL(125.8,"B",GMPIFN)) D  Q  ;BAIL OUT - NO CHANGES
 . S RETURN(0)="NONE"
 ;       get change history
 S IDT=""
 F  S IDT=$O(^GMPL(125.8,"AD",GMPIFN,IDT)) Q:IDT'>0  D
 . S AIFN=""
 . F  S AIFN=$O(^GMPL(125.8,"AD",GMPIFN,IDT,AIFN)) Q:AIFN'>0  D
 .. D DT^GMPLHIST
 ;         Transfer data and clean up for return to GUI
 S S="",I=0,TXT=""
 F  S S=$O(GMPDT(S)) Q:S=""  D
 . S L=GMPDT(S,0)
 . I $L(L,": ")>1 D  Q  ; does line begin with date? (hope ": " can't be part of text)
 .. D FLUSH(.RETURN,.I)
 .. S DT=$P(L,": ") ; get new date
 .. S TXT=$$STRIP($P(L,": ",2,999)) ; start new text string
 . S TXT=TXT_" "_$$STRIP(L)  ; line does not begin with date, so add to existing text line
 I '$D(RETURN(0)) S RETURN(0)=I
 D FLUSH(.RETURN,.I)
 Q 
 ;
FLUSH(RETURN,I) ; FLUSH FORMATTED AUDIT STRING
  I I'=0 D  ; do we have a text string built?
 . S RETURN(I)=$$STRIP(DT)_U_TXT  ; return date and text
  S I=I+1
 Q
 ;
STRIP(VAL) ; STRIP LEADING SPACES FROM VALUES
 N J
 F J=1:1 Q:$E(VAL,J)'=" "
 Q $E(VAL,J,9999)
 ;
 ; ------------------- DELETE A PROBLEM FROM LIST ---------------------
 ;
DELETE(RESULT,GMPIFN,GMPROV,GMPVAMC,REASON) ; DELETE A PROBLEM
 ; From GMPL1 - silent version
 N CHNGE
 I REASON'="" D
 . S GMPFLD(10,"NEW",1)=REASON
 . D NEWNOTE^GMPLSAVE
 S CHNGE=GMPIFN_"^1.02^"_$$HTFM^XLFDT($H)
 S CHNGE=CHNGE_U_DUZ_"^P^H^Deleted^"_+$G(GMPROV)
 S $P(^AUPNPROB(GMPIFN,1),U,2)="H"
 S RESULT=1
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(GMPIFN)
 Q
 ; ------------------ REPLACE REMOVED PROBLEM ----------------------
 ;
REPLACE(RETURN,DA) ; -- replace problem on patient's list
 ; taken from REPLACE^GMPLRPTR
 N CHNGE,DIE
 I $P($G(^AUPNPROB(DA,1)),U,2)'="H" D  Q  ; BAIL OUT - INVALID RECORD
 . S RETURN=0
 S DR="1.02////P"
 S DIE="^AUPNPROB("
 D ^DIE
 S CHNGE=DA_"^1.02^"_$$HTFM^XLFDT($H)_U_DUZ_"^H^P^Replaced^"_DUZ
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(DA)
 S RETURN=1
 Q
 ;
 ; -------------------  VERIFY A PROBLEM ------------------------
 ;
VERIFY(RETURN,GMPIFN) ; -- verify a transcribed problem
 ; RETURN:  ;(consistent with UPDATE function)
 ;   SUCCESS:
 ;     RETURN>0, RETURN(0)=""
 ;   FAILURE:
 ;      RETURN<0, RETURN(0)=verbose error message
 N NOW,CHNGE
 S NOW=$$HTFM^XLFDT($H)
 I $P(^AUPNPROB(GMPIFN,1),U,2)'="T" D  Q  ; BAIL OUT - ALREADY VERIFIED
 . S RETURN=-1
 . S RETURN(0)="Problem Already Verified"
 L +^AUPNPROB(GMPIFN,0):10
 I '$T D  Q  ; BAIL OUT - NO LOCK
 . S RETURN=-1
 . S RETURN(0)="Record in use. Try again in a few moments"
 S $P(^AUPNPROB(GMPIFN,1),U,2)="P"
 S CHNGE=GMPIFN_"^1.02^"_NOW_U_DUZ_"^T^P^Verified^"_DUZ
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(GMPIFN)
 L -^AUPNPROB(GMPIFN,0)
 S RETURN=1
 S RETURN(0)=""
 Q
