RTCU ; GENERATED FROM 'RT REQUEST' INPUT TEMPLATE(#472), FILE 190.1;08/25/94
 D DE G BEGIN
DE S DIE="^RTV(190.1,",DIC=DIE,DP=190.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RTV(190.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(4)=%,DE(8)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W *7
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) S %=$P($P(";"_DU,";"_X_":",2),";"),Y=X I %]"" X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 F %=1:1 S Y=$P(DU,";",%),DG=$F(Y,":"_X) G X:Y="" S YS=Y,Y=$P(Y,":") I DG X:$D(DIC("S")) DIC("S") I  Q:DG
 W:'$D(DB(DQ)) $E(YS,DG,999) S X=$P(YS,":")
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I +$P(DV,",",2),X[".",$P(DQ(DQ),U,5)'["$" S X=$S($P(X,"00")="":"",$E(X)[0:$E(X,2,$L(X)),1:X) S:$E($P(X,".",2),$L($P(X,".",2)))[0 X=$E(X,1,$L(X)-1) I $P(X,".",2)=""&(X[".") S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) *7,"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
BEGIN S DNM="RTCU",DQ=1
 S:$D(DTIME)[0 DTIME=999 S D0=DA,DIEZ=472,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(RTNOW) W !?3,*7,"...variable RTNOW must be set to use this template." S Y="@999"
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 D DUZ^RTPSET,D^RTQ:$D(RTSHOW)
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:'$D(RTB) Y="@10"
 Q
4 S DW="0;5",DV="R*P195.9X",DU="",DLB="REQUESTOR",DIFLD=5
 S DE(DW)="C4^RTCU"
 S DU="RTV(195.9,"
 S X=RTB
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G Z:X,RD
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 K ^RTV(190.1,"ABOR",$E(X,1,30),DA)
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RTV(190.1,"ABOR",$E(X,1,30),DA)=""
 Q
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 D INST^RTUTL:'$D(RTINST)
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S Y=$S($D(RTINST):"@22",1:"@20")
 Q
7 S DQ=8 ;@10
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="0;5",DV="R*P195.9X",DU="",DLB="REQUESTING RECORD FOR WHICH BORROWER",DIFLD=5
 S DE(DW)="C8^RTCU"
 S DU="RTV(195.9,"
 G RE
C8 G C8S:$D(DE(8))[0 K DB S X=DE(8),DIC=DIE
 K ^RTV(190.1,"ABOR",$E(X,1,30),DA)
C8S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^RTV(190.1,"ABOR",$E(X,1,30),DA)=""
 Q
X8 D RTQ^RTDPA31 S DIC("S")="I $D(D0),$D(^RT(+^RTV(190.1,D0,0),0)),$P(^(0),U,4)=$P(^RTV(195.9,Y,0),U,3) D DICS^RTDPA31" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X I $D(X) S RTX="RTB" D TEST^RTQ1 K RTX
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:X]"" RTB=X
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 G A
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 D INST^RTUTL
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S RTPCE=2 D ATT^RTDPA3 K RTPCE K:Y Y S:$D(Y) Y="@20"
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 S I(0,0)=D0 S Y(1)=$S($D(^RTV(190.1,D0,0)):^(0),1:"") S X=$P(Y(1),U,5),X=X S D(0)=+X S X=$S(D(0)>0:D(0),1:"")
 S DGO="^RTCU1",DC="^195.9^RTV(195.9," G DIEZ^DIE0
R13 D DE G A
 ;
14 S DQ=15 ;@20
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 S:$D(RTPULL) Y="@22"
 Q
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S RTPCE=3 D ATT^RTDPA3 K RTPCE K:Y Y S:$D(Y) Y="@22"
 Q
17 D:$D(DG)>9 F^DIE17 G ^RTCU2
