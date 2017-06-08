PRCECNV1 ;WISC/LDB-1358 Conversion continued ; 10/19/93  2:04 PM
V ;;4.0;IFCAP;**3**;9/23/93
QCONV ;Set task to convert remaining 1358's
 I CNVRT W:'$D(^PRC(424,+$O(^PRC(424,0)),"STOP")) !,">>> Finished converting file 424 . . ." W:$D(^("STOP")) !,">>> Conversion stopped, but not finished",$C(7)
 I  W !!,"Started: ",TIME1,!,"Finished: ",TIME2,!,"Records converted: ",CNVRT
 W !,"The remaining 1358's have been tasked for conversion..."
 S ZTDTH=$H
 S ZTRTN="DQCONV^PRCECNV1",ZTIO="",ZTDESC="Conversion of remaining 1358's." S:$D(DUZ) ZTSAVE("DUZ")=DUZ D ^%ZTLOAD
 I '$D(ZTSK) W !,"The conversion of the remaining 1358's has not been queued."
 Q
 ;
DQCONV ;Called to convert remaining 1358's
 D NOW^%DTC,YX^%DTC S TIME1=Y
 S (CNVRT,DA)=0
 F  S DA=$O(^PRC(424,DA)) Q:'DA!('$D(^PRC(424,+DA,0)))!($D(^PRC(424,+$O(^PRC(424,0)),"STOP")))  I '$D(^PRC(424,+DA,2)),($P($G(^PRC(424,+DA,0)),U,3)'?.A) D CNV^PRCECNV
 D NOW^%DTC,YX^%DTC S TIME2=Y
 S TEXT(1)="The conversion of the remaining 1358's has finished.",TEXT(2)="Started: "_TIME1,TEXT(3)="Finished: "_TIME2,TEXT(4)="Number of entries converted: "_CNVRT,XMTEXT="TEXT("
 S XMSUB="1358 CONVERSION PROCESS",XMY($S($D(DUZ):DUZ,1:.5))="" D ^XMD
 D EXIT^PRCECNV Q
 ;
