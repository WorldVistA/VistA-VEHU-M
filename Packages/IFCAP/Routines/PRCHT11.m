PRCHT11 ; ;11/25/98
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(6)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,15) S:%]"" DE(5)=%
 I $D(^(23)) S %Z=^(23) S %=$P(%Z,U,7) S:%]"" DE(1)=% S %=$P(%Z,U,8) S:%]"" DE(10)=%
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
BEGIN S DNM="PRCHT11",DQ=1
1 S DW="23;7",DV="*P411'XR",DU="",DLB="SUBSTATION",DIFLD=31
 S DU="PRC(411,"
 G RE
X1 S DIC("S")="I $E($G(^PRC(411,+Y,0)),1,3)=PRC(""SITE"")" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I $D(^PRCS(410,+$P(^PRC(442,DA,0),"^",12),0)),X'=OSUB W !,?5,"Sub-station cannot be changed because the attached 2237",!,?5,"would then have a different sub-station.",!
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S PRCX=$O(^PRC(411,X,1,0)) S:$G(PRCX)]"" PRCY=$P($G(^PRC(411,X,1,PRCX,0)),U) K PRCX
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 G A
5 S DW="1;15",DV="RDX",DU="",DLB="P.O. DATE",DIFLD=.1
 S DE(DW)="C5^PRCHT11"
 S Y="TODAY"
 G Y
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 K ^PRC(442,"AB",$E(X,1,30),DA)
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"AB",$E(X,1,30),DA)=""
 Q
X5 S %DT="EX" D ^%DT S X=Y K:Y<1 X I $D(X) D EN1^PRCHNPO6
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="0;2",DV="R*P442.5'X",DU="",DLB="METHOD OF PROCESSING",DIFLD=.02
 S DE(DW)="C6^PRCHT11"
 S DU="PRCD(442.5,"
 S X="INVOICE/RECEIVING REPORT"
 S Y=X
 G Y
C6 G C6S:$D(DE(6))[0 K DB S X=DE(6),DIC=DIE
 K ^PRC(442,"F",$E(X,1,30),DA)
C6S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"F",$E(X,1,30),DA)=""
 Q
X6 S DIC("S")="I $P(^(0),U,5)=1,"_$S($D(PRCHNRQ):"Y=8!(Y=25)",1:"Y'=8") S:$D(PRCHDELV) DIC("S")="I Y=1!(Y=26)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S PRCHN("MP")=$S($D(^PRCD(442.5,+X,0)):$P(^(0),U,3),1:""),PRCHN("INV")=$S(PRCHN("MP")=2:"FISCAL",PRCHN("MP")=12:"",PRCHN("INV")]"":PRCHN("INV"),1:"FMS")
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S:PRCHN("MP")'=25 Y=.08
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 D LOOK^PRCSPC
 Q
10 D:$D(DG)>9 F^DIE17,DE S DQ=10,DW="23;8",DV="R*P440.5'X",DU="",DLB="PURCHASE CARD NUMBER",DIFLD=46
 S DE(DW)="C10^PRCHT11"
 S DU="PRC(440.5,"
 S X=$G(PRCHXXX)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C10 G C10S:$D(DE(10))[0 K DB S X=DE(10),DIC=DIE
 K ^PRC(442,"AM",$E(X,1,30),DA)
C10S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"AM",$E(X,1,30),DA)=""
 Q
X10 Q
11 D:$D(DG)>9 F^DIE17 G ^PRCHT12
