IBXS54 ; ;03/19/19
 D DE G BEGIN
DE S DIE="^DGCR(399,D0,""CV"",",DIC=DIE,DP=399.047,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^DGCR(399,D0,"CV",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(2)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 K X S X("FIELD")=DIFLD,X("FILE")=DP W "  ("_$$EZBLD^DIALOG(710,.X)_")" K X S X="" Q  ;**
TR Q:DV["K"&(DUZ(0)'="@")  R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G A:DV["K"&(DUZ(0)'["@"),PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" I X?.ANP D SET^DIED I 'DDER G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
UNIQ I DV["U",$D(X),DIFLD=.01 K % M %=@(DIE_"""B"",X)") K %(DA) K:$O(%(0)) X
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") I %]"" S Y=$S($G(DUZ("LANG"))'>1:%,'DIFLD:%,1:$$SET^DIQ(DP,DIFLD,Y))
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="IBXS54",DQ=1+D G B
1 S DW="0;1",DV="M*P399.1'X",DU="",DIFLD=.01,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^IBXS54",DE(DW,"INDEX")=1
 S DU="DGCR(399.1,"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^DGCR(399,DA(1),"CV","B",$E(X,1,30),DA)
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGCR(399,DA(1),"CV","B",$E(X,1,30),DA)=""
C1F1 N X,X1,X2 S DIXR=783 D C1X1(U) K X2 M X2=X D C1X1("O") K X1 M X1=X
 K X M X=X2 D
 . N DIEXARR M DIEXARR=X S DIEZCOND=1
 . S X=$$COND^IBCVC(.DA,X1(1),X2(1))
 . S DIEZCOND=$G(X) K X M X=DIEXARR Q:'DIEZCOND
 . D REMOVE^IBCVC(.DA)
 G C1F2
C1X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",399.047,DIIENS,.01,DION),$P($G(^DGCR(399,DA(1),"CV",DA,0)),U,1))
 S X=$G(X(1))
 Q
C1F2 Q
X1 S DIC("S")="I +$P($G(^DGCR(399.1,+Y,0)),U,11),$$ALLOWVC^IBCVC(DA(1),+Y)",D="C^B" D MIX^DIC1 K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;2",DV="FX",DU="",DIFLD=.02,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X2 K:$L(X)>10!($L(X)<1)!'$$FORMCHK^IBCVC(X,.DA) X
 I $D(X),X'?.ANP K X
 Q
 ;
3 G 1^DIE17
