PRCPUBAR ;WISC/RGY,RFJ-process barcode data ;4 Dec 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
PHYSICAL ;     |-> physical count
 D UPDATE("P") Q
 ;
 ;
USAGE ;     |-> usage
 D UPDATE("U") Q
 ;
 ;
UPDATE(V1) ;     |-> update inventory count
 ;     |-> v1=type P:physical counts, U:usage
 I V1'="P",V1'="U" Q
 I '$D(PRCTID)!'$D(PRCTTI)!'$O(^PRCT(446.4,PRCTID,2,PRCTTI,1,0)) Q
 N %,%H,%I,DATA,EACHONE,ERROR,INVPT,ITEMDA,LASTONE,NUMBER,PRCPFLAG,PRCPPROG,PRCPTYPE,PRCPUBAR,QTY,RECORD,X,Y
 S PRCPTYPE=V1,PRCPPROG=$G(^PRCT(446.4,PRCTID,0)) W !!,"<<< Starting to upload barcode program: "_$S(PRCPPROG'="":$P(PRCPPROG,"^")_"  ("_$P(PRCPPROG,"^",2)_")",1:"UNKNOWN")
 S Y=+^PRCT(446.4,PRCTID,2,PRCTTI,0) X ^DD("DD") W !,"    Data Upload On: "_Y
 D NOW^%DTC S Y=% X ^DD("DD") S $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="STARTED ON "_Y
 S %=$G(^PRCT(446.4,PRCTID,2,PRCTTI,1,1,0)) I $E(%,1,2)'="ID" W !,"    Error: First record not an Identifier record." Q
 W !,"    Data Identifier: ",%
 S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCT(446.4,PRCTID,2,PRCTTI,1,0)),"^",3),"*",$G(PRCP("RV1")),$G(PRCP("RV0")))
 K PRCPFLAG,^TMP($J,"PRCPUBAR")
 S RECORD=1 F NUMBER=1:1 S RECORD=$O(^PRCT(446.4,PRCTID,2,PRCTTI,1,RECORD)) Q:'RECORD  S DATA=^(RECORD,0) I DATA'="" D  I 'ERROR S ^PRCT(446.4,PRCTID,2,PRCTTI,1,RECORD,0)="*"_^PRCT(446.4,PRCTID,2,PRCTTI,1,RECORD,0)
 .   S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",$G(PRCP("RV1")),$G(PRCP("RV0")))
 .   S ERROR=1,^TMP($J,"PRCPUBAR","D",RECORD)=DATA
 .   I $E(DATA)="*" S ^TMP($J,"PRCPUBAR","E",RECORD)="Data has been previously uploaded" Q
 .   I $E(DATA,1,2)'="IE" S ^TMP($J,"PRCPUBAR","E",RECORD)="First two characters should equal IE" Q
 .   I DATA'?1"IE"1N.N1" "1N.N1" ",DATA'?1"IE"1N.N1" "1N.N1" "1N.N S ^TMP($J,"PRCPUBAR","E",RECORD)="Record data is not in expected format" Q
 .   S INVPT=+$E($P(DATA," "),3,99),ITEMDA=+$P(DATA," ",2),QTY=+$P(DATA," ",3)
 .   I 'INVPT!('ITEMDA) S ^TMP($J,"PRCPUBAR","E",RECORD)="Record data has inventory point or item equal zero" Q
 .   I PRCPTYPE="U",QTY=0 S ^TMP($J,"PRCPUBAR","E",RECORD)="Quantity is equal to zero for usage" Q
 .   K PRCPUBAR S PRCPUBAR("I")=INVPT,PRCPUBAR("ITEM")=ITEMDA,PRCPUBAR("QTY")=-QTY,PRCPUBAR("COM")="Barcode Usage",PRCPUBAR("TYP")="U"
 .   I PRCPTYPE="P" D  I $D(^TMP($J,"PRCPUBAR","E",RECORD)) Q
 .   .   L +^PRCP(445,INVPT,1,ITEMDA):10 I '$T S ^TMP($J,"PRCPUBAR","E",RECORD)="Unable to LOCK inventory and item" Q
 .   .   S PRCPUBAR("QTY")=QTY-$P($G(^PRCP(445,INVPT,1,ITEMDA,0)),"^",7),PRCPUBAR("COM")="Barcode Physical Count",PRCPUBAR("TYP")="P"
 .   I PRCPUBAR("QTY")'=0 S %=$$UPDATE^PRCPUSA(.PRCPUBAR) I %'="" S ^TMP($J,"PRCPUBAR","E",RECORD)=%
 .   I PRCPTYPE="P" L -^PRCP(445,INVPT,1,ITEMDA)
 .   S ERROR=0
 D QPERCNT^PRCPUX2(+$G(LASTONE),"*",$G(PRCP("RV1")),$G(PRCP("RV0")))
 W !!,"<<< Finished updating inventory points with barcode data !"
 D NOW^%DTC S Y=% X ^DD("DD") S $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="FINISHED ON "_Y
 I '$O(^TMP($J,"PRCPUBAR","E",0)) D
 .   S XP="Do you want to PURGE this upload entry",XH="Enter 'YES' to purge the entry, 'NO' or '^' to exit.",%=1 W ! D YN^PRCPU4 I %'=1 Q
 .   N DA,DIK S DA(1)=PRCTID,DA=PRCTTI,DIK="^PRCT(446.4,"_PRCTID_",2," D ^DIK
 .   Q
 I $O(^TMP($J,"PRCPUBAR","E",0)) D
 .   W !!,"ERRORS were found during processing !"
 .   S %ZIS="Q",%ZIS("A")="Select the DEVICE for printing the ERROR report: " D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZISC Q
 .   .   S ZTDESC="Barcode upload error report",ZTRTN="ERROR^PRCPUBAR"
 .   .   S ZTSAVE("PRC*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("ZTREQ")="@"
 .   .   D ^%ZTLOAD K IO("Q"),ZTSK
 .   W !!,"<*> please wait <*>"
 .   D ERROR,^%ZISC
 K ^TMP($J,"PRCPUBAR")
 Q
 ;
 ;
ERROR ;     |-> print error report
 N %,%H,%I,BARCODE,ERROR,NOW,PAGE,RECORD,SCREEN,TIME,X,Y
 S BARCODE=$G(^PRCT(446.4,PRCTID,0)),BARCODE=$S(BARCODE="":"<<UNKNOWN>>",1:$P(BARCODE,"^")_"  "_$P(BARCODE,"^",2))
 S Y=+$G(^PRCT(446.4,PRCTID,2,PRCTTI,0)) X ^DD("DD") S TIME=Y
 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S RECORD=0 F  S RECORD=$O(^TMP($J,"PRCPUBAR","E",RECORD)) Q:'RECORD!($G(PRCPFLAG))  S ERROR=^(RECORD) D
 .   W !!,"RECORD/LINE NUMBER: ",RECORD,?30,$G(^TMP($J,"PRCPUBAR","D",RECORD))
 .   W !?7,"-> ",$E(ERROR,1,69) S ERROR=$E(ERROR,70,200) S:$E(ERROR)=" " ERROR=$E(ERROR,2,200) I ERROR="" Q
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 I $G(PRCPFLAG) Q
 D END^PRCPUREP
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"BARCODE UPLOAD ERROR REPORT",?(80-$L(%)),%
 W !?5,"BARCODE PROGRAM: ",BARCODE,?50,"UPLOAD TIME: ",TIME,!,"RECORD/LINE NUMBER",?30,"RECORD DATA"
 S %="",$P(%,"-",81)="" W !,%
 Q
