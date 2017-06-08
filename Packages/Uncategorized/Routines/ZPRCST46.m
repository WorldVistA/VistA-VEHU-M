PRCST46 ; ;01/04/88
 D DE G BEGIN
DE S DIE="^PRCS(410,D0,""IT"",",DIC=DIE,DP=410.02,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$N(^PRCS(410,D0,"IT",DA,-1))<0
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,"^",1) S:%]"" DE(2)=% S %=$P(%Z,"^",2) S:%]"" DE(4)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9 I $L(Y)>19,'DV,DV'["P",DV'["S",DV'["I" G RW^DIED
 W:Y]"" "// " I 'DV,DV["I" S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W *7
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,V^DIE2:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) S %=$P($P(";"_DU,";"_X_":",2),";",1),Y=X I %]"" X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 F %=1:1 S Y=$P(DU,";",%),DG=$F(Y,":"_X) G X:Y="" S YS=Y,Y=$P(Y,":",1) I DG X:$D(DIC("S")) DIC("S") I  Q:DG
 W:'$D(DB(DQ)) $E(YS,DG,999) S X=$P(YS,":",1)
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
V D @("X"_DQ) K YS
Z K DIC("S") I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W *7,"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G A:X="@",RD:X]"" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U,1),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U,1) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";",1) S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
BEGIN S DNM="PRCST46",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S DIE("NO^")=1
 Q
2 S DW="0;1",DV="MRNJ3,0",DU="",DLB="LINE ITEM NUMBER",DIFLD=.01
 S DE(DW)="C2^PRCST46"
 G RE
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 K ^PRCS(410,DA(1),"IT","B",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 K ^PRCS(410,DA(1),"IT","AB",$E(X,1,30),DA)
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRCS(410,DA(1),"IT","B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^PRCS(410,DA(1),"IT","AB",$E(X,1,30),DA)=""
 Q
X2 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,D=0 K DE(1) ;1
 S Y="DESCRIPTION^W^^0;1^Q",DG="1" D DIEN^DIWE K DE(1) G A
 ;
4 S DW="0;2",DV="RNJ9,2",DU="",DLB="QUANTITY",DIFLD=2
 S DE(DW)="C4^PRCST46"
 G RE
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N&(E'=DA) E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
 Q
X4 K:+X'=X!(X>999999)!(X<.01)!(X?.E1"."3N.N) X
 Q
 ;
5 D:$D(DG)>9 F^DIE17 G ^PRCST48
