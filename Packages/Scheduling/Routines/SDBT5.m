SDBT5 ; ;11/27/23
 D DE G BEGIN
DE S DIE="^SC(",DIC=DIE,DP=44,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^SC(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,11) S:%]"" DE(5)=% S %=$P(%Z,U,26) S:%]"" DE(9)=% S %=$P(%Z,U,27) S:%]"" DE(10)=%
 I $D(^("SDPROT")) S %Z=^("SDPROT") S %=$P(%Z,U,1) S:%]"" DE(1)=%
 I $D(^("SL")) S %Z=^("SL") S %=$P(%Z,U,1) S:%]"" DE(11)=% S %=$P(%Z,U,2) S:%]"" DE(12)=% S %=$P(%Z,U,5) S:%]"" DE(6)=% S %=$P(%Z,U,6) S:%]"" DE(14)=% S %=$P(%Z,U,7) S:%]"" DE(7)=%
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
T G M^DIE17:DV,^DIE3:DV["V",X:X'?.ANP
 I DV["t" D  G UNIQ ;EXTENSIBLE DATA TYPES ;p21
 .X $S($D(DB(DQ)):$$VALEXTS^DIETLIBF(DP,DIFLD),1:$$VALEXT^DIETLIBF(DP,DIFLD)) K DIPA
 I DV["S" D SET^DIED G V:'DDER K DDER G X ;p22
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
 I DG["t" X $$OUTPUT^DIETLIBF(DP,DIFLD) K DIPA G RP ;p21
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
BEGIN S DNM="SDBT5",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="SDPROT;1",DV="S",DU="",DIFLD=2500,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:YES;"
 G RE
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:X'="Y" Y="@30"
 Q
3 S D=0 K DE(1) ;2501
 S DIFLD=2501,DGO="^SDBT6",DC="1^44.04PA^SDPRIV^",DV="44.04MP200'X",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="VA(200,"
 G RE:D I $D(DSC(44.04))#2,$P(DSC(44.04),"I $D(^UTILITY(",1)="" X DSC(44.04) S D=$O(^(0)) S:D="" D=-1 G M3
 S D=$S($D(^SC(DA,"SDPRIV",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M3 I D>0 S DC=DC_D I $D(^SC(DA,"SDPRIV",+D,0)) S DE(3)=$P(^(0),U,1)
 G RE
R3 D DE
 S D=$S($D(^SC(DA,"SDPRIV",0)):$P(^(0),U,3,4),1:1) G 3+1
 ;
4 S DQ=5 ;@30
5 S DW="0;11",DV="F",DU="",DIFLD=10,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X5 K:$L(X)>25!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
6 S DW="SL;5",DV="*P44'",DU="",DIFLD=1916,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="SC("
 G RE
X6 S DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
7 S DW="SL;7",DV="RNJ4,0",DU="",DIFLD=1918,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C7^SDBT5",DE(DW,"INDEX")=1
 G RE
C7 G C7S:$D(DE(7))[0 K DB
C7S S X="" G:DG(DQ)=X C7F1 K DB
C7F1 S DIEZRXR(44,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1547 S DIEZRXR(44,DIXR)=""
 Q
X7 K:+X'=X!(X>9999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,D=0 K DE(1) ;1910
 S DIFLD=1910,DGO="^SDBT7",DC="1^44.03A^SI^",DV="44.03F",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 I $D(DSC(44.03))#2,$P(DSC(44.03),"I $D(^UTILITY(",1)="" X DSC(44.03) S D=$O(^(0)) S:D="" D=-1 G M8
 S D=$S($D(^SC(DA,"SI",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M8 I D>0 S DC=DC_D I $D(^SC(DA,"SI",+D,0)) S DE(8)=$P(^(0),U,1)
 G RE
R8 D DE
 G A
 ;
9 S DW="0;26",DV="RS",DU="",DIFLD=20,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="1:YES;0:NO;"
 S Y="NO"
 G Y
X9 Q
10 S DW="0;27",DV="RS",DU="",DIFLD=21,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="1:YES;0:NO;"
 S Y="NO"
 G Y
X10 Q
11 S DW="SL;1",DV="RNJ2,0X",DU="",DIFLD=1912,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X11 K:+X'=X!(X>240)!(X<10)!(X?.E1"."1N.N)!($S('(X#10):0,'(X#15):0,1:1)) X I $D(X) S SDLA=X I $D(^SC(DA,"SL")),+$P(^("SL"),U,6) S SDZ0=$P(^("SL"),U,6),SDZ1=60\SDZ0 I X#SDZ1 D LAPPT^SDUTL
 Q
 ;
12 S DW="SL;2",DV="S",DU="",DIFLD=1913,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="V:YES, VARIABLE LENGTH;"
 G RE
X12 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S:+$O(^SC(DA,"ST",0))>0 Y="@99"
 Q
14 S DW="SL;6",DV="RSX",DU="",DIFLD=1917,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="1:60-MIN ;2:30-MIN ;4:15-MIN ;3:20-MIN ;6:10-MIN ;"
 S Y="4"
 G Y
X14 S ZSI=$S(X=1!(X=2)!(X=3)!(X=4)!(X=6):60/X,1:0),SDLA=$S('$D(^SC(DA,"SL")):0,1:+^("SL")) K:('SDLA)!('ZSI) SDLA,ZSI,X Q:'$D(X)  I SDLA#ZSI>0 X ^DD(44,1917,9.2) Q
 Q
 ;
15 S DQ=16 ;@99
16 G 0^DIE17
