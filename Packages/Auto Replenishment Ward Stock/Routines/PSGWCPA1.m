PSGWCPA1 ;BHAM ISC/PTD,CML-Print Cost Per AOU Report for Selected Date Range - CONTINUED ; 13 Jan 97 / 9:24 AM
 ;;2.3;Automatic Replenishment/Ward Stock ;**9,21**;4 JAN 94;Build 6
EN1 S AOU=0,PGCT=1,OUT=0,HFLG=0,$P(LN,"-",80)="" I '$O(^TMP("PSGWCPA",$J,0)) D HDR W !,LN,!?5,"NO COST DATA FOUND FOR SELECTED DATE RANGE." G DONE
AOULP S (AOUQD,AOUCST,INACTOT)=0 K WRDDA S AOU=$O(^TMP("PSGWCPA",$J,AOU)) D:('AOU)&(AOUCNT>1)&($O(^TMP("PSGWCPA",$J,"SMWD",0))]"") SMRY G:OUT END G:'AOU DONE
 D HDR G:OUT END D:FLG=1 SUB1 D:FLG=2 SUB2 W !?7,"==> ",$P(^PSI(58.1,AOU,0),"^") S DRG=0
DRGLP S DRG=$O(^TMP("PSGWCPA",$J,AOU,DRG)) G:DRG="" WRTOT S LOC=^TMP("PSGWCPA",$J,AOU,DRG)
 I FLG=1 S:$Y>(IOSL-6) HFLG=1 D:HFLG HDR G:OUT END D:HFLG SUB1 S HFLG=0 W !?5,DRG,?46,$J($P(LOC,"^"),8,0),?64,$S($P(LOC,"^",2)'="NO DATA":$J($P(LOC,"^",2),10,2),1:"DATA MISSING")
 S AOUQD=AOUQD+$P(LOC,"^") I $P(LOC,"^",2)'="NO DATA" S AOUCST=AOUCST+$P(LOC,"^",2) G DRGLP
 E  S INACTOT=1 G DRGLP
 ;
WRTOT W !?44 F J=1:1:31 W "-"
 W !?39,"TOTAL",?46,$J((AOUQD),8,0),?64,$S(INACTOT=1:"INCOMPLETE",1:$J((AOUCST),10,2)),!!
 I '$O(^PSI(58.1,AOU,2,0))!(INACTOT=1) G AOULP
 D BRKDN G:OUT END G AOULP
 ;
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST)="C" W !!,"Press RETURN to continue: " R AUTO:DTIME
 ;PSGW*2.3*21 add PSGWCNM to kill list
END K PSGWCNM,ALL,AOU,AOUCST,AOUQD,BDT,DRG,DRGCST,DRGDA,DRGNAME,DRGNM,DRGQD,CST,EDT,FLG,GRTOT,HFLG,INACTOT,INC,INVDA,INVDT,INVN,J,JJ,SEL,IGDA,L,LN,LOC,LOC1,LOC2,LOCSR,LOCWD,ODA,ODT,PGCT,PRCNT,PRCT,IO("Q"),ZTSK,Y,JJ,AOUCNT,AOULP,AUTO,OUT
 K QD,SRNAM,SRLOC,SV,VAR,WDNAM,WDLOC,WD,RETDT,SRV,SRVDA,WARD,WDN,WRDA,WRDDA,PSGWIO,TAB,^TMP("PSGWCPA",$J),ZTSK,ZTIO,G,%,%I,%H D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
HDR ;PRINT REPORT MAIN HEADER
 I $E(IOST)="C"&(PGCT>1) S DIR(0)="E" D ^DIR K DIR I Y'=1 S OUT=1 Q
 W:$Y @IOF W !?5,"COST REPORT FROM " S Y=BDT X ^DD("DD") W Y," TO " S Y=EDT X ^DD("DD") W Y,?70,"PAGE ",PGCT I $D(SEL),SEL="I",$D(IGDA) W !?5,"FOR INVENTORY GROUP - ",$P(^PSI(58.2,IGDA,0),"^")
 W !!?53,"DATE: ",$$PSGWDT^PSGWUTL1 S PGCT=PGCT+1
 Q
 ;
SUB1 W !?11,"AREA OF USE",!?46,"QUANTITY",!?5,"ITEM",?45,"DISPENSED",?67,"COST",!,LN
 Q
SUB2 W !!?46,"QUANTITY",!?11,"AREA OF USE",?46,"DISPENSED",?67,"COST",!,LN
 Q
 ;
BRKDN ;PRINT THE COST PER WARD AND COST PER SERVICE BREAKDOWN
WARD D:$Y>(IOSL-20) HDR Q:OUT  W !?5,$P(^PSI(58.1,AOU,0),"^"),?29,"COST PER WARD/LOCATION",!!?23,"WARD/LOC",?45,"% OF TOTAL",?60,"COST",!,"             " F J=1:1:54 W "-"
 W ! S WRDA=0
WRDLP S WRDA=$O(^PSI(58.1,AOU,2,WRDA)) G:'WRDA SERV S (LOCWD,WRDDA(WRDA))=^PSI(58.1,AOU,2,WRDA,0),WARD=$P(LOCWD,"^"),PRCNT=$P(LOCWD,"^",2)
 F J=1:1:2 I $P(LOCWD,"^",J)="" W !,"WARD/LOCATION DATA MISSING" Q
 S WDNAM=$P(^SC(WARD,0),"^") W !?14,WDNAM,?48,$J(PRCNT,3),?57,$J(((PRCNT/100)*AOUCST),10,2)
 S WDLOC=($S($D(^TMP("PSGWCPA",$J,"SMWD",WDNAM)):^(WDNAM),1:0)+((PRCNT/100)*AOUCST)),^(WDNAM)=WDLOC G WRDLP
 ;
SERV W !!!!?33,"COST PER SERVICE",!?16,"WARD/LOC",!?24,"SERVICE",?44,"% OF WARD/LOC",?60,"COST",!,"             " F J=1:1:54 W "-"
 S WDN=0
WD S WDN=$O(WRDDA(WDN)) Q:'WDN  W !!?14,$P(^SC($P(WRDDA(WDN),"^"),0),"^"),":"
 I '$O(^PSI(58.1,AOU,2,WDN,1,0)) W !!?16,"NO SERVICES LISTED FOR WARD/LOCATION." Q
 S SRVDA=0
SRLP S SRVDA=$O(^PSI(58.1,AOU,2,WDN,1,SRVDA)) G:'SRVDA WD S LOCSR=^PSI(58.1,AOU,2,WDN,1,SRVDA,0) F J=1:1:2 I $P(LOCSR,"^",J)="" W !,"SERVICE DATA MISSING" Q
 S SRV=$P(LOCSR,"^"),PRCT=$P(LOCSR,"^",2),SRNAM=$P(^DIC(42.4,SRV,0),"^") W !?16,SRNAM,?48,$J(PRCT,3),?57,$J(((PRCT/100)*(($P(WRDDA(WDN),"^",2)/100))*AOUCST),10,2)
 S SRLOC=$S($D(^TMP("PSGWCPA",$J,"SMSRV",SRNAM)):^(SRNAM),1:0)+(((PRCT/100)*(($P(WRDDA(WDN),"^",2)/100))*AOUCST)),^(SRNAM)=SRLOC G SRLP
 ;
SMRY ;PRINT SUMMARY PAGES - COST BY WARD & COST BY SERVICE
 Q:$O(^TMP("PSGWCPA",$J,"SMWD",0))=""  S VAR="WARD/LOCATION",(GRTOT,WD,SV)=0 D HDR Q:OUT  D SUB3
 F L=0:0 S WD=$O(^TMP("PSGWCPA",$J,"SMWD",WD)) Q:WD=""  S CST=^(WD),GRTOT=GRTOT+CST W !?5,WD,?45,$J(CST,8,2)
 D TOTLN S VAR="SERVICE",GRTOT=0 D HDR Q:OUT  D SUB3
 F J=0:0 S SV=$O(^TMP("PSGWCPA",$J,"SMSRV",SV)) Q:SV=""  S CST=^(SV),GRTOT=GRTOT+CST W !?5,SV,?45,$J(CST,8,2)
 D TOTLN Q
 ;
SUB3 W !!?27,"COST BY ",VAR," SUMMARY",!!?15,VAR,?48,"COST",! F J=1:1:80 W "-"
 Q
 ;
TOTLN W !!?40 F J=1:1:20 W "=" S TAB=$S(VAR="SERVICE":15,1:9)
 W !,?TAB,"TOTAL FOR ALL ",VAR,"S:",?45,$J(GRTOT,8,2)
 Q
