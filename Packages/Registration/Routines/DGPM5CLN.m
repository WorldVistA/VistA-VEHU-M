DGPM5CLN ;ALB/MIR - CLEAN UP OF OBSOLETE ROUTINES/DDS ; SEP 8 89@8
 ;;MAS VERSION 5.0;;**2**;
EN I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to execute clean-up routine.",! G Q
 ;
 I $S('$D(^DG5(1,"T",6,0)):1,'$P(^(0),"^",3):1,1:0) W !,"Your conversion is not complete!!" G Q
 ;
 K DG5LINE S $P(DG5LINE,"-",80)=""
 W !,DG5LINE
 D QUEALL^DGPTCR1 ;ptf workfile clean-up
 W !,DG5LINE
 D UPDT^VADPT60 ;update pt id's
 W !,DG5LINE
 W !,">>>DATABASE AND DATA DICTIONARY CLEANUP..."
 S ZTDESC="MAS v5 Clean-up",DGPGM="QUE^DGPM5CLN",DGVAR="DG5LINE" D ZIS^DGUTQ
 I POP W !,DG5LINE G Q
 ;
QUE W @IOF
 W !?20,">>> DATABASE AND DATA DICTIONARY CLEANUP <<<"
 W !!,"Starting Time: " D NOW^%DTC S Y=% D DT^DIO2
 W !!,DG5LINE
 W !,">>>Checking to make sure all ""DA"" nodes in the PATIENT file are gone."
 W !,"   Will also kill the ""C405"" node for each patient."
 W !,"   This may take a while..."
 S DGER=0 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  W:'(DFN#500) "." D ELIG K ^DPT(DFN,"C405") I $D(^DPT(DFN,"DA")) W !?3,"Inpatient data still exists DFN=",DFN,$S($D(^DPT(DFN,0)):"   "_$P(^(0),"^",1),1:"") S DGER=1
 K ^DPT("C405")
 I DGER W !!,"The conversion has not completed, you can not continue" Q
 W !,">>>You have successfully completed the patient file conversion."
 W !,DG5LINE
 ;
 W !,">>>Will now remove some no longer needed files and cross-references."
 W !!,">>>REMOVING OBSOLETE FILES..."
 S DIU(0)="DT" F DGX=42.1:.1:42.3,43.9 W !,"...Removing file ",DGX S DIU=DGX D EN^DIU2
 W !!,">>>REMOVING OBSOLETE ADMISSION DATE/TIME MULTIPLE FROM THE PATIENT FILE..."
 S DIU(0)="ST",DIU=2.95 D EN^DIU2
 W !!,">>>STORING ROOM-BED DESCRIPTIONS..." D DESC
 W !!,">>>REMOVING OBSOLETE ROOM MULTIPLE FROM THE WARD LOCATION FILE..."
 S DIU(0)="DST",DIU=42.03 D EN^DIU2
 K ^DIC(42,"R") ;cross-reference not deleted via fileman
 W !,">>>DATA DICTIONARY DELETION NOW COMPLETE!"
 ;
 W !!,">>>REMOVING ""AA"", ""AT"", ""AD"", and ""AHEM"" CROSS-REFERENCES FROM FILE 2..."
 F I="AA","AT","AD","AHEM" K ^DPT(I)
 I $D(^YSG("INP","MAS5")) W !!,">>>REMOVING MAS5 CROSS-REFERENCE FROM THE MENTAL HEALTH INPT FILE" K ^YSG("INP","MAS5")
 W !,">>>CROSS-REFERENCE DELETION NOW COMLETE!"
 W !,DG5LINE
 W !,">>>YOU WILL NEED TO DELETE THE DGPM5* ROUTINES ON YOUR SYSTEM(S)."
 W !,DG5LINE
 W !!,"Ending Time: " D NOW^%DTC S Y=% D DT^DIO2
Q K %,ZTDESC,DGPGM,DGVAR,DG5LINE,DIU,DGPMI,I,X Q
 ;
ELIG ;set the 2nd piece of the 0 node of the eligibility multiple without I
 I $D(^DPT(DFN,"E",0)) S:$P(^(0),"^",2)'="2.0361P" $P(^(0),"^",2)="2.0361P"
 Q
DESC F DGW=0:0 S DGW=$O(^DG5(1,"RE","R",DGW)) Q:'DGW  S DGRB="" F DGI=0:0 S DGRB=$O(^DG5(1,"RE","R",DGW,DGRB)) Q:DGRB=""  F DGR=0:0 S DGR=$O(^DG5(1,"RE","R",DGW,DGRB,DGR)) Q:'DGR  D UPD
 K DA,DGI,DGO,DGR,DGRB,DGW,DIE,DR,X,Y
 Q
UPD S DGO=+$O(^DIC(42,DGW,2,"B",$P(DGRB,"-"),0)) Q:'$D(^DIC(42,DGW,2,DGO,0))  S X=$E($P(^(0),"^",3),1,30) Q:X=""
 S DIC="^DG(405.6,",DIC(0)="L",DLAYGO=405.6 D ^DIC K DIC,DLAYGO Q:Y<0
 I $D(^DG(405.4,DGR,0)) S DIE="^DG(405.4,",DR=".02////"_+Y,DA=DGR D ^DIE
 Q
