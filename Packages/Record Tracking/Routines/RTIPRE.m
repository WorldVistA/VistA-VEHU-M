RTIPRE ;TROY ISC/PKE-preinit,NOMAP; 6/26/88 10:00AM
 ;;v 2.0;Record Tracking;;10/22/91 
 I $D(DUZ(0)),DUZ(0)="@"
 E  W !!,$C(7,7),?10,"DUZ(0) Must be set to @ !" K DIFQ Q
 D ^RTNTEG Q:'$D(DIFQ)
 I $D(VERSION),VERSION<17.33,'$D(^RT)!('$D(^RTV))
 E  D ALL Q
 ;
EN S I=0 F Z=3.6,19,19.1 I $D(^DD(Z,.01,"AUDIT")),^("AUDIT")="y" S ^TMP("RT_INIT_AUDIT",Z)="y",I=I+1 W:I=1 !!,"These files have audit enabled on the name field" D NAM
 ;
 IF I W !! D WRITMOR
 IF I=0 D ALL Q
 ;
ASK S U="^",DTIME=300,RTRD(0)="S",RTRD("B")=1
 S RTRD(1)="Yes^allow the program to disable audit now"
 S RTRD(2)="No^stop and audit may be disabled through fileman"
 S RTRD("A")="Allow this routine to disable auditing on files ? "
 D SET^RTRD K RTRD
 I $E(X)="Y" D DAUDIT,ALL Q
 I "N^"[$E(X) K DIFQ,^TMP("RT_INIT_AUDIT") QUIT
 ;
DAUDIT S I=0 F Z=3.6,19,19.1 I $D(^DD(Z,.01,"AUDIT")),^("AUDIT")="y" S ^DD(Z,.01,"AUDIT")="n" S I=I+1 W:I=1 !!?8,"Audit has been disabled on files " D NAM
 W:I !,"Audit should be re-enabled after the init complete's"
 W:I !,"There will be a confirmation message at the end of the init.",!!
 Q
 ;
EAUDIT ;called from post-init RTLOAD
 S I=0 F Z=3.6,19,19.1 I $D(^TMP("RT_INIT_AUDIT",Z)),$D(^DD(Z,.01,"AUDIT")),^("AUDIT")="n" S ^DD(Z,.01,"AUDIT")="y" S I=I+1 W:I=1 !!?8,"Audit has been re-enabled on files " D NAM
 W:I !
 K ^TMP("RT_INIT_AUDIT") Q
 ;
NAM W !?10,$P(^DIC(Z,0),"^"),?26,"File # ",Z Q
 ;
 ;
WRITMOR W !,"For the first installation of Record Tracking it is best to to disable"
 W !,"auditing or the initialization may fail after the first option, bulletin, or security key is filed."
 W !,"Auditing may be re-activated when the initialization is complete."
 Q
 ;
ALL W !!,"If this is the First Installation of Record Tracking you will want to answer",!,"Yes to all the questions from the DIFROM."
 W !!,"If Record Tracking has already been installed on this system, you should"
 W !,"probably answer NO to the questions 'WANT MY DATA ADDED TO YOURS'."
 W !!,"Two new label print field entries have been added to the Label Print"
 W !,"Field file:"
 W !,?12,"Ward Location and Current Borrower Date/Time"
 W !!,"Answer 'YES' to add this data to the Label Print Field file (#194.5)."
 W !!
 Q
