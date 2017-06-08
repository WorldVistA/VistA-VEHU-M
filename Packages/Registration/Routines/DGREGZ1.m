DGREGZ1 ; ;10/13/99
 D DE G BEGIN
DE S DIE="^DPT(D0,""DIS"",",DIC=DIE,DP=2.101,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^DPT(D0,"DIS",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(1)=%
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(19)=%
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,1) S:%]"" DE(20)=% S %=$P(%Z,U,2) S:%]"" DE(22)=% S %=$P(%Z,U,3) S:%]"" DE(24)=% S %=$P(%Z,U,4) S:%]"" DE(5)=% S %=$P(%Z,U,5) S:%]"" DE(7)=% S %=$P(%Z,U,6) S:%]"" DE(8)=% S %=$P(%Z,U,7) S:%]"" DE(9)=%
 I $D(^(3)) S %Z=^(3) S %=$P(%Z,U,1) S:%]"" DE(10)=% S %=$P(%Z,U,2) S:%]"" DE(11)=% S %=$P(%Z,U,3) S:%]"" DE(12)=% S %=$P(%Z,U,4) S:%]"" DE(14)=% S %=$P(%Z,U,5) S:%]"" DE(15)=% S %=$P(%Z,U,6) S:%]"" DE(16)=% S %=$P(%Z,U,8) S:%]"" DE(18)=%
 I  S %=$P(%Z,U,9) S:%]"" DE(17)=%
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
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
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
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"N")=X,^("O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="DGREGZ1",DQ=1
1 S DW="0;5",DV="P200'",DU="",DLB="WHO ENTERED 10/10",DIFLD=4
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I '$D(^DPT(DFN,.36)) S Y=23
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I $P(^DPT(DFN,.36),U,2) S Y=23
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I $S($D(^DIC(8,+^DPT(DFN,.36),0)):$P(^(0),U,9),1:0)'=5 S Y=23
 Q
5 S DW="2;4",DV="RS",DU="",DLB="NEED RELATED TO AN ACCIDENT",DIFLD=23
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I "NU"[X S Y=20
 Q
7 S DW="2;5",DV="F",DU="",DLB="INJURY CAUSED BY",DIFLD=24
 G RE
X7 K:$L(X)>80!($L(X)<4) X
 I $D(X),X'?.ANP K X
 Q
 ;
8 S DW="2;6",DV="P36'",DU="",DLB="INJURING PARTIES INSURANCE",DIFLD=25
 S DU="DIC(36,"
 G RE
X8 Q
9 S DW="2;7",DV="S",DU="",DLB="FILED AGAINST INJURING PARTY",DIFLD=26
 S DU="Y:YES;N:NO;"
 G RE
X9 Q
10 S DW="3;1",DV="F",DU="",DLB="ATTORNEY'S NAME",DIFLD=30
 G RE
X10 K:$L(X)>30!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DW="3;2",DV="F",DU="",DLB="A-ADDRESS 1",DIFLD=31
 G RE
X11 K:$L(X)>30!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
12 S DW="3;3",DV="F",DU="",DLB="A-ADDRESS 2",DIFLD=32
 G RE
X12 K:$L(X)>30!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S:X="" Y=34
 Q
14 S DW="3;4",DV="F",DU="",DLB="A-ADDRESS 3",DIFLD=33
 G RE
X14 K:$L(X)>30!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
15 S DW="3;5",DV="F",DU="",DLB="A-CITY",DIFLD=34
 G RE
X15 K:$L(X)>30!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
16 S DW="3;6",DV="P5'",DU="",DLB="A-STATE",DIFLD=35
 S DU="DIC(5,"
 G RE
X16 Q
17 S DW="3;9",DV="FOX",DU="",DLB="A-ZIP+4",DIFLD=38
 S DQ(17,2)="S Y(0)=Y D ZIPOUT^VAFADDR"
 S DE(DW)="C17^DGREGZ1"
 G RE
C17 G C17S:$D(DE(17))[0 K DB
 S X=DE(17),DIC=DIE
 D KILLMULT^DGREGDD1(DA(1),DA,2.101,"DIS",36,3,7,$E(X,1,5))
C17S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 D SETMULT^DGREGDD1(DA(1),DA,2.101,"DIS",36,3,7,$E(X,1,5))
 Q
X17 K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>15!($L(X)<5) X I $D(X) D ZIPIN^VAFADDR
 I $D(X),X'?.ANP K X
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S DQ=18,DW="3;8",DV="F",DU="",DLB="A-PHONE",DIFLD=37
 G RE
X18 K:$L(X)>20!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
19 S DW="1;1",DV="F",DU="",DLB="DESCRIPTION OF INCIDENT",DIFLD=10
 G RE
X19 K:$L(X)>250!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
20 S DW="2;1",DV="RS",DU="",DLB="NEED RELATED TO OCCUPATION",DIFLD=20
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
X20 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 I "UN"[X S Y=""
 Q
22 S DW="2;2",DV="S",DU="",DLB="WORKMEN'S COMP CLAIM FILED",DIFLD=21
 S DU="Y:YES;N:NO;"
 G RE
X22 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 S:X="N" Y=""
 Q
24 S DW="2;3",DV="F",DU="",DLB="WORKMEN'S COMP CLAIM NUMBER",DIFLD=22
 G RE
X24 K:$L(X)>10!($L(X)<4) X
 I $D(X),X'?.ANP K X
 Q
 ;
25 G 1^DIE17
