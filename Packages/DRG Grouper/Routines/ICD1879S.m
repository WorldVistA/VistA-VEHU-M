ICD1879S ;ALB/JDG - UPDATE DX & PX CODES ; 10/5/11 3:23pm
 ;;18.0;DRG Grouper;**79**;Oct 20, 2000;Build 6
 ;
 Q
 ;
 ; Update Px code(s)
ICDUPDPX ; update the IDENTIFIER (#1.2) field
 D BMES^XPDUTL(">>>Modify existing procedure codes - file 80.1")
 N ICDLINE,ICDX,ICDPROC,ICDENTRY,ICDTXTFP,ICDTXTSP
 F ICDLINE=1:1 S ICDX=$T(PROCUP1+ICDLINE) S ICDPROC=$P(ICDX,";;",2),ICDTXTFP=$P(ICDPROC,"^",1),ICDTXTSP=$P(ICDPROC,"^",2) Q:ICDPROC="EXIT"  D
 .S ICDENTRY=+$O(^ICD0("BA",""_ICDTXTFP_" "_"",0))
 .D:'ICDENTRY BMES^XPDUTL(">>>Unable to find procedure code "_ICDTXTFP_" in file 80.1 <<<")
 .I ICDENTRY D
 ..S DA=ICDENTRY
 ..S DIE="^ICD0("
 ..S DR="1.2///^S X=ICDTXTSP"
 ..D ^DIE
 Q
 ;
ICDUPPX1 ; update the MAJOR O.R. PROCEDURE (#20) field
 D BMES^XPDUTL(">>>update procedure codes field MAJOR O.R. PROCEDURE (#20) - file 80.1")
 N ICDLINE,ICDX,ICDPROC,ICDENTRY,ICDTXTFP,ICDTXTSP
 F ICDLINE=1:1 S ICDX=$T(PROCUP3+ICDLINE) S ICDPROC=$P(ICDX,";;",2),ICDTXTFP=$P(ICDPROC,"^",1),ICDTXTSP=$P(ICDPROC,"^",2) Q:ICDPROC="EXIT"  D
 .S ICDENTRY=+$O(^ICD0("BA",""_ICDTXTFP_" "_"",0))
 .D:'ICDENTRY BMES^XPDUTL(">>>Unable to find procedure code "_ICDTXTFP_" in file 80.1 <<<")
 .I ICDENTRY D
 ..S DA=ICDENTRY
 ..S DIE="^ICD0("
 ..S DR="20///^S X=ICDTXTSP"
 ..D ^DIE
 Q
 ;
 ; Update Dx code(s)
ICDUPDDX ; update the IDENTIFIER (#1.2) field
 D BMES^XPDUTL(">>>Modify existing diagnosis codes - file 80")
 N ICDLINE,ICDX,ICDDIAG,ICDENTRY,ICDTXTFP,ICDTXTSP
 F ICDLINE=1:1 S ICDX=$T(PROCUP2+ICDLINE) S ICDDIAG=$P(ICDX,";;",2),ICDTXTFP=$P(ICDDIAG,"^",1),ICDTXTSP=$P(ICDDIAG,"^",2) Q:ICDDIAG="EXIT"  D
 .S ICDENTRY=+$O(^ICD9("BA",""_ICDTXTFP_" "_"",0))
 .D:'ICDENTRY BMES^XPDUTL(">>>Unable to find diagnosis code "_ICDTXTFP_" in file 80 <<<")
 .I ICDENTRY D
 ..S DA=ICDENTRY
 ..S DIE="^ICD9("
 ..S DR="1.2///^S X=ICDTXTSP"
 ..D ^DIE
 Q
 ;
 ;Update Px code(s)
UPDTADRG ; update existing operation/procedure codes 
 D BMES^XPDUTL(">>>Modify existing procedure codes - file 80.1")
 N ICDLINE,ICDX,ICDPROC,ENTRY,SUBLINE,DATA,ICDFDA
 F ICDLINE=1:1 S ICDX=$T(PROCUP4+ICDLINE) S ICDPROC=$P(ICDX,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",""_ICDPROC_" "_"",0))
 .I ENTRY D
 ..; check if already created in case patch being re-installed
 ..Q:$D(^ICD0(ENTRY,2,"B",3141001))
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S ICDX=$T(PROCUP5+SUBLINE) S DATA=$P(ICDX,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ....S ICDFDA(80.171,"+2,?1,",.01)=3121001
 ....D UPDATE^DIE("","ICDFDA") K ICDFDA
 ...S DATA=$E(DATA,2,99)
 ...S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ...S ICDFDA(80.171,"?2,?1,",.01)=3121001
 ...S ICDFDA(80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","ICDFDA") K ICDFDA
 ...S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ...S ICDFDA(80.171,"?2,?1,",.01)=3121001
 ...S ICDFDA(80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S ICDFDA(80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...S ICDFDA(80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
 ;
INACTDRG ;
 N LINE,ICDX,ICDDRG,DESC,DA,DIE,DR,MDC,SURG,ICDFDA
 D BMES^XPDUTL(">>> Inactivating DRG(s)...")
 F LINE=1:1 S ICDX=$T(INAC+LINE) S ICDDRG=$P(ICDX,";;",2) Q:ICDDRG="EXIT"  D
 .S DESC="NO LONGER VALID"
 .S DA(LINE)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(LINE)_",1,"
 .S DR=".01///^S X=DESC"
 .D ^DIE
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD($P(ICDDRG,U),66,"B",3141001))
 .; add entry to 80.266
 .S MDC=$P(ICDDRG,U,2)
 .S SURG=$P(ICDDRG,U,3)
 .S ICDDRG=$P(ICDDRG,U)
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.266,"+2,?1,",.01)=3141001
 .S ICDFDA(80.266,"+2,?1,",.03)=0
 .S ICDFDA(80.266,"+2,?1,",.05)=MDC
 .S ICDFDA(80.266,"+2,?1,",.06)=SURG
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .; add entry to 80.268 and 80.2681 
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"+2,?1,",.01)=3141001
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.2681,"?2,?1,",.01)=3141001
 .S ICDFDA(80.2681,"+3,?2,?1,",.01)=DESC
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
 ; 
 ;
 ;
PROCUP1 ; updating the IDENTIFIER (#1.2) field for the following Procedure codes
 ;;44.99^Ox
 ;;37.74^7Pp
 ;;EXIT
 ;
 ;
PROCUP2 ; updating the IDENTIFIER (#1.2) field for the following Diagnosis codes
 ;;398.91^AZc
 ;;288.60^k
 ;;EXIT
 ;
 ;
PROCUP3 ; updating the MAJOR O.R. PROCEDURE (#20) field for the following Procedure codes
 ;;39.65^A
 ;;31.29^2
 ;;31.1^@
 ;;EXIT
 ;
 ;
PROCUP4 ; update the following ICD OPERARTION/PROCEDURE codes with related DRGs
 ;;76.76
 ;;76.74
 ;;76.79
 ;;76.92
 ;;EXIT
 ;
 ;
PROCUP5 ;
 ;;+3^131^132
 ;;EXIT
 ;
 ;
INAC ;DRG^MDC^SURG (1=surg, 0=med)
 ;;484^8^1
 ;;EXIT
