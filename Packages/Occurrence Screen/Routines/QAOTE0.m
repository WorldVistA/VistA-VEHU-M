QAOTE0 ; GENERATED FROM 'QAOS VALIDATE/CONFIRM' INPUT TEMPLATE(#1031), FILE 741;10/05/93
 D DE G BEGIN
DE S DIE="^QA(741,",DIC=DIE,DP=741,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^QA(741,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,17) S:%]"" DE(4)=% S %=$P(%Z,U,18) S:%]"" DE(2)=% S %=$P(%Z,U,19) S:%]"" DE(10)=%,DE(13)=%
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
BEGIN S DNM="QAOTE0",DQ=1
 S:$D(DTIME)[0 DTIME=999 S D0=DA,DIEZ=1031,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S (QAOSESMF,QAOSQOCF)=0
 Q
2 S DW="0;18",DV="P741.8'O",DU="",DLB="SEVERITY OF OUTCOME",DIFLD=19
 S DQ(2,2)="S Y(0)=Y S:+Y(0) Y=$P(^QA(741.8,+Y(0),0),""^"")_""  ""_$P(^(0),""^"",2)"
 S DU="QA(741.8,"
 G RE
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 G A
4 S DW="0;17",DV="DX",DU="",DLB="*DATE VALIDATED/CONFIRMED",DIFLD=18
 S DE(DW)="C4^QAOTE0"
 S X="TODAY"
 S Y=X
 G Y
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 K ^QA(741,"AVAL",$E(X,1,30),DA)
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^QA(741,"AVAL",$E(X,1,30),DA)=""
 Q
X4 S %DT="EXP",%DT(0)=$P(^QA(741,D0,0),"^",3)\1 D ^%DT K %DT(0) S X=Y K:(Y<1)!(Y\1>DT) X
 Q
 ;
5 S DQ=6 ;@201
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 W !,"WAS THERE A SECOND LEVEL REVIEW FOR A QUALITY OF CARE ISSUE (Y/N)" S %=$S($P(^QA(741,DA,0),"^",19)]"":1,1:2) D YN^DICN S Y=$S(%=-1:"@999",%=2:"@203",%=1:"@20",1:"@202")
 Q
7 S DQ=8 ;@202
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 W !,"     Please enter Y(es) or N(o)",! S Y="@201"
 Q
9 S DQ=10 ;@203
10 D:$D(DG)>9 F^DIE17,DE S DQ=10,DW="0;19",DV="*P741.6'O",DU="",DLB="*QUALITY OF CARE SCALE",DIFLD=20
 S DQ(10,2)="S Y(0)=Y S:+Y(0) Y=$P(^QA(741.6,+Y(0),0),""^"")_""  ""_$P(^(0),""^"",2)"
 S DU="QA(741.6,"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X10 S DIC("S")="I $P(^QA(741.6,+Y,0),""^"",3)[""V""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S Y="@211"
 Q
12 S DQ=13 ;@20
13 S DW="0;19",DV="*P741.6'O",DU="",DLB="VALIDATED QUALITY OF CARE SCALE",DIFLD=20
 S DQ(13,2)="S Y(0)=Y S:+Y(0) Y=$P(^QA(741.6,+Y(0),0),""^"")_""  ""_$P(^(0),""^"",2)"
 S DU="QA(741.6,"
 G RE
X13 S DIC("S")="I $P(^QA(741.6,+Y,0),""^"",3)[""V""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:X'="" QAOSQOCF=1
 Q
15 S DQ=16 ;@211
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 W !,"WAS THERE A SECOND LEVEL REVIEW FOR AN EQUIPMENT OR SYSTEM/MANAGEMENT ISSUE" S %=$S($P(^QA(741,DA,0),"^",20)]"":1,1:2) D YN^DICN S Y=$S(%=-1:"@999",%=2:"@213",%=1:"@21",1:"@212")
 Q
17 S DQ=18 ;@212
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 W "     Please enter Y(es) or N(o)",! S Y="@211"
 Q
19 S DQ=20 ;@213
20 D:$D(DG)>9 F^DIE17 G ^QAOTE01
