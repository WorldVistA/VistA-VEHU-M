DGBT1P40 ;ALB/DBE - BENEFICIARY TRAVEL PATCH 40 POST-INIT ;9/6/2023
 ;;1.0;Beneficiary Travel;**40**;September 25, 2001;Build 8
 ;
 ; This is a post install routine used to mark all mileage
 ; related options as out of order. Also the out of order
 ; options will be removed from the main Beneficiary Travel 
 ; Menu [DGBT BENE TRAVEL MENU].
 ;
 ;Supported IA: #1157 - XPDMENU
 ;
 Q
 ;
EN ;entry point
 ;
 D BMES^XPDUTL("Post install starting...")
 D DELFILE
 D UPDATE
 D BMES^XPDUTL("...Post install complete")
 Q
 ;
DELFILE ;*** Remove files 392.5, and 392.51 from the system ***
 ;
 K DIU
 I $D(^DIC(392.5,0,"GL")) K DIU S DIU=^DIC(392.5,0,"GL"),DIU(0)="DEST" D EN^DIU2 K DIU
 I $D(^DIC(392.51,0,"GL")) K DIU S DIU=^DIC(392.51,0,"GL"),DIU(0)="DEST" D EN^DIU2 K DIU
 Q
 ;
UPDATE  ;update mileage options with out of order message and remove from main menu
 ;
 N DGBTMENU,DGBTCNT,DGBTOPT,DGBTCHK
 S DGBTMENU="DGBT BENE TRAVEL MENU"
 F DGBTCNT=1:1:6 S DGBTOPT=$P($T(OPTIONS+DGBTCNT),";;",2) D
  .D OUT^XPDMENU(DGBTOPT,"Option is no longer available. Please use BTSSS.")
  .D BMES^XPDUTL("  "_DGBTOPT_" placed out of order...")
  .S DGBTCHK=$$DELETE^XPDMENU(DGBTMENU,DGBTOPT)
  .D MES^XPDUTL("  ..."_DGBTOPT_" option "_$S(DGBTCHK:"removed from ",1:"not found in ")_DGBTMENU)
 Q
 ;
OPTIONS  ;DGBT options that will be marked out of order
 ;;DGBT ALTERNATE INCOME
 ;;DGBT BENE TRAVEL CERTIFICATION
 ;;DGBT BENE TRAVEL CONFIG EDIT
 ;;DGBT BENE TRAVEL RATES
 ;;DGBT BENE TRAVEL REPRINT
 ;;DGBT MANUAL DEDUCTIBLE WAIVER
