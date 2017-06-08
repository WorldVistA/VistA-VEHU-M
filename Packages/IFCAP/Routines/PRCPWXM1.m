PRCPWXM1 ;WISC/RFJ-build repetitive item list from confirmation message (actual build) ;1 May 91
 ;;4.0;IFCAP;;9/23/93
 Q
BUILD ;build repetitive item list
 K:PRCPTYPE ^PRCS(410.3,PRCPDA,1) S:'$D(^PRCS(410.3,PRCPDA,1,0)) ^(0)="^410.31IPA^^" S %=^(0),PRCPENT=$P(%,"^",3)+1,PRCPCNT=$P(%,"^",4)
 D NOW^%DTC S $P(^PRCS(410.3,PRCPDA,0),"^",4)=%,PRCPDT=X,PRCPNSN=0 F  S PRCPNSN=$O(^TMP($J,"ITEM",PRCPNSN)) Q:'PRCPNSN  S D=^(PRCPNSN) D
 .   S PRCPITEM=+$P(D,"^",7) Q:'$D(^PRC(441,PRCPITEM,0))  I $D(^PRC(441,PRCPITEM,2,PRCPSRC,0)) S $P(^(0),"^",2)=$P(D,"^",4),$P(^(0),"^",6)=PRCPDT
 .   I $D(^PRC(441,PRCPITEM,2,PRCPPVNO,0)) S $P(^(0),"^",2)=$P(D,"^",4),$P(^(0),"^",6)=PRCPDT
 .   S %=$O(^PRCS(410.3,PRCPDA,1,"B",PRCPITEM,0)) I %,$D(^PRCS(410.3,PRCPDA,1,%,0)) S X=^(0) D  Q
 .   .   K:$P(X,"^",3)'="" ^PRCS(410.3,PRCPDA,1,"AC",$P(X,"^",3),%) S $P(X,"^",2,5)=$P(D,"^",6)_"^"_PRCPNAME_"^"_$P(D,"^",4)_"^"_PRCPSRC,^PRCS(410.3,PRCPDA,1,"AC",PRCPNAME,%)="",^PRCS(410.3,PRCPDA,1,%,0)=X
 .   F PRCPENT=PRCPENT:1 Q:'$D(^PRCS(410.3,PRCPDA,1,PRCPENT))
 .   S ^PRCS(410.3,PRCPDA,1,PRCPENT,0)=PRCPITEM_"^"_$P(D,"^",6)_"^"_PRCPNAME_"^"_$P(D,"^",4)_"^"_PRCPSRC,^PRCS(410.3,PRCPDA,1,"AC",PRCPNAME,PRCPENT)="",^PRCS(410.3,PRCPDA,1,"B",PRCPITEM,PRCPENT)="",PRCPCNT=PRCPCNT+1
 S:'$D(^PRCS(410.3,PRCPDA,1,PRCPENT,0)) PRCPENT=PRCPENT-1 S ^PRCS(410.3,PRCPDA,1,0)=$P(^PRCS(410.3,PRCPDA,1,0),"^",1,2)_"^"_PRCPENT_"^"_PRCPCNT W !!,"REPETITIVE ITEM LIST HAS BEEN BUILT!"
 S:$D(PRCSIP) $P(^PRCS(410.3,PRCPDA,0),"^",3)=PRCSIP S PRCSNO=$P(^PRCS(410.3,PRCPDA,0),"^"),PRCSDA=PRCPDA D CALC^PRCSRIE1 Q
TYPE ;select add to or delete from repetitive item list
 K PRCPTYPE I $O(^PRCS(410.3,PRCPDA,1,0))="" S PRCPTYPE=1 Q
 W !!,"THERE ARE ",+$P($G(^PRCS(410.3,PRCPDA,1,0)),"^",4)," ITEMS CURRENTLY STORED IN THIS REPETITIVE ITEM LIST."
 S DIR(0)="S^1:Add to Existing Items in List;2:Delete Items and Create a New List",DIR("?",1)="Select the option 'Add to Existing Items in List' to add the items"
 S DIR("?",2)="in the message to the current list.  If an item is found in the list,",DIR("?",3)="the new item from the message will overwrite the existing item.",DIR("?",4)=""
 S DIR("?",5)="Select the option 'Delete Items and Create a New",DIR("?",6)="List' to delete all the items in the current list and create a new list",DIR("?")="with the items found in the message."
 S DIR("A")="Create Repetitive Items List by",DIR("B")="Add to Existing Items in List" D ^DIR I Y'=1,Y'=2 Q
 S PRCPTYPE=$S(Y=2:1,1:0) Q
NEW ;create a new repetitive item list
 K PRCPDA W !! D EN^PRCSUT Q:'$D(PRC("SITE"))!(Y<0)  I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)>1 S Y="NONE" G STF
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)<2 I '$O(^PRC(420,PRC("SITE"),1,+PRC("CP"),2,0)) D  Q
 .   W !!,"There are no cost centers entered for this station and control point in the Fund",!,"Control Point file.  You must enter one or more cost centers before continuing."
 S DIC("A")="Select COST CENTER: ",DIC="^PRC(420,PRC(""SITE""),1,+PRC(""CP""),2,",DIC(0)="AEMNQZ" D ^DIC Q:Y<1  S Y=$P(Y(0),"^") Q:'$D(^PRCD(420.1,Y,0))
STF S X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")_"-"_Y
 S DLAYGO=410.3,DIC="^PRCS(410.3,",DIC(0)="LZ" D ^DIC K DLAYGO Q:Y<0  S PRCPDA=+Y,PRCPLOCK(1)="^PRCS(410.3,"_PRCPDA_")" D LOCK^PRCPU4(.PRCPLOCK,1,10) G:'$D(PRCPLOCK) NEW
 Q
