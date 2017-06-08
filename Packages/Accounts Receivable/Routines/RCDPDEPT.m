RCDPDEPT ;WISC/RFJ-deposit (process) a deposit ticket ;1 Oct 97
 ;;4.5;Accounts Receivable;**90**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  called by menu option PRCA DEPOSIT MONEY
 W !!,"This option will allow you to mark a deposit as processed and send the CR"
 W !,"document to FMS."
 ;
 N %,DEPOSDA,ERROR
 ;
 F  D  Q:'DEPOSDA
 .   ;  select the deposit ticket      add to prompt, default ticket
 .   W ! S DEPOSDA=$$GETDEPOS(" to DEPOSIT",$P($G(^RCY(344.1,+$O(^RCY(344.1,"AC",1,0)),0)),"^"))
 .   I 'DEPOSDA Q
 .   ;
 .   I $P(^RCY(344.1,DEPOSDA,0),"^",12)'=1 W !,"*** This ticket number is not in an 'OPEN' status ***" Q
 .   ;
 .   S ERROR=$$CHECK(DEPOSDA)
 .   I ERROR<0 S DEPOSDA=0 Q  ; ^ pressed, exit routine
 .   I ERROR Q                ; errors still on deposit ticket
 .   ;
 .   ;  no errors, ask to process
 .   S %=$$ASKOKAY(0)
 .   I %<0 S DEPOSDA=0 Q
 .   I %'=1 Q
 .   ;
 .   ;  lock the deposit
 .   L +^RCY(344.1,DEPOSDA):5
 .   I '$T W !,"This DEPOSIT is currently being edited by another user." Q
 .   ;
 .   ;  set bank deposit date (.03), deposited by (.08),
 .   ;  deposit date/time (.09), and status (.12) to 2 deposited
 .   S %=$$SETDEPOS(DEPOSDA,".03////^S X="_$P($G(^RCY(344.1,DEPOSDA,0)),"^",2)_";.08////^S X=DUZ;.09///^S X=""NOW"";.12////^S X=2;")
 .   W !,"Deposit Ticket Approved for Deposit."
 .   ;
 .   D STARTCR^RCXFMSCR(DEPOSDA)
 .   L -^RCY(344.1,DEPOSDA,0)
 Q
 ;
 ;
CHECK(DEPOSDA) ;  check a deposit for required fields
 ;  will return 0 for no errors, 1 for errors, -1 for errors and halt
 ;
 N DATA,ERROR,PIECE,RECDA,RESULT,STOPFLAG
 ;
 ;  show the deposit data
 D VDEP^RCDPVW(DEPOSDA)
 ;
 ;  display message if no receipts for deposit
 I '$O(^RCY(344,"AD",DEPOSDA,0)) W !,"N O T E, there are NO RECEIPTS for this deposit ticket."
 ;
 ;  check to make sure all receipts are closed, if not quit w/ error
 S ERROR=0
 S RECDA=0 F  S RECDA=$O(^RCY(344,"AD",DEPOSDA,RECDA)) Q:'RECDA  D
 .   I $P(^RCY(344,RECDA,0),"^",14) W !,"ERROR: Receipt # '",$P(^(0),"^"),"' is not closed." S ERROR=1
 I ERROR Q 1
 ;
 ;  check fields
 S STOPFLAG=0 F  D  Q:STOPFLAG
 .   ;  ask to edit deposit ticket
 .   S %=$$ASKEDIT(1)
 .   I %<0 S RESULT=-1,STOPFLAG=1 Q  ; ^ pressed
 .   ;  edit the deposit ticket, quit if ^ pressed
 .   I %=1 S %=$$SETDEPOS(DEPOSDA,"[RCDP TICKET DEPOSIT]") I '% S RESULT=-1,STOPFLAG=1 Q
 .   ;
 .   ;  loop through the fields and check the data
 .   S ERROR=0,DATA=$G(^RCY(344.1,DEPOSDA,0))
 .   F PIECE=1,2,4,6,7 I $P(DATA,"^",PIECE)="" D
 .   .   W !,"ERROR: missing data in required field: ",$P("TICKET #^DATE PRESENTED TO BANK^AMOUNT OF DEPOSIT^OPENED BY^DATE/TIME OPENED","^",PIECE)
 .   .   S ERROR=1
 .   ;
 .   ;  no errors found
 .   I 'ERROR S RESULT=0,STOPFLAG=1 Q
 ;
 Q RESULT
 ;
 ;
GETDEPOS(ADDPROMP,DEFAULT) ;  select the deposit ticket
 ;  addpromp = add to prompt, default = default selection
 ;  returns ien or 0 for no selection
 N %,%Y,C,DATA0,DDC,DIC,DTOUT,DUOUT,X,Y
 S DIC(0)="QEAMN",DIC="^RCY(344.1,"
 S DIC("A")="Select DEPOSIT TICKET NUMBER"_$G(ADDPROMP)_": "
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 D ^DIC
 I Y<0 S Y=0
 Q +Y
 ;
 ;
SETDEPOS(DEPOSDA,DR) ; set fields in dr for deposit
 ;  returns 1 for success, 0 for ^
 N %,%DT,D0,DI,DIC,DIE,DQ,DA,X
 I '$D(^RCY(344.1,DEPOSDA,0)) Q 0
 S (DIC,DIE)="^RCY(344.1,",DA=DEPOSDA
 D ^DIE
 I $D(Y) Q 0
 Q 1
 ;
 ;
ASKOKAY(YESNO) ;  ask if its the correct deposit
 ;  pass yesno equal to the default answer, 1 is yes, otherwise no
 N DIR,X,Y
 S DIR(0)="YO",DIR("B")=$S(YESNO=1:"YES",1:"NO")
 S DIR("A")="  Is this DEPOSIT TICKET okay to PROCESS"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKEDIT(YESNO) ;  ask if okay to edit deposit
 ;  pass yesno equal to the default answer, 1 is yes, otherwise no
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")=$S(YESNO=1:"YES",1:"NO")
 S DIR("A")="  Do you want to edit the DEPOSIT TICKET"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
