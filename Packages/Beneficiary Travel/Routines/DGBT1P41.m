DGBT1P41 ;WAR/PHL - BENEFICIARY TRAVEL PATCH 41 POST-INIT ; 1/16/24 7:57am
 ;;1.0;Beneficiary Travel;**41**;September 25, 2001;Build 7
 ;
 ; This is a post install routine used to mark all special mode
 ; related options as out of order. Also the out of order
 ; options will be removed from the main Beneficiary Travel 
 ; Menu [DGBT BENE TRAVEL MENU].
 ;
 ;
 ;
 Q
 ;
EN ;entry point
 ;
 D BMES^XPDUTL("Post install starting...")
 D UPDATE
 D BMES^XPDUTL("...Post install complete")
 Q
 ;
UPDATE  ;update options with out of order message and remove from main menu
 ;
 N DGBTMENU,DGBTCNT,DGBTOPT,DGBTCHK
 S DGBTMENU="DGBT BENE TRAVEL MENU"
 F DGBTCNT=1:1:4 S DGBTOPT=$P($T(OPTIONS+DGBTCNT),";;",2) D
  .D OUT^XPDMENU(DGBTOPT,"Option is no longer available. Please use appropriate claim processing system.")
  .D BMES^XPDUTL("  "_DGBTOPT_" placed out of order...")
  .S DGBTCHK=$$DELETE^XPDMENU(DGBTMENU,DGBTOPT)
  .D MES^XPDUTL("  ..."_DGBTOPT_" option "_$S(DGBTCHK:"removed from ",1:"not found in ")_DGBTMENU)
 Q
 ;
OPTIONS  ;DGBT options that will be marked out of order
 ;;DGBT BENE TRAVEL ACCOUNT
 ;;DGBT BENE TRAVEL SCREEN
 ;;DGBT REPRINT DENIAL LETTERS
 ;;DGBT EDIT DENIAL LETTERS
