ORY582 ; SLC/TDP - Post Install Routine ;11/07/25  09:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**582**;Dec 17, 1997;Build 9
 ;
 ;Reference to $$DT^XLFDT,$$FMADD^XLFDT in ICR #10103
 ;Reference to MES^XPDUTL,BMES^XPDUTL in ICR #10141
 Q
 ;
POST ;Post-Init Entry Point
 D BACKUP
 D S^ORY582ES ;Call the Build Rule Transport Routine
 Q
 ;
BACKUP ;Backup the GLUCOPHAGE-LAB RESULTS entry in the Order
 ;   Check Rule (#860.2) file.
 N NEWDT,OCRIEN,ORDESC
 I $D(^XTMP("ORY582",0)) D  Q  ;Quit if backup already created
 . ;Extend Purge Date by 120 days
 . S NEWDT=$$FMADD^XLFDT($P(^XTMP("ORY582",0),U,1),120,0,0,0)
 . S $P(^XTMP("ORY582",0),U,1)=NEWDT
 S OCRIEN=$O(^OCXS(860.2,"B","GLUCOPHAGE - LAB RESULTS",0))
 I OCRIEN'>0 Q
 D BMES^XPDUTL("Backing up GLUCOPHAGE - LAB RESULTS Order Check Rule from file #860.2")
 M ^XTMP("ORY582",1)=^OCXS(860.2,OCRIEN)
 I $D(^XTMP("ORY582",1)) D
 . I 'DT S DT=$$DT^XLFDT
 . S NEWDT=$$FMADD^XLFDT(DT,120,0,0,0) ;Add 120 days to today's date for Purge
 . S ORDESC="OR*3*582 Post-Init Backup of 860.2 GLUCOPHAGE - LAB"
 . S ORDESC=ORDESC_" RESULTS Order Check Rule"
 . S ^XTMP("ORY582",0)=NEWDT_U_DT_U_ORDESC
 D MES^XPDUTL("   Completed!")
 Q
