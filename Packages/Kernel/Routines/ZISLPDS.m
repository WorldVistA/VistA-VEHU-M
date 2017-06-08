ZISLPDS ;WILM/RJ - Print Daily Statistics; 3-31-87
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="QUE^ZISLPDS",ZTDESC="Micom Print Daily Statistics" D ^%ZTLOAD G Q
QUE D H S X=0 F I=1:1 S X=$O(^%ZISL(107,X)) Q:X=""!(X'?.N)  D 1
Q X ^%ZIS("C") K X,I,A,D,J,ZTSK Q
1 S D=^%ZISL(107,X,0) W !,$P(D,"^",1),?9,$P(D,"^",2),?15,$P(D,"^",3),?25,$P(D,"^",4),?35,$P(D,"^",5),?45,$P(D,"^",6),?55,$P(D,"^",7)
 I IO=IO(0),$Y'<(IOSL-2),'$D(ZTSK) W !,"Press RETURN to continue, ""^"" to exit: " R A:DTIME S:'$T A="^" S:A["^" X="ZZZZ"
 Q:X="ZZZZ"  I $Y'<(IOSL-2) D H
 Q
H U IO W @IOF,!,"Entry#",?9,"Type",?15,"Init L/P",?25,"Dest L/P",?35,"Class",?45,"DOY",?55,"Time"
 W ! F J=1:1:79 W "-"
 Q
