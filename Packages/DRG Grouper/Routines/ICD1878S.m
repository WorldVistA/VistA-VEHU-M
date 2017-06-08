ICD1878S ;ALB/JDG - UPDATE DX & PX CODES ; 10/5/11 3:23pm
 ;;18.0;DRG Grouper;**78**;Oct 20, 2000;Build 15
 ;
 Q
 ;
 ; Update Px code(s)
ICDUPDPX ; update the IDENTIFIER (#1.2) field
 D BMES^XPDUTL(">>>Modify existing procedure codes - file 80.1")
 N LINE,ICDX,ICDPROC,ICDENTRY,ICDTXTFP,ICDTXTSP
 F LINE=1:1 S ICDX=$T(PROCUP1+LINE) S ICDPROC=$P(ICDX,";;",2),ICDTXTFP=$P(ICDPROC,"^",1),ICDTXTSP=$P(ICDPROC,"^",2) Q:ICDPROC="EXIT"  D
 .S ICDENTRY=+$O(^ICD0("BA",""_ICDTXTFP_" "_"",0))
 .D:'ICDENTRY BMES^XPDUTL(">>>Unable to find procedure code "_ICDTXTFP_" in file 80.1 <<<")
 .I ICDENTRY D
 ..S DA=ICDENTRY
 ..S DIE="^ICD0("
 ..S DR="1.2///^S X=ICDTXTSP"
 ..D ^DIE
 Q
 ;
ICDUPPX1 ; update the MDC24 (#1.5) field
 D BMES^XPDUTL(">>>update the MDC24 (#1.5) field of existing procedure codes - file 80.1")
 N LINE,ICDX,ICDPROC,ICDENTRY,ICDTXTFP,ICDTXTSP
 F LINE=1:1 S ICDX=$T(PROCUP3+LINE) S ICDPROC=$P(ICDX,";;",2),ICDTXTFP=$P(ICDPROC,"^",1),ICDTXTSP=$P(ICDPROC,"^",2) Q:ICDPROC="EXIT"  D
 .S ICDENTRY=+$O(^ICD0("BA",""_ICDTXTFP_" "_"",0))
 .D:'ICDENTRY BMES^XPDUTL(">>>Unable to find procedure code "_ICDTXTFP_" in file 80.1 <<<")
 .I ICDENTRY D
 ..S DA=ICDENTRY
 ..S DIE="^ICD0("
 ..S DR="1.5///^S X=ICDTXTSP"
 ..D ^DIE
 Q
 ;
 ; Update Dx code(s)
ICDUPDDX ; update the IDENTIFIER (#1.2) field
 D BMES^XPDUTL(">>>Modify existing diagnosis codes - file 80")
 N LINE,ICDX,ICDDIAG,ICDENTRY,ICDTXTFP,ICDTXTSP
 F LINE=1:1 S ICDX=$T(PROCUP2+LINE) S ICDDIAG=$P(ICDX,";;",2),ICDTXTFP=$P(ICDDIAG,"^",1),ICDTXTSP=$P(ICDDIAG,"^",2) Q:ICDDIAG="EXIT"  D
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
 N LINE,ICDX,ICDPROC,ENTRY,SUBLINE,DATA,ICDFDA
 F LINE=1:1 S ICDX=$T(PROCUP4+LINE) S ICDPROC=$P(ICDX,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",""_ICDPROC_" "_"",0))
 .I ENTRY D
 ..; check if already created in case patch being re-installed
 ..Q:$D(^ICD0(ENTRY,2,"B",3141001))
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S ICDX=$T(PROCUP5+SUBLINE) S DATA=$P(ICDX,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ....S ICDFDA(80.171,"+2,?1,",.01)=3141001
 ....D UPDATE^DIE("","ICDFDA") K ICDFDA
 ...S DATA=$E(DATA,2,99)
 ...S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ...S ICDFDA(80.171,"?2,?1,",.01)=3141001
 ...S ICDFDA(80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","ICDFDA") K ICDFDA
 ...S ICDFDA(80.1,"?1,",.01)="`"_ENTRY
 ...S ICDFDA(80.171,"?2,?1,",.01)=3141001
 ...S ICDFDA(80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S ICDFDA(80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...S ICDFDA(80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...D UPDATE^DIE("","ICDFDA") K ICDFDA
 Q
 ;
 ;
PROCUP1 ; updating the IDENTIFIER (#1.2) field for the following Procedure codes
 ;;86.04^x
 ;;60.21^Oy
 ;;84.81^O
 ;;34.06^O
 ;;51.23^OTz
 ;;64.92^Oz
 ;;34.91^O
 ;;99.04^@
 ;;EXIT
 ;
 ;
PROCUP2 ; updating the IDENTIFIER (#1.2) field for the following Diagnosis codes
 ;;649.11^D
 ;;649.41^D
 ;;655.71^v
 ;;755.59^S
 ;;508.2^j
 ;;518.0^HJVCj
 ;;518.51^j
 ;;518.52^j
 ;;942.33^b*
 ;;EXIT
 ;
 ;
PROCUP3 ; updating the MDC24 (#1.5) field for the following Procedure codes
 ;;39.79^3
 ;;EXIT
 ;
 ;
PROCUP4 ; update the following ICD OPERARTION/PROCEDURE codes with related DRGs
 ;;35.05
 ;;35.06
 ;;35.07
 ;;35.08
 ;;35.09
 ;;EXIT
 ;
 ;
PROCUP5 ;
 ;;+5^266^267
 ;;EXIT
