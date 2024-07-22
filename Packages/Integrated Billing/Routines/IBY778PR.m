IBY778PR ;AITC/CKB PRE-Installation for IB patch 778; MAR 18, 2024
 ;;2.0;INTEGRATED BILLING;**778**;MAR 21,1994;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 Q
 ;
PRE ; pre-install
 ;
 N IBCT,IBTCT,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=2
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 D MES^XPDUTL("")
 ;
 D BMES^XPDUTL("PRE-INSTALL for IB*2.0*778 at "_$G(SITENAME)_":"_$G(SITENUM)_"  - Starting.")
 ;
 ; Update IIV TRANSMISSION QUEUE file #365.1 where the TRANSMISSION STATUS is (2)'Transmitted'
 ;  with the GROUP NUMBER from the Patient record (#2.312)
 D TQTIMING(1)
 ;
 ; Update IIV TRANSMISSION QUEUE file #365.1 entries to add GROUP NUMBER from the Buffer (#355.33)
 D UPDTQ(2)
 ;
 D BMES^XPDUTL("PRE-INSTALL for IB*2.0*778 at "_$G(SITENAME)_":"_$G(SITENUM)_"  - Finished.")
 D MES^XPDUTL("")
 ;
PREX ;
 Q
 ;============================
 ;
TQTIMING(IBXPD) ; Update the entries in the TQ file #365.1 where the TRANSMISSION STATUS (#.04)
 ; is set to (2)'Transmitted' with the GROUP NUMBER from the Patient record (#2.312)
 ;
 N IBERR,IBGPIEN,IBGRPNUM,IBINSIEN,IBPAT,IBTCT,IBTQDA
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Updating IIV TRANSMISSION QUEUE file (#365.1) entries where the TRANSMSSION")
 D MES^XPDUTL(" STATUS is 'Transmitted', with a GROUP NUMBER from the Patient record #2.312.")
 ;
 S (IBERR,IBTCT)=0
 S IBTQDA="" F  S IBTQDA=$O(^IBCN(365.1,"AC",2,IBTQDA)) Q:IBTQDA=""  D
 . ; if WHICH EXTRACT is NOT '2' for 'Appt', quit
 . I $$GET1^DIQ(365.1,IBTQDA_",",.1,"I")'=2 Q
 . ; if GROUP NUMBER is populated, quit
 . I $$GET1^DIQ(365.1,IBTQDA_",",1.03)'="" Q
 . ; Get the Group Number from the Patient Record
 . D CHKPAT
 . ; if CHKPAT returned an error (ie, Patient IEN or Group Number not found), quit
 . I IBERR Q
 . ;
 . ;Add GROUP NUMBER to the entry in the TQ file
 . D ADDGRP S IBTCT=IBTCT+1
 ;
 D BMES^XPDUTL("Number of IIV TRANSMISSION QUEUE file (#365.1) entries updated: "_IBTCT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("---------------------")
 Q
 ;
UPDTQ(IBXPD) ; Update the entries in the TQ file #365.1 to include the GROUP NUMBER #1.03
 ; get the GROUP NUMBER from the corresponding Buffer #355.33 entry when possible
 ;
 ; ** This data converion is needed for the modernization of the Appointment Extract, which now uses the
 ;    PATIENT/PAYER/SUBSCRIBER ID/GROUP NUMBER. Converting TQ entries to include the GROUP NUMBER **
 ;
 N IBBUFDA,IBCNDT,IBERR,IBGPIEN,IBGRPNUM,IBINSIEN,IBPAT,IBRESDA,IBTQDA
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Updating IIV TRANSMISSION QUEUE file (#365.1) entries with a GROUP NUMBER")
 D MES^XPDUTL(" from the INSURANCE VERIFICATION PROCESSOR file (#355.33).")
 ;
 S (IBCT,IBERR)=0
 S IBCNDT=0 F  S IBCNDT=$O(^IBA(355.33,"AEST","E",IBCNDT)) Q:'IBCNDT  D
 . S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AEST","E",IBCNDT,IBBUFDA)) Q:'IBBUFDA  D
 . . ;Buffer file (#355.33) checks
 . . I $G(^IBA(355.33,IBBUFDA,0))="" D  Q
 . . . ;D BMES^XPDUTL("No 0 node for Buffer #"_IBBUFDA_", not updated.")
 . . ; if the STATUS is not 'E' for 'ENTERED, quit
 . . I $$GET1^DIQ(355.33,IBBUFDA_",",.04,"I")'="E" D  Q    ;STATUS
 . . . ;D BMES^XPDUTL("The STATUS is NOT 'ENTERED' for Buffer #"_IBBUFDA_", not updated.")
 . . ; if the SOI is not '5' for 'eIV', quit
 . . I $$GET1^DIQ(355.33,IBBUFDA_",",.03,"I")'=5 D  Q      ;SOURCE OF INFORMATION
 . . . ;D BMES^XPDUTL("The SOI is NOT 'eIV' for Buffer #"_IBBUFDA_", not updated.")
 . . S IBGRPNUM=$$GET1^DIQ(355.33,IBBUFDA_",",90.02)       ;GROUP NUMBER
 . . ;
 . . ;Response file (#365) checks
 . . ; if the cross-reference 'AF' to the Buffer file doesn't exist, quity
 . . I '$D(^IBCN(365,"AF",IBBUFDA)) D  Q
 . . . ;D BMES^XPDUTL("No 'AF' cross-ref for Buffer #"_IBBUFDA_", not updated.")
 . . ; Get IIV RESPONSE file (#365) IEN
 . . S IBRESDA=$O(^IBCN(365,"AF",IBBUFDA,""))
 . . ; if Response IEN is null, do not continue
 . . I IBRESDA="" D  Q
 . . . ;D BMES^XPDUTL("There is no Response IEN associated with Buffer #"_IBBUFDA_", not updated.")
 . . ; Get the TQ IEN from the IIV RESPONSE file
 . . S IBTQDA=$$GET1^DIQ(365,IBRESDA_",",.05,"I")
 . . ; if the TQ IEN does not exist, quit
 . . I IBTQDA="" D  Q
 . . . ;D BMES^XPDUTL("There is no TQ IEN associated with Response #"_IBRESDA_", not updated.")
 . . ;
 . . ;TQ file (#365.1) checks
 . . ; if WHICH EXTRACT is '4' for 'EICD', quit
 . . I $$GET1^DIQ(365.1,IBTQDA_",",.1,"I")=4 D  Q
 . . . ;D BMES^XPDUTL("This entry was created by the EICD extract for TQ #"_IBTQDA_", not updated.")
 . . ; if GROUP NUMBER is populated, quit
 . . I $$GET1^DIQ(365.1,IBTQDA_",",1.03)'="" D  Q
 . . . ;D BMES^XPDUTL("Group Number is already populated for TQ #"_IBTQDA_", not updated.")
 . . ;
 . . ;Check Patient Record for a Group Number on file
 . . D CHKPAT
 . . ; if CHKPAT returned an error (ie, Patient IEN or Group Number not found), quit
 . . I IBERR Q
 . . ;
 . . ;Add GROUP NUMBER to the entry in the TQ file
 . . D ADDGRP S IBCT=IBCT+1
 . . ;D BMES^XPDUTL("Group Number "_IBGRPNUM_" was added to TQ #"_IBTQDA_", entry updated.")
 . . Q
 ;
 D BMES^XPDUTL("Number of entries in the IIV TRANSMISSION QUEUE file (#365.1) updated: "_IBCT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("---------------------")
 Q
 ;
CHKPAT ; Check the Patient Record for existence of a Group Number
 ;Get the Patient IEN
 S IBPAT=$$GET1^DIQ(365.1,IBTQDA_",",.02,"I")
 ; if the Patient IEN does not exist, quit
 I IBPAT="" D  S IBERR=1 Q
 . ;D BMES^XPDUTL("The Patient IEN is NOT populated for TQ #"_IBTQDA_".")
 ;
 ;Get the Patient INSUR RECORD IEN
 S IBINSIEN=$$GET1^DIQ(365.1,IBTQDA_",",.13)
 ; if the INSUR RECORD IEN does not exist, quit
 I IBINSIEN="" D  S IBERR=1 Q
 . ;D BMES^XPDUTL("The Insurance IEN is NOT populated for TQ #"_IBTQDA_".")
 ; if the Patient INSUR RECORD IEN isn't valid, quit
 I '$D(^DPT(IBPAT,.312,IBINSIEN)) D  S IBERR=1 Q
 . ;D BMES^XPDUTL("The Insurance IEN "_IBINSIEN_" is NOT valid Patient #"_IBPAT_", TQ #"_IBTQDA_".")
 ;
 ;Get GROUP PLAN IEN from file #2.312 
 S IBGPIEN=$$GET1^DIQ(2.312,IBINSIEN_","_IBPAT_",",.18,"I")
 ; if the GROUP PLAN IEN does not exist, quit
 I IBGPIEN="" D  S IBERR=1 Q
 . ;D BMES^XPDUTL("The Group Plan IEN is NOT populated for "_IBPAT_"-"_IBINSIEN_", TQ #"_IBTQDA_".")
 ;
 ;Reset IBGRPNUM, if the GROUP NUMBER is populated in the Patient record (#355.3)
 I $$GET1^DIQ(355.3,IBGPIEN_",",2.02,"E")'="" S IBGRPNUM=$$GET1^DIQ(355.3,IBGPIEN_",",2.02,"E")
 Q
 ;
ADDGRP ;Add GROUP NUMBER (#1.03) to the entry in the TQ file (#365.1)
 N DA,DIE,DR
 S DR="1.03///"_IBGRPNUM
 S DA=IBTQDA,DIE="^IBCN(365.1," D ^DIE
 ;D BMES^XPDUTL("Group Number "_IBGRPNUM_" was added to TQ #"_IBTQDA_".") ;****for testing
 Q
