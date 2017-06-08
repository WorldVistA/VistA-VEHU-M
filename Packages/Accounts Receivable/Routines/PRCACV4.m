PRCACV4 ;WASH-ISC@ALTOONA,PA/RGY-Convert AR V3.7 database to AR V4.0 ;7/28/93  10:50 AM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
F340 ;
 ;CONVERT FILE 340
 ;
 S CNT=+$P($G(^RCD(340,0)),"^",4),ENT=+$P($G(^RCD(340,0)),"^",3) S:'$D(^RCD(340,0)) ^RCD(340,0)="AR DEBTOR^340V^^0"
 I CNT W !,"OK, I will continue from where I left off (entry number: ",ENT,")",!,"converting file 412 to file 340",!
 W !!,"OK, I need to convert ",+$P($G(^PRC(412,0)),"^",4)," entries in your file 412",!,"I have currently converted ",ENT," entries already.",!
 W !,"I will write a period ('.') for every 100 records"
 S TIME=$$FPS^RCAMFN01(DT,-2)
 F  S ENT=$O(^PRC(412,ENT)) Q:'ENT  D
 .S N0=$G(^PRC(412,ENT,0))
 .S Y=$P(N0,"^") I +Y'=$P(Y,";")!("^PRC(440,^DPT(^DIC(36,^DIC(4,^VA(200,^"'[("^"_$P(Y,";",2,999)_"^")) W !,"Oops, I can't convert entry #",X," from file 412 to file 340!" Q
 .S ^RCD(340,ENT,0)=$P(N0,"^")_$S($P(N0,"^")[";DPT(":"^^"_$P(N0,"^",3),1:""),^RCD(340,"B",$P(N0,"^"),ENT)="",^RCD(340,"AB",$P($P(N0,"^"),";",2),ENT)="",CNT=CNT+1
 .S:$P(^RCD(340,ENT,0),"^",3) ^RCD(340,"AC",$P(^RCD(340,ENT,0),"^",3),ENT)=""
 .I $P(N0,"^")[";DPT(" F RCBL=2,9 I $P(N0,"^",RCBL),RCBL=9!($P(N0,"^",RCBL)>TIME) D
 ..S X=$P($G(^RC(341,0)),"^",3)+1,$P(^(0),"^",3,4)=X_"^"_X
 ..S ^RC(341,X,0)=$P(^RC(342,1,0),"^")_"-"_X_"-0^2^^^"_ENT_"^"_$P(N0,"^",RCBL)_"^"_$P(N0,"^",RCBL)_"^"_DUZ_"^"_$P(^RC(342,1,0),"^")_"^^1"
 ..F Y=1:1:4 S:$P(N0,"^",$S(RCBL=2:4,1:9)+Y) $P(^RC(341,X,1),"^",Y)=$P(N0,"^",$S(RCBL=2:4,1:9)+Y)
 ..S Y=^RC(341,X,0)
 ..S ^RC(341,"B",$P(Y,"^"),X)=""
 ..S ^RC(341,"C",$P(Y,"^",7),X)=""
 ..S ^RC(341,"AD",ENT,$P(Y,"^",2),9999999.999999-$P(Y,"^",7),X)=""
 ..Q
 .W:'(CNT#100) "."
 .S $P(^RCD(340,0),"^",3,4)=ENT_"^"_CNT
Q1 .Q
 ;
 D NIGHT
 ;
 ;REMOVE 'BILL RESULTING' DATA FROM FILE 430.2
 ;
 W !!,"Removing obsolete 'Bill Resulting from' data from file 430.2"
 F X=0:0 S X=$O(^PRCA(430.2,X)) Q:'X  S $P(^PRCA(430.2,X,0),"^",9)=""
 ;
 ;DELETE 'BILL RESULTING' FIELD IN FILE 430.2
 ;
 I $D(^DD(430.2,8)) W !!,"Deleting the obsolete 'Bill Resulting from' field." S DIK="^DD(430.2,",DA(1)=430.2,DA=8 D ^DIK K DA,DIK
 ;
 ;SET PREPAYMENT FLAG IN FILE 430.4
 ;
 W !!,"Flagging your AR Bill Number File 430.4 entries for 'FISCAL' service",!,"as Prepayment series."
 F X=0:0 S X=$O(^PRCA(430.4,X)) Q:'X  S Y=^(X,0) I $D(^DIC(49,"B","FISCAL",+$P(Y,U,5))),$P(Y,U,4)<$P(Y,U,3),$S($L($P(Y,U))<7:1,1:$P(Y,U,4)<1000) W !,$P(Y,U) S $P(^PRCA(430.4,X,0),U,7)=1
 K X,Y
 ;
 ;SETUP FILE 342.1 (AR GROUP FILE)
 ;
 W !,"Setting up AR Group file (342.1) ..."
 I '$P($G(^RC(342.1,0)),"^",3) D
 .S CNT=0
 .F X=0:0 S X=$O(^PRCA(430.5,X)) Q:'X  I $D(^(X,0)),$P(^(0),"^",8)]"",$P(^(0),"^",8)'="F" D
 ..S CNT=CNT+1
 ..S Y=$P(^PRCA(430.5,X,0),"^",8),Y=$S(Y="A":4,Y="B":6,Y="C":1,Y="D":2,Y="J":3,1:7)
 ..S ^RC(342.1,X,0)=$S(",1,2,3,4,"[(","_Y_","):$P("AGENT CASHIER^DISTRICT COUNSEL^DEPT. OF JUSTICE^ACCOUNTS RECEIVABLE","^",Y),1:$P(^PRCA(430.5,X,0),"^"))_"^"_Y
 ..S ^RC(342.1,X,1)=$S(",1,2,3,4,"[(","_Y_","):$P(^PRCA(430.5,X,0),"^",1,7),1:$P(^PRCA(430.5,X,0),"^",2,3)_"^^"_$P(^PRCA(430.5,X,0),"^",4,6)),$P(^RC(342.1,X,1),"^",8)=$P($G(^PRCA(430.5,X,1)),"^",3)
 ..Q
 .I $O(^PRCA(430.5,"C","A",0)),'$O(^RC(342.1,"AC",8,0)) D
 ..F X=0:0 S X=$O(^PRCA(430.5,X)) Q:'$O(^PRCA(430.5,X))
 ..Q:'X
 ..S CNT=CNT+1,X=X+1
 ..S ^RC(342.1,X,0)="RETURN PAYMENT^8",^RC(342.1,X,1)=$P($G(^PRCA(430.5,+$O(^PRCA(430.5,"C","A",0)),0)),"^",1,7)
 ..Q
 .S $P(^RC(342.1,0),"^",3,4)=X_"^"_CNT
 .S DIK="^RC(342.1," D IXALL^DIK
 .Q
 ;
 G ^PRCACV5
Q Q
 ;
NIGHT ;QUEUE NIGHTLY PROCESS
 N DA,DIE,DR,TIME,DIFROM
 S DIE="^DIC(19,",DA=$O(^DIC(19,"B","PRCA NIGHTLY PROCESS",0)) D:DA
 .S TIME=$$FMADD^XLFDT(DT,1)_".0200",DR="200////"_TIME D ^DIE
 .W !!,"PRCA NIGHTLY PROCESS option queued for "_$$FMTE^XLFDT(TIME,"1P"),!!
 .Q
 Q
 ;
