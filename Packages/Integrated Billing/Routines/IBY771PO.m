IBY771PO ;AITC/CKB - Post-Installation for IB patch 771; AUG 3, 2023
 ;;2.0;INTEGRATED BILLING;**771**;MAR 21,1994;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 Q
 ;
POST ; POST-INSTALL
 N IBINSTLD,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=4
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 D MES^XPDUTL("")
 ;
 ; add new report IBCN PT MISSING COVERAGE RPT to IBCN INS RPTS menu
 D OPAR(1)
 ;
 ; add new report IBCN DAILY BUFFER REPORT to IBCN INS RPTS menu
 D OPAR1(2)
 ;
 ; Task job to populate new index 'LAST' to PLAN COVERAGE LIMITATIONS file (#355.32) field 1.04
 D TASK1(3)
 ;
 ; Report X12 entries that are not controlled by FSC
 D TASK(4)
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D BMES^XPDUTL("POST-Install for IB*2.0*771 Completed.")
 Q
 ;============================
 ;
 ;
OPAR(IBXPD) ; add inactive and imbiguous reports to menus
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Add report option: IBCN PT MISSING COVERAGE RPT")
 D MES^XPDUTL("           To Menu: IBCN INS RPTS")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$ADD^XPDMENU
 ; ICR #10141 for the usage of $$INSTALDT^XPDUTL
 ;
 N IBMENU,IBNAM,IBOER,IBRET,IBSYN,IBCHK
 S IBOER="",IBCHK=""
 ;
 ;
 S IBOER=0 S IBMENU="IBCN INS RPTS" D
 . S IBNAM="IBCN PT MISSING COVERAGE REPT",IBSYN="PC"
 . ;
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBNAM,IBSYN)
 . ;
 . I IBRET D MES^XPDUTL("Option: "_IBNAM_" added to menu: "_IBMENU) Q
 . S IBOER=1 D MES^XPDUTL("Not able to add Option: "_IBNAM_" to menu: "_IBMENU)
 ;
OPARQ ; option remove end point
 I IBOER'=2 D BMES^XPDUTL("Add report options to menus was"_($S('IBOER:"",1:" not"))_" successful")
 Q
 ;
OPAR1(IBXPD) ; Add Daily Buffer Report to Insurance Reports menu
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Add report option: IBCN DAILY BUFFER REPORT")
 D MES^XPDUTL("           To Menu: IBCN INS RPTS")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$ADD^XPDMENU
 ; ICR #10141 for the usage of $$INSTALDT^XPDUTL
 ;
 N IBMENU,IBNAM,IBOER,IBRET,IBSYN,IBCHK
 S IBOER="",IBCHK=""
 ;
 ;
 S IBOER=0 S IBMENU="IBCN INS RPTS" D
 . S IBNAM="IBCN DAILY BUFFER REPORT",IBSYN="DB"
 . ;
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBNAM,IBSYN)
 . ;
 . I IBRET D MES^XPDUTL("Option: "_IBNAM_" added to menu: "_IBMENU) Q
 . S IBOER=1 D MES^XPDUTL("Not able to add Option: "_IBNAM_" to menu: "_IBMENU)
 ;
OPAR1Q ; option remove end point
 D BMES^XPDUTL("Add report options to menus was"_($S('IBOER:"",1:" not"))_" successful")
 Q
 ;
TASK1(IBXPD) ; Task population of index 'LAST' to PLAN COVERAGE LIMITATIONS file (#355.32,1.04)
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 N GTASKS,IBDIR,IBRET,IBTASK,IO,RMSG,TSK
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTQUEUED,ZTREQ,ZTSK
 ;
 S IBDIR="Populate 'LAST' Index on PLAN COVERAGE LIMITATIONS file (#355.32,1.04)."
 ; Check to see if the task is already running.
 K GTASKS
 D DESC^%ZTLOAD(IBDIR,"GTASKS")
 S (IBTASK,TSK)=""
 S TSK=$O(GTASKS(TSK))
 I TSK D  G TASK1Q
 . D BMES^XPDUTL(" "_IBDIR)
 . D BMES^XPDUTL(" Task "_TSK_" has Already Been Submitted to TASKMAN.")
 ; build task out array and task off
 S ZTRTN="NEWINDX^IBY771PO",ZTDESC=IBDIR,ZTIO=""
 ; ZTDTH = 7 p.m. Local
 S ZTDTH=$P($$NOW^XLFDT(),"."),ZTDTH=$$FMADD^XLFDT(ZTDTH,,19)
 K IO("Q"),ZTSK
 D ^%ZTLOAD
 S IBRET="" S:$D(ZTSK) IBRET=ZTSK
 D HOME^%ZIS
 ;
 I +IBRET S IBMES=" has been submitted to TASKMAN. Task number: "_(+IBRET)
 I 'IBRET D
 . S IBMES=" was NOT successfully submitted to TASKMAN."
 D BMES^XPDUTL(" "_IBDIR)
 D BMES^XPDUTL(" "_IBMES)  ;update post install with info
TASK1Q ; 
 Q
 ;
NEWINDX ; populate 1.04 field new LAST index in file #355.32
 ;
 N IBMES,IENS,NODE,NOGO
 ;
 S IEN=0
 F  S IEN=$O(^IBA(355.32,IEN)) Q:'IEN  D
 . K ARRAY
 . S IENS=IEN_",",NOGO=0
 . D GETS^DIQ(355.32,IENS,".01;1.03;1.04","I","ARRAY")
 . F NODE=.01,1.03,1.04 I $G(ARRAY(355.32,IENS,NODE,"I"))="" S NOGO=1 Q  ;Quit this entry if any field is null.
 . I NOGO Q
 . N DA,DIK
 . S DIK(1)="1.04^LAST",DIK="^IBA(355.32,",DA=IEN
 . D EN1^DIK
 K ARRAY
 ;
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
NEWEXIT ;
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
 S IBDIR="IB*771 - report X12 entries not controlled by FSC"
 ; Check to see if the task is already running.
 K GTASKS
 D DESC^%ZTLOAD(IBDIR,"GTASKS")
 S (IBTASK,TSK)="",RMSG(0)=0
 S TSK=$O(GTASKS(TSK))
 I TSK D  Q
 . D BMES^XPDUTL(" "_IBDIR)
 . D BMES^XPDUTL(" Task "_TSK_" has Already Been Submitted to TASKMAN.")
 ; build task out array and task off
 S ZTRTN="X12ENTRIES^IBY771PO",ZTDESC=IBDIR,ZTIO=""
 ; ZTDTH = Now
 S ZTDTH=$$NOW^XLFDT()
 F IBI="IBDATE","IBPROD","IBDIR" S ZTSAVE(IBI)=""
 K IO("Q"),ZTSK
 D ^%ZTLOAD
 S IBRET="" S:$D(ZTSK) IBRET=ZTSK
 D HOME^%ZIS
 ;
 I +IBRET S IBMES=" has been submitted to TASKMAN. Task number: "_(+IBRET)
 I 'IBRET D
 . S IBER=1
 . S IBMES=" was NOT successfully submitted to TASKMAN."
 D BMES^XPDUTL(" "_IBDIR)
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
 F D=11:1:18,21:1:29,31:1:39,41:1:46 D
 . S FILE="365.0"_D,IEN=0
 . F  S IEN=$O(^IBE(FILE,IEN)) Q:'IEN  D
 .. N DATA,IENS
 .. S IENS=IEN_","
 .. ;Only include entries where field FSC CONTROLLED (#.05) is equal to 0 (zero) AND DESCRIPTION (#.02)="OTHER"
 .. D GETS^DIQ(FILE,IENS,".02;.05","I","DATA")
 .. I DATA(FILE,IENS,.02,"I")="OTHER",DATA(FILE,IENS,.05,"I")=0 S CT=CT+1,ARRAY(CT)=FILE_U_^IBE(FILE,IEN,0)
 I '$O(ARRAY(0)) S ARRAY(1)="No entries found with 'FSC CONTROLLED' (#.05) equal to zero"
 D MESSAGE
 Q
 ;
MESSAGE ; build and send message to eInsurance
 N IBAL,IBC,IBD,IBMSG,IBSUB,IBT,IBXMY,MCT,MSG,SITE
 S IBSITENAM=$G(IBSITENAM),IBSITE=$G(IBSITE),IBPROD=$G(IBPROD)
 S SITE=IBSITENAM_" (#"_IBSITE_")"
 S IBC=$L(SITE)+41 I IBC>64 S IBD=IBC-64,IBT=$E(IBSITENAM,1,($L(IBSITENAM)-IBD)),SITE=IBT_" (#"_IBSITE_")"
 S IBSUB=SITE_" IB*771 X12 entries not controlled by FSC"
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
