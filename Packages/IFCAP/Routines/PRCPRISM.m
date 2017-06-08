PRCPRISM ;WISC/RFJ-isms descrepancy report ;28 Jan 92
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"THIS OPTION CAN ONLY BE USED BY THE WAREHOUSE INVENTORY POINT." Q
 N WHSESRCE,X,Y S WHSESRCE=+$O(^PRC(440,"AC","S",0)) I 'WHSESRCE W !!,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE." Q
 W !! F %=1:1 S X=$P($T(TEXT+%),";",3,99) Q:X=""  W !,X
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="ISMS SKU Inventory Item Check",ZTRTN="DQ^PRCPRISM"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("WHSE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;queue comes here
 N %,%I,ERROR,ITEMDA,NOW,PAGE,PRCPFLAG,SCREEN,X,Y
 K ^TMP($J,"ERROR") D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D CHECK(PRCP("I"),ITEMDA,WHSESRCE) I $D(ERROR) S ^TMP($J,"ERROR",ITEMDA)=ERROR
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"ERROR",ITEMDA)) Q:'ITEMDA!($D(PRCPFLAG))  S ERROR=^(ITEMDA) D
 .   S X=$P($T(ERROR+ERROR),";",3,99)
 .   S Y="" I ERROR=5!(ERROR=6) S %=$G(^TMP($J,"ERROR",ITEMDA,"E")),Y="SKU: "_$P(%,"^")_"    UI: "_$P(%,"^",2)
 .   I ERROR=6 S Y=Y_"    UP: "_$P(%,"^",3)
 .   W !!,ITEMDA,?7,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,25),?36,"** ",$P(X,";"),?78,"**" W:Y'="" !?7,Y I $P(X,";",2)'="" W:$X>79 ! W ?36,"** ",$P(X,";",2),?78,"**"
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPU4 Q:$D(PRCPFLAG)  D H
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I '$O(^TMP($J,"ERROR",0)) W !!?20,">> NO PROBLEMS FOUND <<"
 I '$D(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"ERROR") Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ISMS ITEM CHECK FOR INVENTORY POINT: ",$E(PRCP("IN"),1,12),?(80-$L(%)),%
 S %="",$P(%,"-",81)="" W !,"MI#",?7,"DESCRIPTION",?36,"**  ERROR",?78,"**",!,%
 Q
 ;
CHECK(V1,V2,V3) ;check item v1 in inventory point v2; v3=whsesrce in file 440
 N DATA,DATA1,DATA2,NSN,SKU,UI,UP
 K ERROR,^TMP($J,"ERROR",+V2,"E") S DATA=$G(^PRC(441,+V2,0)) I DATA="" S ERROR=1 Q
 S DATA1=$G(^PRCP(445,+V1,1,+V2,0)) I DATA1="" S ERROR=2 Q
 S DATA2="" I $P(DATA,"^",8)=V3 S DATA2=$G(^PRC(441,V2,2,V3,0)) I DATA2="" S ERROR=3 Q
 S NSN=$P(DATA,"^",5) I NSN="" S ERROR=4 Q
 S SKU=$P($$UNITVAL^PRCPUX1(0,$P($G(^PRC(441,V2,3)),"^",8),"^"),"^",2),UI=$P($$UNITVAL^PRCPUX1(0,$P(DATA1,"^",5),"^"),"^",2) S:UI="" UI="__"
 I SKU'=UI S ERROR=5,^TMP($J,"ERROR",V2,"E")=SKU_"^"_UI Q
 I DATA2'="" S UP=$P($$UNITVAL^PRCPUX1(0,$P(DATA2,"^",7),"^"),"^",2) S:UP="" UP=".." I UP'=SKU S ERROR=6,^TMP($J,"ERROR",V2,"E")=SKU_"^"_UI_"^"_UP Q
 Q
 ;
TEXT ;;display info text
 ;;This option will loop through the items in your inventory and verify
 ;;that the data requested by ISMS has been correctly entered for each
 ;;item.  If an item has data which is missing or inaccurate, it will
 ;;be displayed on the printout.
 ;;
ERROR ;;error messages
 ;;ITEM NOT FOUND IN ITEM MASTER FILE (441)
 ;;ITEM NOT FOUND IN INVENTORY POINT (445)
 ;;MANDATORY SOURCE IS WHSE, WHSE IS NOT;DEFINED AS A VENDOR IN FILE 441
 ;;ITEM DOES NOT HAVE AN NSN ENTERED
 ;;SKU DOES NOT EQUAL UNIT OF ISSUE
 ;;SKU DOES NOT EQUAL UNIT OF PURCHASE
