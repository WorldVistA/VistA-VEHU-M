PSUC ;BHM ISC/DEB - Regular Report Output of D&PPM ; 01 Mar 94 / 9:03 AM
 ;;1.0; D&PPM ;;11 May 94
IV ;Print IV stuff
 K PAGE
 D:'$D(PSUSNDR(1)) SNDR^PSUB D HDR,IVHDR K PSU,CNT G IVDATA
IVHDR W @IOF,!,XMSUB S PAGE=$G(PAGE)+1 W ?(IOM-($L(PAGE)+6)),"Page: ",PAGE,!,?108,"Number",!,"Drug Name",?41,"Strength",?55,"Dispensed",?75,"Returned",?95,"Destroyed",?108,"of Bags",! F X=1:1:IOM W "-"
 Q
IVDATA I '$D(^TMP($J)) W !!,"No data to report" D CHK Q
 ;
 K IVTTL,DATA
 ;
IVLOOP ;Loop through IV entries
 S PSU=$S('$D(PSU):$O(^TMP($J,"IV",0)),1:$O(^TMP($J,"IV",PSU))) G DONE1:PSU="" W !,$P(PSU,"\",1),?41,$P(PSU,"\",2) S PSU1=^TMP($J,"IV",PSU)
 F X=1:1:4 S PSUIV(X)=$S($P(PSU1,U,X)="":0,1:$P(PSU1,U,X))
 W ?51,$J(PSUIV(1),13,2),?71,$J(PSUIV(2),12,2),?92,$J(PSUIV(3),12,2),?107,$J(PSUIV(4),8,2)
 F X=1:1:4 S IVTTL(X)=$S('$D(IVTTL(X)):PSUIV(X),1:IVTTL(X)+PSUIV(X))
 K PSUIV I $Y>(IOSL-8) D CHK G Q:$D(PSUER) D IVHDR
 G IVLOOP
HDR S XMSUB=XMSUB_" statistics for "_PSUSNDR(1)_" for "_PSUMON1_" to "_PSUMON2 Q
 ;
DONE1 ;Print IV Totals
 D LINE W ?51,$J(IVTTL(1),13,2),?71,$J(IVTTL(2),12,2),?92,$J(IVTTL(3),12,2),?107,$J(IVTTL(4),8,2)
 K IVTTL
Q D:'$D(PSUER) CHK K ^TMP($J),PSU1,OPTTL,PSUOR Q
 ;
DONE2 ;
 D LINE F X=2:1:5 W ?($S(X=2:42,X=3:62,X=4:81,1:101)),$S('$D(UDTTL(X)):$J(0,12,2),1:$J(UDTTL(X),12,2))
 K UDTTL,WSTTL G Q
 ;
DONE3 ;Write WS totals
 D LINE F X=1:1:4 W ?((X+3)*15),$S('$D(WSTTL(X)):$J(0,10,2),1:$J(WSTTL(X),10,2))
 K OPTTL,WSTTL G Q
DONE4 ;Write Outpatient totals
 D LINE F X=4:1:9 S OPTTL(X)=$S('$D(OPTTL(X)):0,1:OPTTL(X))
 W ?51,$J(OPTTL(4),8,2),?61,$J(OPTTL(5),8,2),?71,$J(OPTTL(6),8,2),?81,$J(OPTTL(7),14,2),?107,$J(OPTTL(9),14,2)
 K OPTTL G ^PSUC1
UD ;Print Unit Dose Stuff
 K PAGE D:'$D(PSUSNDR(1)) SNDR^PSUB D HDR,UDHDR K PSU,CNT G UDDATA
UDHDR W @IOF,!,XMSUB S PAGE=$G(PAGE)+1 W ?(IOM-($L(PAGE)+6)),"Page: ",PAGE,!,?45,"Dispensed",?65,"Dispensed",?85,"Returned",?105,"Returned",!,"Drug Name",?49,"Units",?70,"Cost",?88,"Units",?109,"Cost",! F X=1:1:IOM W "-"
 Q
UDDATA K UDTTL
 I '$D(^TMP($J,"UD")) W !!,"No data to report" D CHK Q
UDLOOP ;Loop thrugh Unit Dose entries
 S PSU=$S('$D(PSU):$O(^TMP($J,"UD",0)),1:$O(^TMP($J,"UD",PSU))) G DONE2:PSU="" S PSU1=^TMP($J,"UD",PSU,0) W !,$P(PSU1,U)
 F X=2:1:5 W ?($S(X=2:42,X=3:62,X=4:81,1:101)),$S($P(PSU1,U,X)']"":$J(0,12,2),1:$J($P(PSU1,U,X),12,2))
 F X=2:1:5 S UDTTL(X)=$S('$D(UDTTL(X)):$P(PSU1,U,X),1:UDTTL(X)+$P(PSU1,U,X))
 I $Y>(IOSL-8) D CHK G Q:$D(PSUER) D UDHDR
 G UDLOOP
 ;
WS ;Print AU/WS Data
 K ^TMP($J,"WS"),PSU,PAGE D:'$D(PSUSNDR(1)) SNDR^PSUB D HDR,WSHDR G WSDATA
WSHDR W @IOF,XMSUB S PAGE=$G(PAGE)+1 W ?(IOM-($L(PAGE)+6)),"Page: ",PAGE,!,?61,"Dispensed",?76,"Dispensed",?92,"Returned",?107,"Returned",?120,"AMIS",!,"Drug Name",?65,"Units",?81,"Cost",?95,"Units",?111,"Cost",?120,"Category",!
 F X=1:1:IOM W "-"
 Q
WSDATA I '$D(^TMP($J)) W !!,"No data to report" D CHK Q
WSLOOP S PSU=$S('$D(PSU):$O(^TMP($J,0)),1:$O(^TMP($J,PSU))) G DONE3:PSU="" W !,$P(^TMP($J,PSU,0),U,1)
 S PSU1=^TMP($J,PSU,0)
 F X=1:1:4 W ?((X+3)*15),$J($P(PSU1,U,(X+1)),10,2)
 F X=1:1:4 S WSTTL(X)=$S('$D(WSTTL(X)):$P(PSU1,U,(X+1)),1:WSTTL(X)+$P(PSU1,U,(X+1)))
 W ?120,$P(PSU1,U,6) I $Y>(IOSL-8) D CHK G Q:$D(PSUER) D WSHDR
 G WSLOOP
 ;
OP ;Print Outpatient data
 K PAGE D:'$D(PSUSNDR(1)) SNDR^PSUB D HDR,OPHDR K PSU G OPDATA
OPHDR W @IOF,XMSUB S PAGE=$G(PAGE)+1 W ?(IOM-($L(PAGE)+6)),"Page: ",PAGE,!!,?41,"VA Drug",?51,"Number",?117,"Ttl",!?41,"Class",?51,"Original",?62,"Number",?74,"Total",?90,"Total",?97,"Avg./Cost",?117,"Qnty.",?123,"Disp."
 W !,"Drug Name",?41,"Pointer",?54,"Fills",?62,"Refills",?74,"Fills",?91,"Cost",?101,"Fill",?117,"Disp.",?123,"Unit",! F X=1:1:IOM W "-"
 Q
OPDATA K PSU,OPTTL I '$D(^TMP($J)) W !!,"No data to report",! D CHK G ^PSUC1
OPLOOP S PSU=$S('$D(PSU):$O(^TMP($J,0)),1:$O(^TMP($J,PSU))) G DONE4:PSU'>0 S PSU1=^TMP($J,PSU,0)
 W !,$E($P(PSU1,U,1),1,35),?36,$P(PSU1,U,2),?41,$P(PSU1,U,3),?51,$J($P(PSU1,U,4),8,2),?61,$J($P(PSU1,U,5),8,2),?71,$J($P(PSU1,U,6),8,2),?81,$J($P(PSU1,U,7),14,2),?97,$J($P(PSU1,U,8),8,2),?107,$J($P(PSU1,U,9),14,2),?123,$P(PSU1,U,10)
 F X=4:1:9 S OPTTL(X)=$S('$D(OPTTL(X)):$P(PSU1,U,X),1:OPTTL(X)+$P(PSU1,U,X))
 I $Y>(IOSL-8) D CHK G Q:$D(PSUER) D OPHDR
 G OPLOOP
 ;
LINE W ! F X=1:1:(IOM-1) W "-"
 W !,"Totals : " Q
CHK ;Wait
 I $E(IOST)'="C" Q
 K PSUER W !!,"Press <RET> to CONTINUE, '^' to QUIT:  " R X:DTIME I X["^"!('$T) S PSUER=1 Q
 I X["?" W !?10,"Press the RETURN key to continue please" K X G CHK
 S:X["^" PSUER=1 K X Q
