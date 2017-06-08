QAOTE1 ; GENERATED FROM 'QAOS REVIEW' INPUT TEMPLATE(#1026), FILE 741;10/05/93
 D DE G BEGIN
DE S DIE="^QA(741,",DIC=DIE,DP=741,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^QA(741,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,6) S:%]"" DE(2)=% S %=$P(%Z,U,7) S:%]"" DE(3)=% S %=$P(%Z,U,8) S:%]"" DE(4)=% S %=$P(%Z,U,9) S:%]"" DE(5)=% S %=$P(%Z,U,10) S:%]"" DE(6)=%
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
BEGIN S DNM="QAOTE1",DQ=1
 S:$D(DTIME)[0 DTIME=999 S D0=DA,DIEZ=1026,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S (QAOSOPEN,QAOSLEVL,QAOSLEVL("PEER"))=""
 Q
2 S DW="0;6",DV="P49'",DU="",DLB="SERVICE",DIFLD=5
 S DU="DIC(49,"
 G RE
X2 Q
3 S DW="0;7",DV="P45.7'",DU="",DLB="TREATING SPECIALTY/BEDSECTION",DIFLD=6
 S DU="DIC(45.7,"
 G RE
X3 Q
4 S DW="0;8",DV="P741.93'",DU="",DLB="MEDICAL TEAM",DIFLD=7
 S DU="QA(741.93,"
 G RE
X4 Q
5 S DW="0;9",DV="P200'",DU="",DLB="ATTENDING PHYSICIAN",DIFLD=8
 S DU="VA(200,"
 G RE
X5 Q
6 S DW="0;10",DV="P200'",DU="",DLB="RESIDENT/PROVIDER",DIFLD=9
 S DU="VA(200,"
 G RE
X6 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 D ^QAOSMSGS
 Q
8 S D=0 K DE(1) ;10
 S DIFLD=10,DGO="^QAOTE11",DC="13^741.01IPA^REVR^",DV="741.01M*P741.2'X",DW="0;1",DOW="REVIEW LEVEL",DLB="Select "_DOW S:D DC=DC_D
 S DU="QA(741.2,"
 G RE:D I $D(DSC(741.01))#2,$P(DSC(741.01),"I $D(^UTILITY(",1)="" X DSC(741.01) S D=$O(^(0)) S:D="" D=-1 G M8
 S D=$S($D(^QA(741,DA,"REVR",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M8 I D>0 S DC=DC_D I $D(^QA(741,DA,"REVR",+D,0)) S DE(8)=$P(^(0),U,1)
 G RE
R8 D DE
 S D=$S($D(^QA(741,DA,"REVR",0)):$P(^(0),U,3,4),1:1) G 8+1
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 K DIE("NO^")
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:QAOSLEVL("PEER")'=1 Y="@8888"
 Q
11 S DQ=12 ;@1111
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 W !!?5,"DO YOU WISH TO ENTER PEER ATTRIBUTIONS" S %=2,QA="@1111" D YN^DICN S Y=$S(%=1:Y,%=2:"@8888",%=0:"@0",1:"@9999")
 Q
13 S D=0 K DE(1) ;24
 S DIFLD=24,DGO="^QAOTE12",DC="2^741.024PA^ATRI^",DV="741.024MP200'",DW="0;1",DOW="PEER ATTRIBUTION (INDIVIDUAL)",DLB="Select "_DOW S:D DC=DC_D
 S DU="VA(200,"
 G RE:D I $D(DSC(741.024))#2,$P(DSC(741.024),"I $D(^UTILITY(",1)="" X DSC(741.024) S D=$O(^(0)) S:D="" D=-1 G M13
 S D=$S($D(^QA(741,DA,"ATRI",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M13 I D>0 S DC=DC_D I $D(^QA(741,DA,"ATRI",+D,0)) S DE(13)=$P(^(0),U,1)
 G RE
R13 D DE
 S D=$S($D(^QA(741,DA,"ATRI",0)):$P(^(0),U,3,4),1:1) G 13+1
 ;
14 S D=0 K DE(1) ;25
 S DIFLD=25,DGO="^QAOTE13",DC="2^741.025PA^ATRT^",DV="741.025MP741.93'",DW="0;1",DOW="PEER ATTRIBUTION (MED TEAM)",DLB="Select "_DOW S:D DC=DC_D
 S DU="QA(741.93,"
 G RE:D I $D(DSC(741.025))#2,$P(DSC(741.025),"I $D(^UTILITY(",1)="" X DSC(741.025) S D=$O(^(0)) S:D="" D=-1 G M14
 S D=$S($D(^QA(741,DA,"ATRT",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M14 I D>0 S DC=DC_D I $D(^QA(741,DA,"ATRT",+D,0)) S DE(14)=$P(^(0),U,1)
 G RE
R14 D DE
 S D=$S($D(^QA(741,DA,"ATRT",0)):$P(^(0),U,3,4),1:1) G 14+1
 ;
15 D:$D(DG)>9 F^DIE17 G ^QAOTE14
