ORWRP1A ;SLC/DCM - REPORT CALLS CONTINUED ; Apr 14, 2025@13:50:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,160,350,618,586**;Dec 17, 1997;Build 5
 ;
 ; Reference to EN^LR7OSUM in ICR# 2766
 ; Reference to RPC^PSBO in ICR# 3955
 ; Reference to ^XLFDT in ICR# 10103
 ; Reference to $$GET^XPAR in ICR# 2263
 ;
BCMA1(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ;BCMA Med Log
 Q:'$G(ORDFN)
 I $L($G(DTRANGE)),'$G(ALPHA) S ALPHA=$$FMADD^XLFDT(DT,-DTRANGE),OMEGA=$$NOW^XLFDT
 Q:'$G(ALPHA)  Q:'$G(OMEGA)
 I $L($T(RPC^PSBO)) D RPC^PSBO(.OROOT,"ML",ORDFN,ALPHA,OMEGA,"0^0^0^0^1^1")
 I '$L($G(OROOT)) Q
 I '$O(@OROOT@(0)) S @OROOT@(1)="",@OROOT@(2)="No report available..."
 S @OROOT@(1)="***REPORT NOT DESIGNED TO BE PRINTED***"
 Q
BCMA2(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ;BCMA MAH Report
 Q:'$G(ORDFN)
 I $L($G(DTRANGE)),'$G(ALPHA) S ALPHA=$$FMADD^XLFDT(DT,-DTRANGE),OMEGA=$$NOW^XLFDT
 Q:'$G(ALPHA)  Q:'$G(OMEGA)
 I $L($T(RPC^PSBO)) D RPC^PSBO(.OROOT,"MH",ORDFN,ALPHA,OMEGA,"")
 I '$L($G(OROOT)) Q
 I '$O(@OROOT@(0)) S @OROOT@(1)="",@OROOT@(2)="No report available..."
 S @OROOT@(1)="***REPORT NOT DESIGNED TO BE PRINTED***"
 Q
OTP(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ;OTP Dispense Report
 Q:'$G(ORDFN)
 I $L($G(DTRANGE)),'$G(ALPHA) S ALPHA=$$FMADD^XLFDT(DT,-DTRANGE),OMEGA=$$NOW^XLFDT
 Q:'$G(ALPHA)  Q:'$G(OMEGA)
 D EN^ORDOTP(.OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,.REMOTE,.ORMAX,.ORFHIE)
 I '$L($G(OROOT)) Q
 I '$O(@OROOT@(0)) S @OROOT@(1)="",@OROOT@(2)="No report available..."
 K ^TMP("OR OTP",$J,"WEEKS"),^TMP("OR OTP",$J,"OTPREC")
 Q
EM(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ; -- get Electron Microscopy Report
 N I,C,LINES,X,ORSBHEAD,ORZIP
 K ^TMP("LRC",$J),^TMP("LRH",$J)
 S ORSBHEAD("EM")=""
 D EN^LR7OSUM(.ORZIP,ORDFN,,,,80,.ORSBHEAD)
 I '$O(^TMP("LRC",$J,0)) S ^TMP("LRC",$J,1,0)="",^TMP("LRC",$J,2,0)="No EM reports available..."
 S OROOT=$NA(^TMP("LRC",$J))
 K ^TMP("LRH",$J)
 Q
CY(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ; -- get Cytology Report
 N I,C,LINES,X,ORSBHEAD,ORZIP
 K ^TMP("LRC",$J),^TMP("LRH",$J)
 S ORSBHEAD("CYTOPATHOLOGY")=""
 D EN^LR7OSUM(.ORZIP,ORDFN,,,,80,.ORSBHEAD)
 I '$O(^TMP("LRC",$J,0)) S ^TMP("LRC",$J,1,0)="",^TMP("LRC",$J,2,0)="No Cytology reports available..."
 S OROOT=$NA(^TMP("LRC",$J))
 K ^TMP("LRH",$J)
 Q
SP(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ; -- get Surgical Pathology Report
 N I,C,LINES,X,ORSBHEAD,ORZIP
 K ^TMP("LRC",$J),^TMP("LRH",$J)
 S ORSBHEAD("SURGICAL PATHOLOGY")=""
 D EN^LR7OSUM(.ORZIP,ORDFN,,,,80,.ORSBHEAD)
 I '$O(^TMP("LRC",$J,0)) S ^TMP("LRC",$J,1,0)="",^TMP("LRC",$J,2,0)="No Surgical Pathology reports available..."
 S OROOT=$NA(^TMP("LRC",$J))
 K ^TMP("LRH",$J)
 Q
AU(OROOT,ORDFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ; -- get Autopsy Report
 N I,C,LINES,X,ORSBHEAD,ORZIP
 K ^TMP("LRC",$J),^TMP("LRH",$J)
 S ORSBHEAD("AUTOPSY")=""
 D EN^LR7OSUM(.ORZIP,ORDFN,,,,80,.ORSBHEAD)
 I '$O(^TMP("LRC",$J,0)) S ^TMP("LRC",$J,1,0)="",^TMP("LRC",$J,2,0)="No Autopsy report available..."
 S OROOT=$NA(^TMP("LRC",$J))
 K ^TMP("LRH",$J)
 Q
RADIO(OROOT) ; -- get value of OR REPORT DATE SELECT TYPE parameter
 S OROOT=$$GET^XPAR("DIV^SYS^PKG","OR REPORT DATE SELECT TYPE",1,"Q")
 Q
