DGX510 ; ;06/24/22
 D DE G BEGIN
DE S DIE="^DGPT(D0,""M"",",DIC=DIE,DP=45.02,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^DGPT(D0,"M",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,26) S:%]"" DE(51)=%,DE(54)=% S %=$P(%Z,U,27) S:%]"" DE(57)=%,DE(60)=% S %=$P(%Z,U,28) S:%]"" DE(63)=%,DE(66)=% S %=$P(%Z,U,29) S:%]"" DE(75)=% S %=$P(%Z,U,31) S:%]"" DE(45)=%,DE(48)=%
 I  S %=$P(%Z,U,32) S:%]"" DE(69)=%,DE(72)=%
 I $D(^(81)) S %Z=^(81) S %=$P(%Z,U,15) S:%]"" DE(1)=%
 I $D(^(82)) S %Z=^(82) S %=$P(%Z,U,25) S:%]"" DE(4)=%
 I $D(^(300)) S %Z=^(300) S %=$P(%Z,U,2) S:%]"" DE(13)=% S %=$P(%Z,U,3) S:%]"" DE(17)=% S %=$P(%Z,U,4) S:%]"" DE(22)=%,DE(26)=% S %=$P(%Z,U,5) S:%]"" DE(30)=% S %=$P(%Z,U,6) S:%]"" DE(34)=% S %=$P(%Z,U,7) S:%]"" DE(38)=%
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
BEGIN S DNM="DGX510",DQ=1
1 S DW="81;15",DV="*P80'X",DU="",DIFLD=81.15,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C1^DGX510",DE(DW,"INDEX")=1
 S DU="ICD9("
 G RE
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,25),X=X S DIU=X K Y S X="" X ^DD(45.02,81.15,1,2,2.4)
 S X=DE(1),DIC=DIE
 X "N X S X=""DGRUDD01"" X ^%ZOSF(""TEST"") Q:'$T  N DG1 S DG1=+$P(^DGPT(DA(1),0),""^"",1) D:(DG1>0) ADGRU^DGRUDD01(DG1)"
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,25),X=X S DIU=X K Y S X="" X ^DD(45.02,81.15,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 X "N X S X=""DGRUDD01"" X ^%ZOSF(""TEST"") Q:'$T  N DG1 S DG1=+$P(^DGPT(DA(1),0),""^"",1) D:(DG1>0) ADGRU^DGRUDD01(DG1)"
C1F1 S DIEZRXR(45.02,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1237,1701 S DIEZRXR(45.02,DIXR)=""
 Q
X1 N K D GETAPI^DGICDGT("DG PTF","DIAG",$G(DA(1)),"EN",81)
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S DGXX=X
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I DGXX="" S Y="@271"
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="82;25",DV="SX",DU="",DIFLD=82.25,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:Present on Admission;N:Not Present on Admission;U:Insufficient Docum to Present on Admission;W:Can't Determine if Present on Admission;1:Exempt;"
 G RE
X4 I X]"",$G(DA),$G(DA(1)) K:'$$POA501^DGPTFUT1(X,DA(1),DA,81,15) X
 Q
 ;
5 S DQ=6 ;@271
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S X=DGXX
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I X K DGPTIT S DGNFLD="@280",Y="@8000",DGPTIT(X_$C(59)_"ICD9(")=""
 Q
8 S DQ=9 ;@280
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 K DGNFLD,DGDUP,DGADD S Y=""
 Q
10 S DQ=11 ;@8000
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 D SCAN^DGPTSCAN S:'$D(DGBPC) Y="@8990"
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I '$D(DGBPC(2))!(DGDUP(2)) S Y="@8100"
 Q
13 S DW="300;2",DV="SX",DU="",DIFLD=300.02,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="1:Attempted Suicide;2:Accomplished Suicide;3:Self Inflicted Injury;"
 G RE
X13 S DGFLAG=2 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG Q
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:X]"" DGDUP(2)=1
 Q
15 S DQ=16 ;@8100
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I '$D(DGBPC(3))!(DGDUP(3)) S Y="@8200"
 Q
17 S DW="300;3",DV="SX",DU="",DIFLD=300.03,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="1:Yes;2:No;"
 G RE
X17 S DGFLAG=3 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG Q
 Q
 ;
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:X]"" DGDUP(3)=1
 Q
19 S DQ=20 ;@8200
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 I '$D(DGBPC(4))!(DGDUP(4)) S Y="@8300"
 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 D DRUG^DGPTSC01 I $D(DGTX) S Y="@8250"
 Q
22 S DW="300;4",DV="P45.61'X",DU="",DIFLD=300.04,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(45.61,"
 G RE
X22 S DGFLAG=4 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG
 Q
 ;
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 S:X]"" DGDUP(4)=1
 Q
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 S Y="@8300"
 Q
25 S DQ=26 ;@8250
26 S DW="300;4",DV="P45.61'X",DU="",DIFLD=300.04,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(45.61,"
 S X=DGTX
 S Y=X
 G Y
X26 S DGFLAG=4 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG
 Q
 ;
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 S:X]"" DGDUP(4)=1
 Q
28 S DQ=29 ;@8300
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 I '$D(DGBPC(5))!(DGDUP(5)) S Y="@8400"
 Q
30 S DW="300;5",DV="SX",DU="",DIFLD=300.05,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="0:INADEQUATE INFO OR NO CHANGE;1:NONE;2:MILD;3:MODERATE;4:SEVERE;5:EXTREME;6:CATASTROPHIC;"
 G RE
X30 S DGFLAG=5 D 501^DGPTSC01 K:DGER X K DGER,DGFLAG
 Q
 ;
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 S:X]"" DGDUP(5)=1
 Q
32 S DQ=33 ;@8400
33 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=33 D X33 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X33 I '$D(DGBPC(6))!(DGDUP(6)) S Y="@8500"
 Q
34 S DW="300;6",DV="NJ2,0X",DU="",DIFLD=300.06,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X34 S DGFLAG=6 D 501^DGPTSC01 S:DGER X="" K DGFLAG,DGER K:+X'=X!(X>90)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 S:X]"" DGDUP(6)=1
 Q
36 S DQ=37 ;@8500
37 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=37 D X37 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X37 I '$D(DGBPC(7))!(DGDUP(7)) S Y="@8990"
 Q
38 S DW="300;7",DV="NJ2,0X",DU="",DIFLD=300.07,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X38 S DGFLAG=7 D 501^DGPTSC01 S:DGER X="" K DGER,DGFLAG K:+X'=X!(X>90)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
39 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=39 D X39 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X39 S:X]"" DGDUP(7)=1
 Q
40 S DQ=41 ;@8990
41 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=41 D X41 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X41 K DGPTIT,DGTX S Y=DGNFLD
 Q
42 S DQ=43 ;@9000
43 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=43 D X43 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X43 K DGEXQ D CHQUES^DGPTSPQ I '$D(DGEXQ) S Y="@9999"
 Q
44 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=44 D X44 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X44 I '$D(DGEXQ(6)) S Y="@9040"
 Q
45 S DW="0;31",DV="S",DU="",DIFLD=31,DLB="WAS TREATMENT RELATED TO COMBAT?"
 S DU="Y:YES;N:NO;"
 S Y="YES"
 G Y
X45 Q
46 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=46 D X46 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X46 S Y="@9050"
 Q
47 S DQ=48 ;@9040
48 S DW="0;31",DV="S",DU="",DIFLD=31,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:YES;N:NO;"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X48 Q
49 S DQ=50 ;@9050
50 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=50 D X50 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X50 I '$D(DGEXQ(1)) S Y="@9100"
 Q
51 S DW="0;26",DV="SX",DU="",DIFLD=26,DLB="WAS TREATMENT RELATED TO AGENT ORANGE EXPOSURE?"
 S DU="Y:YES;N:NO;"
 G RE
X51 S DGFLAG=1 D 501^DGPTSPQ K:DGER X K DGER,DGFLAG
 Q
 ;
52 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=52 D X52 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X52 S Y="@9150"
 Q
53 S DQ=54 ;@9100
54 S DW="0;26",DV="SX",DU="",DIFLD=26,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:YES;N:NO;"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X54 S DGFLAG=1 D 501^DGPTSPQ K:DGER X K DGER,DGFLAG
 Q
 ;
55 S DQ=56 ;@9150
56 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=56 D X56 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X56 I '$D(DGEXQ(2)) S Y="@9200"
 Q
57 S DW="0;27",DV="SX",DU="",DIFLD=27,DLB="WAS TREATMENT RELATED TO IONIZING RADIATION EXPOSURE?"
 S DU="Y:YES;N:NO;"
 G RE
X57 S DGFLAG=2 D 501^DGPTSPQ K:DGER X K DGER,DGFLAG
 Q
 ;
58 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=58 D X58 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X58 S Y="@9250"
 Q
59 S DQ=60 ;@9200
60 S DW="0;27",DV="SX",DU="",DIFLD=27,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:YES;N:NO;"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X60 S DGFLAG=2 D 501^DGPTSPQ K:DGER X K DGER,DGFLAG
 Q
 ;
61 S DQ=62 ;@9250
62 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=62 D X62 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X62 I '$D(DGEXQ(3)) S Y="@9300"
 Q
63 S DW="0;28",DV="SX",DU="",DIFLD=28,DLB="WAS TREATMENT RELATED TO SERVICE IN SW ASIA?"
 S DU="Y:YES;N:NO;"
 G RE
X63 S DGFLAG=3 D 501^DGPTSPQ K:DGER X K DGER,DGFLAG
 Q
 ;
64 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=64 D X64 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X64 S Y="@9350"
 Q
65 S DQ=66 ;@9300
66 S DW="0;28",DV="SX",DU="",DIFLD=28,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:YES;N:NO;"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X66 S DGFLAG=3 D 501^DGPTSPQ K:DGER X K DGER,DGFLAG
 Q
 ;
67 S DQ=68 ;@9350
68 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=68 D X68 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X68 I '$D(DGEXQ(7)) S Y="@9400"
 Q
69 S DW="0;32",DV="S",DU="",DIFLD=32,DLB="WAS TREATMENT RELATED TO PROJ 112/SHAD?"
 S DU="Y:YES;N:NO;"
 G RE
X69 Q
70 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=70 D X70 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X70 S Y="@9450"
 Q
71 S DQ=72 ;@9400
72 S DW="0;32",DV="S",DU="",DIFLD=32,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="Y:YES;N:NO;"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X72 Q
73 S DQ=74 ;@9450
74 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=74 D X74 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X74 I '$D(DGEXQ(4)) S Y="@9500"
 Q
75 S DW="0;29",DV="S",DU="",DIFLD=29,DLB="WAS TREATMENT RELATED TO MILITARY SEXUAL TRAUMA?"
 S DU="Y:YES;N:NO;"
 G RE
X75 Q
76 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=76 D X76 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X76 S Y="@9550"
 Q
77 S DQ=78 ;@9500
78 D:$D(DG)>9 F^DIE17 G ^DGX511
