IVM29EN ;ALB/KCL - ENVIRONMENT CHECK FOR PATCH IVM*2*9 ; 15-DEC-1997
 ;;2.0;INCOME VERIFICATION MATCH;**9**; 21-OCT-94
 ;
 ;
EN ; This routine contains environmental checks which get executed
 ; before the IVM*2*9 initialization is allowed to run.
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
 I $D(XPDABORT) W !!,">>> IVM*2*9 Aborted in Environment Checker" Q
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
