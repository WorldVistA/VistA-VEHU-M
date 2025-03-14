EC2P147A ;ALB/DBE - EC National Procedure Update;07/15/19
 ;;2.0;EVENT CAPTURE;**147**;8 May 96;Build 1
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file (#725)
 ;
 Q
 ;
POST ; entry point
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Updating the EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 ;* add new/edit national procedures
 D ADDPROC^EC2P147B ;add new procedures
 D NAMECHG^EC2P147B ;change description
 D CPTCHG^EC2P147C  ;change CPT code
 D INACT^EC2P147C   ;inactivate code
 ;
 ;create task to inspect event code screens
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 10/02/19 at 1:00 AM. If this patch is installed after that time")
 D MES^XPDUTL("the inspection will queue immediately.")
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3191002.0100,ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 D BMES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job.")
 D MES^XPDUTL("You will receive a MailMan message with the results on 10/02/19.")
 ;
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
