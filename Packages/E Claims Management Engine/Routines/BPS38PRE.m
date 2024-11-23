BPS38PRE ;AITC/PED - Pre-install routine for BPS*1*38 ;06/03/2024
 ;;1.0;E CLAIMS MGMT ENGINE;**38**;JUN 2004;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*38 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL("  Starting pre-install for BPS*1*38")
 ;
 ; Update Reject Code explanations in file #9002313.93.
 ;
 D BPS24
 D BPS25
 D BPS93
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*38")
 ;
 Q
 ;
BPS24 ; Update file 9002313.24
 N CNT,DA,DIE,DR,LINE,DATA,ENTRY,NUM,NAME,X
 D MES^XPDUTL("   - Updating BPS NCPDP DAW CODE")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(BPS24CDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S NAME=$P(DATA,";",2)
 . S DIE=9002313.24
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("     - No IEN found for entry "_NUM) Q
 . S DR="1////^S X=NAME"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 S ENTRY="entries"
 I CNT=1 S ENTRY="entry"
 D MES^XPDUTL("     - "_CNT_" "_ENTRY_" updated")
 D MES^XPDUTL("   - Done with BPS NCPDP DAW CODE")
 D MES^XPDUTL(" ")
 Q
 ;
BPS24CDS ; Updated DAW code
 ;;9;SUBSTITUTION ALLOWED BY PRESCRIBER BUT PLAN REQUESTS BRAND OR REFERENCE PRODUCT
 ;;
 ;
 Q
 ;
BPS25 ; Update file 9002313.25
 N CNT,DA,DIE,DR,LINE,DATA,ENTRY,NUM,NAME,X
 D MES^XPDUTL("   - Updating BPS NCPDP CLARIFICATION CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(BPS25CDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S NAME=$P(DATA,";",2)
 . S DIE=9002313.25
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("     - No IEN found for entry "_NUM) Q
 . S DR=".02////^S X=NAME"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 S ENTRY="entries"
 I CNT=1 S ENTRY="entry"
 D MES^XPDUTL("     - "_CNT_" "_ENTRY_" updated")
 D MES^XPDUTL("   - Done with BPS NCPDP CLARIFICATION CODES")
 D MES^XPDUTL(" ")
 Q
 ;
BPS25CDS ; Updated clarification code
 ;;6;CONTINUATION DOSE AFTER STARTER DOSE
 ;;
 ;
 Q
 ;
BPS93 ; Update file 9002313.93
 N CNT,DA,DIE,DR,LINE,DATA,NUM,NAME,X
 D MES^XPDUTL("   - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(BPS93CDS+LINE),";;",2,99) Q:DATA=""  D
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
BPS93CDS ; Updated reject explanation
 ;;362;Patient Pay Amount Reported is not used for this Transaction Code
 ;;DO1;Beneficiary is not a participant in this Medicare Rx Payment Plan
 ;;DX;M/I Patient Pay Amount Reported
 ;;
 ;
 Q
