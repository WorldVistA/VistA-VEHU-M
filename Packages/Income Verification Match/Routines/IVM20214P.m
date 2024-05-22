IVM20214P ;ALB/KUM - IVM*2*214 INSTALL UTILITY;12/20/23 1:36pm
 ;;2.0;INCOME VERIFICATION MATCH;**214**;21-OCT-94;Build 18
 ;
QUIT ;No direct entry
 ;
 ;---------------------------------------------------------------------------
 ;Patch IVM*2.0*214: Environment, Pre-Install, and Post-Install entry points.
 ;---------------------------------------------------------------------------
 ;
 ; Reference to BMES^XPDUTL supported by ICR #10141
 ; Reference to MES^XPDUTL supported by ICR #10141
 ; Reference to $$PATCH^XPDUTL in ICR #10141
 ; Reference to ^XMD in ICR #10070
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,IVMTEXT,ZTSK
 D BMES^XPDUTL(">>> Beginning the IVM*2.0*214 Post-install routine...")
 ;Check if the patch has previously run and data in ^XTMP("IVM20214P, if so quit out POST
 I $$PATCH^XPDUTL("IVM*2.0*214"),$D(^XTMP("IVM20214P")) D  Q
 . D BMES^XPDUTL("Patch has been previously installed and ^XTMP(""IVM20214P"" global contains")
 . D BMES^XPDUTL(" deleted PHONE NUMBER [WORK] records.  Post-install will not be run again.")
 . D BMES^XPDUTL(">>> Patch IVM*2.0*214 Post-install complete.")
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("   The Post Install will now process through the IVM PATIENT")
 D BMES^XPDUTL("   (#301.5) File to remove PHONE NUMBER [WORK] entries.")
 D BMES^XPDUTL(" ")
 ;queue off job
 S ZTRTN="POST1^IVM20214P"
 S ZTDESC="IVM*2.0*214 Remove PHONE NUMBER [WORK] entries from IVM PATIENT (#301.5) File."
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK)'="" D
 . S IVMTEXT(1)=""
 . S IVMTEXT(2)="PHONE NUMBER [WORK] entries cleanup job queued."
 . S IVMTEXT(3)="   The task number is "_$G(ZTSK)_"."
 . S IVMTEXT(4)=""
 . S IVMTEXT(5)="A Mailman Message containing job results will be sent to the installer."
 I $G(ZTSK)="" D
 . S IVMTEXT(1)=""
 . S IVMTEXT(2)="*** PHONE NUMBER [WORK] entries cleanup job FAILED TO QUEUE. ***"
 . S IVMTEXT(3)=""
 . S IVMTEXT(4)="  - Submit a YOUR IT Services ticket with the Enterprise Service Desk"
 . S IVMTEXT(5)="    for assistance."
 D BMES^XPDUTL(.IVMTEXT)
 D BMES^XPDUTL(">>> Patch IVM*2.0*214 Post-install complete.")
 Q
 ;
POST1 ;Entry point to queue off job
 N %,IVMCNT,IVMI,IVMJ,IVM0NODE,IVMDFN,IVM0DPT,IVMDA,IVMDEMO,IVMSTATE,IVMCNT,IVMDTE,IVMDTS
 K ^XTMP("IVM20214P")
 S ^XTMP("IVM20214P",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"PATCH IVM*2.0*214 CLEANUP PHONE NUMBER [WORK] ENTRIES FROM IVM PATIENT (#301.5) File"
 S IVMCNT=0
 D NOW^%DTC S Y=% D DD^%DT
 S IVMDTS=Y
 ;
 ;
 ; - get patients with demographic fields from ASEG x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.5,"ASEG","PID",IVMI)) Q:'IVMI  D
 .S IVM0NODE=$G(^IVM(301.5,IVMI,0)) I IVM0NODE']"" Q
 .S IVMDFN=+IVM0NODE,IVM0DPT=$G(^DPT(+IVMDFN,0)) I IVM0DPT']"" Q
 .;
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,"ASEG","PID",IVMI,IVMJ)) Q:'IVMJ  D
 ..F IVMDA=0:0 S IVMDA=$O(^IVM(301.5,IVMI,"IN",IVMJ,"DEM",IVMDA)) Q:'IVMDA  D
 ...; - grab node with IVM-supplied data
 ...S IVMDEMO=$G(^IVM(301.5,IVMI,"IN",IVMJ,"DEM",IVMDA,0)) I IVMDEMO="" Q
 ...I +$P(IVMDEMO,"^")'=$O(^IVM(301.92,"B","PHONE NUMBER [WORK]",0)) Q
 ...S IVMSTATE=$P(IVMDEMO,"^",2)
 ...S IVMCNT=IVMCNT+1
 ...S ^XTMP("IVM20214P",IVMCNT)=IVMDFN_"^"_IVMI_"^"_IVMJ_"^"_IVMDA_"^"_IVMSTATE
 ...D DELENT^IVMLDEMU(IVMI,IVMJ,IVMDA)
 ;
 ;
 ; job completed, perhaps with an error, capture stats and send mailman message
 D NOW^%DTC S Y=% D DD^%DT
 S IVMDTE=Y
 ;
 ; Place job data into ^XTMP Global
 S ^XTMP("IVM20214P",$J,"IVMSTART")=$G(IVMDTS) ;job start date/time
 S ^XTMP("IVM20214P",$J,"IVMEND")=$G(IVMDTE) ;job end date/time
 S ^XTMP("IVM20214P",$J,"PHONE NUMBER [WORK] RECORDS CLEANED")=IVMCNT ; total records affected
 ;
 D MSG
 Q
 ;
SCR(Y) ;Screen Logic to be called from IVM*2.0*214 build to merge entries from IVM DEMOGRAPHIC UPLOAD (#301.92) file
 N IVMSET
 S IVMSET=0
 I (($P($G(^IVM(301.92,+Y,0)),U,2)["RF171PW")!($P($G(^IVM(301.92,+Y,0)),U,2)["PID13W")) S IVMSET=1
 Q IVMSET
 ; 
MSG ; All data is collected in ^TMP("IVM20214P") - put together email message
 N XMSUB,XMDUZ,XMY,XMTEXT,IVMMSG,IVMLN,IVMSITE
 S IVMSITE=$$SITE^VASITE
 S XMY(.5)=""
 S XMY(DUZ)=""
 S XMTEXT="IVMMSG("
 S XMDUZ=.5,XMSUB="IVM*2.0*214-CLEANUP OF PHONE NUMBER [WORK] ENTRIES IN (#301.5)"
 S IVMMSG($I(IVMLN))=""
 S IVMMSG($I(IVMLN))="The job completed to clean PHONE NUMBER [WORK] records in the IVM PATIENT "
 S IVMMSG($I(IVMLN))="(#301.5) File. ^XTMP(""IVM20214P"" global contains deleted records for "
 S IVMMSG($I(IVMLN))="reference and the format is DFN^IEN OF #301.5^IEN OF SUBFILE #301.501^"
 S IVMMSG($I(IVMLN))="IEN OF SUBFILE #301.511^PHONE NUMBER[WORK]."
 S IVMMSG($I(IVMLN))=""
 S IVMMSG($I(IVMLN))="Job Results:"
 S IVMMSG($I(IVMLN))="------------"
 S IVMMSG($I(IVMLN))="Facility Name: "_$P(IVMSITE,"^",2)
 S IVMMSG($I(IVMLN))="Station Number: "_$P(IVMSITE,"^",3)
 S IVMMSG($I(IVMLN))=""
 S IVMMSG($I(IVMLN))="The process statistics:"
 S IVMMSG($I(IVMLN))="Job Start Date/Time: "_$G(IVMDTS)
 S IVMMSG($I(IVMLN))="  Job End Date/Time: "_$G(IVMDTE)
 S IVMMSG($I(IVMLN))="Total PHONE NUMBER [WORK] records deleted: "_IVMCNT
 S IVMMSG($I(IVMLN))=""
 S IVMMSG($I(IVMLN))="NOTE: The global ^XTMP(""IVM20214P"") will be purged after 60 days."
 S IVMMSG($I(IVMLN))=""
 ; send mail message with results
 ; Per the MailMan Developer Guide, the variable DIFROM should be NEW'd prior to making the call to ^XMD.
 N DIFROM
 D ^XMD
 Q
