IBXSC35 ; ;09/01/09
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("M1")) S %Z=^("M1") S %=$P(%Z,U,3) S:%]"" DE(6)=%,DE(17)=%,DE(23)=% S %=$P(%Z,U,10) S:%]"" DE(1)=% S %=$P(%Z,U,11) S:%]"" DE(7)=%,DE(18)=%
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
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
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
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="IBXSC35",DQ=1
1 S DW="M1;10",DV="*P355.97'",DU="",DLB="Primary ID Qualifier",DIFLD=128
 S DU="IBE(355.97,"
 G RE
X1 S DIC("S")="I $$BPS^IBCEPU(Y)!($$EPT^IBCEPU(Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 S DQ=3 ;@3215
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 K DIE("NO^")
 Q
4 S DQ=5 ;@3221
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I '$$SUPPPT^IBCEP7B(DA,2) S Y="@3222"
 Q
6 S DW="M1;3",DV="FX",DU="",DLB="SECONDARY PROVIDER #",DIFLD=123
 S DE(DW)="C6^IBXSC35"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C6 G C6S:$D(DE(6))[0 K DB
 S X=DE(6),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,3)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399,123,1,1,2.4)
C6S S X="" G:DG(DQ)=X C6F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
C6F1 Q
X6 K:$L(X)>13!($L(X)<3)!($TR(X," ")="") X
 I $D(X),X'?.ANP K X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="M1;11",DV="*P355.97'",DU="",DLB="SECONDARY ID QUALIFIER",DIFLD=129
 S DU="IBE(355.97,"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X7 S DIC("S")="I $$BPS^IBCEPU(Y)!($$EPT^IBCEPU(Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 W !,"No Billing Prov Secondary IDs will be sent for Secondary Ins/Elect Plan Type."
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S Y="@3231"
 Q
10 S DQ=11 ;@3222
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I '$$ATTREND^IBCEP7B(DA,2) S Y="@3223"
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I $P($G(^DGCR(399,DA,"M1")),U,3)]"" S Y="@3223"
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 W !,"The Att/Rend ID will be sent as the secondary ins. Billing Prov Sec ID."
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S Y="@3231"
 Q
15 S DQ=16 ;@3223
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S IBPSDAT=$$GETID^IBCEP7B(DA,2),IBPSID=$P(IBPSDAT,U),IBPSQUAL=$P(IBPSDAT,U,2) I IBPSID="" S Y="@322"
 Q
17 S DW="M1;3",DV="FX",DU="",DLB="SECONDARY PROVIDER #",DIFLD=123
 S DE(DW)="C17^IBXSC35"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C17 G C17S:$D(DE(17))[0 K DB
 S X=DE(17),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,3)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399,123,1,1,2.4)
C17S S X="" G:DG(DQ)=X C17F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
C17F1 Q
X17 K:$L(X)>13!($L(X)<3)!($TR(X," ")="") X
 I $D(X),X'?.ANP K X
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S DQ=18,DW="M1;11",DV="*P355.97'",DU="",DLB="SECONDARY ID QUALIFIER",DIFLD=129
 S DU="IBE(355.97,"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X18 S DIC("S")="I $$BPS^IBCEPU(Y)!($$EPT^IBCEPU(Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S DIE("NO^")=1
 Q
20 S DQ=21 ;@322
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 S IBPSIDO=$P($G(^DGCR(399,DA,"M1")),U,3),IBPSQO=$P($G(^DGCR(399,DA,"M1")),U,11)
 Q
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 G A
23 S DW="M1;3",DV="FX",DU="",DLB="SECONDARY PROVIDER #",DIFLD=123
 S DE(DW)="C23^IBXSC35"
 S X="IBPSID" Q:X  Q:$NA(@X)[U  S X=$G(@X)
 S Y=X
 G Y
C23 G C23S:$D(DE(23))[0 K DB
 S X=DE(23),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,3)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399,123,1,1,2.4)
C23S S X="" G:DG(DQ)=X C23F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
C23F1 Q
X23 K:$L(X)>13!($L(X)<3)!($TR(X," ")="") X
 I $D(X),X'?.ANP K X
 Q
 ;
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 I $G(IBPSQO)]"",X'=$G(IBPSID),X'=$G(IBPSIDO) S Y="@3224"
 Q
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 I $G(IBPSQO)="",$G(IBPSQUAL)="",X]"" S Y="@3224"
 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 G A
27 D:$D(DG)>9 F^DIE17 G ^IBXSC36
