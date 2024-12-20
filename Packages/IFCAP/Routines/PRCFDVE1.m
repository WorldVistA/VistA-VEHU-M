PRCFDVE1 ;WISC/CLH-VENDOR ADD/EDIT CONT ;1/28/93  10:04 AM
V ;;4.0;IFCAP;;9/23/93
 ;;MUST HAVE PRCFD("VEN") (INTERNAL VENDOR NUMBER),PRCFD("TDA") (TEMP DA NUMBER)
 W !!,$C(7),"MUST ENTER THROUGH MENU MANAGER" Q
ADVEN ;AREA TO SET UP MSG FOR AUSTIN TO ESTABLISH NEW VENDOR
 I $D(PRCFD("TDA")),PRCFD("TDA")]"",$D(^PRCF(421.6,PRCFD("TDA"),7)) S PRCFD("NR")=^(7)
 W !!,$C(7),"TWX will be sent to establish vendor: ",NEWNAME," in the CALM Vendor File."
 S %A="Are you sure you want to do this",%B="",%=1 D ^PRCFYN I %'=1 W !,$C(7)," -- Message not being sent --" G OUT
 K UTIL,PRCFDAV S XMDUZ=$S($D(DUZ)#2:DUZ,1:.5),XMSUB="ESTABLISH "_NEWNAME_" IN CALM VENDOR FILE FOR STATION "_PRC("SITE")_":",XMTEXT="UTIL(",XMY(DUZ)="",XMY("XXX@Q-MDY.VA.GOV")=""
 S UTIL(1,0)="047F3G3   PLEASE ESTABLISH THE FOLLOWING IN THE CALM VENDOR FILE FOR",UTIL(2,0)="STATION "_PRC("SITE"),UTIL(3,0)="",UTIL(4,0)="ID#: "_$S($P(^PRCF(421.6,PRCFD("TDA"),7),U,10)]"":$P(^PRCF(421.6,PRCFD("TDA"),7),U,10),1:"")
 S UTIL(5,0)="",UTIL(6,0)=NEWNAME
 S CNT=7 F I=3:1:6 I $P(PRCFD("NR"),U,I)'="" S CNT=CNT+1,UTIL(CNT,0)=$P(PRCFD("NR"),U,I)
 S CNT=CNT+1,UTIL(CNT,0)=$P(PRCFD("NR"),U,7)_" "_$P(^DIC(5,$P(PRCFD("NR"),U,8),0),U,2)_" "_$P(PRCFD("NR"),U,9)
 D ^XMD W !!,$C(7),"     ***   MESSAGE SENT   ***" S PRCFDAV=1 G CHECK
CHVEN ;CHANGE VENDOR IN AUSTIN FILE
 S PRCFD("NR")=^PRCF(421.6,PRCFD("TDA"),7)
 I $D(PRCFD("VEN")),PRCFD("VEN")]"",$D(^PRC(440,PRCFD("VEN"),7)) S PRCFD("OR")=^(7)
 I $P(PRCFD("NR"),U,10)="" W !!,$C(7)," -- VENDOR DOESN'T NOT HAVE AN ID#. NO FURTHER ACTION CAN BE TAKEN. --" G OUT
 W !!,"TWX will be sent to requesting changes be made in CALM Vendor File."
 S %A="Are you sure you want to do this",%B="",%=1 D ^PRCFYN I %'=1 W !,$C(7)," -- Message not being sent --" G OUT
 K UTIL S XMDUZ=$S($D(DUZ)#2:DUZ,1:.5),XMSUB="MAKE CHANGES IN CALM VENDOR FILE FOR STATION "_PRC("SITE")_":",XMTEXT="UTIL(",XMY(DUZ)="",XMY("XXX@Q-MDY.VA.GOV")=""
 S UTIL(1,0)="047F3   PLEASE MAKE THE FOLLOWING CHANGE IN THE CALM VENDOR FILE FOR",UTIL(2,0)="STATION "_PRC("SITE")_":",UTIL(3,0)="",UTIL(4,0)="CHANGE FROM: ",UTIL(5,0)="",UTIL(6,0)="ID#: "_$P(PRCFD("OR"),U,10),UTIL(8,0)=""
 S UTIL(9,0)=OLDNAME,UTIL(10,0)="",CNT=10 F I=3:1:6 I $P(PRCFD("OR"),U,I)'="" S CNT=CNT+1,UTIL(CNT,0)=$P(PRCFD("OR"),U,I)
 S CNT=CNT+1,UTIL(CNT,0)=$P(PRCFD("OR"),U,7)_" "_$S($P(PRCFD("OR"),U,8)="":"",1:$P($G(^DIC(5,$P(PRCFD("OR"),U,8),0)),U,2))_" "_$P(PRCFD("OR"),U,9)
 S UTIL(CNT+1,0)="",UTIL(CNT+2,0)="CHANGE TO:",UTIL(CNT+3,0)="",UTIL(CNT+4,0)="ID#: "_$P(PRCFD("NR"),U,10),UTIL(CNT+5,0)="",UTIL(CNT+6,0)=NEWNAME
 S CNT=CNT+7 F II=3:1:6 I $P(PRCFD("NR"),U,II)'="" S CNT=CNT+1,UTIL(CNT,0)=$P(PRCFD("NR"),U,II)
 S CNT=CNT+1,UTIL(CNT,0)=$P(PRCFD("NR"),U,7)_" "_$P(^DIC(5,$P(PRCFD("NR"),U,8),0),U,2)_" "_$P(PRCFD("NR"),U,9)
 D ^XMD W !!,$C(7),"     ***   MESSAGE SENT   ***" G OUT
CHECK ;CHECK TEMP FILE FOR CHANGES
 K PRCFDNR W !!,"Please hold on, I'm going to check data..."
 I '$D(PRCFD("NR")),$D(PRCFD("TDA")),PRCFD("TDA")]"",$D(^PRCF(421.6,PRCFD("TDA"),7)) S PRCFD("NR")=^(7)
 S:'$D(PRCFD("NR")) PRCFD("NR")=""
 F I=3:1:11 I $P(PRCFD("NR"),U,I)'=$P(PRCFD("OR"),U,I) S PRCFDNR=1
 I '$D(PRCFDNR),'$D(PRCFDNM) W !,$C(7),"Okay no changes were made.",! G OUT
 I '$D(PRCFDAV) W $C(7),!,"You have edited vendor information.",! S %A="Do you want to send these changes to Austin",%B="",%=1 D ^PRCFYN D:%=1 CHVEN
OUT I $D(PRCFDNR) S %A="Do you want to update YOUR Vendor File now",%B="",%=1 D ^PRCFYN I %=1 S ^PRC(440,PRCFD("VEN"),7)=^PRCF(421.6,PRCFD("TDA"),7) W !! H 1 W "Finished."
 I $D(PRCFDNM) S $P(^PRC(440,PRCFD("VEN"),0),U)=NEWNAME,^PRC(440,"B",$E(NEWNAME,1,30),PRCFD("VEN"))="" K ^PRC(440,"B",$E(OLDNAME,1,30),PRCFD("VEN")) W !!,"Vendor name has been changed from ",OLDNAME," to ",NEWNAME,".",$C(7)
 W !!,"Hold on while I do some clean up...."
 I $D(PRCFD("TDA")) S DIK="^PRCF(421.6,",DA=PRCFD("TDA") D ^DIK
O1 K DR,DIK,DIC,DIE,PRCFD("TDA"),DA,X,COUNT,PRCFDT,DLAYGO,%,PRCFDE,PRCFD("OR"),REC,REC1,TEMP,TEMP1,PRCFDNR,PRCFD("NR"),XMY,XMTEXT,XMDUZ,XMSUB,UTIL,PRCFDVEN,CNT,PRCFDM,OLDNAME,NEWNAME,PRCFDNM,PRCFDAV
 Q
