IBXSC8H ; GENERATED FROM 'IB SCREEN8H' INPUT TEMPLATE(#1256), FILE 399;12/13/04
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("U")) S %Z=^("U") S %=$P(%Z,U,13) S:%]"" DE(14)=% S %=$P(%Z,U,16) S:%]"" DE(3)=% S %=$P(%Z,U,17) S:%]"" DE(4)=%
 I $D(^("U2")) S %Z=^("U2") S %=$P(%Z,U,1) S:%]"" DE(7)=% S %=$P(%Z,U,8) S:%]"" DE(16)=% S %=$P(%Z,U,9) S:%]"" DE(18)=% S %=$P(%Z,U,10) S:%]"" DE(24)=%
 I $D(^("UF3")) S %Z=^("UF3") S %=$P(%Z,U,4) S:%]"" DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(10)=% S %=$P(%Z,U,6) S:%]"" DE(12)=%
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
BEGIN S DNM="IBXSC8H",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1256,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1256,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 K DIPA S DIPA("I1")=$D(^DGCR(399,DA,"I1")),DIPA("I2")=$D(^("I2")),DIPA("I3")=$D(^("I3"))
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:IBDR20'["81" Y="@82"
 Q
3 S DW="U;16",DV="D",DU="",DLB="UNABLE TO WORK FROM",DIFLD=166
 G RE
X3 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
4 S DW="U;17",DV="D",DU="",DLB="UNABLE TO WORK TO",DIFLD=167
 G RE
X4 S %DT="EX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
5 S DQ=6 ;@82
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:IBDR20'["82" Y="@83"
 Q
7 S DW="U2;1",DV="*P80'",DU="",DLB="ADMITTING DIAGNOSIS",DIFLD=215
 S DU="ICD9("
 G RE
X7 S ICDVDT=$$BDATE^IBACSV(+$G(DA)),DIC("S")="I $$ICD9ACT^IBACSV(+Y,ICDVDT)",DIC("W")="D EN^DDIOL(""   ""_$P($$ICD9^IBACSV(+Y,ICDVDT),U,3),,""?0"")" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 Q
 ;
8 S DW="UF3;4",DV="F",DU="",DLB="PRIMARY INSURANCE ICN/DCN",DIFLD=453
 G RE
X8 K:$L(X)>23!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:'DIPA("I2") Y="@825"
 Q
10 S DW="UF3;5",DV="F",DU="",DLB="SECONDARY INSURANCE ICN/DCN",DIFLD=454
 G RE
X10 K:$L(X)>23!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S:'DIPA("I3") Y="@825"
 Q
12 S DW="UF3;6",DV="F",DU="",DLB="FORM LOCATOR 37C",DIFLD=455
 G RE
X12 K:$L(X)>23!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 S DQ=14 ;@825
14 S DW="U;13",DV="FX",DU="",DLB="PRIMARY AUTHORIZATION CODE",DIFLD=163
 G RE
X14 K:$L(X)>18!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 S:'DIPA("I2") Y="@83"
 Q
16 S DW="U2;8",DV="FX",DU="",DLB="SECONDARY AUTHORIZATION CODE",DIFLD=230
 G RE
X16 K:$L(X)>18!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S:'DIPA("I3") Y="@83"
 Q
18 S DW="U2;9",DV="F",DU="",DLB="TERTIARY AUTHORIZATION CODE",DIFLD=231
 G RE
X18 K:$L(X)>18!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
19 S DQ=20 ;@83
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S:IBDR20'["83" Y="@84"
 Q
21 S D=0 K DE(1) ;222
 S DIFLD=222,DGO="^IBXSC8H1",DC="17^399.0222ISA^PRV^",DV="399.0222MR*S",DW="0;1",DOW="FUNCTION",DLB="Select "_DOW S:D DC=DC_D
 S DU="1:REFERRING;2:OPERATING;3:RENDERING;4:ATTENDING;5:SUPERVISING;9:OTHER;"
 G RE:D I $D(DSC(399.0222))#2,$P(DSC(399.0222),"I $D(^UTILITY(",1)="" X DSC(399.0222) S D=$O(^(0)) S:D="" D=-1 G M21
 S D=$S($D(^DGCR(399,DA,"PRV",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M21 I D>0 S DC=DC_D I $D(^DGCR(399,DA,"PRV",+D,0)) S DE(21)=$P(^(0),U,1)
 G RE
R21 D DE
 S D=$S($D(^DGCR(399,DA,"PRV",0)):$P(^(0),U,3,4),1:1) G 21+1
 ;
22 S DQ=23 ;@84
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 S:IBDR20'["84" Y="@85"
 Q
24 S DW="U2;10",DV="*P355.93X",DU="",DLB="NON-VA FACILITY",DIFLD=232
 S DE(DW)="C24^IBXSC8H"
 S DU="IBA(355.93,"
 G RE
C24 G C24S:$D(DE(24))[0 K DB
 S X=DE(24),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(399,232,1,1,2.4)
 S X=DE(24),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399,232,1,2,2.4)
C24S S X="" G:DG(DQ)=X C24F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y X ^DD(399,232,1,1,1.1) X ^DD(399,232,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 ;
C24F1 Q
X24 S DIC("S")="I $P(^(0),U,2)=1,$P(^(0),U)'["",""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 S DIPA("NVA_FC")=X S:X="" Y="@842"
 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S DIPA("NVA_FC-0")=$G(^IBA(355.93,+DIPA("NVA_FC"),0)) S:$P(DIPA("NVA_FC-0"),U,5)'=""&($P(DIPA("NVA_FC-0"),U,6)'="")&($P(DIPA("NVA_FC-0"),U,7)'="") Y="@841"
 Q
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 S I(0,0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,10),X=X S D(0)=+X S X=$S(D(0)>0:D(0),1:"")
 S DGO="^IBXSC8H2",DC="^355.93^IBA(355.93," G DIEZ^DIE0
R27 D DE G A
 ;
28 S DQ=29 ;@841
29 D:$D(DG)>9 F^DIE17 G ^IBXSC8H3
