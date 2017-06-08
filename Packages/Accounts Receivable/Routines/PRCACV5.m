PRCACV5 ;WASH-ISC@ALTOONA,PA/RGY-Convert AR V3.7 database to AR V4.0 ;11/19/93  8:42 AM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
 ;
 ;DELETE OBSOLETE INPUT TEMPLATES
 ;
 W !,"Deleting obsolete input templates..."
 S DA=$O(^DIE("B","PRCA CHANGE STATUS",0)) I DA S DIK="^DIE(" D ^DIK
 S DA=$O(^DIE("B","PRCAE DEBTOR ADDRESS",0)) I DA S DIK="^DIE(" D ^DIK
 S DA=$O(^DIE("B","PRCAC REFERAL DC/DOJ",0)) I DA S DIK="^DIE(" D ^DIK
 ;
 ;REMOVE DC/DOJ PAYMENT TYPE FROM FILE AND MOVE BATCH PAYMENT INFO
 ;
 W !,"Moving Batch Payment from obsolete file (435) to new file (344) ..."
 I '$P($G(^RCY(344,0)),"^",3) F X=0:0 S X=$O(^PRCA(435,X)) Q:'X  D:$D(^PRCA(435,X,0))
 .W "."
 .S ^RCY(344,X,0)=^PRCA(435,X,0)
 .I $P(^RCY(344,X,0),"^")]"" S ^RCY(344,"B",$P(^(0),"^"),X)=""
 .I $P(^RCY(344,X,0),"^",2)]"",$P(^(0),"^",4)]"" K ^RCY(344,"AA",$P(^(0),"^",2),$P(^(0),"^",4)) S ^RCY(344,"AA",$P(^RCY(344,X,0),"^",2),$P(^(0),"^",4),X)=""
 .S Y=$P(^PRCA(435,X,0),"^",4),$P(^RCY(344,X,0),"^",4)=$S(Y=1:6,Y=2:4,Y=3:7,1:"")
 .F Y=0:0 S Y=$O(^PRCA(435,X,1,Y)) Q:'Y  D:$D(^PRCA(435,X,1,Y,0))
 ..S:$D(^PRCA(435,X,1,0)) ^RCY(344,X,1,0)=^PRCA(435,X,1,0)
 ..S ^RCY(344,X,1,Y,0)=^PRCA(435,X,1,Y,0)
 ..S ^RCY(344,X,1,"B",Y,Y)=""
 ..S N0=$P(^RCY(344,X,1,Y,0),"^",3) S:N0[";DPT(" ^RCY(344,"AC",N0,X,Y)="" I N0[";PRCA(430,",$D(^RCD(340,+$P(^PRCA(430,+N0,0),"^",9),0)) S ^RCY(344,"AC",$P(^RCD(340,+$P(^PRCA(430,+N0,0),"^",9),0),"^"),X,Y)=""
 ..I $P(^RCY(344,X,1,Y,0),"^",12)]"",$P(^(0),"^",5)="" S $P(^(0),"^",5)=0
 ..S:$P(^RCY(344,X,1,Y,0),"^",12)]"" $P(^(0),"^",12)=""
 ..S:$D(^PRCA(435,X,1,Y,1)) ^RCY(344,X,1,Y,1)=^PRCA(435,X,1,Y,1)
 ..Q
 .Q
 S:$D(^PRCA(435,0)) $P(^RCY(344,0),"^",3,4)=$P(^PRCA(435,0),"^",3,4)
 ;
 ;REMOVE OBSOLETE OPTIONS
 ;
 W !,"Removing obsolete options..."
 F OPT=1:1 S OPT1=$P($T(OPT+OPT),";;",2) Q:OPT1=""  F OPTDA=0:0 S OPTDA=$O(^DIC(19,"B",OPT1,OPTDA)) Q:'OPTDA  W !,"Deleting option '",OPT1,"' ..." S DA=OPTDA,DIK="^DIC(19," D ^DIK
 ;
 ;REMOVE LOCK IF EXISTS
 ;
 S DA=$O(^DIC(19,"B","PRCA BIL AGENCY",0)) I DA S DIE="^DIC(19,",DR="3///@" D ^DIE
XREF ;
 ;X-REF "AS" INDEX
 ;
 K ^PRCA(430,"AS")
 W !,"I need to index your bill file (430) 'AS' cross reference and",!,"update Last INT/ADM charged field",!,"I will write a period (.) for every 1000 entries"
 W !,"  you have '",+$P(^PRCA(430,0),"^",4),"' entries..."
 F X=0:0 S X=$O(^PRCA(430,X)) Q:'X  W:'(X#1000) "." D
 .K ^PRCA(430,X,10,"B")
 .S Y=0 F DA=0:0 S DA=$O(^PRCA(430,X,10,DA)) Q:'DA  S Y=Y+1
 .I 'Y K ^PRCA(430,X,10)
 .I Y S ^PRCA(430,X,10,0)="^^"_Y_"^"_Y
 .S Y=$G(^PRCA(430,X,0))
 .S:$P($G(^PRCA(430.2,+$P(Y,"^",2),0)),"^",12) $P(^PRCA(430,X,6),"^",7)=DT
 .I $P(Y,"^",8)]"",$P(Y,"^",9)]"" S ^PRCA(430,"AS",$P(Y,"^",9),$P(Y,"^",8),X)=""
 .Q
 ;
 ;Setup statement days for non-patients
 ;
 W !,"OK, (almost done!), I just have to set some statement dates",!,"for non patient debtors..."
 F TYP="VA(200,","DIC(4,","PRC(440," F DEB=0:0 S DEB=$O(^RCD(340,"AB",TYP,DEB)) Q:'DEB  I '$P($G(^RCD(340,DEB,0)),"^",3) D
 .S STM=0,PRCABN=0 F  S PRCABN=$O(^PRCA(430,"AS",DEB,$O(^PRCA(430.3,"AC",102,0)),PRCABN)) Q:'PRCABN  S N6=$G(^PRCA(430,PRCABN,6)) F X=9,8,3,2,1 I $P(N6,"^",X)>STM S STM=$P(N6,"^",X) Q
 .I STM S STM=$E(STM,6,7)
 .S STM=$S('STM:DEB,1:STM)#28 S:'STM STM=28
 .S $P(^RCD(340,DEB,0),"^",3)=STM,^RCD(340,"AC",STM,DEB)=""
 .Q
 ;
 ;Load Integrated Billing routines if applicable
 ;
 D ^PRCACV8,^PRCACV9
 ;
 ;END OF INSTALLATION
 ;
 S END=$H,TOTAL=END-START*86400+$$ABS^XLFMTH($P(END,",",2)-$P(START,",",2))
 W !!,"Completed at " D NOW^%DTC S Y=% X ^DD("DD") W Y
 W !,"Total time: " W TOTAL\86400," day(s) " S TOTAL=TOTAL#86400 W TOTAL\3600," hour(s) " S TOTAL=TOTAL#3600 W TOTAL\60," minute(s) " S TOTAL=TOTAL#60 W TOTAL," second(s)."
 Q
OPT ;
 ;;PRCA BIL LIST CANCEL
 ;;PRCA BIL LIST INCOM
 ;;PRCA BIL LIST PEND
 ;;PRCA BIL STATUS
 ;;PRCA BILL LIST
 ;;PRCA SIGNATURE CODE EDIT
 ;;PRCAC EDIT DEBTOR
 ;;PRCAC ADMINT REPAYMENT
 ;;PRCAC DCDOJ PAYMENT
 ;;PRCAC TR PAYMENT
 ;;PRCAD AMIS MONTH
 ;;PRCAD AMIS QUARTER
 ;;PRCAD AMIS REPORT
 ;;PRCAD MAS SUSPENDED
 ;;PRCAE SEND LETTERS
 ;;PRCAF AR ADDRESS
 ;;PRCAF MAXNUM LETTER
 ;;PRCAF MONTH INT.ADM
 ;;PRCAF CASHIER ADDRESS
 ;;PRCAF PARAMETER MENU
 ;;PRCAF PARM DC
 ;;PRCAF PARM DOJ
 ;;PRCAF PARM TAX
 ;;PRCAF REFUND EXCESS
 ;;PRCAF REFUND STATUS
 ;;PRCAF U STATUS
 ;;PRCAL RETURNED BILL
 ;;PRCAL MEANS LIST
 ;;PRCAL L ACTIVE
 ;;PRCAL L INCOMLETE DATA
 ;;PRCAL L INCOMPLETE DATA
 ;;PRCAL L NEW
 ;;PRCAL L WRITTEN OFF
 ;;PRCAL RETURN AR
 ;;PRCAT AR MENU
 ;;PRCAT LIST PENDING CALM
 ;;PRCAT CODE SHEET MENU
 ;;PRCAT PAT COMMON
 ;;PRCAY CREATE/EDIT BATCH
 ;;PRCAY ENTER A PAYMENT
 ;;PRCAY BATCH STATUS
 ;;
