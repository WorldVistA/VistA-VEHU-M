DVBHCE19 ; ;08/14/22
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.3)) S %Z=^(.3) S %=$P(%Z,U,2) S:%]"" DE(38)=% S %=$P(%Z,U,5) S:%]"" DE(13)=% S %=$P(%Z,U,14) S:%]"" DE(39)=%
 I $D(^(.31)) S %Z=^(.31) S %=$P(%Z,U,4) S:%]"" DE(8)=%
 I $D(^(.32)) S %Z=^(.32) S %=$P(%Z,U,2) S:%]"" DE(20)=%
 I $D(^(.321)) S %Z=^(.321) S %=$P(%Z,U,1) S:%]"" DE(26)=%
 I $D(^(.52)) S %Z=^(.52) S %=$P(%Z,U,5) S:%]"" DE(1)=%
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
BEGIN S DNM="DVBHCE19",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW=".52;5",DV="RSX",DU="",DIFLD=.525,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^DVBHCE19",DE(DW,"INDEX")=1
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=DVBPOW1
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 ;
 S X=DE(1),DIC=DIE
 ;
 S X=DE(1),DIC=DIE
 ;
 S X=DE(1),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(1),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DE(1),DIC=DIE
 D EVENT^IVMPLOG(DA)
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.525,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.52)):^(.52),1:"") S X=$S('$D(^DIC(22,+$P(Y(1),U,6),0)):"",1:$P(^(0),U,1)) S DIU=X K Y S X=DIV S X="" X ^DD(2,.525,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.525,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.52)):^(.52),1:"") S X=$P(Y(1),U,7) S DIU=X K Y S X=DIV S X="" X ^DD(2,.525,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.525,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.52)):^(.52),1:"") S X=$P(Y(1),U,8) S DIU=X K Y S X=DIV S X="" X ^DD(2,.525,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C1F1 N X,X1,X2 S DIXR=556 D C1X1(U) K X2 M X2=X D C1X1("O") K X1 M X1=X
 D
 . D FC^DGFCPROT(.DA,2,.525,"KILL",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 K X M X=X2 D
 . D FC^DGFCPROT(.DA,2,.525,"SET",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 G C1F2
C1X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,.525,DION),$P($G(^DPT(DA,.52)),U,5))
 S X=$G(X(1))
 Q
C1F2 Q
X1 S DFN=DA D POWV^DGLOCK I $D(X) D SV^DGLOCK
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 K DVBPOW1 W "." S JP=JP+1,DVBJ2=1
 Q
3 S DQ=4 ;@26
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I $P(Z2,U,JP)'=7 S Y="@27"
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 I '$D(DVBFL) S Y="@27",JP=JP+1
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I DVBFL']"" S Y="@27",JP=JP+1
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I DVBFL'?3N1" - "1U.E S Y="@27",JP=JP+1
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW=".31;4",DV="*P4'X",DU="",DIFLD=.314,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C8^DVBHCE19"
 S DU="DIC(4,"
 S X=+DVBFL
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C8 G C8S:$D(DE(8))[0 K DB
 S X=DE(8),DIC=DIE
 D KILL^DGREGDD(DA)
C8S S X="" G:DG(DQ)=X C8F1 K DB
 S X=DG(DQ),DIC=DIE
 D SET^DGREGDD(DA,X)
C8F1 Q
X8 S DIC("S")="I $$CFLTF^DGREGDD(Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 W "." S JP=JP+1,DVBJ2=1
 Q
10 S DQ=11 ;@27
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I $P(Z2,U,JP)'=8 S Y="@50"
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I '$D(DVBEI) S Y="@50",JP=JP+1
 Q
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW=".3;5",DV="S",DU="",DIFLD=.305,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C13^DVBHCE19"
 S DU="Y:YES;N:NO;"
 S X=$S(DVBEI="Y":"Y",1:"N")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C13 G C13S:$D(DE(13))[0 K DB
 S X=DE(13),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(13),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
C13S S X="" G:DG(DQ)=X C13F1 K DB
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
C13F1 Q
X13 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 W "." S JP=JP+1,DVBJ2=1
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 S Y="@50"
 Q
16 S DQ=17 ;@40
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 I $P(Z2,U,JP)'=1 S Y="@42"
 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I '$D(DVBP(6)) S Y="@42",JP=JP+1
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 I $S($P(DVBP(6),U,8)'="Y":1,'$D(^DPT(DFN,.32)):1,+$P(^(0),U,2):1,1:0) S Y="@42",JP=JP+1
 Q
20 D:$D(DG)>9 F^DIE17,DE S DQ=20,DW=".32;2",DV="DX",DU="",DIFLD=.322,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S X="T"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X20 S %DT="",%DT(0)=-DT D ^%DT K %DT S X=Y K:Y<1 X I $D(X) D EK^DGLOCK
 Q
 ;
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 W "." S JP=JP+1,DVBJ2=1
 Q
22 S DQ=23 ;@42
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 I $P(Z2,U,JP)'=2 S Y="@45"
 Q
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 I '$D(DVBP(6)) S Y="@45",JP=JP+1
 Q
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 I $P(DVBP(6),U,4)[" " S Y="@45",JP=JP+1
 Q
26 S DW=".321;1",DV="RSX",DU="",DIFLD=.32101,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C26^DVBHCE19"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=$P(DVBP(6),U,4)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C26 G C26S:$D(DE(26))[0 K DB
 S X=DE(26),DIC=DIE
 ;
 S X=DE(26),DIC=DIE
 ;
 S X=DE(26),DIC=DIE
 D EVENT^IVMPLOG(DA)
C26S S X="" G:DG(DQ)=X C26F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.32101,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,4) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32101,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.32101,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,5) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32101,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C26F1 Q
X26 S DFN=DA D SV^DGLOCK
 Q
 ;
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 W "." S JP=JP+1,DVBJ2=1
 Q
28 S DQ=29 ;@45
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 I $P(Z2,U,JP)'=3!('$D(DVBDX(1))) S Y="@50"
 Q
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 S:'$D(DVBFL) DVBFL="UNKNOWN"
 Q
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 I $D(DVBCAP),DVBCAP["No C&P",$P(DVBBIR,U,5)'="Y" D CHK^DVBHUTIL
 Q
32 S DQ=33 ;@47
33 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=33 D X33 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X33 S DVB4=$S($D(^DPT(DFN,.3))>0:$P(^(.3),U),1:0),DVB5=$S($D(^DPT(DFN,.36))>0:$P(^(.36),U),1:0),DVB6=$S($D(^DPT(DFN,"VET"))>0:^("VET"),1:0),DVB7=$S($D(^DPT(DFN,"TYPE"))>0:^("TYPE"),1:0)
 Q
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 S DVB8=$O(^DIC(8,"B","SERVICE CONNECTED 50% to 100%",0)),DVB9=$O(^DIC(8,"B","SC LESS THAN 50%",0))
 Q
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 I DVBDXNO I ((DVB8'=DVB5&(DVB9'=DVB5))!(DVB4'="Y")!(DVB6'="Y")!(DVB7'=1)) S Y="@70"
 Q
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 W ! K ^DPT(DFN,.372),JP4,JP6 S ^DPT(DFN,.372,0)="^2.04P^^0",JP=0
 Q
37 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=37 D X37 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X37 S $P(^DPT(DFN,.3),U,2)="",$P(^DPT(DFN,.3),U,14)=""
 Q
38 D:$D(DG)>9 F^DIE17,DE S DQ=38,DW=".3;2",DV="NJ3,0Xa",DU="",DIFLD=.302,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C38^DVBHCE19"
 S X=+$G(DVBDXPCT)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C38 G C38S:$D(DE(38))[0 K DB
 S X=DE(38),DIC=DIE
 ;
 S X=DE(38),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(38),DIC=DIE
 ;
 S X=DE(38),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".302;" D AVAFC^VAFCDD01(DA)
 S X=DE(38),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 S X=DE(38),DIIX=2_U_DIFLD D AUDIT^DIET
C38S S X="" G:DG(DQ)=X C38F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".302;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 I $D(DE(38))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C38F1 Q
X38 S DFN=DA D EV^DGLOCK Q:'$D(X)  K:+X'=X!(X>100)!(X<0)!(X?.E1"."1N.N) X I $D(X),$D(^DPT(DA,.3)),$P(^(.3),U,1)'="Y" W !?4,*7,"Only applies to service-connected applicants." K X
 Q
 ;
39 D:$D(DG)>9 F^DIE17,DE S DQ=39,DW=".3;14",DV="DX",DU="",DIFLD=.3014,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S X=$G(DVBEFF)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X39 S %DT="P" D ^%DT S X=Y K:Y<1!(Y>DT) X
 Q
 ;
40 S DQ=41 ;@46
41 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=41 D X41 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X41 S JP=$O(DVBDX(JP)) I 'JP S Y="@50"
 Q
42 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=42 D X42 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X42 S JPP=+$P(DVBDX(JP),U,2) I JPP'>0 S Y="@46"
 Q
43 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=43 D X43 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X43 I '$D(^DIC(31,JPP)) D CHKDIS^DVBHS3 S Y="@46"
 Q
44 S D=0 K DE(1) ;.3721
 S DIFLD=.3721,DGO="^DVBHCE20",DC="6^2.04P^.372^",DV="2.04MP31'X",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="DIC(31,"
 G RE:D I $D(DSC(2.04))#2,$P(DSC(2.04),"I $D(^UTILITY(",1)="" X DSC(2.04) S D=$O(^(0)) S:D="" D=-1 G M44
 S D=$S($D(^DPT(DA,.372,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M44 I D>0 S DC=DC_D I $D(^DPT(DA,.372,+D,0)) S DE(44)=$P(^(0),U,1)
 S X="""`"_$P(DVBDX(JP),U,2)_""""
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R44 D DE
 G A
 ;
45 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=45 D X45 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X45 W "." S DVBJ2=1
 Q
46 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=46 D X46 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X46 S Y="@46"
 Q
47 S DQ=48 ;@61
48 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=48 D X48 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X48 S Y="@4"
 Q
49 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=49 D X49 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X49 I Z2'[1 S Y="@62"
 Q
50 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=50 D X50 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X50 I '$D(DVBSSA) S Y="@62",JP=JP+1
 Q
51 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=51 D X51 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X51 I DVBSSA S DVBYN="Y",DVBXYN=DVBSSA
 Q
52 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=52 D X52 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X52 I 'DVBSSA S DVBYN="N",DVBXYN=""
 Q
53 D:$D(DG)>9 F^DIE17 G ^DVBHCE21
