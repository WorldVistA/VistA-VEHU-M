ICD185EN ;ALB/MRY - ENVIRONMENT CHECK; 9/17/02 3:32pm
 ;;18.0;DRG Grouper;**5**;Oct 13,2000
 ;;
EN ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 ;
 Q
 ;
PROGCHK(XPDABORT) ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 .Q
 Q
 ;
