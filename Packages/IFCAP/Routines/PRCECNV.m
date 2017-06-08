PRCECNV ;WISC/LDB-Convert file 424 to new structure ;3/4/92 16:15 
 ;;4.0;IFCAP;;9/23/93
SEL ;Select which action to take
 D SETUP S DIR(0)="L^1:3^K:X'?1N X"
 S DIR("?",1)="Select 1 to START the conversion for the very first time."
 S DIR("?",2)="Select 2 to STOP the conversion now."
 S DIR("?")="Select 3 to RESTART the conversion if it aborted or was DELIBERATELY stopped."
 S DIR("A",1)="1. START 1358 CONVERSION FOR THE FIRST TIME"
 S DIR("A",2)="2. STOP 1358 CONVERSION"
 S DIR("A",3)="3. RESTART 1358 CONVERSION"
 S DIR("A")="Select action"
 D ^DIR
 I $D(DIRUT) K DIR,DIROUT,DIRUT,Y Q
 K DIR,DIRUT,DIROUT G:$E(Y,1)=2 STOP G:$E(Y,1)=3 GO
START D SETUP
 K:'$D(^PRC(424,"ACONV")) ^TMP("C1358",$J),PRC424,^PRC(424,"AC"),^PRC(424,"AD"),^PRC(424,"C"),^PRC(424,"AF")
RESTART ;restart process here on same system if process was interrupted
 D TIME S TIME1=Y,U="^",IOP="HOME",CNVRT=0 D ^%ZIS W !,"Starting the conversion of this Fiscal Year's 1358's..."
 S DA410=+$O(^PRC(424,"ACONV",0)),DA=+$O(^(+DA410,0))
 I DA410 S DA410O=99999999-(DA410_.9),DA410=99999999-DA410,DA410=$S('$D(^PRC(424,"AE",+DA410,+DA)):0,1:DA410O)
 S FY=$S($E(X,4,5)<10:($E(X,1,3)-1)_1001,1:$E(X,1,3)_1001)
 G:$D(^PRC(424,+$O(^PRC(424,0)),"STOP")) EXIT
 F  S DA410O=DA410 D:DA410O PRCS410 S DA410=$O(^PRC(424,"AE",+DA410)) Q:'DA410!($D(^PRC(424,+$O(^PRC(424,0)),"STOP")))  D
 .F  S DA=$O(^PRC(424,"AE",+DA410,DA)) Q:'DA!'$D(^PRC(424,+DA,0))!($D(^PRC(424,+$O(^PRC(424,0)),"STOP")))  D:($P($G(^PRC(424,DA,0)),U,3)'?.A)
 ..S PRC424=^PRC(424,DA,0) Q:($E($P(PRC424,U,6),1,8)<FY)!($D(^PRC(424,+$O(^PRC(424,0)),"STOP")))!($D(^PRC(424,+DA,2)))
 ..D CNV W:'(DA#100) "."
 D TIME S TIME2=Y
 D QCONV^PRCECNV1
EXIT K CNVRT,DA,DA410,DA410O,FY,PRC424,XMSUB,XMY,XMTEXT,ZTDESC,ZTIO,ZTSK,ZTSAVE,^TMP("C1358",$J) Q
 ;
CNV ;Convert the 1358
 S PRC424=^PRC(424,DA,0),CNVRT=CNVRT+1
 S ^TMP("C1358",$J,DA,0)=PRC424,^TMP("C1358",$J,DA)=$P(PRC424,U)_U_$P(PRC424,U,2)_U_$S($P(PRC424,U,4)="F":"L",$P(PRC424,U,4)="S":"AU",1:"O")_U
 I $P(PRC424,U,4)="O" S ^TMP("C1358",$J,DA)=^TMP("C1358",$J,DA)_U_U_$P(PRC424,U,5)_U,AMT=""
 I $P(PRC424,U,4)="F" S ^TMP("C1358",$J,DA)=^TMP("C1358",$J,DA)_$P(PRC424,U,9)_U_U_U,AMT=""
 I $P(PRC424,U,4)="S",$P(PRC424,U,8) S ^TMP("C1358",$J,DA)=^TMP("C1358",$J,DA)_U_$P(PRC424,U,8)_U_U,AMT=$P(PRC424,U,8)
 I $P(PRC424,U,4)="S",'$P(PRC424,U,8) S ^TMP("C1358",$J,DA)=^TMP("C1358",$J,DA)_U_$P(PRC424,U,10)_U_U,AMT=$P(PRC424,U,10)
 S:'$D(AMT) AMT=""
 S ^TMP("C1358",$J,DA)=^TMP("C1358",$J,DA)_$P(PRC424,U,6)_U_U_$P(PRC424,U,15)_U_$P(PRC424,U,7)_U_U_AMT_U_AMT_U_U_$P(PRC424,U,3) S:$P(PRC424,U,14)]"" ^(DA,1)=$P(PRC424,U,14)
 S ^PRC(424,DA,0)=^TMP("C1358",$J,DA),^PRC(424,DA,2)=1,^PRC(424,"ACONV",(99999999-+$P(^PRC(424,DA,0),U,15)),DA)="" S:$D(^TMP("C1358",$J,DA,1)) ^PRC(424,DA,1)=^TMP("C1358",$J,DA,1)
 ;Set all new cross-references on new entry
 S PRC424=^PRC(424,DA,0)
 I $P(PRC424,U)'="" S ^PRC(424,"AD",$P($P(PRC424,U),"-",1,2),DA)=""
 I $P(PRC424,U,3)'="",$P(PRC424,U)'="" S:"OA"[$P(PRC424,U,3) ^PRC(424,"AF",$P($P(PRC424,U),"-",1,2),DA)="" S:$P(PRC424,U,3)="L" ^PRC(424,"AG",$P($P(PRC424,U),"-",1,2),DA)=""
 I $P(PRC424,U,3)'="" S ^PRC(424,"AT",$P(PRC424,U,3),DA)=""
 I $P(PRC424,U,2)'="" S ^PRC(424,"C",$P(PRC424,U,2),DA)=""
 I $P(PRC424,U,9)'="" S ^PRC(424,"AC",$P(PRC424,U,9),DA)=""
 I $P(PRC424,U,10)'="" S ^PRC(424,"D",$P(PRC424,U,10),DA)=""
 I $P(PRC424,U,15)'="" S ^PRC(424,"AE",$P(PRC424,U,15),DA)=""
 K ^TMP("C1358",$J,DA),^(DA,1),AMT Q
PRCS410 S:$D(^PRCS(410,DA410O,0)) $P(^(0),U,9)=1 I $D(PRC424),$D(^PRC(442,+$P(PRC424,U,2),8)),'$P(^(8),U,5) S $P(^(8),U,5)=1
 Q
 ;
STOP S DIR(0)="YO",DIR("B")="NO",DIR("?")="To stop the conversion of the 1358's, enter 'Yes'.",DIR("A")="Do you really need to stop the conversion of 1358's" D ^DIR S:Y ^PRC(424,+$O(^PRC(424,0)),"STOP")=1 K DIR,DIRUT,DIROUT Q
 ;
GO S DIR(0)="YO",DIR("B")="NO",DIR("?")="To restart the conversion of the 1358's after having DELIBERATELY stopped the process, answer 'Yes'.",DIR("?",1)="If the conversion has aborted, you may also restart it by answering 'Yes'."
 S DIR("?")="If you have DELIBERATELY stopped this conversion of 1358's process, you may start it again by answering 'Yes'.",DIR("A")="Would you like to restart the conversion of 1358's now" D ^DIR K DIR,DIRUT,DIROUT
 I Y K ^PRC(424,+$O(^PRC(424,0)),"STOP"),Y G RESTART
 Q
TIME ;Set time
 D NOW^%DTC,YX^%DTC Q
SETUP D HOME^%ZIS,DT^DICRW Q
