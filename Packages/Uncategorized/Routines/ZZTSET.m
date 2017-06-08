ZZTSET ;BCIOFO/MAW-main routine for test account set-up after a restore ;9/1/97
 ;;1.0;;test system reset utilities;
 ;
 I '+$G(DUZ) D  Q
 .W $C(7)
 .W !!,"DUZ is undefined.  The environment is not set up correctly to run this routine."
 .W !,"Please DO ^XUP to set up the environment and then DO this routine again."
 ;
 W @IOF
 W !!,"TEST SYSTEM SET UP AFTER RESTORING PRODUCTION SYSTEM BACKUP"
 W !!,"This routine will perform several functions necessary to reset certain file"
 W !,"entries after you have restored the TEST system from a VAH system backup."
 W !,"I'll tell you about each part and ask your permission to execute the changes."
 W !!,"If you used the cookbook set up for the Test system, remember that the"
 W !,"namespace for the Test system is TST, and that the domain name is"
 W !,"TEST.yoursite.VA.GOV.  If you have deviated from the cookbook set up, just"
 W !,"be aware of your differences while editing the fields in the various files"
 W !,"called from this routine."
 ;
 S DIR(0)="YA"
 S DIR("A")="Okay to continue? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W !!,"Process aborted."
 .K DIROUT,DIRUT,X,Y
 ;
 ; process through the subroutines (NOTE:  there are 7 routines, the last one,
 ; ^ZZTSET7, contains the TaskMan startup call.  If you add routines to the
 ; reset procedures, it is suggested that you always call ^ZZTSET7 last.)
 ;
 F ZZ=1:1:7 D  Q:$D(ZZABORT)
 .S ZZPART="^ZZTSET"_ZZ
 .D @ZZPART
 .I $D(DIRUT) D
 ..K DIRUT
 ..S DIR(0)="YA"
 ..S DIR("A")="Do you wish to abort execution of this entire routine? "
 ..S DIR("B")="YES"
 ..W ! D ^DIR K DIR
 ..I Y=1!($D(DIRUT)) D
 ...W !!,"Okay...process aborted."
 ...S ZZABORT=1
 ..K DIROUT,DIRUT,X,Y
 I '$D(ZZABORT) W !!,"Test system set up procedures completed."
 K DIROUT,DIRUT,X,Y,ZZABORT,ZZPART
 Q
