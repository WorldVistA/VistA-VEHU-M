PRCAEIN ;SF-ISC/YJK-EDIT INCOMPLETE ACCOUNTS RECEIVABLE ;10/17/96  1:07 PM
V ;;4.5;Accounts Receivable;**57,67,153,371**;Mar 20, 1995;Build 29
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;This edits incomplete accounts receivable. The account is classified
 ;with category.
 ;
 ;===================== EDIT INCOMPLETE AR ===========================
EDIN ;edit incomplete accounts receivable.
 K PRCA("CKSITE") D CKSITE G:'$D(PRCA("CKSITE")) END S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I Z0=101"
 D DIC^PRCAUDT G:'$D(PRCABN) END S PRCADIOK=0,PRCA("MESS1")="THE ACCOUNT IS STILL INCOMPLETE",PRCA("MESS2")="*** EDITED AND RELEASED TO ACCOUNTING TECHNICIAN ***"
 K PRCADINO D EDT I $G(PRCABN),$P(^PRCA(430,PRCABN,0),U,8)=$O(^PRCA(430.3,"AC",102,0)) D PREPAY^RCBEPAYP(PRCABN)
 D KILLV G EDIN
EDT D DIE I $D(PRCADINO),($P(^PRCA(430,PRCABN,0),U,2)="")!($P(^(0),U,9)="") S PRCADEL=1 Q
 ;DIS
 I $D(PRCADINO) W !!,*7,PRCA("MESS1"),!! Q
DIP S PRCAT=+$P(^PRCA(430,PRCABN,0),U,2) D:$P(^PRCA(430.2,PRCAT,0),U,3)>0 SEGMT^PRCAEOL S PRCAT=$S($D(^PRCA(430.2,PRCAT,0)):$P(^(0),U,6),1:"") D DISPL,DISPLACC^PRCAFUT S PRCAOK=0 D ASK1 G:$D(PRCA("EXIT")) DIP1
 I PRCAOK=1 G:'$D(PRCANM) DIP1 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,"")),PRCA("SDT")=DT D  D UPSEG^PRCAUDT,UPSTATS^PRCAUT2 Q
   . I $$ACCK^PRCAACC(PRCABN) D ASTAT Q
   . D EN^PRCAFBD(PRCABN,.ERR)
   . I +ERR>0 D  Q
   .. W !!,*7,"Error creating FMS Billing Document:",!,?10,$P(ERR,U,2),!,"Bill status remains 'NEW BILL'",!!
   .. S PRCA("STATUS")=$O(^PRCA(430.3,"AC",104,""))
   ..Q
   . S PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,""))
   . Q
 D ASK2 I PRCAOK=1 D DIE G DIP
DIP1 W !!,PRCA("MESS1"),! D KILLV Q  ;end of EDIN
ASTAT ;Set status for accrued bills
 S PRCA("DEBTOR")=$P(^PRCA(430,PRCABN,0),"^",9) Q:PRCA("DEBTOR")=""
 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",102,"")),PRCA("MESS2")="** ACCRUED BILL, STATUS IS NOW ACTIVE **" Q
KILLV L -^PRCA(430,+$G(PRCABN))
 K PRCADIOK,PRCADEL,DIC,DR,DIE,PRCAT,PRCAGLN,PRCA("CKSITE"),PRCADINO,PRCAOK,PRCA("MESS1"),PRCA("MESS2"),PRCA("EXIT"),PRCABN,PRCAT,PRCANM,PRCADEL,PRCATY,Z1,ZZ,J,D0,D1,PRC Q
END D KILLV K PRCA Q
 ;======================= SUBROUTINES ================================
DIE K PRCAT W ! S DA=PRCABN,DIC="^PRCA(430,",PRCA("LOCK")=0 D LOCKF^PRCAWO1 Q:PRCA("LOCK")=1  S DIE=DIC,DR="[PRCA CAT SET]" D ^DIE K DR,DIE,DA
 I ($P(^PRCA(430,PRCABN,0),U,2)="")!($D(Y)) W:$P(^(0),U,2)="" !,*7,"  You should enter a category.",! S PRCADINO="" Q
 S PRCAT=$P(^PRCA(430.2,+$P(^PRCA(430,PRCABN,0),U,2),0),U,6),PRCAGLN=$P(^(0),U,4) S:$P(^(0),U,7)=24 PRCAT("C")=1
D1 S DIE="^PRCA(430,",DA=PRCABN,DR="[PRCA SET]" D ^DIE I $D(Y) S PRCA("EXIT")="",PRCADINO="" Q
 D MTIFY I $D(PRCA("EXIT")) S PRCADIN0="" Q
 K DR D:'$$ACCK^PRCAACC(PRCABN) CPLK^PRCAFUT(PRCABN) I $D(PRCA("EXIT")) S PRCADINO="" Q
 D COMMENTS^PRCAUT3 I $D(PRCA("EXIT")) S PRCADINO="" Q
 I +$P(^PRCA(430,PRCABN,0),U,5)'>0 W !,*7,?3,"The 'Bill Resulting From' input does not exist.",! S PRCADINO="" Q
 Q
DISPL ;display the accounts receivable data user has entered.
 Q:'$D(PRCABN)  I '$D(IOF) S IOP="" D ^%ZIS
 W @IOF S D0=PRCABN K ^UTILITY($J,"W"),DXS D ^PRCATO2,WOBIL^PRCAUDT1 K DXS Q
ASK2 S %=2 W !!,"DO YOU WANT TO EDIT THE DATA" D YN^DICN I %=0 D M2^PRCAMESG G ASK2
 Q:%'=1  S PRCAOK=1 Q
ASK1 S %=2 W !!,"IS THIS DATA CORRECT" D YN^DICN I %<0 S PRCA("EXIT")="" Q
 I %=0 D M1^PRCAMESG G ASK1
 Q:%'=1  S PRCAOK=1,DA=PRCABN D SIG^PRCASIG,NOW^%DTC
 I $D(PRCANM) D ORAMT S PRCANM=$P($G(^VA(200,DUZ,20)),"^",2) D EN^PRCASIG(.PRCANM,DUZ,DA_+$P(^PRCA(430,PRCABN,0),U,3)) S $P(^PRCA(430,PRCABN,9),U,1,3)=+DUZ_U_PRCANM_U_%
 Q
CKSITE ;check site parameter and user number.
 D:'$D(PRCA("SITE")) CKSITE^PRCAUDT
 I ('$D(PRCA("SITE"))) Q
 S PRCA("CKSITE")=1 Q
DELETE ;delete new AR without category and debtor field.
 S PRCACOMM="USER CANCELED" D DELETE^PRCABIL4 K PRCACOMM
 W *7,!,"The entry has been deleted!",! Q
ORAMT ;Update original amount.
 Q:'$D(^PRCA(430,PRCABN,2))  S PRCAMT=0,PRCAORA=0
 F Z0=0:0 S PRCAORA=$O(^PRCA(430,PRCABN,2,PRCAORA)) Q:+PRCAORA'>0  S PRCAMT=PRCAMT+$P(^(PRCAORA,0),U,2)
 N PRCFDA S $P(^PRCA(430,PRCABN,0),U,3)=PRCAMT,PRCFDA(430,PRCABN_",",71)=PRCAMT D FILE^DIE(,"PRCFDA") ; PRCA*4.5*371 - Replace direct global sets in 7 node with FileMan calls so indexes get updated
 K Z0,PRCAORA,PRCAMT Q
RESULT Q:'$D(PRCABN)
 I $P(^PRCA(430,PRCABN,0),U,5)>0,$D(^PRCA(430.6,+$P(^(0),U,5),0)) W !!,"BILL RESULTING FROM: ",$P(^(0),U,2) Q
 Q
MTIFY ;CHECK TO SEE IF ONE FY IS ENTERED PER BILL
 N DA,DIE,DR,PRCAI,PRCAMT,PRCAMT1
MTCHK S PRCAMT1=0 F PRCAI=0:0 S PRCAI=$O(^PRCA(430,PRCABN,2,PRCAI)) Q:'PRCAI  S PRCAMT=+$P($G(^(PRCAI,0)),"^",8)  I PRCAMT S PRCAMT1=PRCAMT1+1
 I PRCAMT1=1 G MTIFYQ
 W !!,?3,"** Currently, just one Fiscal Year amount is sent to FMS."
 W !,?3,"** Please enter just one Fiscal Year for this bill. (",PRCAMT1,") entered",!!
 S DIE="^PRCA(430,",DA=PRCABN,DR="1",DR(2,430.01)=".01;7" D ^DIE
 G MTCHK
MTIFYQ Q
