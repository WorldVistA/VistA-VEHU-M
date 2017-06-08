ICD1820E ;;ALB/JAT - 2006 FY DRG GROUPER UPDATE; 7/27/05 14:50
 ;;18.0;DRG Grouper;**20**;Oct 13,2000
 ;
 ; fix latest tickets
 Q
 ;
REMEDY ;
 D BMES^XPDUTL("...Repairing Remedy tickets...")
 ; HD102030
 ; modify Identifier field (#2) in file 80.1 - add a "B" for bone marrow
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,DIC
 F LINE=1:1 S X=$T(REVID+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..S DR="2///^S X=IDENT"
 ..D ^DIE
 ;
 ; HD97884
 ; change MDC from 1 to 18 for diags 995.90 thru 995.94
 F X=13722,13723,13724,13725,13726 D
 .S DA=X,DIE="^ICD9(",IDENT=18
 .S DR="5///^S X=IDENT"
 .D ^DIE
 ; kill 80.071, 80.711 and 80.072 subfile records for diags 995.90 thru 995.94
 N X,DA,DIK
 F X=13722,13723,13724,13725,13726 D
 .S DA(1)=X
 .S DA=2
 .S DIK="^ICD9("_DA(1)_",""3"","
 .D ^DIK
 .S DIK="^ICD9("_DA(1)_",""4"","
 .D ^DIK
 ;
 ; HD 106613
 ; routine ICDDRG changed - no code set changes
 ; 
 ; HD 107571
 ; add additional MDCs and associated DRGs for new op/pro codes from last year (FY 2005)
PRO ;
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,MDC24,SUBLINE,DATA,FDA
 F LINE=1:1 S X=$T(REVP+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..;this is from the OR column in Table 6B - the Y translates to the letter O (OR) 
 ..I IDENT="Y" S IDENT="O"
 ..I DA=4254 S IDENT="OK"
 ..I DA=4215!(DA=4216) S IDENT="Oz"
 ..S MDC24=$P(ICDPROC,U,3)
 ..S DR="2///^S X=IDENT;5///^S X=MDC24"
 ..D ^DIE
 ..; add 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S X=$T(REVP+LINE+SUBLINE) S DATA=$P(X,";;",2) Q:DATA'["+"  D
 ...S DATA=$E(DATA,2,99)
 ...; check if already created in case patch being re-installed
 ...I $D(^ICD0(ENTRY,2,1,1,"B",$P(DATA,U))) Q
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3041001
 ...S FDA(1820,80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3041001
 ...S FDA(1820,80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S FDA(1820,80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...I $P(DATA,U,3) S FDA(1820,80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...I $P(DATA,U,4) S FDA(1820,80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...I $P(DATA,U,5) S FDA(1820,80.17111,"+7,?3,?2,?1,",.01)=$P(DATA,U,5)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ;
 ; HD 112348 - add identifier "1" to Dx 852.06
 S DA=6391
 S DIE="^ICD9("
 S IDENT=1
 S DR="2///^S X=IDENT"
 D ^DIE
 Q
REVID ;
 ;;41.04^OB
 ;;41.05^OB
 ;;41.06^OB
 ;;41.07^OB
 ;;41.08^OB
 ;;41.09^OB
 ;;EXIT
 ;;
REVP ;
 ;;00.61^Y^2
 ;;+21^442^443
 ;;+24^486
 ;;00.62^Y^2
 ;;+1^533^534
 ;;+21^442^443
 ;;+24^486
 ;;44.38^Y^
 ;;+5^120
 ;;+7^201
 ;;+10^288
 ;;+17^406^407^539^540
 ;;44.67^Y^2
 ;;+21^442^443
 ;;+24^486
 ;;44.68^Y^2
 ;;+10^288
 ;;+21^442^443
 ;;+24^486
 ;;81.65^Y^2
 ;;+21^442^443
 ;;+24^486
 ;;81.66^Y^2
 ;;+21^442^443
 ;;+24^486
 ;;84.59^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.60^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.61^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.62^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.63^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.64^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.65^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.66^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.67^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.68^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;84.69^Y^2
 ;;+1^531^532
 ;;+21^442^443
 ;;+24^486
 ;;EXIT
 ;
       
                         
