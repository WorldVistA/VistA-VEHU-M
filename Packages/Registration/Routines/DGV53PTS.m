DGV53PTS ;ALB/MAF - CONVERTING THE OPTION USED WHEN ACCESSED FIELD OF THE SECURITY LOG FILE - 5/27/93
 ;;5.3;Registration;;Aug 13, 1993
EN I $S('$D(DUZ):1,('$D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,1:0) W !!,"I DON'T KNOW WHO YOU ARE...UNABLE TO PROCEED!",*7 Q
 W !!,"***THIS OPTION WILL CONVERT DATA IN THE DG SECURITY LOG FILE TO DISPLAY PROTOCOL      TEXT AS WELL AS OPTION TEXT ON THE SECURITY DISPLAY LOG.",!!?3,"A MAILMAN MESSAGE WILL BE SENT WHEN CONVERSION IS COMPLETE!"
ASK W !!,"Do you wish to continue?" S %=1 D YN^DICN I '% D HLP G ASK
 I %=2!(%=-1) G QUIT
 S ZTIO="",ZTRTN="START^DGV53PTS",ZTDESC="Conversion of 'Option Used When Accessed' field of Security Log file"
 F X="DUZ" S ZTSAVE(X)=""
 K ZTSK D ^%ZTLOAD W:$D(ZTSK) "  (TASK: #",ZTSK,")"
 Q
START N IFN,DGDT,DGOPT,DGOPTN,DGNODE
 S (IFN,DGDT,DGCNT)=0
 D TIME S DGSTART=X F  S IFN=$O(^DGSL(38.1,IFN)) Q:IFN']""   F  S DGDT=$O(^DGSL(38.1,IFN,"D",DGDT)) Q:DGDT']""  S DGNODE=$G(^DGSL(38.1,IFN,"D",DGDT,0)) I DGNODE]"" S DGOPTN=$P(DGNODE,"^",3) I DGOPTN=+DGOPTN S DGCNT=DGCNT+1 D CK
 D TIME S DGEND=X D MSG
QUIT D:$D(ZTQUEUED) KILL^%ZTLOAD K %,DIE,XMSUB,DGSTART,DGEND,DGMSG,XMTEXT,XMDUZ,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK Q
CK S DGOPT=$G(^DIC(19,+DGOPTN,0)) S DGOPT=$S(DGOPT]"":$P(^DIC(19,DGOPTN,0),"^",2),1:"@") S DIE="^DGSL(38.1,"_IFN_",""D"",",DA=DGDT,DA(1)=IFN,DR="3////"_$E(DGOPT,1,65) D ^DIE K DA,DR
 Q
HLP W !!?10,"'Y' - Yes to run the conversion of the 'OPTION USED WHEN ACCESSED'",!?16,"field of the SECURITY LOG FILE"
 W !?10,"'N' - No to exit"
 Q
MSG S XMSUB="SECURITY LOG FILE CONVERSION"
 S DGMSG(1,0)="The conversion for the Security Log file 'Option Used When Accessed' field     has been completed."
 S DGMSG(2,0)=""
 S DGMSG(3,0)="STARTING TIME: "_DGSTART
 S DGMSG(4,0)="  ENDING TIME: "_DGEND
 S XMTEXT="DGMSG("
 S XMDUZ=DUZ
 S XMY(DUZ)=""
 D ^XMD
TIME D NOW^%DTC S X=$E($P(%,".",2),1,2)_":"_$E($P(%,".",2),3,4) Q
