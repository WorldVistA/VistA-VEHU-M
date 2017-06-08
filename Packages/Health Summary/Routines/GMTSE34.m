GMTSE34 ; CIO/SLC - Environment Check GMTS*2.7*34    ; 05/01/2000
 ;;2.7;Health Summary;**34**;Oct 20, 1995
 ;
ENV ; Environment Check
 ;   Not version 1.5
 I +($$VERSION^XPDUTL("PXRM"))'=1.5 W !," >>  Clinical Reminders version 1.5 not found.  Please install Clinical",!,"     Reminders (PXRM) v 1.5" G EXIT
 ;   Missing Install Routines
 I +($$ROK("GMTSXPD5"))'>0 W !," >>  Can not find component install routines GMTSXPD*.  Please install",!,"     GMTS*2.7*35 first" G EXIT
 ;   Missing Patch 35
 I +($$PROK("GMTSXPD5",35))'>0 W !," >>  Can not find GMTS*2.7*35 install.  Please install GMTS*2.7*35 first" G EXIT
 ;
QUIT ;     Quit   Passed Environment Check
 W !!," Environment is ok",!
 Q
EXIT ;     Exit   Failed Environment Check
 S XPDQUIT=2 Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 S XPDQUIT=1 Q
PROK(X,Y) ; Routine and Patch # OK (in UCI)
 N GMTS,GMTSI,GMTSO S X=$G(X),Y=$G(Y) Q:'$L(X) 0 Q:Y'=""&(+Y=0)
 S Y=+Y,GMTS=$$ROK(X) Q:'GMTS 0 Q:+Y=0 1 S GMTSO=0,GMTS=$T(@("+2^"_X)),GMTS=$P($P(GMTS,"**",2),"**",1)
 F GMTSI=1:1:$L(GMTS,",") S:+($P(GMTS,",",GMTSI))=Y GMTSO=1 Q:GMTSO=1
 S X=GMTSO Q X
ROK(X) ; Routine OK (in UCI) (NDBI)
 S X=$G(X) Q:'$L(X) 0 Q:$L(X)>8 0 X ^%ZOSF("TEST") Q:$T 1 Q 0
