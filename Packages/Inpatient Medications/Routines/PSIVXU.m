PSIVXU ;BIR/PR-SET MEDICATION SITES IN ^TMP("PSJUSER" ;15 May 98 / 9:27 AM
 ;;5.0;INPATIENT MEDICATIONS;**3,407**;16 DEC 97;Build 26
 N PSJNEW,PSGPTMP,PPAGE S PSJNEW=1
 S DONE=0  ;P407
 ;
 K XQUIT D ENCV^PSGSETU I $D(XQUIT) Q
 I $D(^TMP("PSJUSER",$J,"FLAG")) K ^TMP("PSJUSER",$J,"PSIV")  ;P407
 K ^TMP("PSJUSER",$J,"DSPFLAG")  ;P407
 S CHK=$S($D(^TMP("PSJUSER",$J,"PSIV")):1,1:"") S:CHK CHK=$S(^TMP("PSJUSER",$J,"PSIV")=DUZ:1,1:"") I 'CHK D ^PSIVSET Q:$D(XQUIT)!(DONE=1)  D SET Q   ;P407
 E  S PSIVSITE=^TMP("PSJUSER",$J,"PSIV","SITE"),PSIVPR=^TMP("PSJUSER",$J,"PSIV","PSIVPR"),PSIVPL=^TMP("PSJUSER",$J,"PSIV","PSIVPL"),PSIVSN=^TMP("PSJUSER",$J,"PSIV","PSIVSN")
 Q
SET ;Set TMP("PSJUSER" global
 S ^TMP("PSJUSER",$J,"PSIV")=DUZ,^TMP("PSJUSER",$J,"PSIV","SITE")=PSIVSITE,^TMP("PSJUSER",$J,"PSIV","PSIVPR")=PSIVPR,^TMP("PSJUSER",$J,"PSIV","PSIVPL")=PSIVPL,^TMP("PSJUSER",$J,"PSIV","PSIVSN")=PSIVSN
 Q
CHA ;Change site
 ; PSJ*407/RJH - Added KILL of TMP global node to line below in order for the
 ;               Change to Another IV Room functionality to work properly with
 ;               changes for PSJ*407
 ; K XQUIT D ^PSIVSET D:'$D(XQUIT) SET K %DT,XQUIT D ENIVKV^PSGSETU
 K XQUIT K ^TMP("PSJUSER",$J,"FLAG") D ^PSIVSET D:'$D(XQUIT) SET K %DT,XQUIT D ENIVKV^PSGSETU ; PSJ*407
 Q
