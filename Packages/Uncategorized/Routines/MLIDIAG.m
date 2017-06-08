MLIDIAG ;ALB/MLI - Diagnostic routine to generate e-mail of symbol table ; 10/13/94<<= NOT VERIFIED >
 ;;Version 1.0;;**28**;
 ;
 ; This routine will be called whenever there is no text in the 'Stop
 ; Code Background Errors' bulletin.  It will list the key variables
 ; that should be defined at the time.  This should help us in diagnosing
 ; the particular cause of receiving null messages.
 ;
EN ; begin processing
 K XMY
 S XMY("INSLEY,MARCIA@ISC-ALBANY.VA.GOV")="" ; send bulletin to Albany
 S SDBUL(1)="DUZ:         "_$G(DUZ)
 S SDBUL(2)="SDFN:         "_$G(SDFN)
 S SDBUL(3)="MARCIA:       "_$G(MARCIA)
 S SDBUL(4)="ARRAY:        "_$G(^TMP("SDAMIDX",$J,+$O(^TMP("SDAMIDX",$J,0))))
 S XMSUB="Almost error at "_$$SITE^VASITE()
 S XMTEXT="SDBUL("
 D ^XMD
 K XMY,SDBUL,XMTEXT,XMSUB,MARCIA
 Q
