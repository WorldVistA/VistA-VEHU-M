PRCFDVED ;WISC/CLH-VENDOR DISPLAY ;7-12-91/14:13
V ;;4.0;IFCAP;;9/23/93
REVO ;REVIEW OLD VENDOR INFO
 I '$D(^PRC(440,PRCFD("VEN"),0)) W !!,$C(7),"**  No Vendor Information available  **" Q
 S REC=^PRC(440,PRCFD("VEN"),0) I '$D(^PRC(440,PRCFD("VEN"),7)) S REC1="",$P(REC1,U,1,11)=""
 E  S REC1=^PRC(440,PRCFD("VEN"),7)
 I $D(IOF) W @IOF
 W !!?5,"Vendor Name: ",$P(REC,U,1),?48,"Vendor Number: ",PRCFD("VEN")
 W !!!?5,"Payment Information: "
 W !!?19,"Calm ID Number: " I $P(REC1,U,10)'="" W $P(REC1,U,10)
 W !?19,"Stub Name: " I $P(REC1,U,11)'="" W ?35,$P(REC1,U,11)
 W !?19,"Address: " I $P(REC1,U,3)'="" W ?35,$P(REC1,U,3)
 I $P(REC1,U,4)'="" W !?35,$P(REC1,U,4)
 I $P(REC1,U,5)'="" W !?35,$P(REC1,U,5)
 I $P(REC1,U,6)'="" W !?35,$P(REC1,U,6)
 I $P(REC1,U,7)'="" W !?35,$P(REC1,U,7)_", ",$P(^DIC(5,$P(REC1,U,8),0),U)_"  ",$P(REC1,U,9)
 W !!?19,"Phone Number: " I $P(REC1,U,2)'="" W ?35,$P(REC1,U,2)
 Q
REVN ;REVIEW NEW VENDOR INFO
 I '$D(^PRCF(421.6,PRCFD("TDA"),7)) W !,$C(7)," - No Data Available  - " Q
 E  S TEMP1=^PRCF(421.6,PRCFD("TDA"),7)
 S:'$D(OLDNAME) OLDNAME=$P(^PRC(440,PRCFD("VEN"),0),"^")
 S:'$D(NEWNAME) NEWNAME=OLDNAME
 I $D(IOF) W @IOF
 W !!?5,"Vendor Name: ",$S($D(NEWNAME):NEWNAME,1:$P(^PRC(440,PRCFD("VEN"),0),"^"))
 W !!!?5,"Payment Information: "
 W !!?19,"Calm ID Number: " I $P(TEMP1,U,10)'="" W $P(TEMP1,U,10)
 W !?19,"Calm Stub Name: " I $P(TEMP1,U,11)'="" W ?35,$P(TEMP1,U,11)
 W !?19,"Address: " I $P(TEMP1,U,3)'="" W ?35,$P(TEMP1,U,3)
 I $P(TEMP1,U,4)'="" W !?35,$P(TEMP1,U,4)
 I $P(TEMP1,U,5)'="" W !?35,$P(TEMP1,U,5)
 I $P(TEMP1,U,6)'="" W !?35,$P(TEMP1,U,6)
 I $P(TEMP1,U,7)'="" W !?35,$P(TEMP1,U,7)_", ",$P(^DIC(5,$P(TEMP1,U,8),0),U)_"  ",$P(TEMP1,U,9)
 W !!?19,"Phone: " I $P(TEMP1,U,2)'="" W ?35,$P(TEMP1,U,2)
 Q
