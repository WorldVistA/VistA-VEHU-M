DGSATX ; GENERATED FROM 'DGSCHADMIT' INPUT TEMPLATE(#96), FILE 41.1;06/22/22
 D DE G BEGIN
DE S DIE="^DGS(41.1,",DIC=DIE,DP=41.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGS(41.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(4)=% S %=$P(%Z,U,3) S:%]"" DE(16)=% S %=$P(%Z,U,4) S:%]"" DE(17)=% S %=$P(%Z,U,5) S:%]"" DE(18)=% S %=$P(%Z,U,6) S:%]"" DE(19)=% S %=$P(%Z,U,7) S:%]"" DE(20)=% S %=$P(%Z,U,8) S:%]"" DE(7)=%
 I  S %=$P(%Z,U,9) S:%]"" DE(14)=% S %=$P(%Z,U,10) S:%]"" DE(5)=% S %=$P(%Z,U,11) S:%]"" DE(3)=% S %=$P(%Z,U,12) S:%]"" DE(15)=%
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
BEGIN S DNM="DGSATX",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(96,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=96,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(DGDIV)!('$D(DUZ)#2) W !!,*7,"NECESSARY VARIABLES NOT DEFINED!!" S Y=0
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S DGSDIV=$P(DGDIV,"^",2)
 Q
3 S DW="0;11",DV="P200'",DU="",DIFLD=11,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C3^DGSATX",DE(DW,"INDEX")=1
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C3 G C3S:$D(DE(3))[0 K DB
C3S S X="" G:DG(DQ)=X C3F1 K DB
C3F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X3 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;2",DV="RDX",DU="",DIFLD=2,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C4^DGSATX",DE(DW,"INDEX")=1
 G RE
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 K ^DGS(41.1,"C",$E(X,1,30),DA)
C4S S X="" G:DG(DQ)=X C4F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGS(41.1,"C",$E(X,1,30),DA)=""
C4F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X4 S %DT="ERTX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;10",DV="RS",DU="",DIFLD=10,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C5^DGSATX",DE(DW,"INDEX")=1
 S DU="W:WARD;T:TREATING SPECIALTY;"
 G RE
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 ;
 S X=DE(5),DIC=DIE
 ;
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(41.1,10,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGS(41.1,D0,0)):^(0),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(41.1,10,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(41.1,10,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DGS(41.1,D0,0)):^(0),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X="" X ^DD(41.1,10,1,2,1.4)
C5F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:X="T" Y=9
 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="0;8",DV="R*P42'",DU="",DIFLD=8,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C7^DGSATX",DE(DW,"INDEX")=1
 S DU="DIC(42,"
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 K ^DGS(41.1,"ARSV",$E(X,1,30),DA)
 S X=DE(7),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGS(41.1,D0,0)):^(0),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(41.1,8,1,2,2.4)
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGS(41.1,"ARSV",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGS(41.1,D0,0)):^(0),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y X ^DD(41.1,8,1,2,1.1) X ^DD(41.1,8,1,2,1.4)
C7F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X7 S DIC("S")="I $S($D(^(""I"")):^(""I"")="""",1:1)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S DGJJ=$$WACT^DGSCHAD(X,$P(^DGS(41.1,DA,0),U,2))
 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I DGJJ=0 W !!,*7,"Ward OUT-OF-SERVICE on selected date... Try again!",! S Y=2,$P(^DGS(41.1,DA,0),U,8)=""
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I DGJJ=-1 W !!,*7,"???... Try again.",! S Y=2,$P(^DGS(41.1,DA,0),U,8)=""
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I DGJJ=1 W !,"Ward will be in-service on selected date.",!
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I X,'DGDIV S DGSDIV=$S($D(^DIC(42,+X,0)):+$P(^(0),"^",11),1:"") I DGSDIV S DGSDIV=$S($D(^DG(40.8,+DGSDIV,0)):$P(^(0),"^",1),1:"")
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S Y=12
 Q
14 D:$D(DG)>9 F^DIE17,DE S DQ=14,DW="0;9",DV="R*P45.7'",DU="",DIFLD=9,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C14^DGSATX",DE(DW,"INDEX")=1
 S DU="DIC(45.7,"
 G RE
C14 G C14S:$D(DE(14))[0 K DB
C14S S X="" G:DG(DQ)=X C14F1 K DB
C14F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X14 S DIC("S")="I $$ACTIVE^DGACT(45.7,Y,$P($G(^DGS(41.1,DA,0)),U,2))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW="0;12",DV="*P40.8'",DU="",DIFLD=12,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C15^DGSATX",DE(DW,"INDEX")=1
 S DU="DG(40.8,"
 S X=DGSDIV
 S Y=X
 G Y
C15 G C15S:$D(DE(15))[0 K DB
C15S S X="" G:DG(DQ)=X C15F1 K DB
C15F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X15 S DIC("S")="I '$P(^(0),U,3)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S DQ=16,DW="0;3",DV="NJ3,0",DU="",DIFLD=3,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C16^DGSATX",DE(DW,"INDEX")=1
 G RE
C16 G C16S:$D(DE(16))[0 K DB
C16S S X="" G:DG(DQ)=X C16F1 K DB
C16F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X16 K:+X'=X!(X>999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
17 D:$D(DG)>9 F^DIE17,DE S DQ=17,DW="0;4",DV="RF",DU="",DIFLD=4,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C17^DGSATX",DE(DW,"INDEX")=1
 G RE
C17 G C17S:$D(DE(17))[0 K DB
C17S S X="" G:DG(DQ)=X C17F1 K DB
C17F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X17 K:$L(X)>30!($L(X)<2) X
 I $D(X),X'?.ANP K X
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S DQ=18,DW="0;5",DV="R*P200'",DU="",DIFLD=5,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C18^DGSATX",DE(DW,"INDEX")=1
 S DU="VA(200,"
 G RE
C18 G C18S:$D(DE(18))[0 K DB
C18S S X="" G:DG(DQ)=X C18F1 K DB
C18F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X18 S DIC("S")="I $$SCREEN^DGPMDD(Y,DA,DT)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
19 D:$D(DG)>9 F^DIE17,DE S DQ=19,DW="0;6",DV="S",DU="",DIFLD=6,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C19^DGSATX",DE(DW,"INDEX")=1
 S DU="Y:YES;N:NO;"
 G RE
C19 G C19S:$D(DE(19))[0 K DB
C19S S X="" G:DG(DQ)=X C19F1 K DB
C19F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X19 Q
20 D:$D(DG)>9 F^DIE17,DE S DQ=20,DW="0;7",DV="S",DU="",DIFLD=7,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C20^DGSATX",DE(DW,"INDEX")=1
 S DU="1:YES;0:NO;"
 G RE
C20 G C20S:$D(DE(20))[0 K DB
C20S S X="" G:DG(DQ)=X C20F1 K DB
C20F1 S DIEZRXR(41.1,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1703 S DIEZRXR(41.1,DIXR)=""
 Q
X20 Q
21 G 0^DIE17
