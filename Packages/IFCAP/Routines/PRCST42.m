PRCST42 ; ;11/22/00
 D DE G BEGIN
DE S DIE="^PRCS(410,D0,""IT"",",DIC=DIE,DP=410.02,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRCS(410,D0,"IT",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(2)=% S %=$P(%Z,U,2) S:%]"" DE(4)=% S %=$P(%Z,U,3) S:%]"" DE(5)=% S %=$P(%Z,U,4) S:%]"" DE(9)=% S %=$P(%Z,U,6) S:%]"" DE(6)=% S %=$P(%Z,U,7) S:%]"" DE(7)=%
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
BEGIN S DNM="PRCST42",DQ=1
1 S DQ=2 ;@1
2 S DW="0;1",DV="MRNJ3,0",DU="",DLB="LINE ITEM NUMBER",DIFLD=.01
 S DE(DW)="C2^PRCST42"
 S Y="1"
 G Y
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K ^PRCS(410,DA(1),"IT","B",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 K ^PRCS(410,DA(1),"IT","AB",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 ;
C2S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRCS(410,DA(1),"IT","B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^PRCS(410,DA(1),"IT","AB",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S Z(1)=$S($D(^PRCS(410,DA(1),3)):$P(^(3),U,3),1:"") S ^PRCS(410,DA(1),"IT",DA,0)=$P(^PRCS(410,DA(1),"IT",DA,0)_"^^^^^^^",U,1,7)_U_Z(1) K Z(1)
 Q
X2 K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,D=0 K DE(1) ;1
 S Y="DESCRIPTION^W^^0;1^Q",DG="1",DC="^410.03" D DIEN^DIWE K DE(1) G A
 ;
4 S DW="0;2",DV="RNJ9,2",DU="",DLB="QUANTITY",DIFLD=2
 S DE(DW)="C4^PRCST42"
 G RE
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N&(E'=DA) E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
C4S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
 Q
X4 K:+X'=X!(X>999999)!(X<.01)!(X?.E1"."3N.N) X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;3",DV="RP420.5'",DU="",DLB="UNIT OF PURCHASE",DIFLD=3
 S DU="PRCD(420.5,"
 G RE
X5 Q
6 S DW="0;6",DV="FX",DU="",DLB="STOCK NUMBER",DIFLD=6
 G RE
X6 K:$L(X)>24!($L(X)<1)!(X'?.ANP) X
 I $D(X),X'?.ANP K X
 Q
 ;
7 S DW="0;7",DV="RNJ10,2X",DU="",DLB="EST. ITEM (UNIT) COST",DIFLD=7
 S DE(DW)="C7^PRCST42"
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N&(E'=DA) E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
C7S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
 Q
X7 S:X["$" X=$P(X,"$",2) Q:X?1"N/C"  K:+X'=X&(X'?.N1"."2N)!(X>9999999)!(X<0) X I $D(X) S:X=0 X="N/C"
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S X=$P($G(^PRCS(410,DA(1),3)),U,3) I X]"" S X=$$GETBOCNT^PRCSECP(PRC("SITE"),+PRC("CP"),+X) I (+X=1) S $P(^PRCS(410,DA(1),"IT",DA,0),U,4)=$P(X,U,2),Y="@44" W !,"BOC: ",$P(X,U,2)
 Q
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW="0;4",DV="RFX",DU="",DLB="BOC",DIFLD=4
 S DE(DW)="C9^PRCST42"
 S X="" S:$D(PRCS("SUB")) X=PRCS("SUB")
 S Y=X
 G Y
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 K ^PRCS(410,"AD",$E(X,1,30),DA(1))
C9S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^PRCS(410,"AD",$E(X,1,30),DA(1))=""
 Q
X9 K:X[""""!($A(X)=45) X I $D(X) D SUB^PRCSES
 I $D(X),X'?.ANP K X
 Q
 ;
10 S DQ=11 ;@44
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 D 2^PRCSCK
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I $D(PRCSERR),PRCSERR S Y=PRCSERR K PRCSERR
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 D QRB^PRCSCK
 Q
14 D:$D(DG)>9 F^DIE17,DE S DQ=14,D=0 K DE(1) ;12
 S DIFLD=12,DGO="^PRCST43",DC="2^410.212I^2^",DV="410.212MNJ2,0",DW="0;1",DOW="DELIVERY SCHEDULE",DLB="Select "_DOW S:D DC=DC_D
 G RE:D I $D(DSC(410.212))#2,$P(DSC(410.212),"I $D(^UTILITY(",1)="" X DSC(410.212) S D=$O(^(0)) S:D="" D=-1 G M14
 S D=$S($D(^PRCS(410,D0,"IT",DA,2,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M14 I D>0 S DC=DC_D I $D(^PRCS(410,D0,"IT",DA,2,+D,0)) S DE(14)=$P(^(0),U,1)
 G RE
R14 D DE
 S D=$S($D(^PRCS(410,D0,"IT",DA,2,0)):$P(^(0),U,3,4),1:1) G 14+1
 ;
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 K PRCSMDP
 Q
16 G 1^DIE17
