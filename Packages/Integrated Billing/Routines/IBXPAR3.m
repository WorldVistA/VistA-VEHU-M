IBXPAR3 ; ;05/23/94
 D DE G BEGIN
DE S DIE="^IBE(350.9,",DIC=DIE,DP=350.9,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBE(350.9,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,11) S:%]"" DE(1)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,26) S:%]"" DE(4)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,1) S:%]"" DE(5)=% S %=$P(%Z,U,2) S:%]"" DE(6)=% S %=$P(%Z,U,3) S:%]"" DE(7)=% S %=$P(%Z,U,4) S:%]"" DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(9)=% S %=$P(%Z,U,6) S:%]"" DE(10)=%
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
X W *7,"??" I $D(DB(DQ)) G Z^DIE17
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
BEGIN S DNM="IBXPAR3",DQ=1
1 S DW="0;11",DV="P3.8'",DU="",DLB="CATEGORY C BILLING MAIL GROUP",DIFLD=.11
 S DU="XMB(3.8,"
 G RE
X1 Q
2 S DQ=3 ;@5
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:IBDR'["5" Y="@99"
 Q
4 S DW="1;26",DV="*P353'",DU="",DLB="DEFAULT FORM TYPE",DIFLD=1.26
 S DU="IBE(353,"
 G RE
X4 S DIC("S")="I $P(^IBE(353,Y,0),U,1)[""UB""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
5 S DW="2;1",DV="F",DU="",DLB="AGENT CASHIER MAIL SYMBOL",DIFLD=2.01
 G RE
X5 K:$L(X)>25!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
6 S DW="2;2",DV="F",DU="",DLB="AGENT CASHIER STREET ADDRESS",DIFLD=2.02
 G RE
X6 K:$L(X)>25!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
7 S DW="2;3",DV="F",DU="",DLB="AGENT CASHIER CITY",DIFLD=2.03
 G RE
X7 K:$L(X)>15!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
8 S DW="2;4",DV="P5'",DU="",DLB="AGENT CASHIER STATE",DIFLD=2.04
 S DU="DIC(5,"
 G RE
X8 Q
9 S DW="2;5",DV="F",DU="",DLB="AGENT CASHIER ZIP CODE",DIFLD=2.05
 G RE
X9 K:$L(X)>5!($L(X)<5)!'(X?5N) X
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DW="2;6",DV="F",DU="",DLB="AGENT CASHIER PHONE NUMBER",DIFLD=2.06
 G RE
X10 K:$L(X)>25!($L(X)<4) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DQ=12 ;@99
12 G 0^DIE17
