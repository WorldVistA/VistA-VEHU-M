ICD1856C ;ALB/MJB - YEARLY DRG UPDATE;8/9/2010
 ;;18.0;DRG Grouper;**56**;Oct 13, 2000;Build 18
 ;
 Q
 ;       
PRO ;-update operation/procedure codes
 ; from Table 6B in Fed Reg - assumes new codes already added by Lexicon
 D BMES^XPDUTL(">>>Modifying new op/pro codes - file 80.1")
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,MDC24,SUBLINE,DATA,FDA
 F LINE=1:1 S X=$T(REV+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .; check if already created in case patch being re-installed
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I $D(^ICD0(ENTRY,2,"B",3111001)) D
 ..;kill existing entry for FY
 .. S DA(1)=ENTRY,DA=$O(^ICD0(ENTRY,2,"B",3111001,0))
 .. S DIK="^ICD0("_DA(1)_",2," D ^DIK K DIK,DA
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..S MDC24=$P(ICDPROC,U,3)
 ..S DR="2///^S X=IDENT;5///^S X=MDC24"
 ..;I IDENT=""&(MDC24="") Q
 ..D ^DIE
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S X=$T(REV+LINE+SUBLINE) S DATA=$P(X,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ....S FDA(1820,80.171,"+2,?1,",.01)=3111001
 ....D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S DATA=$E(DATA,2,99)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3111001
 ...S FDA(1820,80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3111001
 ...S FDA(1820,80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S FDA(1820,80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...I $P(DATA,U,3) S FDA(1820,80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...I $P(DATA,U,4) S FDA(1820,80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...I $P(DATA,U,5) S FDA(1820,80.17111,"+7,?3,?2,?1,",.01)=$P(DATA,U,5)
 ...I $P(DATA,U,6) S FDA(1820,80.17111,"+8,?3,?2,?1,",.01)=$P(DATA,U,6)
 ...I $P(DATA,U,7) S FDA(1820,80.17111,"+9,?3,?2,?1,",.01)=$P(DATA,U,7)
 ...I $P(DATA,U,8) S FDA(1820,80.17111,"+10,?3,?2,?1,",.01)=$P(DATA,U,8)
 ...I $P(DATA,U,9) S FDA(1820,80.17111,"+11,?3,?2,?1,",.01)=$P(DATA,U,9)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
 ;  
REV ; PROC/OP^IDENTIFIER^
    ; +MDC^DRG
 ;;02.21^KOS^
 ;;+1^23^24^25^26^27
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^955
 ;;02.22^KOS^
 ;;+1^23^24^25^26^27
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^955
 ;;12.67^O^
 ;;+2^116^117
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.53^O^
 ;;+1^34^35^36^37^38^39
 ;;+5^252^253^254
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.54^KO^
 ;;+1^23^24^25^26^27
 ;;+5^252^253^254
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.55^O^
 ;;+5^231^232^246^247^248^249^250^251
 ;;17.56^O^
 ;;+1^37^38^39
 ;;+4^166^167^168
 ;;+5^252^253^254
 ;;+6^356^357^358
 ;;+7^423^424^425
 ;;+8^515^516^517
 ;;+9^579^580^581
 ;;+10^628^629^630
 ;;+11^673^674^675
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.81^^
 ;;35.05^OP^
 ;;+5^216^217^218^219^220^221
 ;;35.06^OP^
 ;;+5^216^217^218^219^220^221
 ;;35.07^OP^
 ;;+5^216^217^218^219^220^221
 ;;35.08^OP^
 ;;+5^216^217^218^219^220^221
 ;;35.09^OP^
 ;;+5^216^217^218^219^220^221
 ;;38.26^O^
 ;;+5^264
 ;;39.77^KOQ^
 ;;+1^37^38^39
 ;;+5^252^253^254
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;39.78^KO^
 ;;+5^252^253^254
 ;;+24^957^958^959
 ;;43.82^O^
 ;;+5^264
 ;;+6^326^327^328
 ;;+10^619^620^621
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;68.24^O^
 ;;+13^749^750
 ;;68.25^O^
 ;;+13^749^750
 ;;EXIT
