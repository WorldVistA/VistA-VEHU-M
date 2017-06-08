PRCFDVE ;WISC@ALTOONA/CLH-ADD/EDIT CALM VENDOR FILE ;7-12-91/12:28 PM
V ;;4.0;IFCAP;;9/23/93
 ;;MUST PASS PRCFD("VEN")=INTERNAL VENDOR NUMBER
 ;;ENTRY POINT IS LINE "EN"
 W !!,$C(7),"MUST ENTER THROUGH MENU MANAGER" Q
EN1 ;VENDOR LOOK UP
 I '$D(PRC("PARAM")) S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DIC(0)="AMENQ" I +$P(PRC("PARAM"),"^",20) S DIC(0)="AEMNQL",DLAYGO=440
 E  W !,$C(7),"Remember, only Supply may add new vendors to file 440."
 S PRCFD("PAY")="",DIC=440,DIC("A")="Select VENDOR: " D ^DIC K DIC Q:+Y<0  S PRCFD("VEN")=+Y
 I $D(^PRC(440,PRCFD("VEN"),10)),+$P(^(10),U,5)'=0 W !!,$C(7),"VENDOR INACTIVE",!,"Select another vendor or '^' to quit." D EN1
EN ;ADD VENDOR
 I '$D(PRC("SITE")) D ^PRCFSITE Q:'%
 K PRCFDE I $D(^PRC(440,PRCFD("VEN"),7)) S PRCFDE=1,%A="Review current information on this vendor",%B="",%=1 D ^PRCFYN I %=1 D REVO^PRCFDVED W !!
 D GN S DIE="^PRCF(421.6,",DA=PRCFD("TDA"),DR="[PRCB VENDOR EDIT]" D MOVE
ENV W ! N DIR S DIR(0)="Y",DIR("A")="Do you need to edit Vendor Name",DIR("?")="Yes to edit name, no or '^' to quit" D ^DIR K DIR I Y D VNE^PRCFDVE2
 D ^DIE I $D(Y) G O1^PRCFDVE1
 D REVN^PRCFDVED W !! S %A="Is this data correct",%B="",%=1 D ^PRCFYN I %'=1 S %A="Re-edit data",%B="",%=1 D ^PRCFYN G:%=1 ENV G OUT^PRCFDVE1
 I '$D(PRCFDE) S %A(1)="This vendor does not appear to have been established in CALM Vendor File",%A(2)="Do you want to establish them at this time",%B="",%=1 D ^PRCFYN G:%=1 ADVEN^PRCFDVE1 G CHECK^PRCFDVE1
 I $P(^PRC(440,PRCFD("VEN"),7),U,10)="" S %A(1)="This vendor does not appear to have a CALM ID Number",%A(2)="Do you want to establish them to the CALM Vendor File",%B="",%=1 D ^PRCFYN G:%=1 ADVEN^PRCFDVE1 G CHECK^PRCFDVE1
 G CHECK^PRCFDVE1
MOVE ;MOVE VENDOR DATA INTO TEMP FILE
 I $D(PRCFDE) S (^PRCF(421.6,PRCFD("TDA"),7),PRCFD("OR"))=^PRC(440,PRCFD("VEN"),7),PRCFDM=1 Q
 S PRCFD("OR")="",$P(PRCFD("OR"),U,1,99)=""
 Q
GN ;GET TEMP NUM
 D WAIT^PRCFYN S DIC="^PRCF(421.6,",DLAYGO=421.6,DIC(0)="XOLM",X=PRC("SITE")_"-"_^%ZOSF("VOL")_"-"_$J,PRCFDT=0
 S:'$D(COUNT) COUNT=0 D ^DIC Q:+Y<0  I +$P(Y,U,3)'=1 S COUNT=COUNT+1 Q:COUNT=3  S DIK=DIC,DA=+Y D ^DIK K DIK G GN
 S PRCFD("TDA")=+Y,PRCFDT=1
 Q
