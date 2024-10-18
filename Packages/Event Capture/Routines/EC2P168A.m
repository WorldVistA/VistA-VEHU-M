EC2P168A ;MNT/JB - EC National Procedure Update; April 19, 2024@15:50
 ;;2.0;EVENT CAPTURE;**168**;May 8, 1996;Build 8
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the EC National Procedure file (#725) for FY25.
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
  ; File Backup prior to Install  
 N EC168FILES
 S EC168FILE=""
 S EC168FILES="725"
 S ECCNT=0
 F ECCNT=1:1:$L(EC168FILES,"^") D
 . S EC168FILE=$P(EC168FILES,"^",ECCNT)
 . D GLBBKUP
 . Q
 ;* add new/edit national procedures
 ;D ADDPROC^EC2P168B  ;add new procedures - No FY25 Request
 D NAMECHG^EC2P168B  ;change description
 D REACT^EC2P168C    ;reactivate code
 D CPTCHG^EC2P168C   ;change CPT code
 D INACT^EC2P168C    ;inactivate code
 ;
 ;create task to inspect event code screens
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 10/2/2024 at 1:00 AM. If this patch is installed after that")
 D MES^XPDUTL("time, the inspection will queue immediately.")
 D MES^XPDUTL(" ")
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3241002.0100
 S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 D MES^XPDUTL("will receive a MailMan message with the results on 10/2/2024.")
 D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 S ECBKUPNDE="EC*2*168-EC NATIONAL CODE UPDATES FOR FY25 - FILE BACKUP"
 S ^XTMP("EC2P168",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_ECBKUPNDE
 M ^XTMP("EC2P168",EC168FILE,$H)=^EC(EC168FILE)
 Q
