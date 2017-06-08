LAPORTZZ ;SLC/DLG/RAF - DIRECT CONNECT FOR PORT ZZ[ 03/01/95  7:14 AM ]
 ;;5.21;LAB;;04/11/91 11:06 ;
EN S LANM=$T(+0),(HOME,T)=+$E(LANM,7,8) Q:+T<1  Q:$D(^LA("LOCK","ZZ"))
 S DEB="D"_T,PAR=$S($D(^LAB(62.4,T,.5))#2:^(.5),1:""),OUT="",BASE=0,TOUT=5,U="^",IOP=$G(^LAB(62.4,HOME,.75)) G:IOP="" H^XUS
 S IOP=IOP_";255",%ZIS="" D ^%ZIS G:POP H^XUS U IO X ^%ZOSF("TYPE-AHEAD"),^%ZOSF("LABOFF")
 D:IO(0)'=IO ^%ZISC S X="TRAP^"_LANM,@^%ZOSF("TRAP"),DUZ=.5
 S ^LA("LOCK","DZZ")=$J
 R X:1,X:1 ;ALLOW BREAK AND FLUSH BUFFER
LA2 S:'$D(^LA(T,"Q")) ^LA(T,"Q")=0 S:(OUT]""&$D(^LA(DEB,0))) (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="OUT: "_OUT_"%^%"_$H W:OUT]"" OUT,! S TRY=0,(OUT,IN)=""
RD S ^LA(ZZ,"R")=$H R IN:TOUT G TOUT:'$T S:$D(^LA(DEB,0)) (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="IN: "_IN_"%^%"_$H S:$A($E(IN,1))<33 IN=$E(IN,2,999)
IO1 S TOUT=5 IF T=HOME S RT=$H,ASK=-2
IO2 ;D SET
 I '$D(^LA(T,"I")),$D(^LAB(62.4,T,1)) X ^(1)
 L ^LA(T) G IO2:'$D(^LA(T,"I"))#2 S CNT=^LA(T,"I")+1,^("I")=CNT,^("I",CNT)=IN L
 I PAR]"" S OUT="" X PAR I OUT]"" S T=T+BASE G LA2
W S:'$D(^LA(T,"Q")) ^("Q")=0 IF $D(^LA("STOP",HOME)) K ^LA("LOCK",HOME),^LA("STOP",HOME) G H^XUS
 S OUT="" G LA2:^LA("Q")'>^LA(HOME,"Q") L ^LA("Q") S Q=0
 F I=0:0 S Q=$O(^LA("Q",Q)) Q:Q<1  Q:^(Q)=T
 L  K:Q>0 ^LA("Q",Q) G LA2:Q<1
 I $D(^LA(T,"O",0)) S CNT=^LA(T,"O",0)+1 IF $D(^(CNT)) S ^(0)=CNT,OUT=^(CNT)
 S TOUT=5 G LA2
 ;
SET S:'$D(^LA(T,"I"))#2 ^LA(T,"I")=0,^("I",0)=0 S:'$D(^LA(T,"O"))#2 ^LA(T,"O")=0,^("O",0)=0,^LA(T,"Q")=0 Q:$D(^LA(T,"ENV"))  D GETENV^%ZOSV S ^LA(T,"ENV")=Y Q
 ;
TOUT S TOUT=$S(TOUT<15:TOUT+1,1:5) S OUT="" I $D(^LA(T,"O",0)),(^LA(T,"O")>^LA(T,"O",0)) G W
 G RD Q
OUT S CNT=^LA(T,"O")+1,^("O")=CNT,^("O",CNT)=OUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T LOCK
 Q
DQ I $D(^LAB(62.4,ZZ,.75)),$L(^(.75)) S ZTIO=^(.75),ZTRTN="LAPORTZZ",ZTDTH=$H,ZTDESC="START LAB JOB PORT #ZZ" K ^LA("LOCK","DZZ") D ^%ZTLOAD Q
 ;
TRAP D ^%ET,^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM)
