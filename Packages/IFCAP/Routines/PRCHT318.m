PRCHT318 ; ;10/08/98
 D DE G BEGIN
DE S DIE="^PRC(442,D0,2,",DIC=DIE,DP=442.01,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^PRC(442,D0,2,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,4) S:%]"" DE(11)=%
 I $D(^(4)) S %Z=^(4) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,6) S:%]"" DE(3)=% S %=$P(%Z,U,7) S:%]"" DE(4)=% S %=$P(%Z,U,15) S:%]"" DE(7)=% S %=$P(%Z,U,16) S:%]"" DE(8)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
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
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
BEGIN S DNM="PRCHT318",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="4;1",DV="NJ4,0",DU="",DLB="SERIAL NO.(GSA/DLA)",DIFLD=30
 G RE
X1 K:+X'=X!(X>9999)!(X<1000)!(X?.E1"."1N.N) X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I PRCHN("SC")=0 S Y="@5"
 Q
3 S DW="4;6",DV="S",DU="",DLB="BACKORDER CONTROL",DIFLD=35
 S DU="-:ESTABLISH BACKORDER;"
 G RE
X3 Q
4 S DW="4;7",DV="S",DU="",DLB="SUBSTITUTE CONTROL",DIFLD=36
 S DU="-:NO SUBSTITUTE;"
 G RE
X4 Q
5 S DQ=6 ;@5
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:'$D(PRCHEDI) Y="@88"
 Q
7 S DW="4;15",DV="S",DU="",DLB="BACKORDER (EDI)",DIFLD=36.3
 S DU="Y:YES;N:NO;"
 G RE
X7 Q
8 S DW="4;16",DV="S",DU="",DLB="SUBSTITUTE (EDI)",DIFLD=36.6
 S DU="Y:YES;N:NO;"
 G RE
X8 Q
9 S DQ=10 ;@88
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I PRCHN("SFC")=2 S $P(^PRC(442,DA(1),2,DA,0),U,4)=$$SUPBOC^PRCHNPO7(-1) S Y="@87"
 Q
11 S DW="0;4",DV="RFX",DU="",DLB="BOC",DIFLD=3.5
 S DE(DW)="C11^PRCHT318"
 S X=$$SUPBOC^PRCHNPO7(-1)
 S Y=X
 G Y
C11 G C11S:$D(DE(11))[0 K DB S X=DE(11),DIC=DIE
 K ^PRC(442,DA(1),2,"D",+$P(X," ",1),DA)
 S X=DE(11),DIC=DIE
 S ALN=$P(^PRC(442,DA(1),2,DA,0),"^") K:ALN>0 ^PRC(442,DA(1),2,"AH",+X,ALN,DA) K ALN
C11S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^PRC(442,DA(1),2,"D",+$P(X," ",1),DA)=""
 S X=DG(DQ),DIC=DIE
 S ALN=$P(^PRC(442,DA(1),2,DA,0),"^") S:ALN>0 ^PRC(442,DA(1),2,"AH",+X,ALN,DA)="" K ALN
 Q
X11 N Z0 S Z0=$P(^PRC(442,DA(1),0),"^",5) K:'Z0 X I $D(X) K:'$D(^PRCD(420.1,Z0,0)) X I $D(X) S X=$$SUPBOC^PRCHNPO7 D EN8^PRCHNPO7
 I $D(X),X'?.ANP K X
 Q
 ;
12 S DQ=13 ;@87
13 S DQ=14 ;@6
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S PRCHTOT=0,PRCHSCN="" F I=0:0 S PRCHSCN=$O(^PRC(442.8,"B",PRCHPONO,PRCHSCN)) Q:PRCHSCN=""  I $P(^PRC(442.8,PRCHSCN,0),U,2)=DA S PRCHTOT=PRCHTOT+$P(^(0),U,5)
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 S PRCHQTY=$P(^PRC(442,DA(1),2,DA,0),U,2)
 Q
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I PRCHTOT>PRCHQTY S PRCHDA1=DA(1),PRCHDA=DA,PRCHLINO=$P(^PRC(442,DA(1),2,PRCHREC,0),U) W !,"Line Item # = ",PRCHLINO,!,"Quantity Ordered: "_$P(^PRC(442,DA(1),2,PRCHREC,0),U,2),! S Y="@555"
 Q
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 W !!,"Enter/Edit Delivery Schedule for this Item?  NO// " R X:DTIME S:'$T X="^" S:X="" X="N" S:X["?" Y="@6" S:"Yy?"'[$E(X) Y="@56" W "  "_$S("Yy"[$E(X):"(YES)","Nn"[$E(X):"(NO)",1:"")
 Q
18 S DQ=19 ;@16
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S PRCHDA=DA,PRCHDA1=DA(1),PRCHLINO=$P(^PRC(442,DA(1),2,PRCHREC,0),U,1) W !,"Line Item # = ",PRCHLINO,!,"Quantity Ordered: "_$P(^(0),U,2),!
 Q
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 I PRCHTOT=PRCHQTY W !,"Delivery schedule quantity of ",PRCHTOT," equals the order quantity.",!,"You may edit delivery schedule(s), but cannot add a new schedule.",!!
 Q
21 S DQ=22 ;@555
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 I PRCHTOT>PRCHQTY W !,"Delivery schedule quantity of ",PRCHTOT," EXCEEDS order quantity of ",PRCHQTY,".",!,"You must edit one or more schedules so that the delivery total equals",!,"no more than ",PRCHQTY,".",!!
 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 S:$D(PRCHSEEN) Y="@55"
 Q
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 S PRCHSEEN=1 W !!,"** To DELETE a schedule, zero out the quantity to be delivered. To add a new",!,"delivery schedule do the following:",!!
 Q
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 W "a. If there is no delivery schedule already in file answer 'Yes' when asked if     you are adding a new delivery schedule."
 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 W !,"b. If there is only one delivery schedule already in the file you will see         'OK? YES//' answer 'No' and then answer 'Yes' when asked if you are adding a    new delivery schedule."
 Q
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 W !,"c. If there is more than one delivery schedule in the file, hit <return> key at    'CHOOSE' prompt and answer 'Yes' when asked if you are adding a new delivery    schedule.",!!
 Q
28 S DQ=29 ;@55
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 X DR(99,1,9.2) S Y(101)=$S($D(^PRC(442.8,D0,0)):^(0),1:"") S X=$P(Y(101),U,1),Y(102)=X S X=$P(Y(101),U,1) S D0=I(0,0) S D1=I(1,0) S X=$S(D(0)>0:D(0),1:"")
 S DGO="^PRCHT319",DC="^442.8^PRC(442.8," G DIEZ^DIE0
R29 D DE G A
 ;
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 S PRCHQTY=$P(^PRC(442,PRCHIEN,2,DA,0),U,2)
 Q
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 I $G(PRCHFLG),PRCHTOT>$G(PRCHQTY) W !!,"Delivery schedule(s) quantity of ",PRCHTOT," is still greater than ordered quantity of ",$G(PRCHQTY),".",!! S Y="@16"
 Q
32 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=32 D X32 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X32 I $G(PRCHFLG) S PRCHFLG=0 W !!!!,"****Returning to Item Multiple editing session.",!! S Y="@44"
 Q
33 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=33 D X33 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X33 I PRCHTOT>PRCHQTY S Y="@555"
 Q
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 W !!,"Enter/Edit Delivery Schedule for this Item?  NO// " R X:DTIME S:'$T X="^" S:X="" X="N" S:X["?" Y="@6" S:"Yy?"[$E(X) Y="@16"
 Q
35 S DQ=36 ;@56
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 K DIE("NO^"),PRCHDA1,PRCHDA,PRCHSCN
 Q
37 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=37 D X37 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X37 K PRCHTOT,PRCHQTY,PRCHSEEN,PRCHMORE
 Q
38 G 1^DIE17
