PRCPEAD0 ;WISC/RFJ-adjust inventory level ;14 Apr 92
 ;;4.0;IFCAP;;9/23/93
 ;
 ;     |-> option for adjusting the warehouse quantities on-hand.
 ;
 D ^PRCPUSEL Q:'$D(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 I $P($G(^PRCP(445,PRCP("I"),0)),"^",6)'="Y" W !,"THE WAREHOUSE MUST BE KEEPING A PERPETUAL INVENTORY." Q
 I $P($G(^PRCP(445,PRCP("I"),0)),"^",2)'="Y" W !,"THE WAREHOUSE MUST BE KEEPING A DETAILED TRANSACTION HISTORY." Q
 N %,%H,%I,D,DI,DISYS,DQ,ISMSFLAG,TYPE,X,Y
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
 S DIR(0)="SO^1:Correction of Receipt or Issue;2:Non-Issuable or Issuable Adjustment;3:Other Adjustment;",DIR("A")="Select TYPE of ADJUSTMENT"
 W ! D ^DIR K DIR I Y'=1,Y'=2,Y'=3 Q
 S TYPE=Y,IOP="HOME" D ^%ZIS K IOP
 S ISMSFLAG=$$ISMSFLAG^PRCPUX2(PRC("SITE"))
 I TYPE=1 D REVERSE^PRCPEAD1,Q Q
 I TYPE=2 D NONISSUE^PRCPEAI1,Q Q
 I TYPE=3 D OTHER^PRCPEAO1
Q K ^TMP($J,"PRCPADJ"),^TMP($J,"PRCPCALM"),^TMP($J,"STRING")
 Q
