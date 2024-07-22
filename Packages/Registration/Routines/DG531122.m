DG531122 ;ALB/RFS - REPLACE VERBIAGE IN THE DIALOG(#.84) FILE ; 05/09/2024
 ;;5.3;Registration;**1122**;Aug 13, 1993;Build 4
 ;
 ;
 Q
 ;
EN ; ENTRY POINT
 N DGDA,DGTEXT
 F DGDA=0:0 S DGDA=+$O(^DI(.84,DGDA)) Q:DGDA=0  S DGTEXT=$P(^DI(.84,DGDA,0),U,5) D
 .I DGTEXT="Copays for an Indian message" D
 ..S DIE="^DI(.84,",DA=DGDA,DR="1.3///Copay AI/AN Veteran;4///Patient is verified American Indian/Alaska Native Veteran copayment exempt. Billing of copayments may be prohibited"
 ..D ^DIE
 ..K DIE,DA,DR
 ..D BMES^XPDUTL("Verbiage for dialog number "_DGDA_" in the DIALOG(#.84) file has been updated.")
 ..Q
 .I DGTEXT="Indian copay message with date" D
 ..S DIE="^DI(.84,",DA=DGDA,DR="1.3///Copay AI/AN Veteran message with date;4///Patient is verified American Indian/Alaska Native Veteran copayment exempt. Billing of copayments may be prohibited eff. Jan 05, 2022"
 ..D ^DIE
 ..K DIE,DA,DR
 ..D BMES^XPDUTL("Verbiage for dialog number "_DGDA_" in the DIALOG(#.84) file has been updated.")
 ..Q
 .Q
 Q
 ;
