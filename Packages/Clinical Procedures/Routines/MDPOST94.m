MDPOST94 ;HPSC/MWA - POST INSTALLATION TASKS ;Jan 20, 2026@14:33
 ;;1.0;CLINICAL PROCEDURES;**94**;Sept 20, 2018;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL  Kernal  (supported)
 ;  #2263        - EN^XPAR     Kernal  (supported)
 ;
 Q
EN ; Update version number
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPCONSOLE","1.0.94.5")
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.94.5")
 ;
 D MES^XPDUTL(" MD*1.0*94 Post Init complete")
 Q
 ;
ROLLBACK ;Rollback code
 D MES^XPDUTL(" Rollback starting....updating Parameters...")
 ;
 ; Rollback MD PARAMETERS with old build numbers for executables.  
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPCONSOLE","1.0.86.2")
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.87.1")
 ;
 D MES^XPDUTL(" MD*1.0*94 rollback to MD*1.0*86 complete")
 D MES^XPDUTL(" MD*1.0*94 rollback to MD*1.0*87 complete")
 Q
