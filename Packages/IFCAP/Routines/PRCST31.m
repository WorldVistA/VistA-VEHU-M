PRCST31 ; ;11/25/98
 D DE G BEGIN
DE S DIE="^PRCS(410,",DIC=DIE,DP=410,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCS(410,DA,""))=""
 I $D(^(2)) S %Z=^(2) S %=$P(%Z,U,1) S:%]"" DE(1)=%,DE(3)=% S %=$P(%Z,U,2) S:%]"" DE(4)=% S %=$P(%Z,U,3) S:%]"" DE(6)=% S %=$P(%Z,U,4) S:%]"" DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(10)=% S %=$P(%Z,U,6) S:%]"" DE(11)=% S %=$P(%Z,U,7) S:%]"" DE(12)=%
 I  S %=$P(%Z,U,8) S:%]"" DE(13)=% S %=$P(%Z,U,9) S:%]"" DE(14)=%
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
BEGIN S DNM="PRCST31",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="2;1",DV="RFX",DU="",DLB="VENDOR",DIFLD=11
 S DE(DW)="C1^PRCST31"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^PRCS(410,"E",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,"E",$E(X,1,30),DA)=""
 Q
X1 D VENDOR^PRCSES
 I $D(X),X'?.ANP K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I $D(Z(1))!('$D(Z("Z"))) S Y="@1"
 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="2;1",DV="RFX",DU="",DLB="VENDOR",DIFLD=11
 S DE(DW)="C3^PRCST31"
 G RE
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^PRCS(410,"E",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,"E",$E(X,1,30),DA)=""
 Q
X3 D VENDOR^PRCSES
 I $D(X),X'?.ANP K X
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="2;2",DV="F",DU="",DLB="VENDOR ADDRESS1",DIFLD=11.1
 G RE
X4 K:$L(X)>33!($L(X)<1)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I X="" S Y=11.5
 Q
6 S DW="2;3",DV="F",DU="",DLB="VENDOR ADDRESS2",DIFLD=11.2
 G RE
X6 K:$L(X)>33!($L(X)<1)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I X="" S Y=11.5
 Q
8 S DW="2;4",DV="F",DU="",DLB="VENDOR ADDRESS3",DIFLD=11.3
 G RE
X8 K:$L(X)>25!($L(X)<1)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I X="" S Y=11.5
 Q
10 S DW="2;5",DV="F",DU="",DLB="VENDOR ADDRESS4",DIFLD=11.4
 G RE
X10 K:$L(X)>25!($L(X)<1)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
11 S DW="2;6",DV="F",DU="",DLB="VENDOR CITY",DIFLD=11.5
 G RE
X11 K:$L(X)>20!($L(X)<3)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
12 S DW="2;7",DV="P5'",DU="",DLB="VENDOR STATE",DIFLD=11.6
 S DU="DIC(5,"
 G RE
X12 Q
13 S DW="2;8",DV="FX",DU="",DLB="VENDOR ZIP CODE",DIFLD=11.7
 G RE
X13 K:$L(X)<5!(X'?5N.ANP)!($L(X)>5&(X'?5N1"-"4N)) X
 I $D(X),X'?.ANP K X
 Q
 ;
14 S DW="2;9",DV="F",DU="",DLB="VENDOR CONTACT",DIFLD=11.8
 G RE
X14 K:$L(X)>30!($L(X)<3)!'(X?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
15 D:$D(DG)>9 F^DIE17 G ^PRCST32
