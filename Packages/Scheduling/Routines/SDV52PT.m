SDV52PT ;ALB/MJK,MC - SD POST-INIT FOR VERSION 5.2 DRIVER ;4/2/92  09:55
 ;;5.2;SCHEDULING;;JUL 29,1992
EN I DGVCUR<5.11
 D LIST
 Q
 ;
BAR ; -- set kyocera barcode logic in terminal type entry
 N SDDA,Y,X,DA
 W !!,">>> Kyocera Barcode Logic Input Utility"
 W !!,"This utility will add the PRESCRIBE logic needed to print barcodes "
 W !,"on a Kyocera printer. (PRESCRIBE is the native language of the Kyocera"
 W !,"laser printer.)"
 W !!,"You will select an entry in the TERMINAL TYPE(#3.2) file and this"
 W !,"utility will enter the PRESCRIBE barcode logic."
 W !!,"The fields affected and the logic are list below:"
 W !,"       Field           PRESRCIBE Logic"
 W !,"       -----           ---------------"
 W !,"    60 BARDCODE ON     ",$P($T(BARON),";;",2)
 W !,"    61 BARCODE OFF     ",$P($T(BAROFF),";;",2)
 W !!,"To print barcodes on the scheduling appointment lists,"
 W !,"this logic needs to be present in these fields."
 W !! S DIR("A")="Do you wish to continue",DIR(0)="Y" D ^DIR K DIR G BARQ:'Y
 D PTR
BARQ Q
BARON ;;"!R! UNIT I; SCP; BARC 19, Y, '"
BAROFF ;;"', .4, .4, .01, .03, .03, .03, .01, .03, .03, .03; RPP; EXIT;"
 ;
PTR ; -- select devices
 S DIC=3.2,DIC(0)="AEMQ",DIC("S")="I $E($P(^(0),U),1,2)=""P-"""
 W !! S DIC("A")="Select Printer Terminal Type: " D ^DIC K DIC G PTRQ:Y<0 S SDDA=+Y
 W !!,"Current barcode settings for '",$P(Y,U,2),"' are the following:"
 W !,"      BARDCODE ON: ",$G(^%ZIS(2,SDDA,"BAR1"))
 W !,"      BARCODE OFF: ",$G(^%ZIS(2,SDDA,"BAR0"))
 W ! S DIR("A")="Ok to update '"_$P(Y,U,2)_"' printer",DIR(0)="Y" D ^DIR K DIR G PTR:'Y
 S DA=SDDA,DIE=3.2,DR="60////^S X=$C(34)_""!R! UNIT I""_$C(59)_"" SCP""_$C(59)_"" BARC 19, Y, '""_$C(34);61////^S X=$C(34)_""', .4, .4, .01, .03, .03, .03, .01, .03, .03, .03""_$C(59)_"" RPP""_$C(59)_"" EXIT""_$C(59)_$C(34)" D ^DIE
 I '$D(Y) W !!,">>> Update was ",$S('$D(Y):"",1:$C(7)_"un"),"successful."
 G PTR
PTRQ K DR,DA,DIE Q
 ;
LIST ; -- add list templates
 W !!,">>> Loading List Templates..."
 W !,"'SD PARM PARAMETERS' List Template..."
 S DA=$O(^SD(409.61,"B","SD PARM PARAMETERS",0)) S DIK="^SD(409.61," D ^DIK:DA
 S DIC(0)="L",DIC=409.61,X="SD PARM PARAMETERS" D ^DIC S SDUL=+Y
 I SDUL>0 D
 .S ^SD(409.61,SDUL,0)="SD PARM PARAMETERS^1^^^2^17^1^1^PARAMETERS^SD PARM PARAMETERS MENU^Scheduling Parameters^2"
 .S ^SD(409.61,SDUL,"ARRAY")=" ^TMP(""SDPARM"",$J)"
 .S ^SD(409.61,SDUL,"FNL")="D QUIT^SDPARM"
 .S ^SD(409.61,SDUL,"HLP")="D HLP^SDAM5"
 .S ^SD(409.61,SDUL,"INIT")="D EN^SDPARM"
 .S DA=SDUL,DIK="^SD(409.61," D IX1^DIK
 .W "Filed."
 ;
 W !,"'SDAM APPT MGT' List Template..."
 S DA=$O(^SD(409.61,"B","SDAM APPT MGT",0)) S DIK="^SD(409.61," D ^DIK:DA
 S DIC(0)="L",DIC=409.61,X="SDAM APPT MGT" D ^DIC S SDUL=+Y
 I SDUL>0 D
 .S ^SD(409.61,SDUL,0)="SDAM APPT MGT^1^1^80^5^14^1^1^Appointment^SDAM MENU^Appt Mgt Module^1^999"
 .S ^SD(409.61,SDUL,"ARRAY")=" ^TMP(""SDAM"",$J)"
 .S ^SD(409.61,SDUL,"COL",0)="^409.621^5^5"
 .S ^SD(409.61,SDUL,"COL",1,0)="NAME^9^22^Patient or Clinic"
 .S ^SD(409.61,SDUL,"COL",2,0)="DATE^32^20^Appt Date/Time"
 .S ^SD(409.61,SDUL,"COL",3,0)="STAT^53^22^Status"
 .S ^SD(409.61,SDUL,"COL",4,0)="APPT#^5^3"
 .S ^SD(409.61,SDUL,"COL",5,0)="TIME^75^5"
 .S ^SD(409.61,SDUL,"EXP")="D EN^SDAMEP"
 .S ^SD(409.61,SDUL,"FNL")="D FNL^SDAM"
 .S ^SD(409.61,SDUL,"HDR")="D HDR^SDAM"
 .S ^SD(409.61,SDUL,"HLP")="D HLP^SDAM5"
 .S ^SD(409.61,SDUL,"INIT")="D INIT^SDAM"
 .S DA=SDUL,DIK="^SD(409.61," D IX1^DIK
 .W "Filed."
 ;
 W !,"'SDAM APPT PROFILE' List Template..."
 S DA=$O(^SD(409.61,"B","SDAM APPT PROFILE",0)) S DIK="^SD(409.61," D ^DIK:DA
 S DIC(0)="L",DIC=409.61,X="SDAM APPT PROFILE" D ^DIC S SDUL=+Y
 I SDUL>0 D
 .S ^SD(409.61,SDUL,0)="SDAM APPT PROFILE^2^^^5^17^1^1^^^Expanded Profile^2"
 .S ^SD(409.61,SDUL,"ARRAY")=" ^TMP(""SDAMEP"",$J)"
 .S ^SD(409.61,SDUL,"EXP")=""
 .S ^SD(409.61,SDUL,"FNL")="D FNL^SDAMEP"
 .S ^SD(409.61,SDUL,"HDR")="D HDR^SDAMEP"
 .S ^SD(409.61,SDUL,"HLP")="D HLP^SDAM5"
 .S ^SD(409.61,SDUL,"INIT")="D INIT^SDAMEP"
 .S DA=SDUL,DIK="^SD(409.61," D IX1^DIK
 .W "Filed."
 ;
 K DIC,DIK,SDUL,X,DA Q
