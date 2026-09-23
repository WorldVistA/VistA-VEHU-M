IBY836PO ;AITC/CKB - Post-Installation for IB patch 836 ; 13-NOV-2025
 ;;2.0;INTEGRATED BILLING;**836**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 ; Reference to ^XUPROD in ICR #4440
 ;
 Q
 ;
POST ; POST-INSTALL
 N IBXPD,SITE,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=2
 ;
 S SITE=$$SITE^VASITE,SITENUM=$P(SITE,U,3)
 D MES^XPDUTL("")
 ;
 D SETDEF(1)  ; Set default for field FUTURE EFFECT DATE PROCESSING (#350.9,54.06) to '0' for 'NO'
 ;
 D SITEREG(2,SITENUM) ; Send site registration message to FSC
 ;
 D MES^XPDUTL("")  ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*836 Completed.")
 Q
 ;================================ 
 ;
SETDEF(IBXPD) ;Set default for FUTURE EFFECT DATE PROCESSING field #350.9,54.06 to '0' for 'NO'.
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Set default for field FUTURE EFFECT DATE PROCESSING (#350.9,54.06) ... ")
 ;
 N IBDFDA,DATA,ENABLED,MSG
 S ENABLED=$$GET1^DIQ(350.9,"1,",54.06)
 I ENABLED'="" S MSG="FUTURE EFFECT DATE PROCESSING is already set." G SETDEFQ
 S IBDFDA=1
 S DATA(54.06)=0
 D UPD^IBDFDBS(350.9,.IBDFDA,.DATA)
 S MSG="FUTURE EFFECT DATE PROCESSING default set to 0 for 'NO'."
SETDEFQ ;
 D MES^XPDUTL(MSG)
 Q
 ;================================
 ;
SITEREG(IBXPD,SITENUM) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Send eIV site registration message to FSC ... ")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL("N/A - Not a production account - No site registration message sent") G SITEREGQ
 I SITENUM=358 D MES^XPDUTL("Current Site is MANILA - NO eIV site registration message sent") G SITEREGQ
 D ^IBCNEHLM
 D MES^XPDUTL("eIV site registration message was successfully sent")
 ;
SITEREGQ ;
 Q
 ;================================  
