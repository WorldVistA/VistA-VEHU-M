DJ ;JA/VDC2 SCREEN HANDLER  ; 05 Dec 86  9:19 AM
V ;;VERSION 1.36
 D:'$D(DT) DT^DICRW S U="^",S=";",O=$T(OPT) I $D(^DOPT($P(O,S,5),"VERSION")),($P($T(V),S,3)=^DOPT($P(O,S,5),"VERSION")) G IN
 K ^DOPT($P(O,S,5))
 F I=1:1 Q:$T(OPT+I)=""  S ^DOPT($P(O,S,5),I,0)=$P($T(OPT+I),S,3),^DOPT($P(O,S,5),"B",$P($P($T(OPT+I),S,3),"^",1),I)=""
 S K=I-1,^DOPT($P(O,S,5),0)=$P(O,S,4)_U_1_U_K_U_K K I,K,X S ^DOPT($P(O,S,5),"VERSION")=$P($T(V),S,3)
IN I $P(O,S,6)'="" D @($P(O,S,6)) Q:'$D(DJRJ)
PR S O=$T(OPT),S=";" S IOP=$I D ^%ZIS W:IOST'["PK-" @IOF K IOP
 I $P(O,S,7)'="" D @($P(O,S,7))
 E  W !!,$P(O,S,3),":",!,$P($T(V),S,3),!!,$P(O,S,4),"S:",!
 F J=1:1 Q:'$D(^DOPT($P(O,S,5),J,0))  S K=$S(J<10:15,1:14) W !,?K,J,". ",$P(^DOPT($P(O,S,5),J,0),U,1)
RE W ! S DIC("A")="Select "_$P($T(OPT),S,4)_": EXIT// ",DIC="^DOPT("_""""_$P($T(OPT),S,5)_""""_",",DIC(0)="AEQMN" D ^DIC G:X=""!(X=U) EX G:Y<0 RE K DIC,J,O D @($P($T(OPT+Y),S,4)) G PR
INIT ;INITIALIZE VARIABLES FOR SCREEN HANDLER
 I DUZ=0 I $D(^DIC(3))>0 S DIC="^DIC(3,",DIC(0)="AEQ" D ^DIC G:Y<0 INIT1 S DUZ=+Y,DUZ(0)=$P(^DIC(3,+Y,0),"^",4)
INIT1 S:$D(DUZ(0))=0 DUZ(0)=""
INIT2 D ^DJPARAM
 S:$D(DTIME)<1 DTIME=120
 I $D(^DJR("VERSION"))'>0 S ^DJR("VERSION")=1.36 Q
 I ^DJR("VERSION")'=1.36 S ^DJR("VERSION")=1.36
 Q
HDR W @IOF,?15,"VA SCREEN HANDLER SYSTEM"
 W !,?21,"VERSION ",^DJR("VERSION")
 W !,?21,"ISC REGION 2"
 K X,Y W !!! Q
 ;
1 S DJOP=1 D Q Q:X=U!(X="")  S DJNM=DJDNM,DJDN=+Y
11 K V D ^DJDPL G EXIT1:$D(DJY) D ^DJDEFS G:DJD'="" 11 G EXIT
2 S DJOP=2,DLAYGO=2000 D Q Q:X=U!(X="")  K V S DJDN=+Y D ^DJDEFG G EXIT
 ;
3 S DJOP=3 D Q Q:X=U!(X="")  S (DA,DJDN)=+Y,DIE=DIC,DR=".01;.08" D ^DIE G:'$D(DA)!(X="") EXIT D ^DJDEFE G EXIT
 ;
4 S DJOP=4 D Q Q:X=U!(X="")  S DJDN=+Y D ^DJDEFH G EXIT
 ;
5 S DJOP=5 D Q Q:X=U!(X="")
EN K ^UTILITY($J,"DJST"),DJST,^UTILITY($J,"DJ") S:'$D(DUZ(0)) DUZ(0)="" S:'$D(DTIME) DTIME=120 S:$D(DJSC) X=DJSC S Y=$N(^DJR("B",X,0)) I Y<0 W !!,"SCREEN NOT DEFINED",*7 Q
 S DJR=Y,DJR(0)=^DJR(Y,0),DJZ=$P(DJR(0),"^",6) I '$D(DJZ) S DJZ=$S(DJZ="":"",$D(^DIC(DJZ,0,"GL"))=1:^("GL"),1:"") I DJZ=""!($D(^DJR(+Y,1))=0) W !,"SCREEN OR GLOBAL NOT DEFINED PROPERLY",*7 H 1 Q
 S DJNM=$P(^DJR(Y,0),"^",1) G:$D(DJDN) D
RD ;D RL Q:X="^"!(X="")  G RD
RL K V
D D:'$D(DJRJ) ^DJPARAM Q:'$D(DJRJ)
 I '$D(DJDN) D ^DJDPL G EXIT1:$D(DJY) D ^DJINJ G EXIT1
 I '$D(DJDIS),$D(DJDN) D ^DJDPL G EXIT1:$D(DJY) S (DA,W(V))=DJDN D ^DJC2 S DJW=1,DJW1=1 D EN^DJINJ G EXIT1
 I $D(DJDIS) D ^DJDPL G EXIT1:$D(DJY) S (DA,W(V))=DJDN D ^DJC2 S DJW=1,DJW1=1 D EN^DJINJ G EXIT1
 ;
Q ; LOCATE SCREEN
 D:'$D(DJRJ) ^DJPARAM Q:'$D(DJRJ)
 S DIC("A")="Select Screen Name: ",DIC(0)="AEMQ",DIC="^DJR(" S:DJOP=2 DLAYGO=2000,DIC(0)=DIC(0)_"L"
 S DIC("S")=$S(DUZ(0)'="@":"I 1 S DJX=$P(^DJR(+Y,0),""^"",4) F DJK=1:1:$L(DJX) I DUZ(0)[$E(DJX,DJK) Q",1:"I Y") I DJOP=5 S DIC("S")="I $P(^DJR(+Y,0),""^"",3)="""",'$D(^DD($P(^DJR(+Y,0),""^"",6),0,""UP"")) "_DIC("S")
 D ^DIC K DIC(0),DLAYGO,DIC("A"),DIC("S") Q:Y<0
 S (X,DJDNM)=$P(Y,U,2) Q
EX K DIC,DJRJ,I,J,K,O,S,X,XY Q
EXIT1 K DJLIN,DJEOP,DJCP,DJCL,DJRJ,DJR,XY I $D(IOST),IOST["C-Q" W @DJHIN
 K DJHIN
EXIT K DJJ,V,X,Y,DIC,DJQ,DJDPL,DJKV,DJNM,DJW,DIE,DE,DJ,DH,DI,DJDIS,DJW1,DJDN,DJ0,DJAT,DJMU,DJST,DJSC,DJI,DJOP,DWLW
 K D,D0,DA,DJ4,DJ3,DJ2,DJDD,DJDNM,DJERR,DJF,DJL,DJN,DJP,DJRNM,DJT,DJX,DJY,DJZ
 K ^UTILITY($J,"DJST"),DJ5,DJ6,DJ7,DJ9,DJA,DJAD,DJBD,DJD,DJDA,DJDP,DJDUZ,DJFF,DJLSTN,DJSM
 K DJ11,DJ01,DJXL,DJXT,DJXX,DJX1,DJX3,DJ8,DX,DY,DJK,DJDIC,DJDICS,W
 W @IOF Q
 ;
OPT ;;SCREEN MAIN MENU;OPTION;DJ;INIT;HDR
 ;;DEFINE NEW/ADD SCREEN CHARACTERISTICS;2
 ;;MODIFY SCREEN CHARACTERISTICS;3
 ;;SHIFT SCREEN ENTRIES;1
 ;;PRINT SCREEN;4
 ;;EXECUTE SCREEN;5
