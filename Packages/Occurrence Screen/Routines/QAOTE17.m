QAOTE17 ; ;10/05/93
 D DE G BEGIN
DE S DIE="^QA(741,D0,""REVR"",",DIC=DIE,DP=741.01,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^QA(741,D0,"REVR",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,3) S:%]"" DE(13)=% S %=$P(%Z,U,4) S:%]"" DE(1)=% S %=$P(%Z,U,5) S:%]"" DE(4)=% S %=$P(%Z,U,6) S:%]"" DE(10)=% S %=$P(%Z,U,7) S:%]"" DE(12)=%
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
BEGIN S DNM="QAOTE17",DQ=1
1 S DW="0;4",DV="*P741.4'O",DU="",DLB="PRIMARY REASON CLIN REFERRAL",DIFLD=3
 S DQ(1,2)="S Y(0)=Y S:+Y(0) Y=$P(^QA(741.4,+Y(0),0),""^"")_""  ""_$S($D(^(2))#2:$P(^(2),""^""),1:"""")"
 S DU="QA(741.4,"
 G RE
X1 S DIC("S")="D EN6^QAOSDDUT" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S Y="@6"
 Q
3 S DQ=4 ;@5
4 S DW="0;5",DV="*P741.6'O",DU="",DLB="FINDINGS",DIFLD=4
 S DQ(4,2)="S Y(0)=Y S:+Y(0) Y=$P(^QA(741.6,+Y(0),0),""^"")_""  ""_$P(^(0),""^"",2)"
 S DU="QA(741.6,"
 S X=3
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X4 S DIC("S")="D EN8^QAOSDDUT" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
5 S DQ=6 ;@6
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 W:QAOSNEWF !!?5,"SINCE FINDINGS HAVE BEEN CHANGED, YOU MUST REVIEW ACTIONS,",!?5,"DELETE ANY NO LONGER APPLICABLE, AND ENTER NEW ACTIONS THAT APPLY",!
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S QAOSACTN=0
 Q
8 S D=0 K DE(1) ;5
 S DIFLD=5,DGO="^QAOTE18",DC="1^741.15PA^2^",DV="741.15M*P741.7'O",DW="0;1",DOW="ACTION",DLB="Select "_DOW S:D DC=DC_D
 S DU="QA(741.7,"
 G RE:D I $D(DSC(741.15))#2,$P(DSC(741.15),"I $D(^UTILITY(",1)="" X DSC(741.15) S D=$O(^(0)) S:D="" D=-1 G M8
 S D=$S($D(^QA(741,D0,"REVR",DA,2,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M8 I D>0 S DC=DC_D I $D(^QA(741,D0,"REVR",DA,2,+D,0)) S DE(8)=$P(^(0),U,1)
 S X=$S(QAOSQUIT:1,1:"")
 S Y=X
 G Y
R8 D DE
 S D=$S($D(^QA(741,D0,"REVR",DA,2,0)):$P(^(0),U,3,4),1:1) G 8+1
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:(QAOSLEVL=1)!(QAOSLEVL=3)!(QAOSQUIT) Y="@8"
 Q
10 S DW="0;6",DV="P741.8'O",DU="",DLB="*SEVERITY OF OUTCOME",DIFLD=6
 S DQ(10,2)="S Y(0)=Y S:+Y(0) Y=$P(^QA(741.8,+Y(0),0),""^"")_""  ""_$P(^(0),""^"",2)"
 S DU="QA(741.8,"
 G RE
X10 Q
11 S DQ=12 ;@8
12 S DW="0;7",DV="FX",DU="",DLB="*COMMENTS",DIFLD=7
 G RE
X12 K X
 I $D(X),X'?.ANP K X
 Q
 ;
13 S DW="0;3",DV="RDX",DU="",DLB="DATE REVIEW COMPLETED",DIFLD=1
 S DE(DW)="C13^QAOTE17"
 G RE
C13 G C13S:$D(DE(13))[0 K DB S X=DE(13),DIC=DIE
 X "N QAQAXREF,QAQADICT,QAQAFLD S QAQAX=X,X=$P(^QA(741,DA(1),""REVR"",DA,0),""^"",8),QAQADICT=741.01,QAQAFLD=8 D ENKILL^QAQAXREF S $P(^QA(741,DA(1),""REVR"",DA,0),""^"",8)="""" S X=QAQAX K QAQAX"
 S X=DE(13),DIC=DIE
 X "S QA(""DA"")=DA,DA=DA(1),QAQAX=X F QA=12:1:13 N QAQAXREF,QAQADICT,QAQAFLD S X=$P(^QA(741,DA,0),""^"",QA),QAQADICT=741,QAQAFLD=QA D ENKILL^QAQAXREF S $P(^QA(741,DA,0),""^"",QA)="""" I QA=13 S DA=QA(""DA""),X=QAQAX K QAQAX"
C13S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "D ENLAPSE^QAOSLAPS"
 S X=DG(DQ),DIC=DIE
 X "D ENDUES^QAOSLAPS"
 Q
X13 S %DT="EXP" S:$D(QAOSD0)#2 %DT(0)=$P(^QA(741,QAOSD0,0),"^",3)\1 D ^%DT K %DT(0) S X=Y K:(Y<1)!(Y\1>DT) X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:QAOSLEVL'=2 Y="@999"
 Q
15 D:$D(DG)>9 F^DIE17 G ^QAOTE19
