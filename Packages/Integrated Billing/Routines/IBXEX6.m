IBXEX6 ; ;10/30/02
 D DE G BEGIN
DE S DIE="^IBA(354.1,",DIC=DIE,DP=354.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^IBA(354.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,6) S:%]"" DE(1)=% S %=$P(%Z,U,7) S:%]"" DE(2)=% S %=$P(%Z,U,8) S:%]"" DE(4)=% S %=$P(%Z,U,10) S:%]"" DE(5)=% S %=$P(%Z,U,11) S:%]"" DE(6)=% S %=$P(%Z,U,15) S:%]"" DE(8)=%
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
BEGIN S DNM="IBXEX6",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="0;6",DV="S",DU="",DLB="HOW ADDED",DIFLD=.06
 S DU="1:SYSTEM;2:MANUAL;"
 S X=IBHOW
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X1 Q
2 S DW="0;7",DV="P200'I",DU="",DLB="USER ADDING ENTRY",DIFLD=.07
 S DU="VA(200,"
 S X=$S(DUZ:DUZ,1:.5)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 G A
4 S DW="0;8",DV="RDI",DU="",DLB="DATE/TIME ADDED",DIFLD=.08
 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 S %DT="STXR" D ^%DT S X=Y K:Y<1 X
 Q
 ;
5 S DW="0;10",DV="R*S",DU="",DLB="ACTIVE",DIFLD=.1
 S DE(DW)="C5^IBXEX6"
 S DU="1:ACTIVE;0:INACTIVE;"
 S Y="1"
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 K ^IBA(354.1,"AA",$E(X,1,30),DA)
 S X=DE(5),DIC=DIE
 N IBX S IBX=^IBA(354.1,DA,0) K ^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-($P(IBX,U)),DA)
 S X=DE(5),DIC=DIE
 K ^IBA(354.1,"ACY",+$P(^IBA(354.1,DA,0),U,3),+$P(^(0),U,2),+$E($P(^(0),U),1,3),DA)
C5S S X="" Q:DG(DQ)=X  K DB
 S X=DG(DQ),DIC=DIE
 S ^IBA(354.1,"AA",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 N IBX S IBX=^IBA(354.1,DA,0) I +X,$P(IBX,U,2),$P(IBX,U,3),$P(IBX,U,4)'="" S ^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-($P(IBX,U)),DA)=""
 S X=DG(DQ),DIC=DIE
 I X,+$P(^IBA(354.1,DA,0),U,2),+$P(^(0),U,3),+^(0) S ^IBA(354.1,"ACY",+$P(^(0),U,3),+$P(^(0),U,2),+$E($P(^(0),U),1,3),DA)=""
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW="0;11",DV="FO",DU="",DLB="ELECTRONIC SIGNATURE",DIFLD=.11
 S DQ(6,2)="S Y(0)=Y S Y(0)=Y S Y=""<Hidden>"""
 S X=$G(IBASIG)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X6 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I '$D(IBPRIOR) S Y="@99"
 Q
8 S DW="0;15",DV="D",DU="",DLB="PRIOR YEAR THRESHOLDS",DIFLD=.15
 S DE(DW)="C8^IBXEX6"
 S X=IBPRIOR
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C8 G C8S:$D(DE(8))[0 K DB
 D ^IBXEX7
C8S S X="" Q:DG(DQ)=X  K DB
 D ^IBXEX8
 Q
X8 Q
9 S DQ=10 ;@99
10 G 0^DIE17
