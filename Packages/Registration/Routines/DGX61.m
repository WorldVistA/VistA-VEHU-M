DGX61 ; ;03/11/23
 D DE G BEGIN
DE S DIE="^DGPT(D0,""P"",",DIC=DIE,DP=45.05,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^DGPT(D0,"P",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(5)=% S %=$P(%Z,U,2) S:%]"" DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(17)=% S %=$P(%Z,U,6) S:%]"" DE(22)=% S %=$P(%Z,U,7) S:%]"" DE(27)=% S %=$P(%Z,U,8) S:%]"" DE(32)=% S %=$P(%Z,U,9) S:%]"" DE(37)=%
 I  S %=$P(%Z,U,10) S:%]"" DE(42)=% S %=$P(%Z,U,11) S:%]"" DE(47)=% S %=$P(%Z,U,12) S:%]"" DE(52)=% S %=$P(%Z,U,13) S:%]"" DE(57)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 K X S X("FIELD")=DIFLD,X("FILE")=DP W "  ("_$$EZBLD^DIALOG(710,.X)_")" K X S X="" Q  ;**
TR Q:DV["K"&(DUZ(0)'="@")  R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G A:DV["K"&(DUZ(0)'["@"),PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",X:X'?.ANP
 I DV["t" D  G UNIQ ;EXTENSIBLE DATA TYPES ;p21
 .X $S($D(DB(DQ)):$$VALEXTS^DIETLIBF(DP,DIFLD),1:$$VALEXT^DIETLIBF(DP,DIFLD)) K DIPA
 I DV["S" D SET^DIED G V:'DDER K DDER G X ;p22
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
UNIQ I DV["U",$D(X),DIFLD=.01 K % M %=@(DIE_"""B"",X)") K %(DA) K:$O(%(0)) X
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
 I DG["t" X $$OUTPUT^DIETLIBF(DP,DIFLD) K DIPA G RP ;p21
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") I %]"" S Y=$S($G(DUZ("LANG"))'>1:%,'DIFLD:%,1:$$SET^DIQ(DP,DIFLD,Y))
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="DGX61",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S:'$D(DGADD) DGADD=0
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:DGADD Y="@25"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:DGJUMP'[1 Y="@2"
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S DGNFLD="@10"
 Q
5 S DW="0;1",DV="MDX",DU="",DIFLD=.01,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C5^DGX61",DE(DW,"INDEX")=1
 G RE
C5 G C5S:$D(DE(5))[0 K DB
C5S S X="" G:DG(DQ)=X C5F1 K DB
C5F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1177,1178,1179,1180,1181,1249,1250,1251,1252,1253,1254,1255,1256,1257,1258,1259,1260,1261,1262,1263,1264,1265,1266,1267,1268,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X5 S %DT="ET" D ^%DT S X=+Y K:+Y<1 X I $D(X) X $S($$BADDT^DGPTFM6(X):"K X",1:"S X=X")
 Q
 ;
6 S DQ=7 ;@10
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S DGNFLD="@15"
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="0;2",DV="*P42.4'",DU="",DIFLD=1,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(42.4,"
 D BS^DGPTFM6 S X=DGMOVM K DGMOVM
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X8 S DIC("S")="I $$ACTIVE^DGACT(42.4,Y,$P(^DGPT(DA(1),""P"",DA,0),U))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
9 S DQ=10 ;@15
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:DGJUMP'[2 Y=""
 Q
11 S DQ=12 ;@2
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S DGNFLD="@25"
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S Y="@899"
 Q
14 S DQ=15 ;@25
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 I DGADD,$P(DGHOLD,U,5)]"" S Y="@40"
 Q
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S DGNFLD="@40"
 Q
17 S DW="0;5",DV="*P80.1'X",DU="",DIFLD=4,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C17^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C17 G C17S:$D(DE(17))[0 K DB
 S X=DE(17),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C17S S X="" G:DG(DQ)=X C17F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C17F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1177,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X17 N DGIT S DGIT=5 D GETAPI^DGICDGT("DG PTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I X K DGPTIT S DGNFLD="@40",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
19 S DQ=20 ;@40
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 I DGADD,$P(DGHOLD,U,6)]"" S Y="@50"
 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 S DGNFLD="@50"
 Q
22 D:$D(DG)>9 F^DIE17,DE S DQ=22,DW="0;6",DV="*P80.1'X",DU="",DIFLD=5,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C22^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C22 G C22S:$D(DE(22))[0 K DB
 S X=DE(22),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C22S S X="" G:DG(DQ)=X C22F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C22F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1178,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X22 N DGIT S DGIT=5 D GETAPI^DGICDGT("DG PTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 I X K DGPTIT S DGNFLD="@50",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
24 S DQ=25 ;@50
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 I DGADD,$P(DGHOLD,U,7)]"" S Y="@60"
 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S DGNFLD="@60"
 Q
27 D:$D(DG)>9 F^DIE17,DE S DQ=27,DW="0;7",DV="*P80.1'X",DU="",DIFLD=6,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C27^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C27 G C27S:$D(DE(27))[0 K DB
 S X=DE(27),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C27S S X="" G:DG(DQ)=X C27F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C27F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1179,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X27 N DGIT S DGIT=5 D GETAPI^DGICDGT("DG PTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 I X K DGPTIT S DGNFLD="@60",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
29 S DQ=30 ;@60
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 I DGADD,$P(DGHOLD,U,8)]"" S Y="@70"
 Q
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 S DGNFLD="@70"
 Q
32 D:$D(DG)>9 F^DIE17,DE S DQ=32,DW="0;8",DV="*P80.1'X",DU="",DIFLD=7,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C32^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C32 G C32S:$D(DE(32))[0 K DB
 S X=DE(32),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C32S S X="" G:DG(DQ)=X C32F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C32F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1180,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X32 N DGIT S DGIT=5 D GETAPI^DGICDGT("DG PTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
33 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=33 D X33 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X33 I X K DGPTIT S DGNFLD="@70",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
34 S DQ=35 ;@70
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 I DGADD,$P(DGHOLD,U,9)]"" S Y="@80"
 Q
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 S DGNFLD="@80"
 Q
37 D:$D(DG)>9 F^DIE17,DE S DQ=37,DW="0;9",DV="*P80.1'X",DU="",DIFLD=8,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C37^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C37 G C37S:$D(DE(37))[0 K DB
 S X=DE(37),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C37S S X="" G:DG(DQ)=X C37F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C37F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1181,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X37 N DGIT S DGIT=5 D GETAPI^DGICDGT("DG PTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 I X K DGPTIT S DGNFLD="@80",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
39 S DQ=40 ;@80
40 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=40 D X40 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X40 I DGADD,$P(DGHOLD,U,10)]"" S Y="@90"
 Q
41 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=41 D X41 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X41 S DGNFLD="@90"
 Q
42 D:$D(DG)>9 F^DIE17,DE S DQ=42,DW="0;10",DV="*P80.1'X",DU="",DIFLD=9,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C42^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C42 G C42S:$D(DE(42))[0 K DB
 S X=DE(42),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C42S S X="" G:DG(DQ)=X C42F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C42F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1265,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X42 N DGIT S DGIT=5 D GETAPI^DGICDGT("DGPTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
43 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=43 D X43 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X43 I X K DGPTIT S DGNFLD="@90",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
44 S DQ=45 ;@90
45 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=45 D X45 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X45 I DGADD,$P(DGHOLD,U,11)]"" S Y="@100"
 Q
46 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=46 D X46 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X46 S DGNFLD="@100"
 Q
47 D:$D(DG)>9 F^DIE17,DE S DQ=47,DW="0;11",DV="*P80.1'X",DU="",DIFLD=10,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C47^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C47 G C47S:$D(DE(47))[0 K DB
 S X=DE(47),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C47S S X="" G:DG(DQ)=X C47F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C47F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1266,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X47 N DGIT S DGIT=5 D GETAPI^DGICDGT("DGPTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
48 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=48 D X48 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X48 I X K DGPTIT S DGNFLD="@100",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
49 S DQ=50 ;@100
50 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=50 D X50 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X50 I DGADD,$P(DGHOLD,U,12)]"" S Y="@110"
 Q
51 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=51 D X51 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X51 S DGNFLD="@110"
 Q
52 D:$D(DG)>9 F^DIE17,DE S DQ=52,DW="0;12",DV="*P80.1'X",DU="",DIFLD=11,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C52^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C52 G C52S:$D(DE(52))[0 K DB
 S X=DE(52),DIC=DIE
 K ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)
C52S S X="" G:DG(DQ)=X C52F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"P","AP6",$E(X,1,30),DA)=""
C52F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1267,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X52 N DGIT S DGIT=5 D GETAPI^DGICDGT("DGPTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
53 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=53 D X53 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X53 I X K DGPTIT S DGNFLD="@110",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
54 S DQ=55 ;@110
55 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=55 D X55 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X55 I DGADD,$P(DGHOLD,U,13)]"" S Y="@120"
 Q
56 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=56 D X56 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X56 S DGNFLD="@120"
 Q
57 D:$D(DG)>9 F^DIE17,DE S DQ=57,DW="0;13",DV="*P80.1'X",DU="",DIFLD=12,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C57^DGX61",DE(DW,"INDEX")=1
 S DU="ICD0("
 G RE
C57 G C57S:$D(DE(57))[0 K DB
 D ^DGX62
C57S S X="" G:DG(DQ)=X C57F1 K DB
 D ^DGX63
C57F1 S DIEZRXR(45.05,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1268,1670 S DIEZRXR(45.05,DIXR)=""
 Q
X57 N DGIT S DGIT=5 D GETAPI^DGICDGT("DGPTF","PROC",$G(DA(1)),"EN1")
 Q
 ;
58 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=58 D X58 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X58 I X K DGPTIT S DGNFLD="@120",Y="@800",DGPTIT(X_$C(59)_"ICD0(")=""
 Q
59 S DQ=60 ;@120
60 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=60 D X60 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X60 I DGADD,$P(DGHOLD,U,14)]"" S Y="@130"
 Q
61 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=61 D X61 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X61 S DGNFLD="@130"
 Q
62 D:$D(DG)>9 F^DIE17 G ^DGX64
