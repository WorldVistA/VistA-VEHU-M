PRCPMCPS ;WISC/AKS-copy items from secondary to secondary ;23 Oct 92
 ;;4.0;IFCAP;**7**;9/23/93
 D ^PRCPUSEL G:'$G(PRCP("I")) Q I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." G Q
 S DIC(0)="AEQM" S:'$D(DIC("S")) DIC("S")="" I '$D(DIC("A")) S DIC("A")="Select SECONDARY INVENTORY/DISTRIBUTION POINT TO COPY FROM: "
 W !! S PRCPI=-1
 S DIC="^PRCP(445,"_PRCP("I")_",2,",DA(1)=PRCP("I"),D0=PRCP("I"),DIC("S")="Q:'$D(^PRCP(445,+Y,0))  I +^(0)=PRC(""SITE"")",PRCPPRIV=1
 D ^DIC K PRCPPRIV,DIC,DA G:Y=-1 Q S PRCPI=+Y I '$D(^PRCP(445,PRCPI,0)) S Y=-1 G Q
 I $P(^PRCP(445,PRCPI,0),"^",2)="Y",'$D(^PRCP(445,PRCPI,4,DUZ)) W !!,"Sorry, You are not a user in the secondary you are trying to copy from" S Y=-1 G Q
TO S DIC(0)="AEQM" S:'$D(DIC("S")) DIC("S")="" I '$D(DIC("A")) S DIC("A")="Select SECONDARY INVENTORY/DISTRIBUTION POINT TO COPY TO: "
 W !! S PRCPSRC1=-1
 S DIC="^PRCP(445,"_PRCP("I")_",2,",DA(1)=PRCP("I"),DIC("S")="Q:'$D(^PRCP(445,+Y,0))  I +^(0)=PRC(""SITE"")",PRCPPRIV=1
 D ^DIC K PRCPPRIV,DIC,DA,D0 G:Y=-1 Q I PRCPI=+Y W !!,$C(7),"      ERROR -- You cannot copy items into the same inventory point" G TO
 S PRCPSRC1=+Y I '$D(^PRCP(445,PRCPSRC1,0)) S Y=-1 G Q
 I $P(^PRCP(445,PRCPSRC1,0),"^",2)="Y",'$D(^PRCP(445,PRCPSRC1,4,DUZ)) W !!,"Sorry, You are not a user in the secondary you are trying to copy to." S Y=-1 G Q
ST W !!,"Are you sure you want to copy "_$P($P(^PRCP(445,PRCPI,0),"^"),"-",2)_" secondary inventory to "_$P($P(^PRCP(445,PRCPSRC1,0),"^"),"-",2),!,"secondary inventory point "
 S %=2 D YN^DICN G:(%=-1!(%=2)) Q I %=0 W !!,"Answer ""Yes"" or ""No""" G ST
 I '$D(^PRCP(445,PRCPI,1)) W !!,"No items in the "_$P($P(^PRCP(445,PRCPI,0),"^"),"-",2)_" inventory point" G Q
 W !!,"Copying..."
 S NIT=$P(^PRCP(445,PRCPI,1,0),"^",4),^PRCP(445,PRCPSRC1,1,0)="^445.01IP^"_$P(^(0),"^",3)_"^"_NIT
 S N=0 F I=1:1:NIT S N=$O(^PRCP(445,PRCPI,1,N)) Q:N=""!(N'?1.N)  D:'$D(^PRCP(445,PRCPSRC1,1,N,0))&('$D(^PRCP(445,PRCPI,1,N,8))) SET I '(I#10) W "."
 W !!,"COPIED SUCCESSFULLY"
ST1 W !!,"Would you like to delete any unwanted items from the inventory",!,"that you have JUST copied to" S %=2 D YN^DICN G:(%=-1!(%=2)) Q I %=0 W !!,"Answer ""Yes"" or ""No""" G ST1
ST2 ; Delete an item, If it is in the inventory and "QTY. ON HAND" field
 ;is equal to null.
 ;
 W !
 S DIC="^PRCP(445,"_PRCPSRC1_",1,",DIC(0)="AEQ",DIC("A")="Select Item no.: "
 S DA(1)=PRCPSRC1,DIC("S")="I $P(^PRCP(445,PRCPSRC1,1,+Y,0),""^"",7)="""""
 S DIC("W")="N %,PRCPDESC S %=$G(^PRC(441,+Y,0)),PRCPDESC=$S($P($G(^PRCP(445,DA(1),1,+Y,6)),U)'="""":$P($G(^(6)),U),1:$P(%,U,2)) W ?9,$E(PRCPDESC,1,30),?45,""NSN: "",$P(%,U,5) W:$E(PRCPDESC,31)'="""" !?9,$E(PRCPDESC,31,60)"
 D ^DIC K DIC,DA I X']""!(X="^") G Q
 K ^PRCP(445,PRCPSRC1,1,+Y) W !,$C(7),"                                               <item(s) deleted>" G ST2
Q K PRCPSRC1,NIT,N,I,%,M,J,K,PRCPI,X,Y,PRCPY,PRCPUN,PRCPA,PRCPVEN,PRCPUIM
 QUIT
SET ; Setting one item at a time
 ;
 Q:'$D(^PRCP(445,PRCPI,1,N,0))  S ^PRCP(445,PRCPSRC1,1,N,0)=^PRCP(445,PRCPI,1,N,0),PRCPUN=$P(^PRCP(445,PRCP("I"),1,N,0),"^",5),PRCPUIM=$P(^(0),"^",14)
 I $D(^PRCP(445,PRCPI,1,N,6)) S ^PRCP(445,PRCPSRC1,1,N,6)=^(6)
 F K=2,3,6,7,8,13,16,18,19,20,23,24,26,27,28,29 S $P(^PRCP(445,PRCPSRC1,1,N,0),"^",K)=""
 S ^PRCP(445,PRCPSRC1,1,N,5,0)="^445.07IV^1^1",PRCPVEN=PRCP("I")_";"_"PRCP(445,",$P(^PRCP(445,PRCPSRC1,1,N,0),"^",12)=PRCPVEN
 S ^PRCP(445,PRCPSRC1,1,N,5,1,0)=PRCPVEN_"^"_PRCPUN_"^"_PRCPUIM_"^"_PRCPUIM,^PRCP(445,PRCPSRC1,1,N,5,"B",PRCPVEN,1)="",^PRCP(445,PRCPSRC1,1,"AC",PRCPVEN,N)=""
 S ^PRCP(445,PRCPSRC1,1,"B",N,N)=""
 Q
