PRMQET1 ; ;06/27/91
 D DE G BEGIN
DE S DIE="^PRMQ(513.8,D0,1,",DIC=DIE,DP=513.801,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$N(^PRMQ(513.8,D0,1,DA,-1))<0
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(3)=%
 I $D(^(5)) S %Z=^(5) S %=$P(%Z,U,1) S:%]"" DE(5)=% S %=$P(%Z,U,2) S:%]"" DE(6)=% S %=$P(%Z,U,3) S:%]"" DE(7)=%
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,4) S:%]"" DE(8)=% S %=$P(%Z,U,5) S:%]"" DE(9)=%
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
BEGIN S DNM="PRMQET1",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 G A
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:'$D(PRMQPHY) Y="@1"
 Q
3 S DW="0;2",DV="P6'O",DU="",DLB="RESIDENT OR FELLOW",DIFLD=1
 S DQ(3,2)="S Y(0)=Y S Y=$S('$D(PRMQIEN):Y,Y]"""":$S($D(^DIC(16,Y,0)):$P(^(0),U),1:Y),1:"""")"
 S DU="DIC(6,"
 S X=PRMQPHY
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X3 Q
4 S DQ=5 ;@1
5 S DW="5;1",DV="P200'I",DU="",DLB="ENTRY CREATED BY",DIFLD=11
 S DU="VA(200,"
 S X=.5
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X5 Q
6 S DW="5;2",DV="MDI",DU="",DLB="ENTRY DATE",DIFLD=12
 S Y="T"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X6 S %DT="STX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
7 S DW="5;3",DV="S",DU="",DLB="HEALTH INSURANCE",DIFLD=.51
 S DU="1:YES;2:NO;"
 S X=PRMQIS
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X7 Q
8 S DW="7;4",DV="SI",DU="",DLB="TRANSFER",DIFLD=.2
 S DE(DW)="C8^PRMQET1"
 S DU="1:YES;2:NO;"
 S X=PRMQTRAN
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C8 G C8S:$D(DE(8))[0 K DB S X=DE(8),DIC=DIE
 K ^PRMQ(513.8,"ATF",$E(X,1,30),DA(1),DA)
C8S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRMQ(513.8,"ATF",$E(X,1,30),DA(1),DA)=""
 Q
X8 Q
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW="7;5",DV="MD",DU="",DLB="ORIGINAL ADMISSION DATE",DIFLD=.21
 S X=PRMQOADM
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X9 S %DT="STX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
10 D:$D(DG)>9 F^DIE17 G ^PRMQET2
