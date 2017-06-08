ICD182EN ; BAY/JAT - ENVIRONMENT CHECK; 9/17/01 3:32pm ; 10/16/01 2:18pm
 ;;18.0;DRG Grouper;**2**;Oct 13,2000
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
