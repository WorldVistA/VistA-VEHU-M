PRCPEAR1 ;WISC/RFJ-print register approval form (end of report) ;15 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
BUILD ;     |-> build tmp global for printing the report
 K ^TMP($J,"PRCPADJ","ITR")
 ;
 ;     |-> build selected adjustements only
 ;
 I $O(^TMP($J,"ADJ",""))'="" D  Q
 .   S TRANID="" F  S TRANID=$O(^TMP($J,"ADJ",TRANID)) Q:$E(TRANID)'="A"  D BUILD1
 ;
 ;     |-> build all adjustments
 ;
 S TRANID="A" F  S TRANID=$O(^PRCP(445.2,"T",PRCP("I"),TRANID)) Q:$E(TRANID)'="A"  D BUILD1
 Q
 ;
BUILD1 ;     |-> build tmp global with adjustment data
 ;
 S DA=0 F  S DA=$O(^PRCP(445.2,"T",PRCP("I"),TRANID,DA)) Q:'DA  S DATA=$G(^PRCP(445.2,DA,0)) I DATA'="" D
 .   I $P(DATA,"^",20)="" S ^TMP($J,"PRCPADJ","ITR",TRANID,DA)=""
 Q
 ;
 ;
END ;print end of report information
 W !!,"----------- S U M M A R Y   O F   I T E M   A C C O U N T   C O D E S ----------"
 S TOTAL=0,ACCT=0 F  S ACCT=$O(^TMP($J,"ACCT",ACCT)) Q:ACCT=""!$G(PRCPFLAG)  S DATA=^(ACCT) D
 .   I $X>40 W !
 .   E  W ?40
 .   W "ACCT: ",ACCT,?($S($X<10:10,1:50)),"INV AMOUNT: ",$J(DATA,12,2) S TOTAL=TOTAL+DATA
 .   I $Y>(IOSL-2),$X>40,$O(^TMP($J,"ACCT",ACCT))'="" D:$G(SCREEN) P^PRCPU4 Q:$D(PRCPFLAG)  D H^PRCPEAR0
 K ^TMP($J,"ACCT") I $D(PRCPFLAG) Q
 W !!,"TOTAL DOLLAR AMOUNT OF ADJUSTMENT (UNAPPROVED): ",$J(TOTAL,0,2)
 I $D(PRCPMSG) W !!,PRCPMSG
 I '$G(PRCPMULT) Q  ;all adjustments printed on same report
 K DATA F %=1:1 S DATA=$P($T(DATA+%),";",3,99) Q:DATA=""  S DATA(%)=DATA
 I $Y>(IOSL-%-2) D:$G(SCREEN) P^PRCPU4 Q:$D(PRCPFLAG)  D H^PRCPEAR0
 W ! S %=0 F  S %=$O(DATA(%)) Q:'%  W !,DATA(%)
 I $O(^TMP($J,"PRCPADJ","ITR",TRANID))'="" D:$G(SCREEN) P^PRCPU4 W @IOF
 S PAGE=0
 Q
 ;
 ;
DATA ;print signature at bottom of report
 ;;CERTIFICATION -- THE SUPPLIES LISTED ON THIS REQUEST HAVE BEEN PROPERLY
 ;;ADJUSTED BY QUANTITY AND VALUE.
 ;; 
 ;;ITEM NUMBERS APPROVED [#MI]:__________________________________________________
 ;; 
 ;;SIGNATURE ACCOUNTABLE OFFICER:________________________________________________
 ;; 
 ;;SIGNATURE APPROVING OFFICIAL:_________________________________________________
