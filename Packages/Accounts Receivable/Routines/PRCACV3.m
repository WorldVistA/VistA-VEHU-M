PRCACV3 ;WASH-ISC@ALTOONA,PA/RGY-Convert AR V3.7 database to AR V4.0 ;8/2/93  8:09 AM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
 I $G(^DD(340,0,"VR"))["4.0" W !,*7,"CONVERSION APPEARS TO HAVE ALREADY BEEN RUN.",!,"IF YOU REALLY WANT TO RUN CONVERSION AGAIN, RUN 'EN^PRCACV3'" G Q
 I '$D(DIFQ) W !,*7,"CONVERSION SHOULD ONLY BE RUN AS PART OF THE INIT PROCESS!!" G Q
EN NEW CNT,SITE,ENT,START,END,I,N0,Y,TOTAL,X,DIK,DIC,%X,%Y,ERR,EVN,TIME,TYP,STM,PRCABN,N6
 I '$$SYS^PRCACV1() W !,*7,"SYSTEM VARIABLES NOT DEFINED - CONVERSION NOT RUN TO COMPLETION!!",!,"DEFINE SYSTEM VARIABLES AND RESTART INSTALLATION PROCESS!" G Q
 S START=$H
 W !,"Accounts Receivable (ARV4.0) conversion started at " D NOW^%DTC S Y=% X ^DD("DD") W Y,!!,"(If you need to re-start the conversion process, run routine EN^PRCAINIT)",!
 ;
 ;KILL OBSOLETE X-REFS
 ;
 W !,"Removing obsolete AR xrefs: "
 K ^PRCA(430,"ALT") H 2 W !,"^PRCA(430,""ALT"", deleted"
 K ^PRCA(430,"AO") H 2 W !,"^PRCA(430,""AO"", deleted"
 K ^PRCA(430,"ADB") H 2 W !,"^PRCA(430,""ADB"", deleted"
 K ^PRCA(430,"A3P") H 2 W !,"^PRCA(430,""A3P"", deleted"
 K ^PRCA(433,"D") H 2 W !,"^PRCA(433,""D"", deleted"
 ;
 ;DELETE OBSOLETE FIELDS
 ;
 W !!,"Deleting Accounts Receivable File 430 fields listed below."
 S DIK="^DD(430,",DA(1)=430 F DA=12.1,12.2,12.3,12.4,12.5,5,6,5.1,6.1,105 I $D(^DD(430,DA,0)) W !,DA,?7,$P(^DD(430,DA,0),U) D ^DIK
 K DA,DIK
 ;
SP ;SETUP SITE PARAMETER FILE (342)
 ;
 W !!,"Setting up AR Site Parameter file (342)"
 S SITE=$P($G(^RC(342,1,0)),"^") G:SITE SP1
 S SITE=$P($G(^PRC(411,$S(+$O(^PRC(411,"AC","Y",0)):$O(^(0)),1:+$O(^PRC(411,0))),0)),"^") I SITE="" D
 .S DIC="^DIC(4,",DIC(0)="QEAM",DIC("A")="Enter your site name: " D ^DIC I Y<0 D
 ..W !!,"SITE PARAMETER FILE NOT SETUP PROPERLY",!,"PLEASE EDIT USING THE AR SUPERVISOR OPTIONS"
 ..Q
 .S SITE=+Y
 .Q
 I SITE<0 W !,*7,"I was not able to set up your AR Site Parameter file!!",!,"CONVERSION HAS NOT RUN TO COMPLETION (^PRCACV3)!!",! G Q
SP1 S:$P($G(^RC(342,1,0)),"^")="" $P(^RC(342,1,0),"^")=SITE
 S:$P(^RC(342,1,0),"^",2)="" $P(^RC(342,1,0),"^",2)=$S($P($G(^PRCA(434,+$O(^PRCA(434,"B","PHARM",0)),2)),"^")="Y":1,1:0)
 S:$P(^RC(342,1,0),"^",4)="" $P(^RC(342,1,0),"^",4)=$O(^PRC(411,SITE,2,"AC","UB",""))
 S:$P(^RC(342,1,0),"^",5)="" $P(^RC(342,1,0),"^",5)=1
 S:$P(^RC(342,1,0),"^",8)="" $P(^RC(342,1,0),"^",8)=$O(^PRC(411,SITE,2,"AC","A",""))
 S $P(^RC(342,1,3),"^",1,3)="2931122^2930914^9.35"
 S CNT=0,X=0 F  S X=$O(^PRCA(431,X)) Q:'X  S Y=$G(^PRCA(431,X,0)) I $P(Y,"^")?7N,$P(Y,"^",4)<1,$P(Y,"^",5)<10 S CNT=CNT+1,^RC(342,1,4,CNT,0)=$P(Y,"^")_"^"_$P(Y,"^",4)_"^"_$P(Y,"^",5)
 I CNT S $P(^RC(342,1,4,CNT,0),"^",4)=.06,^RC(342,1,4,0)="^342.04D^"_CNT_"^"_CNT
 I $P(^RC(342,1,0),"^",10)="" D NOW^%DTC S $P(^RC(342,1,0),"^",10)=%
 S DIK="^RC(342," D IXALL^DIK
 ;
 G ^PRCACV4
Q Q
