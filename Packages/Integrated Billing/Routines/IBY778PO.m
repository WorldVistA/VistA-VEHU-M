IBY778PO ;AITC/DTG - Post-Installation for IB patch 778; OCT 04, 2023
 ;;2.0;INTEGRATED BILLING;**778**;MAR 21,1994;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 ; Reference to ^XPDMENU in ICR #1157
 Q
 ;
POST ; POST-INSTALL
 N IBXPD,SITE,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=4
 ;
 ;
 D MES^XPDUTL("")
 ;
 ; Correct the spelling of a specific Type of Plan 
 D FIXNM(1)
 ;
 ;add new option to IBCN INS RPTS
 D ADDRPT(2)
 ;
 ; add new option to IBCN INS RPTS
 D ADDRPT2(3)
 ;
 ; update the abbreviations for several Type of Plans
 D ABBREV(4)
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D BMES^XPDUTL("POST-Install for IB*2.0*778 Completed.")
 Q
 ;============================
 ;
 ; HEALTH MAINTENANCE ORGANIZ
FIXNM(IBXPD) ; update name in file 355.1 from HEALTH MAINTENANCE ORGANIZ  to HEALTH MAINTENANCE ORGANIZATION
 ;
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 N DA,DR,DIE,IBERR,IBIEN,IBNEWNM,IBOLDNM
 S IBOLDNM="HEALTH MAINTENANCE ORGANIZ",IBNEWNM="HEALTH MAINTENANCE ORGANIZATION"
 S IBIEN=$$FIND1^DIC(355.1,,"MX",IBOLDNM,"","","IBERR")
 I 'IBIEN D  G FIXEX
 . D BMES^XPDUTL("The entry 'HEALTH MAINTENANCE ORGANIZ' for file #355.1 was not found. No change needed")
 S DR=".01///"_IBNEWNM
 S DA=IBIEN,DIE="^IBE(355.1," D ^DIE
 D BMES^XPDUTL("The entry 'HEALTH MAINTENANCE ORGANIZ' for file #355.1 has been changed to")
 D BMES^XPDUTL("'HEALTH MAINTENANCE ORGANIZATION'.")
FIXEX ;
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("-------------")
 Q
 ;
ADDRPT(IBXPD) ; add new report IBCN EDI PAYER ID REPT to IBCN INS RPTS
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Add report option: IBCN EDI PAYER ID REPT")
 D MES^XPDUTL("           To Menu: IBCN INS RPTS")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$ADD^XPDMENU
 ;
 N IBMENU,IBNAM,IBOER,IBRET,IBSYN,IBCHK
 S IBOER="",IBCHK=""
 ;
 ;
 S IBOER=0,IBMENU="IBCN INS RPTS" D
 . S IBNAM="IBCN EDI PAYER ID REPT",IBSYN="EP"
 . ;
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBNAM,IBSYN)
 . ;
 . I IBRET D MES^XPDUTL("Option: "_IBNAM_" added to menu: "_IBMENU) Q
 . S IBOER=1 D MES^XPDUTL("Not able to add Option: "_IBNAM_" to menu: "_IBMENU)
 ;
ADDRPTQ ; quit point
 ;
 ; option remove end point
 D BMES^XPDUTL("Add report options to menus was"_($S('IBOER:"",1:" not"))_" successful")
 Q
 ;
ADDRPT2(IBXPD) ; add new report IBCN DUP GRP PLAN BY INS RPT to IBCN INS RPTS
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Add report option: IBCN DUP GRP PLAN BY INS RPT")
 D MES^XPDUTL("           To Menu: IBCN INS RPTS")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$ADD^XPDMENU
 ;
 N IBMENU,IBNAM,IBOER,IBRET,IBSYN,IBCHK
 S IBOER="",IBCHK=""
 ;
 ;
 S IBOER=0,IBMENU="IBCN INS RPTS" D
 . S IBNAM="IBCN DUP GRP PLAN BY INS RPT",IBSYN="LD"
 . ;
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBNAM,IBSYN)
 . ;
 . I IBRET D MES^XPDUTL("Option: "_IBNAM_" added to menu: "_IBMENU) Q
 . S IBOER=1 D MES^XPDUTL("Not able to add Option: "_IBNAM_" to menu: "_IBMENU)
 ;
ADDRPT2Q ; quit point
 ;
 ; option remove end point
 D BMES^XPDUTL("Add report options to menus was"_($S('IBOER:"",1:" not"))_" successful")
 Q
 ;
 ;
ABBREV(IBXPD) ; update the ABBREVIATION field #.02 in the TYPE OF PLAN file #355.1
 ;
 N IBCNT,IBFNDNM,IBL,IBOLDAB,IBONAME,IBNEWAB
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Changes made (or not made) to the TYPE OF PLAN file #355.1:")
 D MES^XPDUTL("   ")
 N IBNEWAB,IBOLDAB
 F IBCNT=1:1 S IBL=$T(ABLIST+IBCNT),IBOLDAB=$P(IBL,";",3) Q:IBOLDAB=""  D
 . S IBNEWAB=$P(IBL,";",5),IBONAME=$P(IBL,";",7)
 . D UPDAB
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("-------------")
 Q
 ;
UPDAB ; save the updated ABBREVIATION #.02 in file #355.1
 N DA,DIE,DR,IBERR,IBIEN
 S IBIEN=$$FIND1^DIC(355.1,,"MX",IBOLDAB,"","","IBERR")
 I 'IBIEN D  Q
 . D BMES^XPDUTL("'"_IBONAME_"' does not exist with an abbrv. of '"_IBOLDAB_"';")
 . D MES^XPDUTL("    therefore, no change.")
 S IBFNDNM=$$GET1^DIQ(355.1,IBIEN_",",".01","I")
 I IBFNDNM'=IBONAME D  Q
 . D BMES^XPDUTL("'"_IBONAME_"' does not exist with an abbrv. of '"_IBOLDAB_"';")
 . D MES^XPDUTL("    therefore, no change.")
 S DR=".02///"_IBNEWAB
 S DA=IBIEN,DIE="^IBE(355.1," D ^DIE
 D BMES^XPDUTL("'"_IBONAME_"' - abbrv. changed to '"_IBNEWAB_"'")
 Q
 ;
ABLIST ; List of Current and Change To abbreviations
 ;;CI;;CAT INS;;CATASTROPHIC INSURANCE
 ;;DENIN;;DENTAL;;DENTAL INSURANCE
 ;;HSA;;HLTH SYS;;HEALTH SYSTEMS AGENCY (HSA)
 ;;IN;;INDMNTY;;INCOME PROTECTION (INDEMNITY)
 ;;IBH;;INPT HSPTL;;INPATIENT (BASIC HOSPITAL)
 ;;LP;;LAB;;LABS, PROCEDURES, X-RAY, ETC. (ONLY)
 ;;MCS;;MNGD CARE;;MANAGED CARE SYSTEM (MCS)
 ;;MEI;;MED EXPS;;MEDICAL EXPENSE (OPT/PROF)
 ;;MR ADV;;MCR ADV;;MEDICARE ADVANTAGE
 ;;MS+;;MED SEC+B;;MEDICARE SECONDARY (B EXC)
 ;;MS;;MED SEC-B;;MEDICARE SECONDARY (NO B EXC)
 ;;MSP;;MED SUP;;MEDICARE SUPPLEMENTAL
 ;;SCI;;SPCL CLS;;SPECIAL CLASS INSURANCE
 ;;SRI;;SPCL RISK;;SPECIAL RISK INSURANCE
 ;;SDI;;SPCFC DIS;;SPECIFIED DISEASE INSURANCE
 ;;SEI;;SURG INS;;SURGICAL EXPENSE INSURANCE
 ;;TS;;TRI SUPP;;TRICARE SUPPLEMENTAL
 ;;VA SP CL;;VA SPCL CLS;;VA SPECIAL CLASS
 ;;WCI;;WORK COMP;;WORKERS' COMPENSATION INSURANCE
 ;;
