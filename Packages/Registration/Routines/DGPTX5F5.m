DGPTX5F5 ; ;06/24/93
 D DE G BEGIN
DE S DIE="^DGPT(D0,""M"",",DIC=DIE,DP=45.02,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$N(^DGPT(D0,"M",DA,-1))<0
 I $D(^(300)) S %Z=^(300) S %=$P(%Z,U,4) S:%]"" DE(1)=%,DE(5)=% S %=$P(%Z,U,5) S:%]"" DE(9)=% S %=$P(%Z,U,6) S:%]"" DE(13)=%
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
BEGIN S DNM="DGPTX5F5",DQ=1
1 S DW="300;4",DV="P45.61'X",DU="",DLB="SUBSTANCE ABUSE",DIFLD=300.04
 S DU="DIC(45.61,"
 G RE
X1 S DGFLAG=4 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:X]"" DGDUP(4)=1
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S Y="@840"
 Q
4 S DQ=5 ;@835
5 S DW="300;4",DV="P45.61'X",DU="",DLB="SUBSTANCE ABUSE",DIFLD=300.04
 S DU="DIC(45.61,"
 S X=DGTX
 S Y=X
 G Y
X5 S DGFLAG=4 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:X]"" DGDUP(4)=1
 Q
7 S DQ=8 ;@840
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I '$D(DGBPC(5))!(DGDUP(5)) S Y="@850"
 Q
9 S DW="300;5",DV="SX",DU="",DLB="PSYCHIATRY CLASS. SEVERITY",DIFLD=300.05
 S DU="0:INADEQUATE INFO OR NO CHANGE;1:NONE;2:MILD;3:MODERATE;4:SEVERE;5:EXTREME;6:CATASTROPHIC;"
 G RE
X9 S DGFLAG=5 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:X]"" DGDUP(5)=1
 Q
11 S DQ=12 ;@850
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I '$D(DGBPC(6))!(DGDUP(6)) S Y="@860"
 Q
13 S DW="300;6",DV="NJ2,0X",DU="",DLB="CURRENT PSYCH CLASS ASSESS",DIFLD=300.06
 G RE
X13 S DGFLAG=6 D 501^DGPTSC01 S:DGER X="" K DGFLAG,DGER K:+X'=X!(X>90)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:X]"" DGDUP(6)=1
 Q
15 S DQ=16 ;@860
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I '$D(DGBPC(7))!(DGDUP(7)) S Y="@899"
 Q
17 D:$D(DG)>9 F^DIE17 G ^DGPTX5F6
