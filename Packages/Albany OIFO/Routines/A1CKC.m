A1CKC ; GENERATED FROM 'A1CK VARO/DHCP' INPUT TEMPLATE(#1994), FILE 2;06/22/22
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.3)) S %Z=^(.3) S %=$P(%Z,U,1) S:%]"" DE(4)=%,DE(11)=% S %=$P(%Z,U,2) S:%]"" DE(5)=%
 I $D(^(.36)) S %Z=^(.36) S %=$P(%Z,U,1) S:%]"" DE(6)=%,DE(15)=%
 I $D(^(.362)) S %Z=^(.362) S %=$P(%Z,U,12) S:%]"" DE(13)=% S %=$P(%Z,U,13) S:%]"" DE(14)=% S %=$P(%Z,U,14) S:%]"" DE(12)=%
 I $D(^("TYPE")) S %Z=^("TYPE") S %=$P(%Z,U,1) S:%]"" DE(7)=%,DE(16)=%
 I $D(^("VET")) S %Z=^("VET") S %=$P(%Z,U,1) S:%]"" DE(3)=%,DE(10)=%
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
BEGIN S DNM="A1CKC",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1994,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1994,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
2 S DQ=3 ;@10
3 S DW="VET;1",DV="RSXa",DU="",DIFLD=1901,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C3^A1CKC"
 S DU="Y:YES;N:NO;"
 S Y="Y"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(3),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DE(3),DIC=DIE
 ;
 S X=DE(3),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(3),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DE(3),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 S X=DE(3),DIIX=2_U_DIFLD D AUDIT^DIET
C3S S X="" G:DG(DQ)=X C3F1 K DB
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DG(DQ),DIC=DIE
 X ^DD(2,1901,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X=DIV S X="N" X ^DD(2,1901,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 I $D(DE(3))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C3F1 Q
X3 I $D(X) S:'$D(DPTX) DFN=DA D:'$D(^XUSEC("DG ELIGIBILITY",DUZ)) VAGE^DGLOCK:X="Y" I $D(X) D:$D(DFN) EV^DGLOCK
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW=".3;1",DV="RSXa",DU="",DIFLD=.301,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C4^A1CKC"
 S DU="Y:YES;N:NO;"
 S Y="Y"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 ;
 S X=DE(4),DIC=DIE
 ;
 S X=DE(4),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(4),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DE(4),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 S X=DE(4),DIIX=2_U_DIFLD D AUDIT^DIET
C4S S X="" G:DG(DQ)=X C4F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.301,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.301,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 I $D(DE(4))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C4F1 Q
X4 S DFN=DA D EV^DGLOCK I $D(X),X="Y" D VET^DGLOCK
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW=".3;2",DV="NJ3,0Xa",DU="",DIFLD=.302,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C5^A1CKC"
 S X=PER
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 ;
 S X=DE(5),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(5),DIC=DIE
 ;
 S X=DE(5),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".302;" D AVAFC^VAFCDD01(DA)
 S X=DE(5),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 S X=DE(5),DIIX=2_U_DIFLD D AUDIT^DIET
C5S S X="" G:DG(DQ)=X C5F1 K DB
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
 I $D(DE(5))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C5F1 Q
X5 S DFN=DA D EV^DGLOCK Q:'$D(X)  K:+X'=X!(X>100)!(X<0)!(X?.E1"."1N.N) X I $D(X),$D(^DPT(DA,.3)),$P(^(.3),U,1)'="Y" W !?4,*7,"Only applies to service-connected applicants." K X
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW=".36;1",DV="*P8'Xa",DU="",DIFLD=.361,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C6^A1CKC",DE(DW,"INDEX")=1
 S DU="DIC(8,"
 S X=ELIG
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C6 G C6S:$D(DE(6))[0 K DB
 S X=DE(6),DIC=DIE
 ;
 S X=DE(6),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 X ^DD(2,.361,1,2,2.2) I DIV(1)>0 S DIK(0)=DA,DIK="^DPT(DIV(0),""E"",",DA(1)=DIV(0),DA=DIV(1) D ^DIK S DA=DIK(0) K DIK
 S X=DE(6),DIC=DIE
 X "I $S('$D(^DIC(8,+X,0)):0,$P(^(0),""^"",1)[""DOM"":0,'$D(^DPT(DA,.36)):1,'$D(^DIC(8,+^(.36),0)):1,$P(^(0),""^"",1)'[""DOM"":1,1:0) S DGXRF=.361 D ^DGDDC Q"
 S X=DE(6),DIC=DIE
 K ^DPT("AEL",DA,+X) I X=$$FIND1^DIC(8,"","B","COLLATERAL OF VET") D ARCHALL^DGRP1152U(DA)
 S X=DE(6),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(6),DIIX=2_U_DIFLD D AUDIT^DIET
C6S S X="" G:DG(DQ)=X C6F1 K DB
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA D INACT33^DGOTHEL(DFN),EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 X ^DD(2,.361,1,2,89.4) S Y(102)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$S('$D(^DIC(8,+$P(Y(102),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D1=I(1,0) S DIU=X K Y S X=DIV S X=DIV,X=X X ^DD(2,.361,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 S ^DPT("AEL",DA,+X)="" D RESTORE^DGRP1152U(DA)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 I $D(DE(6))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C6F1 N X,X1,X2 S DIXR=852 D C6X1(U) K X2 M X2=X D C6X1("O") K X1 M X1=X
 D
 . D FC^DGFCPROT(.DA,2,.361,"KILL",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 K X M X=X2 D
 . D FC^DGFCPROT(.DA,2,.361,"SET",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 G C6F2
C6X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,.361,DION),$P($G(^DPT(DA,.36)),U,1))
 S X=$G(X(1))
 Q
C6F2 Q
X6 S DFN=DA D EV^DGLOCK I $D(X) D ECD^DGLOCK1
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW="TYPE;1",DV="RP391'a",DU="",DIFLD=391,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C7^A1CKC",DE(DW,"INDEX")=1
 S DU="DG(391,"
 S X=DZT
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="391;" D AVAFC^VAFCDD01(DA)
 S X=DE(7),DIIX=2_U_DIFLD D AUDIT^DIET
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="391;" D AVAFC^VAFCDD01(DA)
 I $D(DE(7))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C7F1 N X,X1,X2 S DIXR=636 D C7X1(U) K X2 M X2=X D C7X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^DPT("APTYPE",X,DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^DPT("APTYPE",X,DA)=""
 G C7F2
C7X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,391,DION),$P($G(^DPT(DA,"TYPE")),U,1))
 S X=$G(X(1))
 Q
C7F2 Q
X7 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
9 S DQ=10 ;@20
10 D:$D(DG)>9 F^DIE17,DE S DQ=10,DW="VET;1",DV="RSXa",DU="",DIFLD=1901,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C10^A1CKC"
 S DU="Y:YES;N:NO;"
 S Y="Y"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C10 G C10S:$D(DE(10))[0 K DB
 S X=DE(10),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(10),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DE(10),DIC=DIE
 ;
 S X=DE(10),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(10),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DE(10),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 S X=DE(10),DIIX=2_U_DIFLD D AUDIT^DIET
C10S S X="" G:DG(DQ)=X C10F1 K DB
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DG(DQ),DIC=DIE
 X ^DD(2,1901,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X=DIV S X="N" X ^DD(2,1901,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 I $D(DE(10))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C10F1 Q
X10 I $D(X) S:'$D(DPTX) DFN=DA D:'$D(^XUSEC("DG ELIGIBILITY",DUZ)) VAGE^DGLOCK:X="Y" I $D(X) D:$D(DFN) EV^DGLOCK
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW=".3;1",DV="RSXa",DU="",DIFLD=.301,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C11^A1CKC"
 S DU="Y:YES;N:NO;"
 S Y="N"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 ;
 S X=DE(11),DIC=DIE
 ;
 S X=DE(11),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(11),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DE(11),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 S X=DE(11),DIIX=2_U_DIFLD D AUDIT^DIET
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.301,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.301,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 I $D(DE(11))'[0!($G(^DD(DP,DIFLD,"AUDIT"))["y") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C11F1 Q
X11 S DFN=DA D EV^DGLOCK I $D(X),X="Y" D VET^DGLOCK
 Q
 ;
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW=".362;14",DV="SX",DU="",DIFLD=.36235,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C12^A1CKC"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=$S(PE="Y":"Y",1:"N")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C12 G C12S:$D(DE(12))[0 K DB
 S X=DE(12),DIC=DIE
 X ^DD(2,.36235,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),.362)),DIV=X S $P(^(.362),U,4)=DIV,DIH=2,DIG=.3624 D ^DICR
 S X=DE(12),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(12),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,3,2.4)
 S X=DE(12),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C12S S X="" G:DG(DQ)=X C12F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$C(59)_$P($G(^DD(2,.36235,0)),U,3) S X=$P($P(Y(1),$C(59)_Y(0)_":",2),$C(59))="NO" I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C12F1 Q
X12 S DFN=DA D MV^DGLOCK
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW=".362;12",DV="SX",DU="",DIFLD=.36205,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C13^A1CKC"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=$S(AA="Y":"Y",1:"N")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C13 G C13S:$D(DE(13))[0 K DB
 D ^A1CKC1
C13S S X="" G:DG(DQ)=X C13F1 K DB
 D ^A1CKC2
C13F1 Q
X13 S DFN=DA D MV^DGLOCK I $D(X) S DFN=DA D EV^DGLOCK
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S DQ=14,DW=".362;13",DV="SX",DU="",DIFLD=.36215,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C14^A1CKC"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=$S(HB="Y":"Y",1:"N")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C14 G C14S:$D(DE(14))[0 K DB
 D ^A1CKC3
C14S S X="" G:DG(DQ)=X C14F1 K DB
 D ^A1CKC4
C14F1 Q
X14 S DFN=DA D MV^DGLOCK I $D(X) S DFN=DA D EV^DGLOCK
 Q
 ;
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW=".36;1",DV="*P8'Xa",DU="",DIFLD=.361,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C15^A1CKC",DE(DW,"INDEX")=1
 S DU="DIC(8,"
 S X=ELIG
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C15 G C15S:$D(DE(15))[0 K DB
 D ^A1CKC5
C15S S X="" G:DG(DQ)=X C15F1 K DB
 D ^A1CKC6
C15F1 N X,X1,X2 S DIXR=852 D C15X1(U) K X2 M X2=X D C15X1("O") K X1 M X1=X
 D
 . D FC^DGFCPROT(.DA,2,.361,"KILL",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 K X M X=X2 D
 . D FC^DGFCPROT(.DA,2,.361,"SET",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 G C15F2
C15X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,.361,DION),$P($G(^DPT(DA,.36)),U,1))
 S X=$G(X(1))
 Q
C15F2 Q
X15 S DFN=DA D EV^DGLOCK I $D(X) D ECD^DGLOCK1
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S DQ=16,DW="TYPE;1",DV="RP391'a",DU="",DIFLD=391,DLB=$$LABEL^DIALOGZ(DP,DIFLD)
 S DE(DW)="C16^A1CKC",DE(DW,"INDEX")=1
 S DU="DG(391,"
 S X=DZT2
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C16 G C16S:$D(DE(16))[0 K DB
 D ^A1CKC7
C16S S X="" G:DG(DQ)=X C16F1 K DB
 D ^A1CKC8
C16F1 N X,X1,X2 S DIXR=636 D C16X1(U) K X2 M X2=X D C16X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^DPT("APTYPE",X,DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^DPT("APTYPE",X,DA)=""
 G C16F2
C16X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,391,DION),$P($G(^DPT(DA,"TYPE")),U,1))
 S X=$G(X(1))
 Q
C16F2 Q
X16 Q
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
18 S DQ=19 ;@30
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 I 'SCI S Y="@39"
 Q
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S ISC=0
 Q
21 S DQ=22 ;@31
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 S ISC=$O(SCI(ISC))
 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 I 'ISC S Y="@39"
 Q
24 D:$D(DG)>9 F^DIE17 G ^A1CKC9
