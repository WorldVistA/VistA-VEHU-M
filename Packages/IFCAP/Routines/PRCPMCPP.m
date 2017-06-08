PRCPMCPP ;WISC/AKS-copy items from primary to secondary ;1-8-93/12:08
 ;;4.0;IFCAP;**7**;9/23/93
 N PRCPSEC,NOITMS,ITMDA,I,%,M,J,K,X,Y,PRCPUN,PRCPA,PRCPVEN,PRCPUIM
 D ^PRCPUSEL G:'$G(PRCP("I")) EXIT I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." G EXIT
 S DIC(0)="AEQM" S:'$D(DIC("S")) DIC("S")="" I '$D(DIC("A")) S DIC("A")="Select SECONDARY INVENTORY/DISTRIBUTION POINT: "
 W !! S PRCPSEC=-1
 S DIC="^PRCP(445,"_PRCP("I")_",2,",DA(1)=PRCP("I"),D0=PRCP("I"),DIC("S")="Q:'$D(^PRCP(445,+Y,0))  I +^(0)=PRC(""SITE"")",PRCPPRIV=1
 D ^DIC K PRCPPRIV,DIC,DA,D0 G:Y=-1 EXIT S PRCPSEC=+Y I '$D(^PRCP(445,PRCPSEC,0)) S Y=-1 G EXIT
 I $P(^PRCP(445,PRCPSEC,0),"^",2)="Y",'$D(^PRCP(445,PRCPSEC,4,DUZ)) W !!,"Sorry, You are not a user in the secondary you are trying to copy to." S Y=-1 G EXIT
START W !!,"Are you sure you want to copy "_$P($P(^PRCP(445,PRCP("I"),0),"^"),"-",2)_" primary inventory to "_$P($P(^PRCP(445,PRCPSEC,0),"^"),"-",2),!,"secondary inventory point "
 S %=2 D YN^DICN G:(%=-1!(%=2)) EXIT I %=0 W !!,"Answer ""Yes"" or ""No""" G START
 I '$D(^PRCP(445,PRCP("I"),1)) W !!,"No items in the "_$P($P(^PRCP(445,PRCP("I"),0),"^"),"-",2)_" inventory point" G EXIT
 W !!,"Copying..."
 S NOITMS=$P(^PRCP(445,PRCP("I"),1,0),"^",4),^PRCP(445,PRCPSEC,1,0)="^445.01IP^"_$P(^(0),"^",3)_"^"_NOITMS
 S ITMDA=0 F I=1:1:NOITMS S ITMDA=$O(^PRCP(445,PRCP("I"),1,ITMDA)) Q:ITMDA=""!(ITMDA'?1.N)  D:'$D(^PRCP(445,PRCPSEC,1,ITMDA,0))&('$D(^PRCP(445,PRCP("I"),1,ITMDA,8)))  I '(I#10) W "."
 .   ; Setting one item at a time
 .   ;
 .   Q:'$D(^PRCP(445,PRCP("I"),1,ITMDA,0))  S ^PRCP(445,PRCPSEC,1,ITMDA,0)=^PRCP(445,PRCP("I"),1,ITMDA,0),PRCPUN=$P(^PRCP(445,PRCP("I"),1,ITMDA,0),"^",5),PRCPUIM=$P(^(0),"^",14)
 .   I $D(^PRCP(445,PRCP("I"),1,ITMDA,6)) S ^PRCP(445,PRCPSEC,1,ITMDA,6)=^(6)
 .   F PCE=2,3,4,6,7,8,9,10,11,13,16,18,19,20,23,24,26,27,28,29 S $P(^PRCP(445,PRCPSEC,1,ITMDA,0),"^",PCE)=""
 .   S ^PRCP(445,PRCPSEC,1,ITMDA,5,0)="^445.07IV^1^1",PRCPVEN=PRCP("I")_";"_"PRCP(445,",$P(^PRCP(445,PRCPSEC,1,ITMDA,0),"^",12)=PRCPVEN
 .   S ^PRCP(445,PRCPSEC,1,ITMDA,5,1,0)=PRCPVEN_"^"_PRCPUN_"^"_PRCPUIM_"^"_PRCPUIM,^PRCP(445,PRCPSEC,1,ITMDA,5,"B",PRCPVEN,1)="",^PRCP(445,PRCPSEC,1,"AC",PRCPVEN,ITMDA)=""
 .   S ^PRCP(445,PRCPSEC,1,"B",ITMDA,ITMDA)=""
 W !!,"COPIED SUCCESSFULLY"
DELQ W !!,"Would you like to delete any unwanted items from the inventory",!,"that you have JUST copied to" S %=2 D YN^DICN G:(%=-1!(%=2)) EXIT I %=0 W !!,"Answer ""Yes"" or ""No""" G DELQ
DEL ; Delete an item, If it is in the inventory and "QTY. ON HAND" field
 ;is equal to null.
 W ! S DIC="^PRCP(445,"_PRCPSEC_",1,",DIC(0)="AEQ",DIC("A")="Select Item no.: "
 S DIC("S")="I $P(^PRCP(445,PRCPSEC,1,+Y,0),""^"",7)="""""
 S DA(1)=PRCPSEC,DIC("W")="S ITMZ=^PRC(441,+Y,0),PRCPDESC=$P(ITMZ,U,2) S:$D(^PRCP(445,DA(1),1,+Y,6)) PRCPDESC=$S($P(^(6),U,1)'="""":$P(^(6),U,1),1:$P(ITMZ,U,2)) D WD^PRCPMCPP"
 D ^DIC K DIC,DA I X']""!(X="^") G EXIT
 K ^PRCP(445,PRCPSEC,1,+Y) W !,$C(7),"                                           <item(s) deleted>" G DEL
EXIT ; Exit the option
 QUIT
WD S DESC=$E(PRCPDESC,1,30),DESC=DESC_$J("",30-$L(DESC))
 W $E("     ",$L(X),5) S ZX=$X+1 W DESC_"     NSN: "_$P(ITMZ,U,5) W:$L(PRCPDESC)>30 !,?ZX,$E(PRCPDESC,31,60) K ITMZ,ZX,DESC Q
