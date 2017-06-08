PRCHT12 ; ;11/25/98
 D DE G BEGIN
DE S DIE="^PRC(442,",DIC=DIE,DP=442,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRC(442,DA,""))=""
 I $D(^(1)) S %Z=^(1) S %=$P(%Z,U,1) S:%]"" DE(3)=%
 I $D(^(7)) S %Z=^(7) S %=$P(%Z,U,3) S:%]"" DE(1)=%
 I $D(^(12)) S %Z=^(12) S %=$P(%Z,U,6) S:%]"" DE(2)=% S %=$P(%Z,U,13) S:%]"" DE(15)=%
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
BEGIN S DNM="PRCHT12",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="7;3",DV="S",DU="",DLB="ESTIMATED ORDER?",DIFLD=.08
 S DU="Y:YES;N:NO;"
 S X=$S(PRCHN("MP")=2:"Y",PRCHN("MP")=12:"Y",1:"N")
 S Y=X
 G Y
X1 Q
2 S DW="12;6",DV="FXO",DU="",DLB="INVOICE ADDRESS",DIFLD=.04
 S DQ(2,2)="S Y(0)=Y Q:Y=""""  S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"""":$P($G(^PRC(442,D0,23)),U,7),1:+^PRC(442,D0,0)) Q:'Z0  S Y=$P($S($D(^PRC(411,Z0,4,Y,0)):^(0),1:""""),U,1) K Z0"
 S X=PRCHN("INV")
 S Y=X
 G Y
X2 S Z0=$S($P($G(^PRC(442,D0,23)),U,7)]"":$P($G(^PRC(442,D0,23)),U,7),1:+^PRC(442,D0,0)) K:'Z0 X Q:'Z0  S DIC="^PRC(411,Z0,4,",DIC(0)="QEMO" D ^DIC S X=+Y K:Y'>0 X K Z0,DIC
 I $D(X),X'?.ANP K X
 Q
 ;
3 S DW="1;1",DV="R*P440X",DU="",DLB="VENDOR",DIFLD=5
 S DE(DW)="C3^PRCHT12"
 S DU="PRC(440,"
 G RE
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^PRC(442,"D",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,"D",$E(X,1,30),DA)=""
 Q
X3 D EN3^PRCHNPO5
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I $P(PRCHNVF,"^",3)=1 S Y="@20"
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S PRCHOV3=$G(^PRC(440,+^PRC(442,D0,1),3)) S:$P(PRCHOV3,"^",12)="P" Y="@20"
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 G A
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:$P(PRCHOV3,"^",6)="N" Y="@20"
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S FLAG=0 I $P(PRCHOV3,"^",4)]""!(($P(PRCHOV3,"^",9)]"")&($P(PRCHOV3,"^",8)]"")) S FLAG=1
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 D EN9^PRCHNPO7
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 W:0 "The jump Y=@20 is set in routine EN9^PRCHNPO7"
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 S I(0,0)=D0 S Y(1)=$S($D(^PRC(442,D0,1)):^(1),1:"") S X=$P(Y(1),U,1),X=X S D(0)=+X S X=$S(D(0)>0:D(0),1:"")
 S DGO="^PRCHT13",DC="^440^PRC(440," G DIEZ^DIE0
R11 D DE G A
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 G A
13 S DQ=14 ;@20
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 I '$D(PRCHEDI) S:$D(^PRC(442,DA,12)) $P(^(12),U,13,14)="^" S Y="@10"
 Q
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW="12;13",DV="S",DU="",DLB="NEED SPECIAL HANDLING?",DIFLD=18.6
 S DU="Y:YES;N:NO;"
 S X="N"
 S Y=X
 G Y
X15 Q
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I X'="Y" S:$D(^PRC(442,DA,12)) $P(^(12),U,14)="" S Y="@10"
 Q
17 D:$D(DG)>9 F^DIE17 G ^PRCHT14
