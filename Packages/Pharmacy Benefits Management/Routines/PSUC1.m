PSUC1 ;BHM ISC/DEB - Print CMOP data ;15SEPT93
 ;;1.0; D&PPM ;;11 May 94
 K PAGE S XMSUB="Centralized Mail-Out Pharmacy (CMOP) " D HDR^PSUC,CMOPHDR G CMDATA
 ;
CMOPHDR ;Print CMOP header
 W @IOF,XMSUB S PAGE=$G(PAGE)+1 W ?(IOM-($L(PAGE)+6)),"Page: ",PAGE,!!,?41,"VA Drug",?51,"Number",?117,"Ttl",!?41,"Class",?51,"Original",?62,"Number",?74,"Total",?90,"Total",?97,"Avg./Cost",?117,"Qnty.",?123,"Disp."
 W !,"Drug Name",?41,"Pointer",?54,"Fills",?62,"Refills",?74,"Fills",?91,"Cost",?101,"Fill",?117,"Disp.",?123,"Unit",! F X=1:1:IOM W "-"
 Q
 ;
CMDATA K PSU,OPTTL I '$D(^TMP($J,"CMOP")) W !!,"No data to report",! D CHK G Q
OPLOOP S PSU=$S('$D(PSU):$O(^TMP($J,"CMOP",0)),1:$O(^TMP($J,"CMOP",PSU))) G DONE4:PSU="" S PSU1=^TMP($J,"CMOP",PSU,0)
 W !,$E($P(PSU1,U,1),1,35),?36,$P(PSU1,U,2),?41,$P(PSU1,U,3),?51,$J($P(PSU1,U,11),8,2),?61,$J($P(PSU1,U,5),8,2),?71,$J($P(PSU1,U,6),8,2),?81,$J($P(PSU1,U,7),14,2),?97,$J($P(PSU1,U,8),8,2),?107,$J($P(PSU1,U,12),14,2),?123,$P(PSU1,U,10)
 F X=4:1:9 S OPTTL(X)=$S('$D(OPTTL(X)):$P(PSU1,U,X),1:OPTTL(X)+$P(PSU1,U,X))
 I $Y>(IOSL-8) D CHK G Q:$D(PSUER) D CMOPHDR
 G OPLOOP
 ;
LINE W ! F X=1:1:(IOM-1) W "-"
 W !,"Totals : " Q
CHK ;Wait
 I $E(IOST)'="C" Q
 K PSUER W !!,"Press <RET> to CONTINUE, '^' to QUIT:  " R X:DTIME I X["^"!('$T) S PSUER=1 Q
 I X["?" W !?10,"Press the RETURN key to continue please" K X G CHK
 S:X["^" PSUER=1 K X Q
Q K PSU1 Q
DONE4 ;Write Outpatient totals
 D LINE F X=4:1:9 S OPTTL(X)=$S('$D(OPTTL(X)):0,1:OPTTL(X))
 W ?51,$J(OPTTL(4),8,2),?61,$J(OPTTL(5),8,2),?71,$J(OPTTL(6),8,2),?81,$J(OPTTL(7),14,2),?107,$J(OPTTL(9),14,2)
 K OPTTL Q
