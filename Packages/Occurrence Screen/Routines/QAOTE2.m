QAOTE2 ; GENERATED FROM 'QAOS FINAL DISPOSITION' INPUT TEMPLATE(#1029), FILE 741;10/05/93
 D DE G BEGIN
DE S DIE="^QA(741,",DIC=DIE,DP=741,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^QA(741,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,14) S:%]"" DE(1)=% S %=$P(%Z,U,16) S:%]"" DE(2)=%
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
BEGIN S DNM="QAOTE2",DQ=1
 S:$D(DTIME)[0 DTIME=999 S D0=DA,DIEZ=1029,U="^"
1 S DW="0;14",DV="DX",DU="",DLB="FINAL DISPOSITION DATE",DIFLD=14
 S DE(DW)="C1^QAOTE2"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 X "N QAQAXREF,QAQADICT,QAQAFLD S QAQAX=X,X=$P(^QA(741,DA,0),""^"",15),QAQADICT=741,QAQAFLD=15 D ENKILL^QAQAXREF S $P(^QA(741,DA,0),""^"",15)="""" S X=QAQAX K QAQAX Q"
 S X=DE(1),DIC=DIE
 X ^DD(741,14,1,2,2.3) I X S X=DIV S Y(1)=$S($D(^QA(741,D0,0)):^(0),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X=DIV S X="0" X ^DD(741,14,1,2,2.4)
 S X=DE(1),DIC=DIE
 ;
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 X "S (QAQAX,X1)=X,X2=$P(^QA(741,DA,0),""^"",3) I X1>0,X2>0 D ^%DTC N QAQAXREF,QAQADICT,QAQAFLD S $P(^QA(741,DA,0),""^"",15)=X,QAQADICT=741,QAQAFLD=15 D ENSET^QAQAXREF S X=QAQAX K QAQAX Q"
 S X=DG(DQ),DIC=DIE
 X ^DD(741,14,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^QA(741,D0,0)):^(0),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X=DIV S X="1" X ^DD(741,14,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 X "N QAUDIT S QAUDIT(""FILE"")=""741^27"",QAUDIT(""DA"")=DA,QAUDIT(""ACTION"")=""c"",QAUDIT(""COMMENT"")=""CLOSE A RECORD"" D:$D(QACLOSE) ^QAQAUDIT Q"
 Q
X1 S %DT="EXP",%DT(0)=$P(^QA(741,D0,0),"^",3)\1 D ^%DT K %DT(0) S X=Y K:(Y<1)!(Y\1>DT) X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;16",DV="*P741.2'",DU="",DLB="FINAL DISPOSITION REACHED BY",DIFLD=16
 S DU="QA(741.2,"
 G RE
X2 S DIC("S")="I $P(^(0),""^"",2)<5" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
3 G 0^DIE17
