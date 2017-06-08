DG53147E ;ALB/KCL/CJM - ENVIRONMENT CHECK FOR PATCH DG*5.3*147 ; 15-DEC-1997
 ;;5.3;REGISTRATION;**147**; 13-AUG-93
 ;
 ;
EN ; This routine contains environmental checks which get executed
 ; before the DG*5.3*147 initialization is allowed to run.
 ;
 ;  Input: Variables set by KIDS during environment check
 ;
 ; Output:  XPDQUIT - KIDS variable set to abort installation
 ;         XPDABORT - KIDS variable set to abort installation
 ;
 N VERSION
 W !!,">>> Beginning the Environment Checker"
 ;
 D DCD ;  Check for DCD pilot version IVMC 1.0
 ;
 I $D(XPDABORT) W !!,">>> DG*5.3*147 Aborted in Environment Checker" Q
 W !!,">>> Environment Checker Successful",!!
 Q
 ;
 ;
DCD ; Check for installation of DCD pilot software IVMC v1.0.
 N VERSION
 ;
 W !!?5,"Checking for installation of IVM/DCD pilot version 1.0 ..."
 ;
 S VERSION=+$$VERSION^XPDUTL("IVMC")
 I VERSION>0 D
 .W !?10,"It looks like you currently have version ",VERSION," of the IVM/DCD pilot"
 .W !?10,"software installed.  This patch can not be installed at facilities"
 .W !?10,"running the IVM/DCD pilot software."
 .S XPDABORT=2
 ;
 Q
