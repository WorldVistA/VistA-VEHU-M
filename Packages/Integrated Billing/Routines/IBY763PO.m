IBY763PO ;AITC/CKB - Post-Installation for IB patch 763; JUN 12, 2023
 ;;2.0;INTEGRATED BILLING;**763**;MAR 21,1994;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 Q
 ;
POST ; POST-INSTALL
 N IBINSTLD,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=2
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S IBINSTLD=$$INSTALDT^XPDUTL("IB*2.0*763","")
 D MES^XPDUTL("")
 ;
 ; Populate new index 'LAST' to PLAN COVERAGE LIMITATIONS file (#355.32) field 1.04
 D NEWINDX(1)
 ;
 ; Initialize the Insurance Import Enabled (#350.9,54.01) field.
 D INIT3509(2)
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D BMES^XPDUTL("POST-Install for IB*2.0*763 Completed.")
 Q
 ;============================
 ;
NEWINDX(IBXPD) ; populate 1.04 field new LAST index in file #355.32
 ;
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 ; Only Initialize and Populate the 'LAST' index if the index doesn't exist
 I $D(^IBA(355.32,"LAST")) D  G NEWEXIT
 . D MES^XPDUTL("The 'LAST' index in the PLAN COVERAGE LIMITATIONS file (#355.32) has already been populated.")
 ;
 N DIK,X,Y
 S DIK(1)="1.04^LAST",DIK="^IBA(355.32,"
 D BMES^XPDUTL("Initializing the 'LAST' index for PLAN COVERAGE LIMITATIONS file (#355.32) 1.04 field.")
 D ENALL2^DIK
 D MES^XPDUTL("The 'LAST' index for PLAN COVERAGE LIMITATIONS file (#355.32) 1.04 field has been initialized.")
 D BMES^XPDUTL("Populating the 'LAST' index for the PLAN COVERAGE LIMITATIONS file (#355.32) 1.04 field.")
 S DIK(1)="1.04^LAST",DIK="^IBA(355.32,"
 D ENALL^DIK
 D MES^XPDUTL("The 'LAST' index in the PLAN COVERAGE LIMITATIONS file (#355.32) 1.04 field has been populated.")
 ;
NEWEXIT ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("-------------")
 Q
 ;
INIT3509(IBXPD) ;Initialize the Insurance Import Enabled (#350.9,54.01) field.
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 N DA,DIE,DR
 ;
 I $$GET1^DIQ(350.9,"1,",54.01)'="" D  G INIT3509X
 . D BMES^XPDUTL("Insurance Import Enabled (#350.9,54.01) field was previously initialized.")
 ;
 D BMES^XPDUTL("Initializing the Insurance Import Enabled (#350.9,54.01) field.")
 S DR="54.01///1",DA=1,DIE=350.9
 D ^DIE
 ;
INIT3509X ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("-------------")
 Q
 ;
