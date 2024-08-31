BPS37PRE ;AITC/PED - Pre-install routine for BPS*1*37 ;12/04/2023
 ;;1.0;E CLAIMS MGMT ENGINE;**37**;JUN 2004;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*37 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL("  Starting pre-install for BPS*1*37")
 ;
 ; Update Reject Code explanations in file #9002313.93.
 ;
 D REJECT
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*37")
 ;
 Q
 ;
REJECT ; Update Reject Codes with new explanations.
 N CNT,DA,DIE,DR,LINE,DATA,NUM,NAME,X
 D MES^XPDUTL("   - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(URJCT+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S NAME=$P(DATA,";",2)
 . S DIE=9002313.93
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("     - No IEN found for entry "_NUM) Q
 . S DR=".02////^S X=NAME"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 D MES^XPDUTL("     - "_CNT_" entries updated")
 D MES^XPDUTL("   - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
URJCT ; Updated reject explanation
 ;;367;Regulatory Fee Amount Submitted Is Not Used For This Transaction Code
 ;;HA;M/I Regulatory Fee Amount Submitted
 ;;
 ;
