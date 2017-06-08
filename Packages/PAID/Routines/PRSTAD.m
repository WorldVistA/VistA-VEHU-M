PRSTAD ; HISC/CLS/WAA - Add/Edit/Delete 8B RECORD ;2/15/94  15:49
 ;;3.5;PAID;;Jan 26, 1995
 S PP=$P(^PRST(455,0),"^",3) G:PP<1 KIL
 W !!,"Add/edit/delete 8B RECORD for Pay Period ",$E(PP,4,5),", ",1700+$E(PP,1,3)
A0 S FLG="",ADD=0
 K DIC,DIE S DIC="^PRSPC(",DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:"^"[X,A0:Y<1
 S DFN=+Y I $D(^PRST(455,PP,1,DFN,0))#10 G AA1
C1 W !!,"No 8B RECORD exists. Do you want to create one" S %=2 D YN^DICN S:%=-1 %=2
 I %=2 G A0
 I %<1 W !!,"Answer YES to CREATE the 8B RECORD; answer NO if you do not want a new 8B RECORD CREATED ",*7 G C1
 S DIC="^PRST(455,PP,1,",DIC(0)="L",(X,DINUM)=DFN,DA(1)=PP,DLAYGO=455 K DD,DO D FILE^DICN S DFN=+Y,ADD=1 K DIC,DLAYGO
AA1 I $P(^PRST(455,PP,1,DFN,0),"^",2)="H" W !,"Employee is on HOLD and must be removed from HOLD to edit!",*7 G A0
A1 L +^PRST(455,PP,1,DFN) S OLD=^PRST(455,PP,1,DFN,0) G:'ADD A2
 S Y=^PRSPC(DFN,0),X=$P(Y,"^",16) I X?3N S $P(Y,"^",16)=$E("+ABCDEF",+$E(X,1,2)-9)_$E(X,3)
 S $P(^PRST(455,PP,1,DFN,0),"^",4,11)=$P(Y,"^",7)_"^"_$P(Y,"^",9)_"^"_$E($P(Y,"^",1),1,3)_"^"_$P(Y,"^",8)_"^"_$P(Y,"^",15)_"^"_$P(Y,"^",16)_"^"_$P(Y,"^",21)_"^"_$P(Y,"^",10)
 I $P(Y,"^",8)'="" S ^PRST(455,"ATL",$P(Y,"^",8),$P(Y,"^",1),DFN)=""
A2 S DIE="^PRST(455,PP,1,",DIE("NO^")="",DA=DFN,DA(1)=PP,DR=".01;3:11" W ! D ^DIE
 I '$D(DA) K DIE,DA,DR G UNL
 K DIE,DA,DR
 I $P(^PRST(455,PP,1,DFN,0),"^",5)'?9N S DA=DFN,DA(1)=PP,DIK="^PRST(455,PP,1," D ^DIK W !,*7,"Invalid SSN - Record not created..." K DA,DIK,DIC,DIE,DR G UNL
 G:'$D(^PRST(455,PP,1,DFN,0)) UNL S X=^PRST(455,PP,1,DFN,0) I X=OLD G UNL
 I 'ADD S C0=OLD,C1="",C2=$G(^PRST(455,PP,1,DFN,2)) D AD^PRSTAUD
 I $D(^PRST(455,PP,1,DFN,2)) S X="T",%DT="X" D ^%DT S DT=+Y K %DT S %=$P($H,",",2)\60,%=%\60*100+(%#60)+1/10000+$P(DT,".",1),$P(^(2),"^",3)=DUZ,$P(^(2),"^",4)=%
 S FLG=$P(^PRST(455,PP,1,DFN,0),"^",2)
 I FLG="X" S $P(^PRST(455,PP,1,DFN,0),"^",2)="H",^PRST(455,"AH",PP,DFN)=""
 I FLG="P"!(FLG="X") S HDR=0 D ^PRSTED1 K CNT,ERR,MX,NOR,X1
 S TL=$P(^PRST(455,PP,1,DFN,0),"^",7),TLIEN=$O(^PRST(455.5,"B",TL,0))
 I ADD S $P(^PRST(455.5,TLIEN,0),"^",3)="",$P(^PRST(455,PP,1,DFN,0),"^",2)="" G UNL
 I 'ADD,TLIEN>0 S X=$P(^PRST(455.5,TLIEN,0),"^",3) S $P(^(0),"^",3)=$S(X="X":"P",X="P":"P",X="T":"T",1:"")
 S STAT=$P(^PRST(455,PP,1,DFN,0),"^",2)
UNL L -^PRST(455,PP,1,DFN) G A0
KIL K ADD,DA,DFN,C0,C1,C2,DIC,DIE,DINUM,DLAYGO,DR,FLG,HDR,OLD,PP,STAT,TL,TLIEN,X,Y,%H,%Y,D0,D1,I
 K CCODE,CNT,NOR,DFN,%,%DT,C,DISYS,DQ,N1,N2,PE,SN,STA,T0,T1,CFLG,D0,DI,DUT,FFLG,I,K,LAB,NFLG,NN,LVG,PAY,S,Z Q
