PRCATE ; GENERATED FROM 'PRCA SET' INPUT TEMPLATE(#701), FILE 430;03/11/23
 D DE G BEGIN
DE S DIE="^PRCA(430,",DIC=DIE,DP=430,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^PRCA(430,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(27)=% S %=$P(%Z,U,7) S:%]"" DE(9)=% S %=$P(%Z,U,8) S:%]"" DE(2)=% S %=$P(%Z,U,9) S:%]"" DE(11)=% S %=$P(%Z,U,10) S:%]"" DE(29)=% S %=$P(%Z,U,16) S:%]"" DE(4)=% S %=$P(%Z,U,19) S:%]"" DE(23)=%
 I  S %=$P(%Z,U,20) S:%]"" DE(25)=% S %=$P(%Z,U,21) S:%]"" DE(6)=%
 I $D(^(100)) S %Z=^(100) S %=$P(%Z,U,2) S:%]"" DE(32)=%
 I $D(^(104)) S %Z=^(104) S %=$P(%Z,U,1) S:%]"" DE(33)=%
 I $D(^(202)) S %Z=^(202) S %=$P(%Z,U,1) S:%]"" DE(13)=% S %=$P(%Z,U,2) S:%]"" DE(15)=% S %=$P(%Z,U,4) S:%]"" DE(16)=% S %=$P(%Z,U,5) S:%]"" DE(17)=% S %=$P(%Z,U,6) S:%]"" DE(18)=% S %=$P(%Z,U,9) S:%]"" DE(19)=% S %=$P(%Z,U,10) S:%]"" DE(21)=%
 I  S %=$P(%Z,U,11) S:%]"" DE(22)=%
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
BEGIN S DNM="PRCATE",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(701,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=701,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I ('$D(PRCAT))!('$D(PRCABN)) S Y=""
 Q
2 S DW="0;8",DV="R*P430.3'X",DU="",DIFLD=8,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C2^PRCATE",DE(DW,"INDEX")=1
 S DU="PRCA(430.3,"
 S Y="INCOMPLETE"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K ^PRCA(430,"AC",$E(X,1,30),DA)
 S X=DE(2),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",9) K ^PRCA(430,"AS",$P(^PRCA(430,DA,0),"^",9),X,DA)
 S X=DE(2),DIC=DIE
 ;
 S X=DE(2),DIC=DIE
 ;
 S X=DE(2),DIC=DIE
 I $P(^PRCA(430,DA,0),U,14) K ^PRCA(430,"ASDT",X,$P($P(^PRCA(430,DA,0),U,14),"."),DA)
 S X=DE(2),DIC=DIE
 I +$P($G(^PRCA(430,+DA,0)),"^",10) K ^PRCA(430,"AJK1",$P(^PRCA(430,+DA,0),"^",10),DA)
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^PRCA(430,"AC",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",9) S ^PRCA(430,"AS",$P(^PRCA(430,DA,0),"^",9),X,DA)=""
 S X=DG(DQ),DIC=DIE
 X ^DD(430,8,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^PRCA(430,D0,6)):^(6),1:"") S X=$P(Y(1),U,21),X=X S DIU=X K Y S X=DIV D NOW^%DTC S X=% X ^DD(430,8,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^PRCA(430,D0,0)):^(0),1:"") S X=$P(Y(1),U,14),X=X S DIU=X K Y S X=DIV S X=DT X ^DD(430,8,1,4,1.4)
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),U,14) S ^PRCA(430,"ASDT",X,$P($P(^PRCA(430,DA,0),U,14),"."),DA)=""
 S X=DG(DQ),DIC=DIE
 I X=16,+$P($G(^PRCA(430,+DA,0)),"^",10) S ^PRCA(430,"AJK1",$P(^PRCA(430,+DA,0),"^",10),DA)=""
C2F1 S DIEZRXR(430,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1188 S DIEZRXR(430,DIXR)=""
 Q
X2 D CKSTAT^PRCAUT3
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I PRCAT'["C" S Y="@6"
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;16",DV="R*P430.2'",DU="",DIFLD=15.1,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="PRCA(430.2,"
 G RE
X4 S DIC("S")="I $P(^(0),U,7)<4" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S PRCAQS=+X
 Q
6 S DW="0;21",DV="NJ3,0",DU="",DIFLD=20.1,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S X=$P(^PRCA(430.2,PRCAQS,0),U,3)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X6 K:+X'=X!(X>500)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
7 S DQ=8 ;@6
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I "T"'[PRCAT S Y="@3"
 Q
9 S DW="0;7",DV="RP2'",DU="",DIFLD=7,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C9^PRCATE"
 S DU="DPT("
 G RE
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 K ^PRCA(430,"E",X,DA)
C9S S X="" G:DG(DQ)=X C9F1 K DB
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",2),$P(^PRCA(430.2,+$P(^(0),"^",2),0),"^",6)["T" S ^PRCA(430,"E",X,DA)=""
C9F1 Q
X9 Q
10 S DQ=11 ;@3
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="0;9",DV="R*P340X",DU="",DIFLD=9,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C11^PRCATE",DE(DW,"INDEX")=1
 S DU="RCD(340,"
 G RE
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 K ^PRCA(430,"C",$E(X,1,30),DA)
 S X=DE(11),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",8) K ^PRCA(430,"AS",X,$P(^PRCA(430,DA,0),"^",8),DA)
 S X=DE(11),DIC=DIE
 D UPATDS^PRCAUTL I $D(^RCD(340,X,0)),$P(^(0),"^")[";DPT(",$D(^PRCA(430,DA,6)),$P(^(6),"^",21) S ^PRCA(430,"ATD",X,$P(^PRCA(430,DA,6),"^",21),DA)=""
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^PRCA(430,"C",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,DA,0),"^",8) S ^PRCA(430,"AS",X,$P(^PRCA(430,DA,0),"^",8),DA)=""
 S X=DG(DQ),DIC=DIE
 D UPATDS^PRCAUTL I $D(^RCD(340,X,0)),$P(^(0),"^")[";DPT(",$D(^PRCA(430,DA,6)),$P(^(6),"^",21) S ^PRCA(430,"ATD",X,$P(^PRCA(430,DA,6),"^",21),DA)=""
C11F1 S DIEZRXR(430,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=1188 S DIEZRXR(430,DIXR)=""
 Q
X11 D EN6^PRCABIL D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I PRCAT'["T" S Y="@4"
 Q
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW="202;1",DV="F",DU="",DIFLD=239,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X13 K:$L(X)>30!($L(X)<2) X
 I $D(X),X'?.ANP K X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:X="" Y=247
 Q
15 S DW="202;2",DV="S",DU="",DIFLD=240,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="M:MALE;F:FEMALE;U:UNKNOWN;"
 G RE
X15 Q
16 S DW="202;4",DV="F",DU="",DIFLD=242,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X16 K:$L(X)>20!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
17 S DW="202;5",DV="F",DU="",DIFLD=243,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X17 K:$L(X)>20!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
18 S DW="202;6",DV="F",DU="",DIFLD=244,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X18 K:$L(X)>17!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
19 S DW="202;9",DV="F",DU="",DIFLD=247,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X19 K:$L(X)>30!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S:X="" Y="@4"
 Q
21 S DW="202;10",DV="F",DU="",DIFLD=248,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X21 K:$L(X)>11!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
22 S DW="202;11",DV="F",DU="",DIFLD=249,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 G RE
X22 K:$L(X)>40!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
23 S DW="0;19",DV="P36'",DU="",DIFLD=19,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(36,"
 G RE
X23 Q
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 S:X="" Y="@4"
 Q
25 S DW="0;20",DV="P36'",DU="",DIFLD=19.1,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(36,"
 G RE
X25 Q
26 S DQ=27 ;@4
27 S DW="0;5",DV="R*P430.6'OX",DU="",DIFLD=4.5,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DQ(27,2)="S Y(0)=Y I $D(^PRCA(430.6,+Y,0)) S Y=$P(^PRCA(430.6,+Y,0),U,2)"
 S DU="PRCA(430.6,"
 G RE
X27 S DIC("S")="S Z0=$P(^PRCA(430,DA,0),U,2) Q:+Z0'>0  S Z0=$P(^PRCA(430.2,Z0,0),U,6) I ($P(^PRCA(430.6,Y,0),U,4)[Z0)!($P(^(0),U,4)[""X"")" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 S $P(^PRCA(430,D0,7),U,1)=X
 Q
29 S DW="0;10",DV="RDX",DU="",DIFLD=10,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C29^PRCATE"
 G RE
C29 G C29S:$D(DE(29))[0 K DB
 S X=DE(29),DIC=DIE
 ;
 S X=DE(29),DIC=DIE
 K ^PRCA(430,"AJK1",X,DA)
C29S S X="" G:DG(DQ)=X C29F1 K DB
 S X=DG(DQ),DIC=DIE
 X "D AR^RCXVDEQ"
 S X=DG(DQ),DIC=DIE
 I $P(^PRCA(430,+DA,0),"^",8)=16 S ^PRCA(430,"AJK1",X,DA)=""
C29F1 Q
X29 S %DT="E" D ^%DT S X=Y K:Y<1!(X>DT) X
 Q
 ;
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 S I(0,0)=D0 S Y(1)=$S($D(^PRCA(430,D0,0)):^(0),1:"") S X=$P(Y(1),U,9),X=X S D(0)=+X S X=$S(D(0)>0:D(0),1:"")
 S DGO="^PRCATE1",DC="^340^RCD(340," G DIEZ^DIE0
R30 D DE G A
 ;
31 D:$D(DG)>9 F^DIE17,DE S DQ=31,D=0 K DE(1) ;1
 S DIFLD=1,DGO="^PRCATE2",DC="7^430.01IA^2^",DV="430.01MRFX",DW="0;1",DOW=$$LABEL^DIALOGZ(DP,DIFLD),DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 G RE:D I $D(DSC(430.01))#2,$P(DSC(430.01),"I $D(^UTILITY(",1)="" X DSC(430.01) S D=$O(^(0)) S:D="" D=-1 G M31
 S D=$S($D(^PRCA(430,DA,2,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M31 I D>0 S DC=DC_D I $D(^PRCA(430,DA,2,+D,0)) S DE(31)=$P(^(0),U,1)
 G RE
R31 D DE
 S D=$S($D(^PRCA(430,DA,2,0)):$P(^(0),U,3,4),1:1) G 31+1
 ;
32 S DW="100;2",DV="RP49'",DU="",DIFLD=101,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="DIC(49,"
 G RE
X32 Q
33 S DW="104;1",DV="P200'",DU="",DIFLD=111,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DU="VA(200,"
 G RE
X33 Q
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 S $P(^PRCA(430,D0,0),U,12)=$S($D(PRCA("SITE")):PRCA("SITE"),1:"")
 Q
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 S $P(^PRCA(430,D0,0),U,4)=$S($D(PRCAGLN):PRCAGLN,1:"")
 Q
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 K PRCAQS
 Q
37 G 0^DIE17
