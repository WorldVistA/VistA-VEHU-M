PRCPEADP ;WISC/RFJ-print register for adjustment ;15 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
PRINT ;print register for selected item and store specific data
 N PRCPDA
 K ^TMP($J,"PRCPADJ","LOG")
 D HDR S (PRCPDA,TOTREC,TOTADJ,VOUCHER)=0 F  S PRCPDA=$O(^TMP($J,"PRCPADJ","ITEM",ITEMDA,PRCPDA)) Q:'PRCPDA  S DATA=^(PRCPDA) D
 .   S Y=$P($P(DATA,"^",17),".") X ^DD("DD")
 .   W !,$P(DATA,"^",2),?10,Y,?22,$J($P(DATA,"^",7),8),$J($P(DATA,"^",6),10),$J($P(DATA,"^",22),14,3),$J($P(DATA,"^",23),14,3),?70,$E($$INVNAME^PRCPUX1($P(DATA,"^",18)),1,9)
 .   I $P(DATA,"^",15)'="",'$D(^TMP($J,"PRCPADJ","LOG",$P(DATA,"^",15))) S ^($P(DATA,"^",15))="",VOUCHER=VOUCHER+1
 .   I $E($P(DATA,"^",4))="R" S TOTREC=TOTREC+$P(DATA,"^",7)
 .   I $P(DATA,"^",4)="A" S TOTADJ=TOTADJ+$P(DATA,"^",7)
 .   I $Y>(IOSL-4) D R^PRCPU4,HDR
 W !!,"TOTAL QTY ",TRANTYPE,?18,": ",$J(TOTREC,10),!,"TOTAL QTY ADJUSTED: ",$J(TOTADJ,10)
 Q
 ;
 ;
HDR ;print display header
 W @IOF,TRANTYPE,": ",TRANNO,!?3,"ITEM NUMBER: ",ITEMDA,?23,$E(ITEMDESC,1,30),?58,"NSN: ",ITEMNSN
 W !?3,"CURRENT ON-HAND QUANTITY: ",+$P(ITEMDATA,"^",7),"     UNIT per ISSUE: ",UNIT
 S %="",$P(%,"-",81)="" W !,"TRANID",?10,"DATE",?22,$J("QUANTITY",8),$J("PKG",10),$J("TOT INV $",14),$J("TOT SELL $",14),?70,"OTH INVPT",!,%
 Q
