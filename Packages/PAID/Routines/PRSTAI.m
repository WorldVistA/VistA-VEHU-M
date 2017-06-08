PRSTAI ; HISC/REL/WAA - Process Austin 8B Input ;8/6/93  08:34
 ;;3.5;PAID;;Jan 26, 1995
 S X="N",%DT="XT" D ^%DT S DT=Y\1,NOW=+Y
 S MSG="",XMDUZ=DUZ,XMZ=0,XMU="ALL",XMD="IN"
ASK K DIC S DIC="^XMB(3.7,XMDUZ,2,",DIC(0)="AEQMNZ",DIC("A")="Select Mail Basket: ",DIC("B")="IN"
 W ! D ^DIC K DIC G KIL:X[U,ASK:Y<1 S XMK=+Y,XMKN=$P(Y(0),"^",1)
 K ^TMP($J) S XMC=0 F XMZ1=0:0 S XMZ1=$O(^XMB(3.7,XMDUZ,2,XMK,1,XMZ1)) Q:XMZ1<1  D UTL
 W "  ",$S(XMC=0:"No",1:XMC)," Message",$S(XMC'=1:"s",1:"")," in basket." G:XMC=0 ASK
LIST W !,"Select from the following:" S XMZ=0 D H^PRSTAIM
 W !!,"Specify messages to Install: " R XMBEG:DTIME S:'$T XMBEG=U G:XMBEG[U!(XMBEG="") PRSTAI
 I XMBEG["?" W @IOF D QU^PRSTAIM G LIST
 F XMB3=1:1 S (ERR,OUT)=0 D VAL Q:OUT  I ERR K ^TMP($J,"C") D QU^PRSTAIM G LIST
 I '$D(^TMP($J,"C")) G KIL
 K X S XMC=0 F MSG=0:0 S MSG=$O(^TMP($J,"C",MSG)) Q:MSG<1  G:'$D(^XMB(3.9,MSG,2,3,0))!($E(^(0),20,21)'="8B") WARN2 S XMC=XMC+1,X(XMC)=$E(^(0),30,31)_"^"_MSG
 S PP=$P(X(1),"^",1) F I=2:1:XMC I $P(X(I),"^",1)'=PP G WARN3
 K X S YR=$E(DT,1,3) S:PP>24&($E(DT,4,5)="01") YR=YR-1 S:PP<2&($E(DT,4,5)="12") YR=YR+1
 S PP=YR_PP I '$D(^PRST(455,PP,0)) S ^PRST(455,PP,0)=PP,^PRST(455,"B",PP,PP)=""
L1 S %=1 I $D(^PRST(455,PP,1,0)) D WARN1 I %=-1!(%=2) G KIL
 I %'=1 W !!,"Answering YES will add these records or over-write existing",!,"ones for the same employee." G L1
 W !!,"Installing Mail Messages into Pay Period 8B FILE ..." K ^XUTL("PRST")
 S (II,IIN,IR)=0 F XMZ=0:0 S XMZ=$O(^TMP($J,"C",XMZ)) Q:XMZ<1  W "." F XCN=.99:0 S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:+XCN'=XCN  S IN=^(XCN,0) F I=1:31:$L(IN)-30 S ID=$E(IN,I,I+30) D:$E(ID,20,21)="8B" PROC
 I II S IM=$P(^PRSPC(0),"^",3),^PRST(455,PP,1,0)="^455.02P^"_IM_"^"_II
 I II S IM=^PRST(455,0),$P(^PRST(455,0),"^",3,4)=PP_"^"_($P(IM,"^",4)+1)
 ; Initialize T&L Units
 F K=0:0 S K=$O(^PRST(455.5,K)) Q:K<1  S $P(^PRST(455.5,K,0),"^",3)=""
 ; Build ATL Cross-Ref
 K ^PRST(455,"ATL")
 F K=0:0 S K=$O(^PRST(455,PP,1,K)) Q:K<1  S TL=$P($G(^(K,0)),"^",7),Y0=$P($G(^PRSPC(K,0)),"^",1) I TL'="",Y0'="" S ^PRST(455,"ATL",TL,Y0,K)=""
 W !!,"Payroll Data from Austin for Payroll Period # ",$E(PP,4,5)," now loaded."
 W !!,"Total Employees Loaded: ",II
 S X1=$G(^PRST(455,PP,"S"))
 S $P(^PRST(455,PP,"S"),"^",1,4)=($P(X1,"^",1)+IIN)_"^"_($P(X1,"^",2)+IR)_"^"_DUZ_"^"_NOW
 D ^PRSTAN G KIL
 ;
UTL ; Selects only valid TAB messages
 S X=$P(^XMB(3.9,XMZ1,0),"^",1) I X'["TAB/" Q
 S J=+^XMB(3.7,XMDUZ,2,XMK,1,XMZ1,0),XMC=XMC+1,^TMP($J,"B",XMC)=J Q
PROC ; Process Record
 S SSN=$E(ID,5,13) Q:SSN'?9N  S DFN=$O(^PRSPC("SSN",SSN,0))
 S TL=$E(ID,22,24) I TL'?3N,TL'?1"VC"1U S IR=IR+1 Q
 I DFN<1 S ^XUTL("PRST",SSN)=ID Q
 I '$D(^PRST(455.5,"B",TL)) K DD,DO,DIC,DINUM S DIC="^PRST(455.5,",DIC(0)="L",DLAYGO=455.5,X=TL D FILE^DICN K DIC,DLAYGO W !!,"New T&L ",TL," found and added to T&L file."
 S Y0=DFN_"^^^"_$E(ID,2,4)_"^"_SSN_"^"_$E(ID,14,16)_"^"_TL_"^"_$E(ID,25)_"^"_$E(ID,26,27)_"^"_$E(ID,28)_"^"_$E(ID,29)
 S ^PRST(455,PP,1,DFN,0)=Y0 I '$D(^PRST(455,PP,1,"B",DFN,DFN)) S ^PRST(455,PP,1,"B",DFN,DFN)="",IIN=IIN+1
 S II=II+1 Q
 ;
WARN1 W *7,!!,"Data already exists for this pay period!",!!,"Do you want to continue" S %=2 D YN^DICN Q
WARN2 W @IOF,"Message # ",MSG," with Subject: ",$P(^XMB(3.9,MSG,0),U,1),!,"  does not appear to contain payroll data." G ASK
WARN3 W @IOF,"The messages you selected are not for the same pay period!!",!!,"Message #",?15,"Subject",?60,"Pay Period",!
 F I=1:1:XMC S MSG=$P(X(I),"^",2) W !,MSG,?15,$E($P(^XMB(3.9,MSG,0),U,1),1,40),?64,$P(X(I),"^",1)
 G ASK
 ;
VAL ; Validate message list elements
 S XMB1=$P(XMBEG,",",XMB3) I XMB1="" S OUT=1 Q
 I XMB1'?1N.N,XMB1'?1N.N1"-"1N.N S ERR=1 Q
 S XMB2=+XMB1
 I XMB1["-" S XMB2=$P(XMB1,"-",2) I XMB2<XMB1 S ERR=1 Q
 F XMDN=+XMB1:1:+XMB2 I $D(^TMP($J,"B",XMDN)) S MSG=^(XMDN),^TMP($J,"C",MSG)=""
 Q
 ;
KIL K ^TMP($J),%,%DT,DFN,DIC,DINUM,DLAYGO,I,ID,II,IIN,IM,IN,IR,J,K,MSG,PP,SSN,TL
 K X,X1,XCN,XMB1,XMB2,XMB3,XMBEG,XMC,XMD,XMDN,XMDUZ,XMK,XMKN,XMU
 K OUT,ERR,C,DISYS,Y,Z,XMZ,XMZ1,Y,Y0,YR,NOW Q
