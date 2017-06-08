ICD1820D ;;ALB/JAT - 2006 FY DRG GROUPER UPDATE; 7/27/05 14:50
 ;;18.0;DRG Grouper;**20**;Oct 13,2000
 ;
 ; DRG Reclassification
 Q
DRGRECL ;
 D BMES^XPDUTL(">>> Doing DRG Reclassification updates ...")
 D MCV
 D DRGTITLE
 D MISC
 Q
MCV ; update diagnoses with new or additional identifiers
 ; c or s = DRGs 547 thru 558 (see MCV^ICDTLB6B)
 ; 6 = DRG 546
 N LINE,X,ICDDIAG,ENTRY,IDENT,DA,DIE,DR,DUPE
 F LINE=1:1 S X=$T(DXID+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0)) I ENTRY D
 ..; check for any dupe (some are in MNTVBB)
 ..S DUPE=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",ENTRY)) I DUPE Q
 ..S IDENT=$P($G(^ICD9(ENTRY,0)),U,2)
 ..; check if already there in case patch is being re-installed
 ..I IDENT["c" Q
 ..I IDENT["s" Q
 ..I IDENT["6" Q
 ..S IDENT=IDENT_$P(ICDDIAG,U,2)
 ..S DA=ENTRY,DIE="^ICD9("
 ..S DR="2///^S X=IDENT"
 ..D ^DIE
 Q
DRGTITLE ; modify titles of DRGs
 N LINE,X,ICDDRG,DESC,DA,DIE,DR
 F LINE=1:1 S X=$T(TITLE+LINE) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  D
 .S DESC=$P(ICDDRG,U,2)
 .S DA(1)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(1)_",1,"
 .S DR=".01///^S X=DESC"
 .D ^DIE
 .S DA(2)=$P(ICDDRG,U)
 .S DA(1)=1
 .S DA=1
 .S DIE="^ICD("_DA(2)_",68,"_DA(1)_",1,"
 .S DR=".01///^S X=DESC"
 .D ^DIE
 Q
MISC ; create field #71 entries for pro codes (see patch description) 
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,MDC24,SUBLINE,DATA,FDA
 F LINE=1:1 S X=$T(REVP+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..S MDC24=$P(ICDPROC,U,3)
 ..S DR="2///^S X=IDENT;5///^S X=MDC24"
 ..D ^DIE
 ..;add 80.171 and 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S X=$T(REVP+LINE+SUBLINE) S DATA=$P(X,";;",2) Q:DATA'["+"  D
 ...; check if already created in case patch being re-installed
 ...I $D(^ICD0(ENTRY,2,"B",3051001)) Q
 ...S DATA=$E(DATA,2,99)
 ...I SUBLINE=1 D
 ....S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ....S FDA(1820,80.171,"+2,?1,",.01)=3051001
 ....D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3051001
 ...S FDA(1820,80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3051001
 ...S FDA(1820,80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S FDA(1820,80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...I $P(DATA,U,3) S FDA(1820,80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...I $P(DATA,U,4) S FDA(1820,80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...I $P(DATA,U,5) S FDA(1820,80.17111,"+7,?3,?2,?1,",.01)=$P(DATA,U,5)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
DXID ;
 ;;398.91^c
 ;;402.01^c
 ;;402.11^c
 ;;402.91^c
 ;;404.01^c
 ;;404.03^c
 ;;404.11^c
 ;;404.13^c
 ;;404.91^c
 ;;404.93^c
 ;;410.01^c
 ;;410.11^c
 ;;410.21^c
 ;;410.31^c
 ;;410.41^c
 ;;410.51^c
 ;;410.61^c
 ;;410.71^c
 ;;410.81^c
 ;;410.91^c
 ;;411.0^c
 ;;414.10^c
 ;;414.11^c
 ;;414.12^c
 ;;414.19^c
 ;;415.0^c
 ;;415.11^s
 ;;415.19^s
 ;;420.0^c
 ;;420.90^c
 ;;420.91^c
 ;;420.99^c
 ;;421.0^c
 ;;421.1^c
 ;;421.9^c
 ;;422.92^c
 ;;423.0^c
 ;;424.90^c
 ;;427.1^c
 ;;427.41^c
 ;;427.5^c
 ;;428.0^c
 ;;428.1^c
 ;;428.20^c
 ;;428.21^c
 ;;428.22^c
 ;;428.23^c
 ;;428.30^c
 ;;428.31^c
 ;;428.32^c
 ;;428.33^c
 ;;428.40^c
 ;;428.41^c
 ;;428.42^c
 ;;428.43^c
 ;;428.9^c
 ;;429.5^c
 ;;429.6^c
 ;;429.71^c
 ;;429.79^c
 ;;429.81^c
 ;;430.^s
 ;;431.^s
 ;;432.0^s
 ;;432.1^s
 ;;432.9^s
 ;;433.01^s
 ;;433.11^s
 ;;433.21^s
 ;;433.31^s
 ;;433.81^s
 ;;433.91^s
 ;;434.00^s
 ;;434.01^s
 ;;434.10^s
 ;;434.11^s
 ;;434.90^s
 ;;434.91^s
 ;;436.^s
 ;;441.00^c
 ;;441.01^c
 ;;441.02^c
 ;;441.03^c
 ;;441.1^c
 ;;441.3^c
 ;;441.5^c
 ;;441.6^c
 ;;443.22^c
 ;;443.29^c
 ;;444.0^c
 ;;444.1^c
 ;;445.81^s
 ;;453.2^c
 ;;785.50^c
 ;;785.51^c
 ;;861.02^c
 ;;861.03^c
 ;;861.10^c
 ;;861.11^c
 ;;861.12^c
 ;;861.13^c
 ;;862.9^s
 ;;996.61^c
 ;;996.62^c
 ;;996.72^c
 ;;996.83^c
 ;;170.2^6
 ;;198.5^6
 ;;213.2^6
 ;;238.0^6
 ;;239.2^6
 ;;732.0^6
 ;;733.13^6
 ;;737.0^6
 ;;737.10^6
 ;;737.11^6
 ;;737.12^6
 ;;737.19^6
 ;;737.20^6
 ;;737.21^6
 ;;737.22^6
 ;;737.29^6
 ;;737.30^6
 ;;737.31^6
 ;;737.32^6
 ;;737.33^6
 ;;737.34^6
 ;;737.39^6
 ;;737.8^6
 ;;737.9^6
 ;;754.2^6
 ;;756.51^6
 ;;EXIT
 Q
TITLE ;
 ;;541^ECMO OR TRACH W/MV 96+ HRS OR PDX EXC FACE,MOUTH,& NECK W/MAJOR OR
 ;;542^TRACH W/MV 96+ HRS OR PDX EXC FACE,MOUTH,& NECK W/O MAJOR OR
 ;;14^INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION
 ;;315^OTHER KIDNEY & URINARY TRACT PROCEDURES
 ;;276^NON-MALIGNANT BREAST DISORDERS
 ;;EXIT
 Q
REVP ;
 ;;99.10^^
 ;;+1^559
 ;;35.52^Oo^
 ;;+5^518
 ;;81.51^OM^2
 ;;+8^471^544
 ;;81.52^OM^2
 ;;+8^471^544
 ;;81.53^OM^2
 ;;+8^471^545
 ;;81.54^OM^3
 ;;+8^471^544
 ;;81.55^OM^3
 ;;+8^471^545
 ;;81.56^OM^3
 ;;+8^471^544
 ;;84.26^O^2
 ;;+8^544
 ;;84.27^O^2
 ;;+8^544
 ;;84.28^O^2
 ;;+8^544
 ;;EXIT
 Q 
