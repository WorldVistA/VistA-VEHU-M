ZISLSO1 ;WILM/RJ - Print Statistics; 9-10-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="QUE^ZISLSO1",ZTDESC="Micom Print Statistics" D ^%ZTLOAD G Q
QUE U IO D H S (XX,J2)=0,(T1,T2)="00:00:00" F I=1:1 S XX=$O(^%ZISL(107.2,"B",XX)) Q:XX=""  S Z=$O(^%ZISL(107.2,"B",XX,0)) Q:Z=""  D 1 Q:XX="ZZZZ"  D PAUS
 W ! F T=1:1:79 W "="
 S T1=T2 D T1 W !,"Total Lines: ",$J((I-1),5),?25,"Total Days: ",$J(J2,4),?56,"Total Time: ",$J(T1,10)
Q X ^%ZIS("C") K %DT,A,D,DX,DY,H,I,J,K,J2,M,S,T,T1,T2,X,XX,Y,Z1,ZTSK,Z,YY Q
1 Q:'$D(^%ZISL(107.2,Z,0))  D H1 S YY=0 F J=1:1 S YY=$O(^%ZISL(107.2,Z,1,YY)) Q:YY=""!(YY'?.N)  S T=$P(^%ZISL(107.2,Z,1,YY,0),"^",3) D T,PAUS
 Q:XX="ZZZZ"  W:J=1 ! W ?20 F K=21:1:79 W "-"
 W !?25,"Total Days: ",$J((J-1),4),?56,"Total Time: ",$J(T1,10) S H=$P(T1,":",1)+$P(T2,":",1),M=$P(T1,":",2)+$P(T2,":",2),S=$P(T1,":",3)+$P(T2,":",3),J2=J2+J-1,T2=H_":"_M_":"_S,T1="00:00:00"
 W ! F K=1:1:79 W "#"
 Q
H1 S Z1=^%ZISL(107.2,Z,0) W !,$P(Z1,"^",1),?7,$E($P(Z1,"^",2),1,15) Q
T S D=^%ZISL(107.2,Z,1,YY,0) W ?25,$P(D,"^",1),?45,$P(D,"^",2),?70,$P(D,"^",3),!
 S H=$P(T1,":",1)+$P(T,":",1),M=$P(T1,":",2)+$P(T,":",2),S=$P(T1,":",3)+$P(T,":",3)
T1 S:'$D(M) M=0 S:'$D(S) S=0 S:'$D(H) H=0 S M=M+(S\60),S=S#60,H=H+(M\60),M=M#60 S:$L(S)=1 S=0_S S:$L(M)=1 M=0_M S:$L(H)=1 H=0_H
 S T1=H_":"_M_":"_S
 Q
H D NOW^%DTC S Y=% X ^DD("DD") W @IOF,!?20,"MICOM CUMULATIVE STATISTICS: ",Y,!?25,"From Last Purge Date: " I $D(^%ZISL(107,"PURGE")) S Y=^("PURGE") X ^DD("DD") W Y
 W !!,"LINE",?10,"LOCATION",?25,"From Date",?45,"To Date",?70,"HH:MM:SS"
 W ! F I=1:1:79 W "="
 Q
PAUS I IO=IO(0),$Y'<(IOSL-3),'$D(ZTSK) W !,"Press RETURN to continue, ""^"" to exit: " R A:DTIME S:'$T A="^" S:A["^" (XX,YY)="ZZZZ"
 Q:YY="ZZZZ"  I $Y'<(IOSL-3) D H,H1
 Q
