RMPRLN8 ;PHX/RFM-RETURN ITEMS FROM AUTO TRANS LIST ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 D DIV4^RMPRSIT G:$D(X) EXIT^RMPRLN0 K ^TMP($J) S DIC="^RMPR(665,",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: " D ^DIC G:Y<0 EXIT^RMPRLN0
 S DFN=+Y
EN1 I '$D(^RMPR(667,"AD",DFN)) G ^RMPRLN9
 D WAIT^DICD F RP=0:0 S RP=$O(^RMPR(667,"C",DFN,RP)) Q:RP'>0  F ZI=0:0 S ZI=$O(^RMPR(667.3,"AD",RP,ZI)) Q:ZI'>0  F ZA=0:0 S ZA=$O(^RMPR(667.3,"AD",RP,ZI,ZA)) Q:ZA'>0  D
 .I $P(^RMPR(667.3,ZA,0),U,8)="X"!($P(^(0),U,12)) Q
 .S ^TMP($J,ZA)=$P(^RMPR(667.1,ZI,0),U)
TMP I '$D(^TMP($J)) W !,"No items are availabel for loan" G ^RMPRLN9
TMP1 W !!?15,"*RECORDED AUTO-ADAPTIVE EQUIPMENT*",!!,?15,"ITEM",?30,"DATE ISSUED",?43,"SERIAL NUMBER"
 W ! I '$D(^TMP($J)) W ?30,"No items issued" G EXIT^RMPRLN0
 W ! S RO=0 F I=1:1 S RO=$O(^TMP($J,RO)) Q:RO=""  I '$D(RMPREXF1) S RZ(I)=RO D WRI9 I $D(RMPRIEN)!(X="^")!($D(DTOUT)) Q
 G:$D(DTOUT) EXIT^RMPRLN0 G:'$D(RMPRIEN) CON G POS
WRI9 W !,I_".",?7,$E($P(^TMP($J,RO),U),1,20) S Y=$P(^RMPR(667.3,RO,0),U,1) X ^DD("DD") W ?30,Y,?43,$P(^RMPR(667.3,RO,0),U,6)
SEL I I#15=0!($O(^TMP($J,RO))="") D  Q:(X="^")!(X="")
 .W !! K DIR S DIR(0)="NO^1:"_I,DIR("A")="Please enter a number " D ^DIR  Q:(X="^")!(X="")!($D(DTOUT))
 .I +X S (ZRMP,RMPRIEN)=RZ(X),RMPRSER=$P(^RMPR(667.3,RMPRIEN,0),U,6),RMPRITEM=$P(^(0),U,3)
 Q
CON W $C(7),!!,"You have not selected a Patient's Auto-Adaptive Equipment entry.",! G ^RMPRLN9
POS D WAIT^DICD H 1 K DIC,DD,DO S DIC="^RMPR(660.1,",DIC(0)="L",X=DT,DLAYGO=660.1 D FILE^DICN K DLAYGO G:+Y<0 EXIT^RMPRLN0 S IEN=+Y,ZZ=^RMPR(667.3,RMPRIEN,0)
 S ^RMPR(660.1,IEN,0)=DT_U_DFN_U_U_$P(ZZ,U,7)_U_$P(ZZ,U,4)_U_$P(ZZ,U,6)_"^^^"_2_"^^^^^^"_RMPR("STA")_U,$P(^(0),U,21)=RMPRITEM,$P(^(0),U,22)=RMPRIEN S DIK=DIC,DA=IEN D IX1^DIK
 S DIE=DIC,DA=IEN,DR="@3;10R;I $P(^RMPR(660.1,DA,0),U,11)<$P(ZZ,U) W !,$C(7),""The Date of Return must be equal to or greater the date of issue"" S $P(^(0),U,11)="""",Y=""@3"";13R;5R" D ^DIE
 I '$P(^RMPR(660.1,IEN,0),U,11)!('$P(^(0),U,14))!($P(^(0),U,6)']"") S DIK=DIC,DA=IEN D ^DIK W $C(7),!?10,"Deleted..."
 I $D(DA) S $P(^RMPR(667.3,RMPRIEN,0),U,12)=DT
 G EXIT^RMPRLN0
