ZZTSETM ;BCIOFO/maw-reset test account process menu ;10/1/97
 ;;1.1;test account/system reset utilities;
 ;
 ; first, make sure the basic environment is set up...
 I '$D(DUZ) D
 .W !!,"DUZ is not defined.  Calling ^XUP to get things set up before we start."
 .W !,"Just press <return> at the OPTION prompt when it appears."
 .D ^XUP
 I +$G(DUZ)'>0 W $C(7),!!,"DUZ is undefined, environment unknown...process ABORTED!" Q
 ;
 ; check the UCI/namespace we're running in...
 X ^%ZOSF("UCI")
 S ZZUCI=Y
 I $E(ZZUCI)'="T" D  I $D(DIRUT) K DIROUT,DIRUT,X,Y Q
 .W $C(7)
 .W !!,"** WARNING :: WARNING :: WARNING **"
 .W !!,"This account/namespace (",ZZUCI,") does NOT appear to be your Test system!!"
 .W !,"Running ANY of the options in this utility on your production account will"
 .W !,"definitely cause you major problems."
 .W !!,"Please MAKE SURE YOU ARE LOGGED INTO YOUR TEST SYSTEM!!"
 .W $C(7)
 .K X,Y
 .S DIR(0)="YA"
 .S DIR("A")="Are you SURE you wish to continue? "
 .S DIR("B")="NO"
 .W ! D ^DIR K DIR
 .I Y'=1 D
 ..W !!,"Process ABORTED!"
 ..S DIRUT=1
 ;
 ; initialize the options array...
 K ZZOPTS
 S ZZOPTS(1)="[1] Re-christen the Test system domain^0"
 S ZZOPTS(2)="[2] Close MailMan Domains^0"
 S ZZOPTS(3)="[3] Disable Printers^0"
 S ZZOPTS(4)="[4] Reset VA Kernel (%Z*) Globals^0"
 S ZZOPTS(5)="[5] Set Up Options to Run at Startup^0"
 S ZZOPTS(6)="[6] Reset RPC Broker Parameters File^0"
 S ZZOPTS(7)="[7] Scramble Data in the Patient File^0"
 S ZZOPTS(8)="[8] Start Task Manager^0"
 ;
 F  D  Q:$D(DIRUT)
 .W @IOF
 .W !!,"You're logged into: ",ZZUCI
 .W !!,"Test Account Database/Parameters Reset Utility",!
 .S ZZOPTS=0
 .F  S ZZOPTS=$O(ZZOPTS(ZZOPTS)) Q:'ZZOPTS  D
 ..W !
 ..I $P(ZZOPTS(ZZOPTS),U,2)>0 W " <*>"
 ..W ?5,$P(ZZOPTS(ZZOPTS),U)
 .S DIR(0)="NAO^1:8"
 .S DIR("A")="Select OPTION: "
 .S DIR("?")="""<*> indicates you've accessed this option during this session."
 .S DIR("?",1)="Enter an option NUMBER; <return> or ""^"" to quit..."
 .W !
 .D ^DIR K DIR
 .I $D(DIRUT) Q
 .S ZZOPTION=Y
 .S ZZROUTIN="^ZZTSET"_ZZOPTION
 .W @IOF
 .D @ZZROUTIN
 .I '$D(DIRUT) S $P(ZZOPTS(ZZOPTION),U,2)=1
 .K DIROUT,DIRUT,X,Y,ZZOPTION,ZZROUTIN
 K DIROUT,DIRUT,X,Y,ZZOPTION,ZZOPTS,ZZROUTIN,ZZUCI
 Q
         
