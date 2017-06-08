PRCPEAAP ;WISC/RFJ-adjustment approval ;17 Apr 92
 ;;4.0;IFCAP;;9/23/93
 ;
 ;     |-> option to approve adjustments.
 ;
 D ^PRCPUSEL Q:'$D(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 N %,%H,%I,ADJNO,COUNT,D,D0,DA,DATA,DI,DIC,DIE,DR,DQ,ITEMDA,NOW,NOWDT,PRCPFLAG,UNAPPR,X,Y
 S IOP="HOME" D ^%ZIS K IOP
 ;
ADJ ;     |-> get adjustment number, quit if no adjustment is selected.
 ;
 D ADJUSTNO I ADJNO["^" K ^TMP($J,"PRCPADJ") Q
 ;
 ;     |-> get a list of unapproved adjustments and store in tmp global.
 ;
 K ^TMP($J,"PRCPADJ") S (DA,UNAPPR)=0
 F  S DA=$O(^PRCP(445.2,"T",PRCP("I"),ADJNO,DA)) Q:'DA  S DATA=$G(^PRCP(445.2,DA,0)) I $P(DATA,"^",5) S ^TMP($J,"PRCPADJ","ITEM",$P(DATA,"^",5))=DA S:'$P(DATA,"^",20) UNAPPR=UNAPPR+1,^TMP($J,"PRCPADJ","UNAPPR",$P(DATA,"^",5),DA)=""
 W !!?10,">> THERE IS '",UNAPPR,"' UNAPPROVED ITEMS ON THIS ADJUSTMENT. <<"
 ;
 ;     |-> approve **all** items for the selected adjustment.
 ;
 D NOW^%DTC S (Y,NOWDT)=% X ^DD("DD") S NOW=Y
 I UNAPPR D  I $D(PRCPFLAG) K ^TMP($J,"PRCPADJ") G ADJ
 .   S XP="  DO YOU WANT TO APPROVE ALL OF THE ITEMS ON THIS ADJUSTMENT",XH="  ENTER 'YES' TO APPROVE ALL THE ITEMS ON THE ADJUSTMENT, 'NO' TO SELECT ITEMS.",%=2 W ! D YN^PRCPU4 I %<0 S PRCPFLAG=1 Q
 .   I %=2 Q
 .   W !!?10,"approving adjustment items"
 .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPADJ","UNAPPR",ITEMDA)) Q:'ITEMDA  S DA=0 F  S DA=$O(^TMP($J,"PRCPADJ","UNAPPR",ITEMDA,DA)) Q:'DA  I $D(^PRCP(445.2,DA,0)) D
 .   .   D LOCKITEM("+",DA) I $G(PRCPFLAG) K PRCPFLAG Q
 .   .   S DATA=^PRCP(445.2,DA,0) I $P(DATA,"^",20)="" W "." S $P(DATA,"^",20)=NOWDT,$P(DATA,"^",21)=DUZ,^(0)=DATA
 .   .   D LOCKITEM("-",DA) K ^TMP($J,"PRCPADJ","UNAPPR",ITEMDA,DA)
 .   I $O(^TMP($J,"PRCPADJ","UNAPPR",0)) D  K PRCPFLAG Q
 .   .   W !!?10,">> ANOTHER USER WAS EDITING THE FOLLOWING ITEMS:"
 .   .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPADJ","UNAPPR",ITEMDA)) Q:'ITEMDA  W !?15,"ITEM NUMBER: ",ITEMDA
 .   .   W !?10,">> YOU WILL NEED TO GO BACK APPROVE THESE ITEMS ! <<"
 .   W !!?10,">> ALL ITEMS ON ADJUSTMENT HAVE BEEN APPROVED. <<" S PRCPFLAG=1
 ;
ITEM ;     |-> aprrove items as selected.  only selection of items from the
 ;     |-> selected adjustment number.  quit if no item is selected.
 ;
 W ! D ITEM^PRCPEAD2 I ITEMDA["^" K ^TMP($J,"PRCPADJ") G ADJ
 S DA=^TMP($J,"PRCPADJ","ITEM",ITEMDA)
 D LOCKITEM("+",DA) I $G(PRCPFLAG) K PRCPFLAG W !!?10,">> ANOTHER USER IS EDITING THIS ITEM. <<" G ITEM
 S DATA=^PRCP(445.2,DA,0),DR="20  ADJUSTMENT APPROVAL" I $P(DATA,"^",20)="" S DR=DR_"//"_NOW
 E  W !!?10,">> ITEM ADJUSTMENT HAS ALREADY BEEN APPROVED, '@' FOR UNAPPROVED. <<"
 S DIE="^PRCP(445.2," D ^DIE K DIE
 S DATA=^PRCP(445.2,DA,0) I $P(DATA,"^",20),'$P(DATA,"^",21) S $P(^(0),"^",21)=DUZ,$P(DATA,"^",6)=DUZ
 I '$P(DATA,"^",20),$P(DATA,"^",21) S $P(^(0),"^",21)=""
 D LOCKITEM("-",DA)
 G ITEM
 ;
 ;
 ;
LOCKITEM(V1,V2) ;     |-> lock item (v1=+) or unlock register entry (v1=-)
 ;     |-> v2 = entry to lock or unlock.
 ;     |-> returns $g(prcpflag) if unsucessful.
 ;
 K PRCPFLAG I V1'="+" L -^PRCP(445.2,V2,0) Q
 L +^PRCP(445.2,V2,0):10 I '$T S PRCPFLAG=1
 Q
 ;
 ;
 ;
ADJUSTNO ;     |-> select adjustment number from file 445.2.
 ;     |-> returns variable adjno.
 ;     |-> adjno=^ if no adjustment number is selected.
 K PRCPFLAG,ADJNO W !!,"Select ADJUSTMENT NUMBER: " R X:DTIME S:'$T X="^" I X["^"!(X="") S ADJNO="^" Q
 S:$E(X) X="A"_X
 I $E(X)="A",$D(^PRCP(445.2,"T",PRCP("I"),X)) S ADJNO=X Q
 W !,"Select the ADJUSTMENT NUMBER from the list below:",!
 S COUNT=0,X="A" F  S X=$O(^PRCP(445.2,"T",PRCP("I"),X)) Q:$E(X)'="A"!($G(PRCPFLAG))  D
 .   W "  ADJUSTMENT NUMBER: ",X S COUNT=COUNT+1
 .   I COUNT#20=0 D P^PRCPU4 W $C(13),"                                                                               "
 .   W !
 G ADJUSTNO
