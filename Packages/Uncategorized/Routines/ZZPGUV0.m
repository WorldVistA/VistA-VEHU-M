ZZPGUV0 ; B'ham ISC/CML3 - MOVE GLOBALS, WORK DONE HERE ; 1/22/92  14:18 [ 04/07/93  9:56 AM ]
 ;;1T7
 ;
ERR ; come here if an error occurs
 S $P(^ZZMG(DA,0),"^",6)="" I $G(NF),$G(SND),$D(C) S $P(^(1,NF,1,SND,0),"^",2,3)=C_"^"_$H
 I '$G(AR) D NOW^%DTC S ^ZZMG(DA,"E")=%_"^"_$ZERROR I '$G(AR) S $ZT="" ZT Q
 H 30 G M1
 ;
MOVE(DA) ; entry for initial move and manual restart
 ;
M1 ;
 K C S ND=$G(^ZZMG(DA,0)) D NOW^%DTC
 I ND="" S ^ZZMG(DA,"E")=%_"^"_"DATA NODE NOT FOUND FOR "_DA G MD
 S $P(^(0),"^",6)=$J,$P(^(0),"^",$P(ND,"^",7)>0+7)=%,LG=$G(^("LG"))
 S VOL=$P(ND,"^",2),AR=$P(ND,"^",3),DORT=$P(ND,"^",4),NF=+$P(ND,"^",10),UCI=$P(VOL,","),VOL=$P(VOL,",",2)
 S $ZT="ERR^ZZPGUV0",TG="^["""_UCI_""","""_VOL_"""]"
 F  S NF=$O(^ZZMG(DA,1,NF)) Q:'NF  S SG=$P($G(^(NF,0)),"^") I SG]"" D  ;
 .S C=0,SND=$G(^ZZMG(DA,1,NF,1,0))
 .F SND=$P(SND,"^",3)+1:1 I '$D(^ZZMG(DA,1,NF,1,SND,0)) S ^(0)=$H Q
 .I SND=1 S ^ZZMG(DA,1,NF,1,0)="^521521.0101^1^1"
 .E  S $P(^ZZMG(DA,1,NF,1,0),"^",3,4)=SND_"^"_SND
 .I LG]"",$E(LG,1,$L(SG))=SG S SG=LG
 .S LG=SG,GBL="^"_SG I $D(@GBL)#2 S @(TG_SG)=@GBL,C=C+1
 .F  D  Q:GBL=""  W:DORT="D" !,$H," ",GBL S ^ZZMG(DA,"LG")=C_"^"_LG
 ..F C=C+1:1:C+1000 S GBL=$Q(@GBL) Q:GBL=""  S LG=$E(GBL,2,999),@(TG_LG)=@GBL
 .S $P(^ZZMG(DA,0),"^",10)=NF,^("LG")=C_"^"_LG,$P(^(1,NF,1,SND,0),"^",2,3)=C_"^"_$H,SND=0,LG=""
 D NOW^%DTC S $P(^ZZMG(DA,0),"^",9)=%
 ;
MD ;
 K C,DA,GBL,LG,ND,NF,SND,SG,TG,UCI,VOL Q
 ;
MS ; move statistics
 D NOW^%DTC
 W #,!?29,"GLOBAL MOVE STATISTICS",!,"You are signed on to ",HERE,?65,$$DTC^ZZPGUVH(%)
 W !!,"TASK  JOB #                  STARTED               FINISHED",!!?10,"GLOBAL    NODES           TIME           NODES PER",!?20,"MOVED           TAKEN          MINUTE"
 W !,"-------------------------------------------------------------------------------" S Q=0
 F  S Q=$O(^ZZMG("B",HERE,Q)) Q:'Q  S ND=$G(^ZZMG(Q,0)) D:$P(ND,"^",10)  ;
 .I $Y>20 R !,"<>",X:30 S $Y=0
 .W !!,Q W:'$P(ND,"^",9) ?6,$P(ND,"^",6) W ?29,$$DTC^ZZPGUVH($P(ND,"^",7)) I $P(ND,"^",9) W ?51,$$DTC^ZZPGUVH($P(ND,"^",9))
 .W ! S X=0 F  S X=$O(^ZZMG(Q,1,X)) Q:'X  S ND1=$P($G(^(X,0)),"^") I ND1]"" S (TNM,TT,Y)=0 F  S Y=$O(^ZZMG(Q,1,X,1,Y)) D  I 'Y W:TNM]0 !?10,ND1,?20,TT,?35,$J(TNM,8),?50,NPM Q
 ..I Y S ND2=$G(^ZZMG(Q,1,X,1,Y,0)) S A=$P(ND2,"^"),B=$P(ND2,"^",3) I A,B S TT=TT+$P(ND2,"^",2),TNM=B-A*86400+$P(B,",",2)-$P(A,",",2)+TNM
 ..I 'Y,TNM S NPM=TT/TNM*60\1,T1=TNM\3600,T2=TNM#3600\60,T3=TNM#60 S:T1<10 T1="0"_T1 S:T2<10 T2="0"_T2 S:T3<10 T3="0"_T3 S TNM=T1_":"_T2_":"_T3
 R !,"<>",X:90
 K ND,ND1,ND2,Q,X,Y,A,B,TNM,TT,T1,T2,T3,NPM Q
 
