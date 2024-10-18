RORP042 ;ALB/FPT - CCR PRE/POST-INSTALL PATCH 42 ;9 FEB 2024  1:03 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**42**;Feb 17, 2006;Build 9
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;  
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*42   FEB 2024   F TRAXLER    Change REGISTRY STATUS(#11) field value
 ;                                     in ROR REGISTRY PARAMETERS (#798.1) file 
 ;                                     to "1" (INACTIVE) for VA TRANSGENDER.          
 ;******************************************************************************
 ;******************************************************************************
 ; 
 ;SUPPORTED CALLS:
 ; BMES^XPDUTL   #10141
 ;
PRE ; --- Pre-Install routine for Patch 42
 N RORREG,REGIEN
 N RORPARM
 S RORPARM("DEVELOPER")=1
 D BMES^XPDUTL("Updating FILE 798.1, FIELD #11")
 S RORREG="VA TRANSGENDER"
 S REGIEN=$$REGIEN^RORUTL02(RORREG)
 I REGIEN'>0 D  Q
 . D BMES^XPDUTL("Cannot find the "_RORREG_" entry in FILE #798.1.")
 . D BMES^XPDUTL("Please log a ticket.")
 ;Change REGISTRY STATUS field value
 K RORFDA,RORMSG
 S RORFDA(798.1,REGIEN_",",11)=1
 D UPDATE^DIE(,"RORFDA",,"RORMSG")
 D BMES^XPDUTL("COMPLETED.")
 Q
