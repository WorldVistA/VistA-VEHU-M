PRCHT15 ; ;11/25/98
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(3)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,2) S:%]"" DE(5)=% S %=$P(%Z,U,3) S:%]"" DE(16)=% S %=$P(%Z,U,11) S:%]"" DE(12)=% S %=$P(%Z,U,18) S:%]"" DE(8)=%
 I $D(^(23)) S %Z=^(23) S %=$P(%Z,U,2) S:%]"" DE(1)=%
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
BEGIN S DNM="PRCHT15",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="23;2",DV="D",DU="",DLB="BBFY",DIFLD=26
 S X=PRC("BBFY")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X1 S %DT="" D ^%DT S X=Y K:Y<1 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 D EN2^PRCHNPO3
 Q
3 S DW="0;5",DV="RFX",DU="",DLB="COST CENTER",DIFLD=2
 S X=PRCHN("CC")
 S Y=X
 G Y
X3 S Z0=+$P(^PRC(442,DA,0),"^",3) K:'$D(PRC("SITE"))!'Z0 X,Z0 I $D(X) K:'$D(^PRC(420,PRC("SITE"),1,Z0,2,0)) X I $D(X) D EN2^PRCHNPO5
 I $D(X),X'?.ANP K X
 Q
 ;
4 S DQ=5 ;@88
5 S DW="1;2",DV="RP49'",DU="",DLB="REQUESTING SERVICE",DIFLD=5.2
 S DU="DIC(49,"
 S X=PRCHN("SVC")
 S Y=X
 G Y
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 G A
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:PRCHN("MP")=2 Y="@3" I $D(^PRC(442,DA,1)),$P(^(1),U,18)]"" S Y="@3"
 Q
8 S DW="1;18",DV="RS",DU="",DLB="EXPENDABLE/NONEXPENDABLE",DIFLD=.3
 S DU="E:EXPENDABLE;N:NON-EXPENDABLE;"
 S X="E"
 S Y=X
 G Y
X8 Q
9 S DQ=10 ;@3
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:PRCHN("MP")=4 Y=5.3
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I '$P(^PRC(442,DA,0),U,19)&(PRCHN("MP")'=2) W !,"Enter the word 'PATIENT' in the 'DELIVERY LOCATION' field for a direct delivery",!,"to a patient."
 Q
12 S DW="1;11",DV="F",DU="",DLB="DELIVERY LOCATION",DIFLD=5.6
 G RE
X12 K:$L(X)>20!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I X="PATIENT",$P(^PRC(442,DA,0),U,19) I $P(^(0),U,19)!(PRCHN("MP")=2) W *7,!,"  PATIENT DELIVERY not valid for this type of order!" S Y=5.6
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 I X="PATIENT" W "   Direct Delivery to Patient" S Y=5.3
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 G A
16 S DW="1;3",DV="NJ5,0XO",DU="",DLB="SHIP TO",DIFLD=5.4
 S DQ(16,2)="S Y(0)=Y Q:Y']""""  S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"""":$P($G(^PRC(442,D0,23)),U,7),1:$E($G(^PRC(442,D0,0)),1,3)) Q:'Z0  S Y=$P($S($D(^PRC(411,Z0,1,Y,0)):^(0),1:""""),U,1) K Z0"
 S X=$G(PRCY)
 S Y=X
 G Y
X16 S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"":$P($G(^PRC(442,D0,23)),U,7),1:$E($G(^PRC(442,D0,0)),1,3)) K:'Z0 X Q:'Z0  S DIC="^PRC(411,Z0,1,",DIC(0)="QEM" D ^DIC S X=+Y K:Y'>0 X K Z0,DIC
 Q
 ;
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 I $P(^PRC(442,DA,1),U,12)'="" W *7,!,"Delete the Direct Delivery patient name if you wish the 'Ship to' address",!,"to print on the P.O.",!
 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:(PRCHN("MP")'=4)&($P(^(1),U,12)="") Y=6
 Q
19 D:$D(DG)>9 F^DIE17 G ^PRCHT16
