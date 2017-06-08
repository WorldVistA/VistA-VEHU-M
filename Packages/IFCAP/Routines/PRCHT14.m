PRCHT14 ; ;11/25/98
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,3) S:%]"" DE(9)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,7) S:%]"" DE(3)=% S %=$P(%Z,U,19) S:%]"" DE(5)=%
 I $D(^(12)) S %Z=^(12) S %=$P(%Z,U,14) S:%]"" DE(1)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
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
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
BEGIN S DNM="PRCHT14",DQ=1
1 S DW="12;14",DV="P443.4'",DU="",DLB="TYPE OF SPECIAL HANDLING",DIFLD=18.7
 S DU="PRC(443.4,"
 G RE
X1 Q
2 S DQ=3 ;@10
3 S DW="1;7",DV="R*P420.8'",DU="",DLB="SOURCE CODE",DIFLD=8
 S DU="PRCD(420.8,"
 S X=PRCHN("SC")
 S Y=X
 G Y
X3 S DIC("S")="I "_$S($D(PRCHPUSH):"""13""[$E(^(0))",$D(PRCHNRQ):"""1390""[$E(^(0))",1:"""2456789B""[$E(^(0))") D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I "29"'[X K:0 DIC("DR") D ^PRCHNPO3 S Y="@1"
 Q
5 S DW="1;19",DV="RP443.8'",DU="",DLB="LOCAL PROCUREMENT REASON CODE",DIFLD=.25
 S DE(DW)="C5^PRCHT14"
 S DU="PRC(443.8,"
 G RE
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 ;
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^PRC(442,D0,1)):^(1),1:"") S X=$P(Y(1),U,17),X=X S DIU=X K Y X ^DD(442,.25,1,1,1.1) X ^DD(442,.25,1,1,1.4)
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 D ^PRCHNPO3
 Q
7 S DQ=8 ;@1
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I $D(^PRCS(410,+$P(^PRC(442,DA,0),"^",12),0)) S X=$P($P(^(0),U,1),"-",4) I +X=+$P(^PRC(442,DA,0),U,3) W !,"FCP: ",$P(^(0),U,3) S Y="@2"
 Q
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW="0;3",DV="RFX",DU="",DLB="FCP",DIFLD=1
 S DE(DW)="C9^PRCHT14"
 G RE
C9 G C9S:$D(DE(9))[0 K DB S X=DE(9),DIC=DIE
 K ^PRC(442,"E",$P(X," ",1),DA)
 S X=DE(9),DIC=DIE
 S $P(^PRC(442,DA,0),U,19)="",$P(^(17),U,1)=""
C9S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"E",$P(X," ",1),DA)=""
 S X=DG(DQ),DIC=DIE
 I $D(^PRC(420,+^PRC(442,DA,0),1,+X,0)) S Z=^(0) S:$P(Z,U,12) $P(^PRC(442,DA,0),U,19)=$P(Z,U,12) S:$P(Z,U,18) $P(^PRC(442,DA,17),U,1)=$E($P(Z,U,18),1,3) K Z
 Q
X9 K:X[""""!($A(X)=45) X I $D(X) K:'$D(PRC("SITE"))!('$D(^PRC(442,DA,1))) X Q:'$D(X)  S:$P(^(1),U,15)]"" PRC("FY")=$P(^(1),U,15) D EN1^PRCHNPO5 Q:'$D(X)  S $P(^PRC(442,DA,0),U,4)=PRC("APP")
 I $D(X),X'?.ANP K X
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 G A
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S PRCHN("SFC")=$P(^PRC(442,DA,0),U,19)
 Q
12 S DQ=13 ;@2
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I $G(PRC("BBFY"))="" S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),$P(^PRC(442,DA,0),U,3))
 Q
14 D:$D(DG)>9 F^DIE17 G ^PRCHT15
