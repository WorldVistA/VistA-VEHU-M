PRCPWPO1 ;WISC/RFJ-post issue book ;17 Jul 92
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN POST ISSUE BOOKS!" Q
 I $P($G(^PRCP(445,PRCP("I"),0)),"^",6)'="Y" W !,"THE WAREHOUSE MUST BE KEEPING A PERPETUAL INVENTORY." Q
 I $P($G(^PRCP(445,PRCP("I"),0)),"^",2)'="Y" W !,"THE WAREHOUSE MUST BE KEEPING A DETAILED TRANSACTION HISTORY." Q
 N %,DI,DIC,DISYS,DQ,PRCPDA,PRCPDT,PRCPFLAG,PRCPLOCK,PRCPNODE,PRCPOPT,PRCPORD,PRCPPVNO,PRCPREPT,PRCPSRC1,PRCPTYPE,PRIMORD,X,Y,ZTSK
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
TOP S PRCPPVNO=+$O(^PRC(440,"AC","S",0))_";PRC(440," I '$D(^PRC(440,+PRCPPVNO,0)) W !!,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE." Q
 S DIC="^PRCS(410,",DIC(0)="QEAMZ",DIC("A")="Select TRANSACTION NUMBER: ",DIC("S")="I $P(^(0),U,2)=""O"",$P(^(0),U,4)=5,$P($G(^(3)),U,4)=+PRCPPVNO,$P($G(^(7)),U,6)]"""",'$P($G(^(9)),U,3),$S('$D(^PRC(443,+Y,0)):1,$P(^(0),U,3)]"""":1,1:0)"
 W ! D ^PRCSDIC K DIC Q:Y<1  S PRCPDA=+Y,PRCPSRC1=$P($G(^PRCS(410,PRCPDA,0)),"^",6)
 I '$D(^PRCP(445,+PRCPSRC1,0)) W !,"NOT A VALID PRIMARY INVENTORY POINT ('",$S(PRCPSRC1="":"<<NO ENTRY>>",1:PRCPSRC1),"')." D  I 'PRCPSRC1 G TOP
PRIMARY .   S PRCPSRC1=+$$DISTRPT^PRCPUINV(PRCP("I")) Q:'PRCPSRC1
 .   S XP="  ARE YOU SURE YOU WANT TO USE THIS INVENTORY POINT FOR DISTRIBUTION",XH="ENTER 'YES' TO USE THIS INVENTORY POINT, 'NO' TO SELECT ANOTHER INVENTORY",XH(1)="POINT, OR '^' TO EXIT.",%=1 D YN^PRCPU4 G:%=2 PRIMARY I %'=1 S PRCPSRC1=0 Q
 .   S $P(^PRCS(410,PRCPDA,0),"^",6)=PRCPSRC1
 ;
 W !,"Distribution for Primary Inventory Point: ",$P($$INVNAME^PRCPUX1(PRCPSRC1),"-",2,99)
 S PRCPORD=$P($G(^PRCS(410,PRCPDA,100)),"^") I PRCPORD]"" W !!,"Reference Voucher Number: ",PRCPORD G OPTION
LOG W !!,"Enter Reference Voucher Number (for History): " R X:DTIME G:'$T!(X["^") TOP
 I X'?1UN4N!(('X)&("OJK"'[$E(X))) W !,"Voucher Number must have fiscal month (0=Oct. J=Nov. K=Dec. 1=Jan...9=Sep)",!,"followed by a 4-digit sequential number" G LOG
 S PRCPORD=X
 ;
OPTION ;     |-> type of posting
 S DIR(0)="S^1:ALL Items on Request;2:EXCEPTION (Enter only items NOT distributed);3:SELECTION (Enter only items distributed);",DIR("A")="Select METHOD of Distribution",DIR("B")="SELECTION"
 S DIR("?",1)="Enter ALL to distribute ALL the items exactly as the primary ordered them."
 S DIR("?",2)="Enter EXCEPTION to enter the items NOT distributed as ordered.  ALL other",DIR("?",3)="NON selected items will be distributed as ordered by the primary."
 S DIR("?",4)="Enter SELECTION to select ONLY the items you want to distribute.  All",DIR("?")="other items NOT selected will NOT be distributed as ordered by the primary." D ^DIR K DIR I Y'=1,Y'=2,Y'=3 G TOP
 S PRCPOPT=Y,PRCPTYPE="Posting" D REPASK^PRCPWPOR G:'$D(PRCPREPT) TOP
 ;
 K ^TMP($J) W !!,"LOCKING INVENTORY POINTS: ",$P($$INVNAME^PRCPUX1(PRCP("I")),"-",2,99),!?26,$P($$INVNAME^PRCPUX1(PRCPSRC1),"-",2,99)
 S PRCPLOCK(1)="^PRCP(445,"_PRCP("I")_",1)",PRCPLOCK(2)="^PRCP(445,"_PRCPSRC1_",1)" D LOCK^PRCPU4(.PRCPLOCK,1,10) G:'$D(PRCPLOCK) TOP
 W !,"INVENTORY POINTS LOCKED.  OTHER JOBS WILL NOT BE ABLE TO ACCESS INVENTORY",!,"POINTS UNTIL POSTING IS COMPLETED."
 I $P($G(^PRCS(410,PRCPDA,9)),"^",3)'="" W !!,"*** THIS TRANSACTION NUMBER WAS JUST MADE A 'FINAL' ***" D LOCK^PRCPU4(.PRCPLOCK,0,0) G TOP
 D RETRIEVE^PRCPWPO2,GETITEMS^PRCPWPO2,LOCK^PRCPU4(.PRCPLOCK,0,0) K ^TMP($J),ZTSK,PRCPFLAG G TOP
 ;
 ;
DICW ;     |-> write identifier for item
 ;  reference global ^prcs(410,da,0) from fileman
 N %,A,B S %=^(0),B=$G(^PRC(441,+$P(%,U,5),0)) W ?7," ",$P(B,U,5)," (#",+$P(%,U,5),")",?35," QTY.ORD: ",+$P(%,U,2),?50," QTY.DIS: ",+$P(%,U,PRCPNODE),?65 I $P(%,U,14)="" S A=$P(%,"^",2)-$P(%,U,PRCPNODE) S:A<0 A=0 W " QTY.OUT: ",A
 E  S %=$P(%,U,14) S A=$S(%["C":" CANCEL",1:"")_$S(%["S":" SUBST",1:"") W A
 I $D(DZ),DZ["??" W !?7," ",$P(B,U,2)
 Q
