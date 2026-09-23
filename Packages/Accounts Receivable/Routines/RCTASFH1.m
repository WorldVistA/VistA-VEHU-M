RCTASFH1 ;AITC/CJE - Receive FHIR message for ePayments 835 EFT/ERA
 ;;4.5;Accounts Receivable;**455**;Oct 4, 2018;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
FILERR(ARG,RCTYPE,RCERR,ERRMSG) ; File an error
 ; Inputs : ARG    - Array of FHIR data passed into VistaLink
 ;          RCTYPE - type of msg (835ERA/835EFT/etc.)
 ;          RCERR  - Line used in ^RCSPESR1 to get error text
 ;          ERRMSG - Error message from PARSE^RCTASFH
 ;
 N GLOB,K,RCOUNT,RCD,RCGBL
 ; A global reference is needed for the call to ERRUPD^RCSPESR1 but the global is empty in this case
 S RCGBL="^TMP(""RCTASFH"","_$J_")"
 S RCD("DATE")=$$NOW^XLFDT()
 S RCD("SUBJ")="835 EFT FHIR MESSAGE. "_ERRMSG
 S RCD("MSG#")="N/A - FHIR Message via VistALink"
 ;
 ; Put data from ARG array into message test
 S K="",RCOUNT=0
 F  S K=$O(ARG(K)) Q:K=""  D  ;
 . S RCOUNT=RCOUNT+1,^TMP("RCRAW",$J,RCOUNT)=K_" = "_ARG(K)_" , "
 ;
 I $D(^TMP("DIERR",$J)) S RCOUNT=RCOUNT+1 S ^TMP("RCRAW",$J,RCOUNT)=" "
 ; Put data from ^TMP("DIERR",$J) into message text
 S GLOB="^TMP(""DIERR"",$J)"
 F  S GLOB=$Q(@GLOB) Q:GLOB'[("^TMP(""DIERR"","_$J)  D  ;
 . S RCOUNT=RCOUNT+1,^TMP("RCRAW",$J,RCOUNT)=GLOB_" = "_@GLOB
 ;
 M ^TMP("RCFHIR",$J)=ARG
 S ^TMP("RCFHIR",$J,"ERRORMSG")=ERRMSG
 ;
 D ERRUPD^RCDPESR1(RCGBL,.RCD,RCTYPE,.RCERR)
 ;
 D PERROR^RCDPESR1(.RCERR,"G.RCDPE PAYMENTS EXCEPTIONS",RCD("MSG#"))
 ;
CLEAN ; Clean up temp globals and variables
 K ^TMP("RCERR",$J)
 K ^TMP("RCFHIR",$J)
 K ^TMP("RCRAW",$J)
 Q
