ECX3P190 ;ALB/TJL - DSS FY2025 Conversion, Post-init ;4/10/24  10:54
 ;;3.0;DSS EXTRACTS;**190**;Dec 22, 1997;Build 36
 ;
POST ;Post-install items
 D TEST ;Set testing site information
 D MENU ;update menus
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2025")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
MENU ;update menus
 N DA,DIE,DR,MENU,OPTION,CHECK,CHOICE,SYN,ORD,TYPE,OFF,UPDATE
 ;S TYPE="MENUDEL" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 ;.S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2)
 ;.S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 ;.D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 S TYPE="MENUADD" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 .S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2),SYN=$P(CHOICE,"^",3),ORD=$P(CHOICE,"^",4)
 .S CHECK=$$ADD^XPDMENU(MENU,OPTION,SYN,ORD)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION"_$S('CHECK:" NOT",1:"")_" ADDED TO "_MENU_" <<<")
 ;S OPTION=$$LKOPT^XPDMENU("ECX SOURCE AUDITS") Q:'+OPTION
 ;S UPDATE(19,OPTION_",",1)="Extract Audit Reports"
 ;D FILE^DIE("","UPDATE")
 ;D BMES^XPDUTL("Source Audit menu text updated")
 Q
 ;
MENUDEL ;Menu items to be deleted
 ;;ECX SETUP LAB^ECX MAINTENANCE
 ;;DONE
MENUADD ;Menu items to be added
 ;;ECX KILL TASK^ECX TRANSMISSION^X^17
 ;;ECX DRG RPT^ECX MAINTENANCE^DRG^5.5
 ;;ECX MAS MOV RPT^ECX MAINTENANCE^MOV^7.7
 ;;ECX TREAT SPEC RPT^ECX MAINTENANCE^TSR^8.8
 ;;ECX PHA IV HOLD^ECX PHARMACY PRE-EXTRACT^5^5
 ;;DONE
