DGRPXX82 ; ;09/06/91
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$N(^DPT(DA,-1))<0
 I $D(^(.32)) S %Z=^(.32) S %=$P(%Z,U,3) S:%]"" DE(2)=%
 I $D(^("ODS")) S %Z=^("ODS") S %=$P(%Z,U,2) S:%]"" DE(4)=% S %=$P(%Z,U,3) S:%]"" DE(5)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I" S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W *7 K DG,DQ
 Q
A K DQ(DQ) S DQ=DQ+1
 I '$D(DDTM),$D(DIE("NO^")),DIE("NO^")="" S DDTM=DTIME,DTIME=DTIME+1800
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR G:$D(DTOUT) QY^DIE1
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
Y I '$D(DE(DQ)) D O G QY^DIE1:$D(DTOUT),RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O G:$D(DTOUT) QY^DIE1 I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
BEGIN S DNM="DGRPXX82",DQ=1
1 S D=0 K DE(1) ;361
 S DIFLD=361,DGO="^DGRPXX83",DC="3^2.0361PI^E^",DV="2.0361M*P8'X",DW="0;1",DOW="ELIGIBILITY",DLB="Select "_DOW
 S DU="DIC(8,"
 G RE:D I $D(DSC(2.0361))#2,$P(DSC(2.0361),"I $D(^UTILITY(",1)="" X DSC(2.0361) S D=$N(^(0)) G M1
 S D=$S($D(^DPT(DA,"E",0)):$P(^(0),U,3,4),1:$N(^(0)))
M1 I D>0 S DC=DC_D I $D(^DPT(DA,"E",+D,0)) S DE(1)=$P(^(0),U,1)
 G RE
R1 D DE
 S D=1 G 1+1
 ;
2 S DW=".32;3",DV="*P21'X",DU="",DLB="PERIOD OF SERVICE",DIFLD=.323
 S DE(DW)="C2^DGRPXX82"
 S DU="DIC(21,"
 G RE
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 K ^DPT("APOS",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 ;
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^DPT("APOS",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.323,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,"ODS")):^("ODS"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y X ^DD(2,.323,1,2,1.1) X ^DD(2,.323,1,2,1.4)
 Q
X2 S DFN=DA D POS^DGLOCK1
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 D ^DGYZODS S:'DGODS Y="@83"
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="ODS;2",DV="S",DU="",DLB="RECALLED TO ACTIVE DUTY",DIFLD=11500.02
 S DE(DW)="C4^DGRPXX82"
 S DU="0:NO;1:NATIONAL GUARD;2:RESERVES;"
 G RE
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
 Q
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="ODS;3",DV="*P25002.1'",DU="",DLB="RANK",DIFLD=11500.03
 S DE(DW)="C5^DGRPXX82"
 S DU="DIC(25002.1,"
 G RE
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
 Q
X5 S DIC("S")="I '$P(^(0),""^"",4),(""^e^c^""[(""^""_$P(^(0),""^"",2)_""^""))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
6 S DQ=7 ;@83
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:DGDR'["83" Y="@99"
 Q
8 D:$D(DG)>9 F^DIE17 G ^DGRPXX84
