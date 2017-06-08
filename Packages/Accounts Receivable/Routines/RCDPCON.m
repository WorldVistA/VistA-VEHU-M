RCDPCON ;WASH-ISC@ALTOONA,PA/RGY-CONFIRM A DEPOSIT TICKET ;8/26/96  10:49 AM
V ;;4.5;Accounts Receivable;**52,90**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CONF ;Select ticket to confirm
 NEW DIC
 F  S DIC="^RCY(344.1,",DIC(0)="QEAM",DIC("A")="Select TICKET NUMBER to CONFIRM: ",DIC("B")=$P($G(^RCY(344.1,+$O(^RCY(344.1,"AC",2,0)),0)),"^") D ^DIC Q:Y<0  D EDTR(+Y) Q:$D(DTOUT)
 Q
EDTR(TIC) ;Confirm a deposit
 NEW DIE,DIR,DIRUT,DUOUT,DIROUT,REC,ERR,X,Y,ZTLOAD,ZTRTN,ZTIO,ZTDESC
 I $P(^RCY(344.1,TIC,0),"^",12)'>2 W *7,!,"*** This ticket number was not 'DEPOSITED' ***",! Q
 I '$O(^RCY(344,"AD",TIC,0)) W *7,!,"*** WARNING: This deposit has no receipts associated with it ***",!
 S REC=0,ERR=0 F  S REC=$O(^RCY(344,"AD",TIC,REC)) Q:'REC  I $P(^RCY(344,REC,0),"^",14) W *7,!,"*** Receipt # '",$P(^(0),"^"),"' is not closed ***" S ERR=1
 I ERR W ! Q
BEG1 S DA=TIC,DR="[RCDP TICKET CONFIRM]",DIE="^RCY(344.1," D ^DIE
 I $D(Y)!($D(DTOUT)) Q
 S DIR(0)="SAO^0:NO;1:YES",DIR("B")="YES"
 S X=$G(^RCY(344.1,TIC,0))
 F Y=1:1:4,6:1:9 I $P(X,"^",Y)="" W *7," ... Required information not present!",! S DIR(0)="SAO^0:NO",DIR("B")="NO" Q
 D VDEP^RCDPVW(TIC)
 S DIR("A")="Is this OK? " D ^DIR K DIR
 I $D(DIRUT) W " ... No Action Taken!",! Q
 I Y=0 G BEG1
 S DIE="^RCY(344.1,",DA=TIC,DR=".1////^S X=DUZ;.11///^S X=""NOW"";.12////^S X=3" D ^DIE
 W !!?15,"... Deposit confirmation accepted"
 Q
