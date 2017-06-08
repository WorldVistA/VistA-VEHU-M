ZRDISPL ;NP-ISCA;3/22/87;12:45p;Select and display infor about routines
 S DTIME=$S($D(DTIME):$S(DTIME<60:60,1:DTIME),1:60),PG="",HDR="TECHNICAL CHECK LIST FOR ROUTINES",(TLINE,LINE)="",$P(TLINE,"-",IOM)="",$P(LINE,"=",IOM)="" K ^UTILITY($J)
 D ^%RSEL G:$D(%GO)=0 EXIT S %IS="M" D ^%ZIS S (TLINE,LINE)="",$P(TLINE,"-",IOM)="",$P(LINE,"=",IOM)=""
 D HDR S RR="" F I=1:1 S RR=$O(^UTILITY($J,RR)) Q:RR=""  D WRITE
 I IOST["C-" R !!,"Any key to continue",XK:DTIME
 W @IOF X ^%ZIS("C")
EXIT ;
 K XK,RR,HDR,PG Q
WRITE ;
 D:$Y>(IOSL-10) HDR W !,?3,RR,?13,"|",?18,$P(^ (RR),",",3),?27,"|",?39,"|",?52,"|",!,TLINE
 Q
HDR ;
 S PG=PG+1 W @IOF,?(IOM-$L(HDR)\2),HDR,!,?(IOM-29\2) D ^%D W "  " D ^%T W "   Page",$J(PG,3),!!,"   ROUTINE   |   ROUTINE   |   FIRST   |   SECOND   |"
 W !,?4,"NAME",?18,"SIZE",?31,"LINE",?44,"LINE",!,LINE
 Q
