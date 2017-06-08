ONCAENV ;WISC/MLH-ROUTINES FOR PATCH ONC*2.1*3-CHECK ENVIRONMENT ;2/14/94  08:53
 ;;2.1;Oncology;**3**;Oct 29, 1993
 N OK2GO ;    proceed flag
 N X ;    scratch var
 S X="ONCOU" X ^%ZOSF("TEST") S OK2GO=$T ;    does routine ONCOU exist?
 IF 'OK2GO D
 .  N ONC,I F I=1:1:5 S ONC(I)=""
 .  S ONC(3)="ERROR:  Routine ONCOU not found."
 .  D EN^DDIOL(.ONC)
 .  Q
 ELSE  S OK2GO=$$VERCHK^ONCOU("ONCOLOGY",2.1,3) ;    right version?
 ;END IF
 ;
 I 'OK2GO K DIFQ ;    don't proceed if not OK.
 QUIT
