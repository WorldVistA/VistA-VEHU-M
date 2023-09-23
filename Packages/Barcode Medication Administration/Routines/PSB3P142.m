PSB3P142 ;WILM/BDB - Patch PSB*3*142 Post init ;05/10/23
 ;;3.0;BAR CODE MED ADMIN;**47,76,142**;Mar 2004;Build 12
 ;Per VHA Directive 2004-038 this routine should not be modified.
 ;
 Q
POST ;
 ;Unschedule the PSB option
 D BMES^XPDUTL("...Unscheduling PSB PX BCMA2PCE TASK...")
 D RESCH^XUTMOPT("PSB PX BCMA2PCE TASK","@","","@")
 D BMES^XPDUTL("...Unscheduling complete...")
 ;Place the PSB option out of order
 D BMES^XPDUTL("...Placing PSB PX BCMA2PCE TASK menu option out of order...")
 D OUT^XPDMENU("PSB PX BCMA2PCE TASK"," Obsolete; Use CPRS Immunization Documentation")
 D BMES^XPDUTL("...Out of order task complete...")
 Q
 ;
