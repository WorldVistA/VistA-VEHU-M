IBY794PO ;AITC/CKB - Post-Installation for IB patch 794; JUN 12, 2024
 ;;2.0;INTEGRATED BILLING;**794**;21-MAR-94;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 Q
 ;
POST ; POST-INSTALL
 N IBXPD,SITE,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=1
 ;
 D MES^XPDUTL("")
 ;
 ; Correct the ENTRY ACTION field (#20) for several entries in the PROTOCOL FILE (#101)
 D FIXEA(1)
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D BMES^XPDUTL("POST-Install for IB*2.0*794 Completed.")
 Q
 ;============================
 ;
FIXEA(IBXPD) ; Fix the ENTRY ACTION field (#20), in file #101
 ;
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 N DA,DR,IBERR,IBIEN,IBACT,IBPRO
 S IBACT="K IBFASTXT S VALMBCK=""R"""
 ;
 S IBPRO="IBJT CLAIM SCREEN MENU"
 S IBIEN=$$FIND1^DIC(101,,"MX",IBPRO,"","","IBERR")
 I 'IBIEN D
 . D BMES^XPDUTL("The protocol "_IBPRO_" in file #101 was not found. No change made.")
 I IBIEN'="" D UPDEA
 ;
 S IBPRO="IBJT NS VIEW EXP POL MENU"
 K IBEIN,IBERR
 S IBIEN=$$FIND1^DIC(101,,"MX",IBPRO,"","","IBERR")
 I 'IBIEN D
 . D BMES^XPDUTL("The protocol "_IBPRO_" in file #101 was not found. No change made.")
 I IBIEN D UPDEA
 ;
 S IBPRO="IBJT NS VIEW INS CO MENU"
 K IBEIN,IBERR
 S IBIEN=$$FIND1^DIC(101,,"MX",IBPRO,"","","IBERR")
 I 'IBIEN D
 . D BMES^XPDUTL("The protocol "_IBPRO_" in file #101 was not found. No change made.")
 I IBIEN D UPDEA
 ;
 S IBPRO="IBJT EDI STATUS MENU"
 K IBIEN,IBERR
 S IBIEN=$$FIND1^DIC(101,,"MX",IBPRO,"","","IBERR")
 I 'IBIEN D
 . D BMES^XPDUTL("The protocol "_IBPRO_" in file #101 was not found. No change made.")
 I IBIEN D UPDEA
 ;
FIXEAX ; FIXEA exit
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("-------------")
 Q
 ;
UPDEA ; update the ENTRY ACTION field (#101,20)
 N DR,DA,DIE
 S DR="20///"_IBACT
 S DA=IBIEN,DIE="^ORD(101," D ^DIE
 D BMES^XPDUTL("The protocol "_IBPRO_" in file #101 has been modified")
 Q
