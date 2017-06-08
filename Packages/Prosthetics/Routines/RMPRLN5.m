RMPRLN5 ;PHX/RFM-ENTER RETURNED LOAN INFORMATION ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 D DIV4^RMPRSIT G:$D(X) EXIT^RMPRLN0 K ^TMP($J) S DIC="^RMPR(660.1,",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: ",DIC("S")="I $P(^(0),U,9)=1,'$P(^(0),U,11)"
 S DIC("W")="S RO=^(0) W ?20,$P(^DPT($P(RO,U,2),0),U) W:$P(RO,U,21)?1N.N ?50,""AUTO ADAPTIVE ITEM"" I $P(RO,U,3)?1N.N W ?50,$E($P(^PRC(441,$P(^RMPR(661,$P(RO,U,3),0),U),0),U,2),1,29)"
 D ^DIC G:Y<0 EXIT^RMPRLN0 S:$P(^RMPR(660.1,+Y,0),U,21) RMPRA=1
 S IEN=+Y,DFN=$P(Y(0),U,2),RMPREDT9=1 L +^RMPR(660.1,IEN,0):3 I '$T W !!,$C(7),?5,"Someone else is Editing this entry" G EXIT^RMPRLN0
 D EN^RMPRLN3
EDIT S DIE=DIC,DA=IEN,%DT="AX",%DT("A")="DATE OF RETURN: ",%DT("B")="TODAY" D ^%DT
 L -^RMPR(660.1,IEN,0) G:$D(DTOUT)!($D(Y(0)))!(Y<0) EXIT^RMPRLN0 I Y<$P(^RMPR(660.1,IEN,0),U,10) W $C(7)," ??",!,"Date of Return must be equal to or greater than date of loan." G EDIT
 S $P(^RMPR(660.1,IEN,0),U,11)=Y
 S DIE("NO^")="BACK",DR="13R;21R;2.5" L +^RMPR(660.1,IEN,0) D ^DIE L -^RMPR(660.1,IEN,0) G:$D(DTOUT) EXIT^RMPRLN0 S RMPRIEN=^RMPR(660.1,DA,0) D UPD^RMPRLN4
 I $D(^RMPR(660,IEN,1)),+$P(^(1),U,3),$D(^PRCP(445,$P(^(1),U,3),1,RMPRITEM)),$P(^DIC(669.9,RMPRSITE,0),U,3)=1 G INV
 G EXIT^RMPRLN0
INV W $C(7),!!,"The item you have selected, "_$E($P(^PRC(441,RMPRITEM,0),U,2),1,30)_","_" was issued",!,"from inventory as a quantity of ",$P(^RMPR(660,RMPRIEN,0),U,7)
QUE S %=1 W !!,"Would you like to add this item back into inventory with this quantity" D YN^DICN
 I %=0 W !!,"Enter `YES` to add item back into inventory, `NO` to edit the information.",! H 2 G QUE
 I %<0!(%=2) G EXIT^RMPRLN0
 S PRCP("I")=$P(^RMPR(660,RMPRIEN,1),U,3),PRCP("QTY")=$P(^(0),U,7),PRCP("ITEM")=$P(^RMPR(661,$P(^(0),U,6),0),U),PRCP("TYP")="R" D ^PRCPUSA I $D(PRCP("ITEM")) W !,$C(7),$C(7),"Error encountered while trying to post this item to GIP.  Please"
 I  W !,"post this item manually,",!
 S DIE=DIC,DA=IEN,DR="R13;10//TODAY;2.5" D ^DIE I '$D(RMPRFLAG) D ^RMPRLN3
 G EXIT^RMPRLN0
