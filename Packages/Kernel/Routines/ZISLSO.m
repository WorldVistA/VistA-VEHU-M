ZISLSO ;WILM/RJ - Print Statistics Cumulative; 9-10-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="QUE^ZISLSO",ZTDESC="Micom Cumulative Statistics" D ^%ZTLOAD G Q
QUE U IO D H S (XX,J2)=0,(T1,T2)="00:00:00" F I=1:1 S XX=$O(^%ZISL(107.2,"B",XX)) Q:XX=""  S X=$O(^%ZISL(107.2,"B",XX,0)) Q:X=""  D 1
 W ! F T=1:1:79 W "="
 S T1=T2 D T1 W !,$J((I-1),5),?10,"<<TOTALS>>",?35,$J(J2,4),?45,$J(T1,10)
Q X ^%ZIS("C") K A,DX,DY,H,I,J,J2,M,S,T,T1,T2,X,XX,Y,Z1,ZTSK Q
1 Q:'$D(^%ZISL(107.2,X,0))  S Y=0 F J=1:1 S Y=$O(^%ZISL(107.2,X,1,Y)) Q:Y=""!(Y'?.N)  S T=$P(^%ZISL(107.2,X,1,Y,0),"^",3) D T
 S Z1=^%ZISL(107.2,X,0) W !,$P(Z1,"^",1),?10,$E($P(Z1,"^",2),1,20)
 W ?35,$J((J-1),4),?45,$J(T1,10) S H=$P(T1,":",1)+$P(T2,":",1),M=$P(T1,":",2)+$P(T2,":",2),S=$P(T1,":",3)+$P(T2,":",3),J2=J2+J-1,T2=H_":"_M_":"_S,T1="00:00:00"
 I IO=IO(0),$Y'<(IOSL-2),'$D(ZTSK) W !,"Press RETURN to continue, ""^"" to exit: " R A:DTIME S:'$T A="^" S:A["^" XX="ZZZZ"
 Q:XX="ZZZZ"  I $Y'<(IOSL-2) D H
 Q
T S H=$P(T1,":",1)+$P(T,":",1),M=$P(T1,":",2)+$P(T,":",2),S=$P(T1,":",3)+$P(T,":",3)
T1 S:'$D(M) M=0 S:'$D(S) S=0 S:'$D(H) H=0 S M=M+(S\60),S=S#60,H=H+(M\60),M=M#60 S:$L(S)=1 S=0_S S:$L(M)=1 M=0_M S:$L(H)=1 H=0_H
 S T1=H_":"_M_":"_S Q
H D NOW^%DTC S Y=% X ^DD("DD") W @IOF,!?20,"MICOM CUMULATIVE STATISTICS: ",Y,!?20,"From Last Purge Date: " I $D(^%ZISL(107,"PURGE")) S Y=^("PURGE") X ^DD("DD") W Y
 W !!,"LINE",?10,"LOCATION",?36,"DAYS",?47,"HH:MM:SS USAGE"
 W ! F I=1:1:79 W "="
 Q
