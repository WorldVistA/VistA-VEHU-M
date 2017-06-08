PXRMP21E ; SLC/JVS - Inits for PXRM*1.5*21 ;11/25/03  10:38
 ;;1.5;CLINICAL REMINDERS;**21**;Jun 19, 2000
 ;===============================================================
ENV ;Environment check
 ;
 ;Make sure the user has programmer access
 I $G(DUZ(0))'="@" D  Q
 .D BMES^XPDUTL("Programmer access required") S XPDQUIT=2
 ;Make sure the package version is 1.5 and not 2.0
 I $$VERSION^XPDUTL("PXRM")'=1.5 D  Q
 .D BMES^XPDUTL("Not Reminder Package Version 1.5") S XPDQUIT=2
 Q
