DG531082P ;ALB/JAM - PATCH DG*5.3*1082 INSTALL UTILITIES ;2/25/21 09:12am
 ;;5.3;Registration;**1082**;Aug 13, 1993;Build 29
 ;
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to MES^XPDUTL in ICR #10141
 ; Reference to $$PATCH^XPDUTL in ICR #10141
 ; Reference to EVENT^IVMPLOG in ICR #2486
 ; Reference to DELIX^DDMOD in ICR #2916
 ;
 ;No direct entry
 QUIT
 ;
 ;--------------------------------------------------------------------------
 ;Patch DG*5.3*1082: Environment, Pre-Install, and Post-Install entry points.
 ;--------------------------------------------------------------------------
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1082 Pre-install routine...")
 D PRE1
 D BMES^XPDUTL(">>> Patch DG*5.3*1082 Pre-install complete.")
 Q
 ;
PRE1 ; Remove "-" from VHAP name "HUD-VASH RESTRICTED CARE"
 D BMES^XPDUTL("  - Updating the HEALTH BENEFIT PLAN file (#25.11)...")
 D MES^XPDUTL("  - Renaming HUD-VASH RESTRICTED CARE plan.")
 N DGOLDNAME,DGIEN,DGDATA,DGERR
 S DGOLDNAME="HUD-VASH RESTRICTED CARE"
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 I 'DGIEN  D MES^XPDUTL("  - HUD-VASH RESTRICTED CARE does not exist... No action required.") Q
 ; Rename the old plan to the new plan name 
 S DGDATA(.01)="HUD VASH RESTRICTED CARE"
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D  Q
 . D MES^XPDUTL("  - HUD-VASH RESTRICTED CARE plan renamed to")
 . D MES^XPDUTL("    HUD VASH RESTRICTED CARE")
 I $G(DGERR)'="" D
 . D MES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("   - The HUD-VASH RESTRICTED CARE plan was not updated.")
 . D MES^XPDUTL("   - Error: "_DGERR)
 . D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("     for assistance.")
 . D MES^XPDUTL(">>> DG*5.3*1082 Pre-install Routine Failed.")
 . D MES^XPDUTL("   - Installation Terminated.")
 . D MES^XPDUTL("   - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1082 Post-install routine...")
 D POST1
 D POST2
 D POST3
 D BMES^XPDUTL(">>> Patch DG*5.3*1082 Post-install complete.")
 Q
 ;
POST1 ; Add PRESUMPTIVE PSYCHOSIS ELIGIBLE eligibility to file #8
 NEW DGEC,DGFDA,DGERR
 S DGEC="PRESUMPTIVE PSYCHOSIS ELIGIBLE"
 D BMES^XPDUTL("  - Adding '"_DGEC_"' to the ELIGIBILITY CODE (#8) file.")
 I '$$FIND1^DIC(8.1,"","X",DGEC) D  Q
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - "_DGEC_" entry missing from MAS ELIGIBILITY CODE (#8.1) file")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 I $$FIND1^DIC(8,"","X",DGEC) D  Q
 . D BMES^XPDUTL("  - "_DGEC_" entry already exists... No action required.")
 ; Add entry to file
 S DGFDA(8,"+1,",.01)=DGEC
 S DGFDA(8,"+1,",.12)=0
 S DGFDA(8,"+1,",1)="RED"
 S DGFDA(8,"+1,",2)="PP"
 S DGFDA(8,"+1,",3)=12
 S DGFDA(8,"+1,",4)="N"
 S DGFDA(8,"+1,",5)="PRESUMPTVE PSYCHOSIS ELIG"
 S DGFDA(8,"+1,",7)=1
 S DGFDA(8,"+1,",8)=DGEC
 S DGFDA(8,"+1,",9)="VA STANDARD"
 S DGFDA(8,"+1,",11)="VA"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I '$D(DGERR) D BMES^XPDUTL("  - "_DGEC_" successfully added to ELIGIBILITY CODE (#8) file.")
 I $D(DGERR) D
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - "_DGEC_" was NOT successfully added to the ELIGIBILITY CODE (#8) file.")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
 ;
POST2 ; For patients with a PRESUMPTIVE PSYCHOSIS CATEGORY (#.5601) field in PATIENT file (#2), send HL7/Z07 message 
 D BMES^XPDUTL("  - Queuing job to send an HL7/Z07 message to the Enrollment System for")
 D MES^XPDUTL("     any patient with a PRESUMPTIVE PSYCHOSIS CATEGORY (#.5601) field value.")
 ; Quit if already installed and ^XTMP exists
 I $$PATCH^XPDUTL("DG*5.3*1082"),$D(^XTMP("DG531082P")) D MES^XPDUTL("  - Job does not need to be run since patch has been installed previously.") Q
 ;queue off job
 N ZTRTN,ZTDESC,ZTDTH,DGTEXT,ZTIO,ZTSK
 S ZTRTN="QJOB^DG531082P"
 S ZTDESC="DG*5.3*1082 Send HL7/Z07 message for any patient with a PRESUMPTIVE PSYCHOSIS CATEGORY (#.5601) field value."
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 S DGTEXT(1)="  - Presumptive Psychosis HL7/Z07 job queued."
 S DGTEXT(2)="  - The task number is "_$G(ZTSK)_"."
 D MES^XPDUTL(.DGTEXT)
 Q
 ;
QJOB ; Job Entry point
 ; Sweep through PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1) file - "B" xref - and for each DFN found
 ;  check for a value in PATIENT (#2) file, field .5601 and if there is a value, send HL7/Z07
 ; Information from the job will be placed in ^XTMP (60 day expiration) and sent in a Mailman message
 K ^XTMP("DG531082P")
 S ^XTMP("DG531082P",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"PATCH DG*5.3*1082 Presumptive Psychosis job"
 ; Collect stats: start/end time and the number of records scanned and number of Z07's sent
 N %,DGDTS,DGDTE,Y
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTS=Y
 ;
 N DGIEN,DGCAT,DGCNT,DGHLCNT
 S (DGCNT,DGHLCNT,DGIEN)=0
 F  S DGIEN=$O(^DGPP(33.1,"B",DGIEN)) Q:'DGIEN  D
 . S DGCNT=DGCNT+1
 . S DGCAT=$$GET1^DIQ(2,DGIEN_",",.5601,"I")
 . Q:DGCAT=""
 . D EVENT^IVMPLOG(DGIEN)
 . S DGHLCNT=DGHLCNT+1
 . S ^XTMP("DG531082P",$J,"Z07",DGHLCNT)=DGIEN
 ; job completed, capture stats and send mailman message
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTE=Y
 D SENDMSG
 ; Place job data into ^XTMP Global
 S ^XTMP("DG531082P",$J,"DGSTART")=$G(DGDTS) ;job start date/time
 S ^XTMP("DG531082P",$J,"DGEND")=$G(DGDTE) ;job end date/time
 S ^XTMP("DG531082P",$J,"TOTAL")=DGHLCNT ; total records affected
 Q
 ;
SENDMSG ;Send MailMan message when process completes
 N XMSUB,XMDUZ,XMY,XMTEXT,DGMSG,DGLN
 S XMY(DUZ)="",XMTEXT="DGMSG("
 S XMDUZ=.5,XMSUB="DG*5.3*1082 PRESUMPTIVE PSYCHOSIS HL7/Z07 JOB "
 S DGMSG($$LN)="The DG*5.3*1082 process has completed."
 S DGMSG($$LN)=""
 S DGMSG($$LN)="This process ran through the PRESUMPTIVE PSYCHOSIS CATEGORY CHANGES (#33.1)"
 S DGMSG($$LN)="file and for each patient record found, the PRESUMPTIVE PSYCHOSIS CATEGORY"
 S DGMSG($$LN)="(#.5601) field in the PATIENT (#2) file was checked for a value."
 S DGMSG($$LN)="If a value was found, an HL7/Z07 message was queued to the Enrollment System."
 S DGMSG($$LN)="Note: The queued HL7 messages won't be sent until the IVM BACKGROUND JOB"
 S DGMSG($$LN)="      [IVM BACKGROUND JOB] option is run."
 S DGMSG($$LN)="      If any HL7 consistency check fails, the HL7 message is not sent."
 S DGMSG($$LN)=""
 S DGMSG($$LN)="The process statistics:"
 S DGMSG($$LN)="Job Start Date/Time: "_$G(DGDTS)
 S DGMSG($$LN)="  Job End Date/Time: "_$G(DGDTE)
 S DGMSG($$LN)="Total records with a Presumptive Psychosis Category: "_+$G(DGHLCNT)
 S DGMSG($$LN)=""
 S DGMSG($$LN)="If a list of records that had an HL7/Z07 message queued to the Enrollment"
 S DGMSG($$LN)="System is needed, you may view global ^XTMP(""DG531082P"","_$J_",""Z07"""
 S DGMSG($$LN)=""
 S DGMSG($$LN)="NOTE: The global ^XTMP(""DG531082P"") will be purged after 60 days."
 D ^XMD
 Q
LN() ;Increment line counter
 S DGLN=$G(DGLN)+1
 Q DGLN
 ;
POST3 ; ;Remove x-ref on PRESUMPTIVE PSYCHOSIS field #.5601 of the PATIENT file #2
 ; CROSS-REFERENCE:  2^AX^MUMPS
 ;
 ; Quit if patch previously installed
 I $$PATCH^XPDUTL("DG*5.3*1082") Q
 ;
 N DGERR
 D BMES^XPDUTL("  - Removing 'AX' cross-reference on the PRESUMPTIVE PSYCHOSIS (#.5601) field")
 D MES^XPDUTL("    of the PATIENT (#2) file.")
 D DELIX^DDMOD(2,.5601,1,,,"DGERR")
 ; No error, xRef deleted
 I '$D(DGERR) D MES^XPDUTL("  - Cross reference removed.") Q
 ; Error encountered, xRef not deleted.
 D BMES^XPDUTL(" ** ERROR encountered deleting the cross reference. **")
 D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 D MES^XPDUTL("    for assistance.")
 Q
