PRSXP59 ;WCIOFO/MJE-POST INIT FOR PATCH PRS*4*59 ;5/01/00
 ;;4.0;PAID;**59**;Sep 21, 1995
 ;
 ; Post install routine corrects descriptions of Followup codes
 ; 04 and 20 in PAID CODE FILE #454 
 ;
FIX ; Quit if patch has been previously installed
 I $$PATCH^XPDUTL("PRS*4.0*59") D  Q
 .D BMES^XPDUTL("     Post install routine skipped since PRS*4*59 was previously installed.")
 ;
 ;
 ; LOOK IN FILE 454 FIND PAID CODE 04 AND 20 AND CHANGE THEM
 ;
 D MES^XPDUTL("    BEGIN UPDATE OF PAID CODE FILE")
 D MES^XPDUTL("    ------------------------------")
 N DA,DR,DIE
 I '$D(^PRSP(454,1,"PUC","B","04")) D
 .D MES^XPDUTL("    PAID CODE 04 NOT FOUND!")
 .D MES^XPDUTL("    -----------------------")
 I $D(^PRSP(454,1,"PUC","B","04")) D
 .S DA=""
 .S DA=$O(^PRSP(454,1,"PUC","B","04",DA))
 .S DIE="^PRSP(454,1,""PUC"","
 .S DA(1)=1
 .S DR="1///2-YEAR PROB PERIOD INCEPTION"
 .D ^DIE
 .D MES^XPDUTL("    PAID CODE 04 UPDATED SUCCESSFULLY")
 .D MES^XPDUTL("    ---------------------------------")
 .K DA,DR,DIE
 I '$D(^PRSP(454,1,"PUC","B",20)) D
 .D MES^XPDUTL("    PAID CODE 20 NOT FOUND!")
 .D MES^XPDUTL("    -----------------------")
 I $D(^PRSP(454,1,"PUC","B",20)) D
 .S DA=""
 .S DA=$O(^PRSP(454,1,"PUC","B","20",DA))
 .S DIE="^PRSP(454,1,""PUC"","
 .S DA(1)=1
 .S DR="1///1-YEAR PROB PERIOD INCEPTION"
 .D ^DIE
 .D MES^XPDUTL("    PAID CODE 20 UPDATED SUCCESSFULLY")
 .D MES^XPDUTL("    ---------------------------------")
 D BMES^XPDUTL("    Please delete routine PRSXP59 when installation is complete.")
 Q
