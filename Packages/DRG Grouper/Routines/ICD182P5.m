ICD182P5 ;BAY/JAT - UPDATE DIAGS W/CC CODES ; 10/16/01 2:24pm
 ;;18.0;DRG Grouper;**2**;Oct 13,2000
 ;;
 ;; ICDCCFED looked at all the diagnoses listed in
 ;; Fed Reg that appear in Table 6G or 6H because 
 ;; their complications/comorbidities codes are affected;
 ;; it then found these diagnoses in the file from 3M
 ;; (after conversion from EBCDIC to ASCII via ICDZHSI)
 ;; along with all the complications/codes that now apply
 ;; to create the ^XTMP global.  This global file will be
 ;; sent to sites along with update routine ICD182P5.
 ;; This will accomplish what ICDZHSI1 used to do,
 ;; except that now it won't be necessary to ship
 ;; the ^ICD9 global.
 Q
 ; 
PRETRANS ; this is executed from the Pre-Transportation section of KIDS
 M @XPDGREF@("ICDCCFED")=^XTMP("ICDCCFED")
 Q
EN ; this is executed from the Post-Init section of KIDS
 D BMES^XPDUTL(">>>Updating Diagnoses w/complications/comorbidities")
 ;D BMES^XPDUTL(">>>Please verify that 48 Diagnoses updated")
 ;D BMES^XPDUTL("   and that ^TMP('ICD182P5' is empty")
 N DIAG,CNT,KFLAG,REC,X1,X2,AJ,DA1,DA2,TOT
 K ^TMP("ICD182P5",$J)
 M ^XTMP("ICDCCFED")=@XPDGREF@("ICDCCFED")
 S DIAG="",TOT=0
 F  S DIAG=$O(^XTMP("ICDCCFED",DIAG)) Q:DIAG="ERR"  D
 .S CNT=0,KFLAG=1,TOT=TOT+1
 .F  S CNT=$O(^XTMP("ICDCCFED",DIAG,CNT)) Q:'CNT  D
 ..S REC=$G(^XTMP("ICDCCFED",DIAG,CNT))
 ..S X1=$E(REC,1,5),X2=$E(REC,6,10)
 ..D CC
 ;D BMES^XPDUTL(">>> "_TOT_" diagnoses updated")
 Q
CC ;
 S AJ=X1 I AJ?.A S X1=$E(AJ,1,4)
 S AJ=X2 I AJ?.A S X2=$E(AJ,1,4) G CC1
 S AJ=X1 S:AJ["  " X1=$E(AJ,1,3)
 S AJ=X2 S:AJ["  " X2=$E(AJ,1,3)
CC1 S AJ=X1,X1=$E(AJ,1,3)_"."_$E(AJ,4,5) S:AJ'[" " X1=X1_" "
 S AJ=X2,X2=$E(AJ,1,3)_"."_$E(AJ,4,5) S:AJ'[" " X2=X2_" "
 S DA1=$O(^ICD9("AB",X1,0)),DA2=$O(^ICD9("AB",X2,0))
 I (DA1="")!(DA2="") S ^TMP("ICD182P5",$J,X1,X2)="" Q
 I KFLAG K ^ICD9(DA2,2) K ^ICD9("ACC",DA2) S KFLAG=0
 S:'$D(^ICD9(DA2,2)) ^ICD9(DA2,2,0)="^80.03P^0^0"
 S:$D(^ICD9(DA2,2,0)) FR=$P(^(0),U,3)+1,TO=$P(^(0),U,4)+1
 Q:$D(^ICD9("ACC",DA2,DA1))
 S ^ICD9(DA2,2,FR,0)=DA1,^ICD9(DA2,2,0)="^80.03P^"_FR_U_TO,^ICD9("ACC",DA2,DA1)=""
 Q
