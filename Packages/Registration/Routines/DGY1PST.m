DGY1PST ;ALB/ABR - CLEAN UP FOR DGBT CLAIM FILE (392),  9/14/95
 ;;5.3;Registration;**60**;Aug 13, 1993
 ;
EN ;
 N I,X
 W !!,"Bene Travel Claim file clean-up",!
 I '$D(DUZ) W !,"DUZ NOT DEFINED.  CANNOT CONTIUE.",! Q
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W !,X
QUE S ZTRTN="UPD^DGY1PST",ZTDESC="BT CLAIMS FILE CERT. DATE CLEAN-UP",ZTIO=""
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):">>>Task "_ZTSK_" has been queued.",1:">>>    UNABLE TO QUEUE THIS JOB.")
 Q
UPD ;
 N DA,DIE,DR,DGY1,DGYX,DGYST
 S DGYST=$$HTE^XLFDT($H)
 S (DGYX,DA)=0,DIE="^DGBT(392,",DR="""5///""_DGY1"
 F  S DA=$O(^DGBT(392,DA)) Q:'DA  S DGY1=$P($G(^(DA,0)),U,5) I $E(DGY1)?1A S DR="5///"_DGY1 D
 .D ^DIE
 .I '$D(ZTQUEUED) S DGYX=DGYX+1 W:'(DGYX#20) "."
 I '$D(ZTQUEUED) W !!,"<< DONE >>",! Q
 D MAIL
 Q
MAIL ;
 N BTTEXT,DIFROM
 S BTTEXT(1)="The Bene Travel Claims file clean-up began on "_DGYST
 S BTTEXT(2)="and ran to completion on "_$$HTE^XLFDT($H)_"."
 S BTTEXT(3)=" ",BTTEXT(4)="** Please delete the DGY1* routines at this time. **"
 S XMSUB="BT Claims file clean-up is complete",XMTEXT="BTTEXT("
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K BTTEXT
 Q
TEXT ; description of routine
 ;;This will loop through the Bene Travel Claims file (#392)
 ;;and ensure that any Certification Dates present are stored
 ;;in the correct format.
 ;;  
 ;;THIS CLEAN-UP MAY TAKE SOME TIME, AND MUST BE QUEUED!!
 ;;  
 ;;QUIT
