AHJZMXFR ;557/THM-TRANSFER MAIL BETWEEN UCIS [ 02/09/93  11:12 AM ]
 ;;1.0;;
 ;
 I $ZV'["MSM-PC" W *7,*7,"This can only be run on MSM systems!",!,*7,*7
 I $D(DUZ)#2=0 W !!,*7,"No user number !",!! H 2 Q
 ;
EN S $ZT="ERROR^AHJZMXFR" D DT^DICRW S IOP="HOME" D ^%ZIS K IOP
 S $P(SPACE," ",80)="",X=IOST(0),ZDT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) K IOSC
 X ^%ZOSF("UCI") S HOMEUCI=Y
 ;
SEL W @IOF,!,"Transfer mail message(s) to another UCI,VOL",!!
 F I=1:1 S DIC="^XMB(3.9,",DIC(0)="AEQM" D ^DIC Q:X=""!($D(DUOUT))  S MSG(+Y)="",DIC("A")="Select next MESSAGE SUBJECT: " H 1 G SEL
 G:$D(DTOUT)!('$D(MSG)) EXIT
 ;
EN1 W @IOF,!!,"Transfer to UCI,VOL: " R UCIVOL:120 G:'$T!(UCIVOL=U)!(UCIVOL="") EXIT
 I UCIVOL'?3U1","3U W *7,!!,"Not the correct format.  Must be like VAH,XDA  "  H 2 G EN1
 S TUCI=$P(UCIVOL,",",1),TSYS=$P(UCIVOL,",",2) I '$D(^[TUCI,TSYS]XMB(3.9,0)) W *7,!!,"MailMan is not running in that UCI and system." H 2  G EN1
 S DIC="^["_""""_TUCI_""""_","_""""_TSYS_""""_"]"_"VA(200,",DIC(0)="AEQM",DIC("A")="Select REMOTE UCI RECIPIENT: " D ^DIC G:X=""!(X=U) EXIT S USER=+Y
 W !!,"Do you want to queue this task to run later" S %=2,QUEUE="N" D YN^DICN I %=1 S QUEUE="Y"
 I QUEUE="Y" S ZTIO="",ZTSAVE("*")="",ZTRTN="GO^AHJZMXFR",ZTDESC="Mail message transfer to "_UCIVOL D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued as task #",ZTSK,!! H 2 G EXIT
 W !!
 ;
GO S MSGNUM="" F Z=1:1 S MSGNUM=$O(MSG(MSGNUM)) Q:MSGNUM=""  S %X="^XMB(3.9,"_MSGNUM_",2,",%Y="^["_""""_TUCI_""""_","_""""_TSYS_""""_"]"_"UTILITY(""MAILMAN TRANSFER"""_","_MSGNUM_"," D
 .S SUBJ=$P(^XMB(3.9,MSGNUM,0),U,1)
 .I '$D(ZTQUEUED) W:$X>70 ! W ?Z-1#8*10,MSGNUM
 .D %XY^%RCR J RECV^AHJZMXFR(MSGNUM,USER,HOMEUCI,SUBJ)[TUCI,TSYS]::10
 I '$D(ZTQUEUED) K MSG G EN
 ;
EXIT I IOST?1"C-".E,'$D(ZTQUEUED) W @IOF,!
 D ^%ZISC K IOP,%X,%Y,QUEUE,ZTSAVE,ZTRTN,MSGNUM,XFER,TUCI,TSYS,ZTSK,ZDT,Y,X,UCIVOL,SPACE,POP,MSG,DX,DY,HOMEUCI,DIC,DISYS,I,%,DTOUT,DUOUT,XMDUZ,Z,ZTDESC,ZTIO,ZTQUEUED
 Q
 ;
ERROR W !!,*7,"An error has occurred during the message transfer:",!,*7
 I $ZE["NOSYS" W !,*7,"There is no system by that name.",! H 3 G EXIT
 I $ZE["NOUCI" W !,*7,"There is no UCI by that name.",! H 3 G EXIT
 W !?5,"$ZE=",$ZE,!,"Please contact the system manager.    " H 3 G EXIT
 ;
RECV(MSGNUM,USER,HOMEUCI,SUBJ) F I=0,.001:.001:.099 K ^UTILITY("MAILMAN TRANSFER",MSGNUM,I) ;remove origination info
 S U="^",XMDUZ=.5,XMTEXT="^UTILITY(""MAILMAN TRANSFER"""_","_MSGNUM_",",XMSUB=$E(SUBJ,1,40)_" (sent from "_HOMEUCI_")" S XMY(USER)="",XMY(.5)=""
 D ^XMD K USER,XMY,XMTEXT,XMSUB,HOMEUCI,^UTILITY("MAILMAN TRANSFER",MSGNUM)
 Q
