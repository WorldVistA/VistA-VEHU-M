DG531111P ;ALB/JAM - DG*5.3*1111 INSTALL UTILITY;07/12/2021 15:21pm
 ;;5.3;Registration;**1111**;Jan 26 2022;Build 18
 ;
QUIT ;No direct entry
 ;
 ;---------------------------------------------------------------------------
 ;Patch DG*5.3*1111: Environment, Pre-Install, and Post-Install entry points.
 ;---------------------------------------------------------------------------
 ;
 ; Reference to BMES^XPDUTL supported by ICR #10141
 ; Reference to MES^XPDUTL supported by ICR #10141
 ; Reference to $$PATCH^XPDUTL in ICR #10141
 ; Reference to ^XMD in ICR #10070
 ;
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1111 Post-install routine...")
 ; Check if the patch has previously run and ^XTMP exists, if so quit out POST
 I $$PATCH^XPDUTL("DG*5.3*1111"),$D(^XTMP("DG531111P")) D  Q
 . D BMES^XPDUTL("Patch has been previously installed and ^XTMP(""DG531111P"" global")
 . D BMES^XPDUTL(" contains informational data from previous install.")
 . D BMES^XPDUTL(" The Post-install will not be run again.")
 . D BMES^XPDUTL(">>> Patch DG*5.3*1111 Post-install complete.")
 D POST1
 D POST2
 D BMES^XPDUTL(">>> Patch DG*5.3*1111 - Post-install complete.")
 Q
 ;
POST1 ; Rename any entries in ENROLLMENT STATUS file (#27.15) with REJECTED to DEFERRED
 D BMES^XPDUTL("  - Rename all entries in the ENROLLMENT STATUS file (#27.15)")
 D MES^XPDUTL("    with the name containing REJECTED to DEFERRED.")
 N DGOLDNAME,DGNAME,DGIEN,DGDATA,DGERR,DGOLD,DGNEW,DGCTR,DGERR
 S DGIEN=0
 S DGOLD="REJECTED"
 S DGNEW="DEFERRED"
 F  S DGIEN=$O(^DGEN(27.15,DGIEN)) Q:'DGIEN  D
 . S DGNAME=$$GET1^DIQ(27.15,DGIEN,.01)
 . ; No action needed if the name does not contain REJECTED
 . Q:DGNAME'[DGOLD
 . S DGOLDNAME=DGNAME
 . ; Replace REJECTED with DEFERRED in the name
 . F DGCTR=1:1:($L(DGNAME,$E(DGOLD))-1) I $F(DGNAME,DGOLD)>0 S $E(DGNAME,$F(DGNAME,DGOLD)-$L(DGOLD),$F(DGNAME,DGOLD)-1)=DGNEW
 . ; Set updated NAME back into the entry
 . S DGDATA(.01)=DGNAME
 . I $$UPD^DGENDBS(27.15,.DGIEN,.DGDATA,.DGERR) D
 . . D BMES^XPDUTL("Enrollment Status: ")
 . . D MES^XPDUTL(DGOLDNAME)
 . . D MES^XPDUTL("renamed to: ")
 . . D MES^XPDUTL(DGNAME)
 . I $G(DGERR)'="" D
 . . D BMES^XPDUTL("**** Error updating "_DGOLDNAME)
 . . D MES^XPDUTL(">>> Error: "_DGERR)
 . . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . . D MES^XPDUTL("    for assistance.")
 D BMES^XPDUTL("  - Rename of ENROLLMENT STATUS entries complete.")
 Q
 ;
POST2 ; Update the REMARKS field (#.091) in the PATIENT file (#2) to replace instances with
 ;      the text **REJECTED** with **DEFERRED**
 ;
 D BMES^XPDUTL("  - Queuing job to replace **REJECTED** with **DEFERRED** in the REMARKS")
 D MES^XPDUTL("    field (#.091) of the PATIENT file (#2) from all Patient records.")
 D BMES^XPDUTL("    All records in the PATIENT file (#2) will be scanned.")
 D MES^XPDUTL("    If the REMARKS field (#.091) contains the text **REJECTED**")
 D MES^XPDUTL("    it will be replaced with **DEFERRED**.")
 ;
 ;queue off job
 N ZTRTN,ZTDESC,ZTDTH,DGTEXT,ZTIO,ZTSK,DGTXT
 S ZTRTN="QJOB^DG531111P"
 S ZTDESC="DG*5.3*1111 Replace **REJECTED** with **DEFERRED** from the REMARKS (#.091) field in all Patient records."
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK)'="" D
 . S DGTEXT(1)=""
 . S DGTEXT(2)="Patient REMARKS data cleanup job queued."
 . S DGTEXT(3)="The task number is "_$G(ZTSK)_"."
 . S DGTEXT(4)=""
 . S DGTEXT(5)="A Mailman Message containing job results will be sent to the installer."
 I $G(ZTSK)="" D
 . S DGTEXT(1)=""
 . S DGTEXT(2)="*** Patient REMARKS data cleanup job FAILED TO QUEUE. ***"
 . S DGTEXT(3)=""
 . S DGTEXT(4)="  - Submit a YOUR IT Services ticket with the Enterprise Service Desk"
 . S DGTEXT(5)="    for assistance."
 D BMES^XPDUTL(.DGTEXT)
 Q
 ;
QJOB ; Job Entry point
 ; Information from the job will be placed in ^XTMP (60 day expiration) and sent in a Mailman message
 K ^XTMP("DG531111P")
 S ^XTMP("DG531111P",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"PATCH DG*5.3*1111 Patient REMARKS data cleanup job"
 ; Collect stats: start/end time and the number of records scanned and modified
 N %,DGDFN,DGCNT,DGERR,DGREM,DGREMORIG,DGDATA,DGDTS,DGDTE,Y,DGERRCNT,DGNEW,DGOLD,DGMAX,DGCTR
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTS=Y
 ;
 S (DGCNT,DGERRCNT,DGDFN)=0
 S DGOLD="**REJECTED**"
 S DGNEW="**DEFERRED**"
 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D  ; loop patients
 . ; Get REMARKS field data
 . S (DGREM,DGREMORIG)=$$GET1^DIQ(2,DGDFN,.091)
 . I DGREM'[DGOLD Q
 . S DGMAX=$L(DGREM)
 . ; Replace text in the DGREM string
 . F DGCTR=1:1:($L(DGREM,$E(DGOLD))-1) I $F(DGREM,DGOLD)>0 S $E(DGREM,$F(DGREM,DGOLD)-$L(DGOLD),$F(DGREM,DGOLD)-1)=DGNEW
 . ; Set updated remarks back into patient record
 . S DGDATA(.091)=DGREM
 . I $$UPD^DGENDBS(2,.DGDFN,.DGDATA,.DGERR) D  Q
 . . S DGCNT=DGCNT+1 ; bump count of patients we are updating
 . . S ^XTMP("DG531111P",$J,"IA",DGCNT)=DGDFN_U_DGREMORIG  ;update was successful, store the DFN and original REMARKS
 . ; If error occurred, record it in ^XTMP
 . I $G(DGERR)'="" D
 . . S DGERRCNT=DGERRCNT+1 ; bump count of errors
 . . S ^XTMP("DG531111P",$J,"IA","ERRORS",DGERRCNT)=DGDFN_U_DGERR ;set DFN and error into XTMP
 ;
 ; job completed, perhaps with an error, capture stats and send mailman message
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTE=Y
 ;
 ; Place job data into ^XTMP Global
 S ^XTMP("DG531111P",$J,"DGSTART")=$G(DGDTS) ;job start date/time
 S ^XTMP("DG531111P",$J,"DGEND")=$G(DGDTE) ;job end date/time
 S ^XTMP("DG531111P",$J,"PATIENT RECORDS MODIFIED")=DGCNT ; total records affected
 S ^XTMP("DG531111P",$J,"ERROR TOTAL")=DGERRCNT ; total error records
 ;
 D MESSAGE
 Q
 ;
MESSAGE ; Send MailMan Message when process completes
 N XMSUB,XMDUZ,XMY,XMTEXT,DGMSG,DGLN
 S XMY(DUZ)="",XMTEXT="DGMSG("
 S XMDUZ=.5,XMSUB="DG*5.3*1111 PATIENT REMARKS DATA CLEANUP JOB RESULTS"
 ;
 S DGMSG($I(DGLN))="The DG*5.3*1111 process has completed."
 S DGMSG($I(DGLN))=""
 I DGERRCNT D
 . S DGMSG($I(DGLN))="!!!! WARNING !!!!"
 . S DGMSG($I(DGLN))="  - Filing Errors encountered: "_DGERRCNT
 . S DGMSG($I(DGLN))="  - Submit a YOUR IT Services ticket with the Enterprise Service Desk"
 . S DGMSG($I(DGLN))="    for assistance with the errors. ***"
 . S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="This process ran through the PATIENT file (#2)"
 S DGMSG($I(DGLN))="and for each patient record, if the REMARKS field (#.091) contained"
 S DGMSG($I(DGLN))="the text **REJECTED** it was replaced with **DEFERRED**"
 S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="The process statistics:"
 S DGMSG($I(DGLN))="Job Start Date/Time: "_$G(DGDTS)
 S DGMSG($I(DGLN))="  Job End Date/Time: "_$G(DGDTE)
 S DGMSG($I(DGLN))="Total records with REMARKS text replaced: "_DGCNT
 S DGMSG($I(DGLN))="Errors encountered: "_DGERRCNT
 S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="If a list of records that had the REMARKS text replaced"
 S DGMSG($I(DGLN))="is needed, you may view global ^XTMP(""DG531111P"","_$J_",""IA"""
 S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="NOTE: The global ^XTMP(""DG531111P"") will be purged after 60 days."
 ; Per the MailMan Developer Guide, the variable DIFROM should be NEW'd prior to making the call to ^XMD.
 N DIFROM
 D ^XMD
 Q
