RCYPT ;WASH-ISC@ALTOONA,PA/RGY-POST TRANSACTION FROM TEMP FILE ;5/2/96  3:14 PM
V ;;4.5;Accounts Receivable;**36,90,63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW CFL,DIR,DUOUT,DTOUT,DIRUT,DIROUT,RCYC,RCYQUE
EN S Y=$$EN^RCYUT("QEAMN") G:+Y<0!$D(DTOUT) Q S RCYC=+Y
 I '$D(^RCY(344,RCYC,1,0)) W *7,!,"This RECEIPT doesn't appear to have entries to post.",!,"Please edit and try again.",! G EN
 I '$P(^RCY(344,RCYC,0),"^",7) W *7,!,"*** This RECEIPT has not been approved ***",! G EN
 S DIR("A")="Is this the correct RECEIPT",DIR(0)="Y",DIR("?")="Enter YES, NO or '^' to quit." D ^DIR K DIR G:$D(DTOUT) Q G:'Y EN
 I $P(^RCY(344,RCYC,0),"^",9)]"" W ! S DIR(0)="Y",DIR("A",1)="This RECEIPT appears to have already been posted",DIR("A")="Do you want to continue",DIR("?")="^S X=""PT"" D ^RCYHLP" D ^DIR K DIR G:$D(DTOUT) Q G:'Y EN
 D ^RCYPT4 I CFL G EN
 D QUE
Q Q
DEQUE ;Process batch payments
 N DA1,RCYRN,DOP,AMT,ACCT,COM,N0,DIE,DR,DA,RCYERR,TYPE,RCYCHK,BY
 L +^RCY(344,RCYC,0):1 E  G Q1
 D NOW^%DTC S $P(^RCY(344,RCYC,0),"^",9,10)=%_"^",RCYRN=$P(^(0),"^")
 F DA1=0:0 S DA1=$O(^RCY(344,RCYC,1,DA1)) Q:'DA1  L +^RCY(344,RCYC,1,DA1):1 D
 .I $P(^RCY(344,RCYC,1,DA1,0),"^",5)]"" L -^RCY(344,RCYC,1,DA1) Q
 .S $P(^RCY(344,RCYC,1,DA1,0),"^",5)=0 L -^RCY(344,RCYC,1,DA1)
 .D POST
 .Q
 L -^RCY(344,RCYC,0)
 S DA=RCYC,DIE="^RCY(344,",DR=".14////^S X=0" D ^DIE
 D NOW^%DTC S $P(^RCY(344,RCYC,0),"^",10)=%
 I RCYDEV]"" S ZTRTN="DQ^RCY215A",ZTIO=RCYDEV,ZTSAVE("RECEIPDA")=RCYC,ZTSAVE("RCTYPE")="A",ZTSAVE("IOP")=RCYDEV,ZTDTH=$H D ^%ZTLOAD
Q1 K RCYC Q
POST ;Post a payment transaction to accounts
 S N0=$G(^RCY(344,RCYC,1,DA1,0)) S DOP=$P(N0,"^",6),ACCT=$P(N0,"^",3),AMT=$P(N0,"^",4),TYPE=$P($G(^RC(341.1,+$P(^RCY(344,RCYC,0),"^",4),0)),"^",2),TYPE=$S(TYPE=5:"DOJ",TYPE=3:"RC",TYPE=11:"IRS",1:"") G:AMT=""!'DOP!'ACCT OU1
 S BY=$P(N0,"^",12) S:'BY BY=DUZ
 ;S Y=$P(^RCY(344,RCYC,0),"^",6),Y=$P($G(^RCY(344.1,Y,0)),"^",2) X ^DD("DD")
 ;S COM="Date of Deposit: "_Y
 S COM=" " S:$P(N0,"^",8)]"" COM=COM_"Bank #"_$P(N0,"^",8) S:$P(N0,"^",7)]"" COM=COM_", Check #"_$P(N0,"^",7)
 S:$P(N0,"^",11)]"" COM=COM_", Credit Card #"_$P(N0,"^",11) S:$P(N0,"^",2)]"" COM=COM_", Confirmation #"_$P(N0,"^",2)
 D POST^PRCAPAY(DOP,RCYRN,BY,.AMT,ACCT,COM,.RCYERR,TYPE) S DIE="^RCY(344,"_RCYC_",1,",DA(1)=RCYC,DA=DA1,DR=".05////^S X="_AMT_$S($G(RCYERR)]"":";1.01////^S X=RCYERR",1:"") D ^DIE
OU1 K RCYERR Q
QUE ;Queue posting of transactions
 NEW %DT,RCYDEV,ZTSK
QUE1 W !,"SELECT PRINTER TO QUEUE TO",!
 S RCYDEV="",%ZIS="MNQ",IOP="Q" D ^%ZIS G:POP QUE1
 S RCYDEV=ION_";"_IOST_";"_IOM_";"_IOSL_$S($D(IO("DOC")):";"_IO("DOC"),1:"")
 I '$D(IO("Q")) W !,*7,"*** YOU MUST QUEUE YOUR OUTPUT TO A PRINTER DEVICE ***",! G QUE1
 D ^%ZISC
 S %DT="AEFRX",%DT("A")="Request time to post payments: ",%DT("B")="NOW",%DT(0)="NOW"
 D ^%DT G:Y<0 QUE1
 S ZTDTH=Y,$P(^RCY(344,RCYC,0),"^",5)=Y
 S ZTRTN="DEQUE^RCYPT",ZTSAVE("RCYC")="",ZTSAVE("RCYDEV")="",ZTIO="",ZTDESC="Post Payment Transactions" D ^%ZTLOAD W !!,"*** REQUEST QUEUED ***",!
QUEQ K IO("Q") Q
