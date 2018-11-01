IBXS37 ; ;10/30/18
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("M")) S %Z=^("M") S %=$P(%Z,U,4) S:%]"" DE(13)=% S %=$P(%Z,U,5) S:%]"" DE(14)=% S %=$P(%Z,U,6) S:%]"" DE(15)=% S %=$P(%Z,U,7) S:%]"" DE(18)=% S %=$P(%Z,U,8) S:%]"" DE(19)=% S %=$P(%Z,U,9) S:%]"" DE(20)=%
 I $D(^("M1")) S %Z=^("M1") S %=$P(%Z,U,1) S:%]"" DE(17)=% S %=$P(%Z,U,4) S:%]"" DE(1)=% S %=$P(%Z,U,12) S:%]"" DE(5)=%,DE(8)=%
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
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" I X?.ANP D SET^DIED I 'DDER G V
 K DDER G X
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
BEGIN S DNM="IBXS37",DQ=1
1 S DW="M1;4",DV="FX",DU="",DIFLD=124,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^IBXS37"
 S X="IBPSID" Q:X  Q:$NA(@X)[U  S X=$G(@X)
 S Y=X
 G Y
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,4)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(399,124,1,1,2.4)
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
C1F1 Q
X1 K:$L(X)>13!($L(X)<3)!($TR(X," ")="") X
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I $G(IBPSQO)]"",X'=$G(IBPSID),X'=$G(IBPSIDO) S Y="@3234"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I $G(IBPSQO)="",$G(IBPSQUAL)="",X]"" S Y="@3234"
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 G A
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="M1;12",DV="*P355.97'",DU="",DIFLD=130,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="IBE(355.97,"
 S X="IBPSQUAL" Q:X  Q:$NA(@X)[U  S X=$G(@X)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X5 S DIC("S")="I $$BPS^IBCEPU(Y)!($$EPT^IBCEPU(Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S Y="@3235"
 Q
7 S DQ=8 ;@3234
8 S DW="M1;12",DV="*P355.97'",DU="",DIFLD=130,DLB="Tertiary ID Qualifier"
 S DU="IBE(355.97,"
 G RE
X8 S DIC("S")="I $$BPS^IBCEPU(Y)!($$EPT^IBCEPU(Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
9 S DQ=10 ;@3235
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 K DIE("NO^")
 Q
11 S DQ=12 ;@33
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S:IBDR20'["33" Y="@34"
 Q
13 S DW="M;4",DV="F",DU="",DIFLD=104,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X13 K:$L(X)>30!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
14 S DW="M;5",DV="FX",DU="",DIFLD=105,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X14 K:$L(X)>35!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
15 S DW="M;6",DV="F",DU="",DIFLD=106,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X15 K:$L(X)>35!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S:X="" Y=107
 Q
17 S DW="M1;1",DV="F",DU="",DIFLD=121,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X17 K:$L(X)>35!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
18 S DW="M;7",DV="F",DU="",DIFLD=107,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X18 K:$L(X)>25!($L(X)<2) X
 I $D(X),X'?.ANP K X
 Q
 ;
19 S DW="M;8",DV="P5'",DU="",DIFLD=108,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(5,"
 G RE
X19 Q
20 S DW="M;9",DV="FX",DU="",DIFLD=109,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X20 S:$E(X,6)="-" X=$TR(X,"-") K:$L(X)>9!($L(X)<5)!'(X?5N!(X?9N)) X
 I $D(X),X'?.ANP K X
 Q
 ;
21 S DQ=22 ;@34
22 S DQ=23 ;@999
23 G 0^DIE17
