SDESGETPATINQUIR ;ALB/BLB,JAS - SDES GET PATIENT INQUIRY ;Apr 18, 2024
 ;;5.3;Scheduling;**842,877**;Aug 13, 1993;Build 14
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
GETINQUIRY(JSONRETURN,DFN) ;
 N ERRORS,RETURN,DETAILS,TMPRETURN,ORDA,ORDAS
 I '$$VALIDATEDFN(.ERRORS,$G(DFN)) M RETURN=ERRORS D BUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 K ^TMP("ORDATA",$J)
 D PTINQ^ORWPT(.TMPRETURN,DFN)
 ; Remove all but Last Four of SSN
 S ORDA=0
 F  S ORDA=$O(^TMP("ORDATA",$J,ORDA)) Q:'ORDA  I $D(^TMP("ORDATA",$J,ORDA)) D
 . S ORDAS=0
 . F  S ORDAS=$O(^TMP("ORDATA",$J,ORDA,ORDAS)) Q:'ORDAS  I $L(^TMP("ORDATA",$J,ORDA,ORDAS)) D
 . . N ORLINE S ORLINE=^TMP("ORDATA",$J,ORDA,ORDAS)
 . . I ORLINE?.E3N1"-"2N1"-"4N.E D
 . . . S ^TMP("ORDATA",$J,ORDA,ORDAS)=$E(ORLINE,1,$L($P(ORLINE,"-"))-3)_$P(ORLINE,"-",3)
 ;
 M DETAILS("PatientInquiryDetails")=^TMP("ORDATA",$J)
 ;
 I '$D(DETAILS) S DETAILS("PatientInquiryDetails",1)=""
 M RETURN=DETAILS D BUILDJSON(.JSONRETURN,.RETURN)
 Q
 ;
VALIDATEDFN(ERRORS,DFN) ;
 I DFN="" D ERRLOG^SDESJSON(.ERRORS,1) Q 0
 I DFN'="",'$D(^DPT(DFN,0)) D ERRLOG^SDESJSON(.ERRORS,2) Q 0
 Q 1
 ;
BUILDJSON(JSONRETURN,RETURN) ;
 N JSONERR
 D ENCODE^XLFJSON("RETURN","JSONRETURN","JSONERR")
 Q
 ;
