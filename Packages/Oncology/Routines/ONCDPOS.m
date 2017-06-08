ONCDPOS ;WISC/MLH-ROUTINES FOR PATCH ONC*2.1*8-REMOVE PACKAGE ENTRY ;3/9/94  15:37
 ;;2.1;Oncology;**8**;Oct 29, 1993
 N UCIVOL X ^%ZOSF("UCI") S UCIVOL=Y ;    define UCI and volume set
 ;    don't purge Washington ISC's development environment
 I $E(UCIVOL,1,2)'="DV",$P(UCIVOL,",",2)'="MED" D REMVPKG
 W !!,"Patch installation completed successfully."
 QUIT
 ;
REMVPKG W !!,"Now removing the ONCD entry from the PACKAGE File..."
 S DIC=9.4,DIC(0)="",D="C",X="ONCD" D IX^DIC K DIC,D,X ;    find the entry
 N PKGNO S PKGNO=$P(Y,U)
 IF PKGNO>0 D  ;    entry found?  yes, delete it
 .  S DIK="^DIC(9.4,",DA=PKGNO D ^DIK
 .  K DIK,DA,ONC
 .  W "Done."
 .  Q
 ELSE  W !!,*7,"ERROR:  Entry not found.  (Call your ISC for assistance.)",!! ;    no, weird.. it should be there
 ;END IF
 ;
 Q
