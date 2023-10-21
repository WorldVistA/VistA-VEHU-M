IBY752PO ;AITC/DTG - Post-Installation for IB patch 752; JAN 18, 2023
 ;;2.0;INTEGRATED BILLING;**752**;MAR 21,1994;Build 20
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$INSTALDT^XPDUTL in ICR #10141
 ; Reference to $$DELETE^XPDMENU in ICR #1157
 ;
 Q
 ;
POST ; POST-INSTALL
 N ARRAY,IBINSTLD,IBMES,IBSITE,IBSITENAM,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=5
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 S IBSITE=SITE,IBSITENAM=SITENAME
 S IBINSTLD=$$INSTALDT^XPDUTL("IB*2.0*752","")
 D MES^XPDUTL("")
 ;
 D FLDINIT(1)         ; Initialize new field to 0 (zero)
 ;
 D TASK(2)            ; Report X12 entries that are not controlled by FSC
 ;
 D STATUPD(3)
 ;
 D OPTR(4)  ; remove menu options
 ;
 D SITEREG(5,SITENUM) ; Send site registration message to FSC
 ;
 D MES^XPDUTL("")     ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*752 Completed.")
 Q
 ;============================
 ;
OPTR(IBXPD) ; Remove options IB OUTPATIENT VET REPORT and IB INPATIENT VET REPORT from IBCN INS RPTS
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Remove options: Veterans w/Insurance and Opt. Visits")
 D MES^XPDUTL(" AND Veterans w/Insurance and Inpatient Admissions")
 D MES^XPDUTL("From Menu: Insurance Reports ... [IBCN INS RPTS]")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$DELETE^XPDMENU
 ; ICR #10141 for the usage of $$INSTALDT^XPDUTL
 ;
 N IBMENU,IBNAM,IBRET,IBCHK
 S (IBOER,IBCHK)=""
 ;
 ; [IB OUTPATIENT VET REPORT]  (to be removed)
 ; [IB INPATIENT VET REPORT] (to be removed)
 ; IBCN INS RPTS (menu to be removed from)
 ;
 ;
 F IBNAM="IB OUTPATIENT VET REPORT","IB INPATIENT VET REPORT" S IBMENU="IBCN INS RPTS" D
 . ;
 . S IBRET=$$DELETE^XPDMENU(IBMENU,IBNAM)
 . ;
 . I IBRET D BMES^XPDUTL("Option: "_IBNAM_" removed from menu: "_IBMENU) Q
 . D BMES^XPDUTL("Option: "_IBNAM_" NOT on menu: "_IBMENU)
 ;
OPTRQ ; option remove end point
 ;
 D BMES^XPDUTL("Options removal from menu process done")
 Q
 ;
FLDINIT(IBXPD) ; Initialize new FSC CONTROLLED (#file,.05) field to 0 (zero)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 I ($$PROD^XUPROD(1))&(IBINSTLD) D MES^XPDUTL("Fields have already initialized ... ") G FLDINITQ
 D MES^XPDUTL("Initialing new fields ... ")
 ;
 N ARR,B,DATA,DIERR,FIELD1,FIELD2,FILE,FILENUM,I,IENS
 K DATA
 F I=11:1:18,21:1:29,31:1:39,41:1:46 S FILE("365.0"_I)=""
 S FIELD1=".05",DATA(FIELD1)=0
 S FIELD2=".04",DATA(FIELD2)=$$NOW^XLFDT()
 S FILENUM=0 F  S FILENUM=$O(FILE(FILENUM)) Q:'FILENUM  D
 . S B=0 F  S B=$O(^IBE(FILENUM,B)) Q:'B  D
 . . S IENS=$$IENS^DILF(B) K ARR
 . . I $$GET1^DIQ(FILENUM,IENS,.05,"I")=1 Q  ; quit if under FSC control
 . . S ARR(FILENUM,IENS,FIELD1)=$G(DATA(FIELD1))
 . . S ARR(FILENUM,IENS,FIELD2)=$G(DATA(FIELD2))
 . . D FILE^DIE("K","ARR")
 . . I +$G(DIERR) D BMES^XPDUTL("Log SNOW Ticket - File #"_FILENUM_"-"_B_" encountered an issue with fields #.04,#.05")
 . . ;
 D MES^XPDUTL("Finished initializing new fields ... ")
FLDINITQ ; 
 Q
 ;
TASK(IBXPD) ; Report X12 entries that are not controlled by FSC
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 N GTASKS,IBA,IBDATE,IBDIR,IBEMSG,IBER,IBI,IBPROD,IBRET,IBTASK,IO,RMSG,TSK
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTQUEUED,ZTREQ,ZTSK
 ;
 S IBPROD=$$PROD^XUPROD(1),IBDATE=$$FMTE^XLFDT(DT,5),IBER=0
 S IBA=$G(IBSITE) N IBSITE S IBSITE=SITENUM
 I ($$PROD^XUPROD(1))&(IBINSTLD) D MES^XPDUTL("Report of X12 entries has already been generated ... ") G TASKQ
 S IBDIR="IB*752 - report X12 entries not controlled by FSC"
 ; Check to see if the task is already running.
 K GTASKS
 D DESC^%ZTLOAD(IBDIR,"GTASKS")
 S (IBTASK,TSK)="",RMSG(0)=0
 S TSK=$O(GTASKS(TSK))
 I TSK D  Q
 . D BMES^XPDUTL(" "_IBDIR_" Task "_TSK_" has Already Been Submitted to TASKMAN.")
 ; build task out array and task off
 S ZTRTN="X12ENTRIES^IBY752PO",ZTDESC=IBDIR,ZTIO=""
 ; ZTDTH = 2 days from Today at 8:00 PM
 S ZTDTH=($P($$NOW^XLFDT(),".")+2),ZTDTH=$$FMADD^XLFDT(ZTDTH,,20)
 F IBI="IBDATE","IBPROD","IBDIR" S ZTSAVE(IBI)=""
 K IO("Q"),ZTSK
 D ^%ZTLOAD
 S IBRET="" S:$D(ZTSK) IBRET=ZTSK
 D HOME^%ZIS
 ;
 I +IBRET S IBMES=IBDIR_" has been submitted to TASKMAN. Task number: "_(+IBRET)
 I 'IBRET D
 . S IBER=1
 . S IBMES=IBDIR_" was NOT successfully submitted to TASKMAN."
 D BMES^XPDUTL(" "_IBMES)  ;update post install with info
 S IBTASK=1 D MESSAGE  ;Send email message indicating task submission status.
TASKQ ; 
 Q
 ;
X12ENTRIES ; Build a delimited list of entries where the FSC CONTROLLED
 ; field is equal to 0 (zero). Send email to eBiz eInsurance with the info.
 N ARRAY,CT,D,FILE,IBBCK,IBSITE,IBSITENAM,IEN,XX
 S IBSITE=$$SITE^VASITE ; Get the site name & #
 S IBSITENAM=$P(IBSITE,U,2),IBSITE=$P(IBSITE,U,3) ; piece 3 is the site #
 ;
 K ARRAY S CT=0
 F D=11:1:18,21:1:29,31:1:39,41:1:46 S XX("365.0"_D)=""
 S FILE=0 F  S FILE=$O(XX(FILE)) Q:'FILE  S IEN=0 F  S IEN=$O(^IBE(FILE,IEN)) Q:'IEN  D
 . ;Only include entries where field FSC CONTROLLED (#A,.05) is equal to 0 (zero)
 . I $$GET1^DIQ(FILE,IEN_",",.05,"I")=0 S CT=CT+1,ARRAY(CT)=FILE_U_^IBE(FILE,IEN,0)
 I '$O(ARRAY(0)) S ARRAY(1)="No entries found with 'FSC CONTROLLED' (#.05) equal to zero"
 D MESSAGE
 Q
 ;
MESSAGE ; build and send message to eInsurance
 N IBAL,IBC,IBD,IBMSG,IBSUB,IBT,IBXMY,MCT,MSG,SITE
 S IBSITENAM=$G(IBSITENAM),IBSITE=$G(IBSITE),IBPROD=$G(IBPROD)
 S SITE=IBSITENAM_" (#"_IBSITE_")"
 S IBC=$L(SITE)+41 I IBC>64 S IBD=IBC-64,IBT=$E(IBSITENAM,1,($L(IBSITENAM)-IBD)),SITE=IBT_" (#"_IBSITE_")"
 S IBSUB=SITE_" IB*752 X12 entries not controlled by FSC"
 ;Send mailman message at completion.
 S MSG(1)=IBDIR_" at "_IBSITE_" in the "_$S('IBPROD:"NON-",1:"")_"Production Account"
 S MSG(2)=" "
 S MSG(3)="   "_($S(+$G(IBTASK):"Task"_($S($G(IBER)=1:" Not",1:""))_" Submitted",1:"Run"))_" On: "_IBDATE
 S MSG(4)=" --------------------------------------------------------------------------"
 S MSG(5)=" "
 S IBMSG=5
 I $G(IBMES)'="" D
 . I '$G(IBER) D
 .. F IBAL=1,60 D
 ... S IBMSG=IBMSG+1
 ... S MSG(IBMSG)=($S(IBAL=60:"         ",1:""))_$E(IBMES,IBAL,($S(IBAL=1:59,1:999)))
 ... I IBAL=60 S IBMSG=IBMSG+1,MSG(IBMSG)=" "
 . I $G(IBER) D
 .. F IBAL=1,59 D
 ... S IBMSG=IBMSG+1
 ... S MSG(IBMSG)=($S(IBAL=59:"         ",1:""))_$E(IBMES,IBAL,($S(IBAL=1:58,1:999)))
 ... I IBAL=59 S IBMSG=IBMSG+1,MSG(IBMSG)=" "
 ;
 S MCT=0 F  S MCT=$O(ARRAY(MCT)) Q:MCT=""  S IBMSG=IBMSG+1,MSG(IBMSG)=ARRAY(MCT)
 S IBMSG=IBMSG+1,MSG(IBMSG)=" "
 ;
 ; Only send to eInsurance Rapid Response if in Production
 ;  1=Production Environment, 0=Test Environment
 S IBXMY="" I IBPROD&($G(IBTASK)'=1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 ;
 ; send message
 D MSG^IBCNEUT5(,IBSUB,"MSG(",,.IBXMY)
 ;
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q 
 ;
 ;
STATUPD(IBXPD) ; Update the CORRECTIVE ACTION field for 2 entries in the IIV STATUS TABLE FILE (#365.15)
 ;
 N FIELD,FILE,IENS,TEXT
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Updating 'Corrective Action' in the IIV STATUS TABLE file (#365.15) for entries B3 & B4")
 ;
 S FILE=365.15
 ;
 ;Update DESCRIPTION for status B3
 S FIELD=1
 S IENS=$$FIND1^DIC(365.15,,,"B3")_","
 S TEXT(1)="eIV could not create an inquiry for this entry. eIV matched the insurance"
 S TEXT(2)="company name in the Insurance Buffer file (#355.33) to more than one insurance"
 S TEXT(3)="company entry with the same name in the Insurance Company file (#36).  At"
 S TEXT(4)="least one of these matching entries are linked to a different payer."
 D WP^DIE(FILE,IENS,FIELD,,"TEXT","ERROR")
 ;
 ;Update CORRECTIVE ACTION for status B3
 S FIELD=2
 S IENS=$$FIND1^DIC(365.15,,,"B3")_","
 S TEXT(1)="Action to take: Run the ""Ins Company Link Report"" option for all linked"
 S TEXT(2)="insurance companies, using the keyword feature to narrow down the search."
 S TEXT(3)="This will provide a report showing which payer the different insurance company"
 S TEXT(4)="records are linked to. Next, use the ""Insurance Company Entry/Edit"" option"
 S TEXT(5)="to correct those insurance companies who are linked to the wrong payer."
 D WP^DIE(FILE,IENS,FIELD,,"TEXT","ERROR")
 ;
 ;Update CORRECTIVE ACTION for status B4
 S IENS=$$FIND1^DIC(365.15,,,"B4")_","
 S TEXT(1)="Action to take: Either contact the insurance company to manually verify"
 S TEXT(2)="this insurance information or link the insurance company to a payer. Steps"
 S TEXT(3)="to link an insurance company to a payer are as follows: run the"
 S TEXT(4)="""Ins Company Link Report"" option for all unlinked insurance companies. Use"
 S TEXT(5)="the keyword feature or select the specific company when running the report"
 S TEXT(6)="to narrow down the search. This will provide a report showing which insurance"
 S TEXT(7)="companies are not linked to a payer. Next, use the ""Insurance Company"
 S TEXT(8)="Entry/Edit"" option to link those insurance companies to the correct payer."
 D WP^DIE(FILE,IENS,FIELD,,"TEXT","ERROR")
 ;
 D BMES^XPDUTL("Status Description successfully updated.")
 Q
 ;
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
