EC2P162A ;HDSO/RD - EC National Procedure Update; May 19, 2023@09:50
 ;;2.0;EVENT CAPTURE;**162**;May 8, 1996;Build 2
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the EC National Procedure file (#725) for FY24.
 ;
 ; Reference to ^%ZTLOAD supported by ICR# 10063
 ; Reference to BMES^XPDUTL supported by ICR# 10141
 ; Reference to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ;Entry point
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Updating the EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 ;
 ;* add new/edit national procedures
 ;D ADDPROC^EC2P162B  ;add new procedures - No FY24 Request
 D NAMECHG^EC2P162B  ;change description
 ;D REACT^EC2P162C    ;reactivate code - No FY24 Request
 D CPTCHG^EC2P162C   ;change CPT code
 D INACT^EC2P162C    ;inactivate code
 ;
 ;create task to inspect event code screens
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 10/02/2023 at 1:00 AM. If this patch is installed after that")
 D MES^XPDUTL("time, the inspection will queue immediately.")
 D MES^XPDUTL(" ")
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3231002.0100
 S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 D MES^XPDUTL("will receive a MailMan message with the results on 10/02/2023.")
 D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
