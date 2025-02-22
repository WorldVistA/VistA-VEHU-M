DGYPGLO1 ;ALB/LM - TREATING SPECIALTY INPATIENT LISTING BY WARDS ;2-2-93
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 ;
START Q:'PTLWD
 S REPORT="< <  PATIENT LISTING BY WARD  > >"
 S (PAGE,TOTAL)=0
 D HEAD^DGYPGLO
 D SUBHEAD
 ;
DIV S DIV="" F DIV1=0:0 S DIV=$O(^TMP($J,"PTLWD",DIV)) Q:DIV=""  D:$Y+8>IOSL HEAD^DGYPGLO,SUBHEAD Q:END  W !?5,"DIVISION: ",$S($D(^DG(40.8,DIV,0)):$P(^(0),"^"),1:"EMPTY") D WARD Q:END  S SUBCOUNT=^TMP($J,"PTLWD",DIV) D TOTAL Q:END
 ;
 G:END END
 D:$Y+8>IOSL HEAD^DGYPGLO,SUBHEAD Q:END
 F L=1:1:(IOM-3) W "-"
 W !!?3,"TOTAL   =  ",$J($P(TOTAL,"^",1),4),?25,"PASS   = ",$J($P(TOTAL,"^",2),4),?45,"AA   = ",$J($P(TOTAL,"^",3),4),?65,"UA   = ",$J($P(TOTAL,"^",4),4),?85,"ASIH   = ",$J($P(TOTAL,"^",5),4),?105,"PTS REMAINING   =  ",$J($P(TOTAL,"^",6),4)
 S PTLWD=0
 ;
END K ABSENCE,ADMDT,DGW,DGW1,DIV,DIV1,ID,IFN,L,PAGE,PTNM,PTNM1,REPORT,SUBCOUNT,TOTAL,TREAT,TSXFR,WARD,WARD1,PTLWD,SUBNAME
 Q
 ;
WARD S WARD="" F WARD1=0:0 S WARD=$O(^TMP($J,"PTLWD",DIV,WARD)) Q:WARD=""  Q:END  D DGW
 Q
 ;
DGW S DGW="" F DGW1=0:0 S DGW=$O(^TMP($J,"PTLWD",DIV,WARD,DGW)) Q:DGW=""  D:$Y+8>IOSL HEAD^DGYPGLO,SUBHEAD Q:END  W !!?10,"INPATIENT WARD:  ",WARD D PTNM Q:END  S SUBCOUNT=^TMP($J,"PTLWD",DIV,WARD,DGW) S SUBNAME="WARD" D SUB Q:END
 Q
 ;
PTNM S PTNM="" F PTNM1=0:0 S PTNM=$O(^TMP($J,"PTLWD",DIV,WARD,DGW,PTNM)) Q:PTNM=""  F IFN=0:0 S IFN=$O(^TMP($J,"PTLWD",DIV,WARD,DGW,PTNM,IFN)) Q:'IFN  D INFO Q:END
 Q
 ;
INFO S TREAT=$P(^TMP($J,"PTLWD",DIV,WARD,DGW,PTNM,IFN),"^")
 S ADMDT=$P(^TMP($J,"PTLWD",DIV,WARD,DGW,PTNM,IFN),"^",2)
 S TSXFR=$P(^TMP($J,"PTLWD",DIV,WARD,DGW,PTNM,IFN),"^",3)
 S ABSENCE=$P(^TMP($J,"PTLWD",DIV,WARD,DGW,PTNM,IFN),"^",4)
 S ID=$S($D(^DPT(IFN,.36)):$P(^DPT(IFN,.36),"^",3),1:"")
 ;
 I $Y+8>IOSL D HEAD^DGYPGLO,SUBHEAD Q:END
LINE W !,PTNM,?30,ID,?45,ADMDT,?65,TREAT,?100,TSXFR,?120,ABSENCE
 Q
 ;
 ;
TOTAL S $P(TOTAL,"^",1)=$P(TOTAL,"^",1)+$P(SUBCOUNT,"^",1) ; current patients
 S $P(TOTAL,"^",2)=$P(TOTAL,"^",2)+$P(SUBCOUNT,"^",2) ; pass
 S $P(TOTAL,"^",3)=$P(TOTAL,"^",3)+$P(SUBCOUNT,"^",3) ; aa
 S $P(TOTAL,"^",4)=$P(TOTAL,"^",4)+$P(SUBCOUNT,"^",4) ; ua
 S $P(TOTAL,"^",5)=$P(TOTAL,"^",5)+$P(SUBCOUNT,"^",5) ; asih
 S $P(TOTAL,"^",6)=$P(TOTAL,"^")-$P(TOTAL,"^",3)-$P(TOTAL,"^",4)-$P(TOTAL,"^",5) ; Current patient minus absences except Pass equals patient's remaining.
 ;
 S SUBNAME="DIVISION"
 ;
SUB D:$Y+6>IOSL HEAD^DGYPGLO Q:END
 ;
 S $P(SUBCOUNT,"^",6)=$P(SUBCOUNT,"^")-$P(SUBCOUNT,"^",3)-$P(SUBCOUNT,"^",4)-$P(SUBCOUNT,"^",5) ; Current patient minus absences except Pass equals patient's remaining.
 W !
 F L=1:1:(IOM-3) W "-"
 W !,SUBNAME,!
 W "SUBCOUNT   =  ",$J($P(SUBCOUNT,"^",1),4),?25,"PASS   = ",$J($P(SUBCOUNT,"^",2),4),?45,"AA   = ",$J($P(SUBCOUNT,"^",3),4),?65,"UA   = ",$J($P(SUBCOUNT,"^",4),4),?85,"ASIH   = ",$J($P(SUBCOUNT,"^",5),4)
 W ?105,"PTS REMAINING   =  ",$J($P(SUBCOUNT,"^",6),4),!
 Q
 ;
SUBHEAD ;
 Q:END
 W !!,"PATIENT",?30,"PT'S ID",?45,"ADMISSION DATE",?65,"LAST FACILITY TREATING SPECIALTY",?100,"LAST TS SERVICE",?120,"ABSENCE",!
 F L=1:1:(IOM-3) W "-"
 W !
 Q
