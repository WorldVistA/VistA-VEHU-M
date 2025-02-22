ICD182P3 ;;ALB/EG/JAT - INACTIVATE/REVISE DIAG & PROC CODES ; 9/12/01 5:24pm
 ;;18.0;DRG Grouper;**2**;Oct 13,2000
 ;
 Q
 ;
CHGDIAG ; Inactivate Diagnoses (info taken from Fed Reg Table 6C)
 ; Revise titles of Diagnoses (info from Table 6E)
 ;;
 D BMES^XPDUTL(">>>Inactivating Diagnoses")
 N LINE,X,ICDDIAG,ENTRY,DA,DIE,DR,DIAG,DESC
 F LINE=1:1 S X=$T(INACT+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",ICDDIAG_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD9(",DR="100///1;102///100101"
 ..D ^DIE
 D BMES^XPDUTL(">>>Revising descriptions of Diagnoses")
 S LINE=1
 F  S X=$T(REVD+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD9("
 ..S DIAG=$P(ICDDIAG,U,2) I DIAG="" S DIAG=$P(ICDDIAG,U,3)
 ..S DESC=$P(ICDDIAG,U,3)
 ..S DR="3///"_DIAG_";10///"_DESC
 ..D ^DIE
 ..S LINE=LINE+1
 Q
INACT ; Inactive Diagnoses
 ;;256.3
 ;;464.0
 ;;521.0
 ;;525.1
 ;;564.0
 ;;772.1
 ;;793.8
 ;;E888.
 ;;E885.
 ;;EXIT
 Q
 ;
REVD ; Revise diagnoses/descriptions
 ;;411.81^AC CORONAR OCCL W/O MYO INFARC^ACUTE CORONARY OCCLUSION WITHOUT MYOCARDIAL INFARCTION
 ;;493.00^EXT ASTHMA W/O STAT ASTH/ACUTE^EXTRINSIC ASTHMA WITHOUT MENTION OF STATUS ASTHMATICUS OR ACUTE EXACERBATION OR UNSPECIFIED 
 ;;493.10^INT ASTHMA W/0 STAT ASTH/ACUTE^INTRINSIC ASTHMA WITHOUT MENTION OF STATUS ASTHMATICUS OR ACUTE EXACERBATION OR UNSPECIFIED
 ;;493.20^CHR OBS ASTHMA W/O STAT ASTH/A^CHRONIC OBSTRUCTIVE ASTHMA WITHOUT MENTION OF STATUS ASTHMATICUS OR ACUTE EXACERBATION OR UNSPECIFIED
 ;;493.90^ASTHMA UNSPEC W/O STATUS ASTH^ASTHMA, UNSPECIFIED WITHOUT MENTION OF STATUS ASTHMATICUS OR ACUTE EXACERBATION OR UNSPECIFIED
 ;;V70.7^EXAM IN CLINICAL TRIAL^EXAMINATION OF PARTICIPANT IN CLINICAL TRIAL
 ;;EXIT
 Q
 ;
CHGPROC ; Inactivate Procedures (info taken from Fed Reg Table 6D)
 ; Revise descriptions of Procedures ( info from Table 6F)
 D BMES^XPDUTL(">>>Inactivating Procedures")
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,PROC,DESC
 F LINE=1:1 S X=$T(INAC+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",ICDPROC_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD0(",DR="100///1;102///100101"
 ..D ^DIE
 D BMES^XPDUTL(">>>Revising descriptions of Procedures")
 S LINE=1
 F  S X=$T(REVP+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD0("
 ..S PROC=$P(ICDPROC,U,2) I PROC="" S PROC=$P(ICDPROC,U,3)
 ..S DESC=$P(ICDPROC,U,3)
 ..S DR="4///"_PROC_";10///"_DESC
 ..D ^DIE
 ..S LINE=LINE+1
 Q
 ;
INAC ; Inactive Procedures
 ;;67.5
 ;;81.09
 ;;EXIT
 Q
 ;
REVP ; Revise descriptions 
 ;;75.34^^OTHER FETAL MONITORING
 ;;EXIT
 Q
 ;
