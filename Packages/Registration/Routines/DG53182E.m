DG53182E ;ALB/SEK - DG*5.3*182 Environment Check Routine ; 14-AUGUST-1999
 ;;5.3;Registration;**182**;Aug 13, 1993
 ;
 ;
EN ; Description: This entry point will be used as a driver for
 ;  environment checks.
 ;
 ; Check for FILEMAN version 22.0
 D FILEMAN
 Q
 ;
 ;
FILEMAN ; Check for FILEMAN version 22.0
 ;
 N VERSION
 D BMES^XPDUTL(">>> Checking for FILEMAN version 22.0")
 S VERSION=$$VERSION^XPDUTL("DI") I VERSION<22.0 D  Q
 .; Install aborted, transport globals not deleted
 .S XPDABORT=2
 .D MES^XPDUTL("    FILEMAN version 22.0 must be installed before")
 .D MES^XPDUTL("    this patch can be installed.  Install aborted")
 .D MES^XPDUTL("    and transport globals not deleted.")
 .Q
 ;
 D MES^XPDUTL("     FILEMAN version 22.0 is installed.")
 D MES^XPDUTL("     Install continues.")
 Q
