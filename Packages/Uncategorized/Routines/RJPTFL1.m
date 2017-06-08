RJPTFL1 ;RJ WILM DE -LISTS PAT CHECKED BUT UNCLOSED; 12-12-85
 ;;4.0
 W !!,"This report can be Queued by typing a ""Q"" at the DEVICE: prompt."
 S %IS="QM",%IS("B")="" D ^%ZIS G:POP Q I $D(IO("Q")) S PGM="S^RJPTFL1" D ^RJPTFQ G Q
 W !,"This will take a while."
S K ^UTILITY("PTF1",$J) S (RJPFLAG,RJPT,RJPTIN,RJPTCH,RJPTNC,RJPTD)=0,I=0,X=$P(^DGPT(0),"^",4) S:'$D(DTIME) DTIME=300 F P=1:1 S I=$O(^DGPT(I)) Q:I'?.N  D L D:I#1000=0 W Q:RJPFLAG
 I RJPFLAG G Q
 D H,O W ! F I=1:1:79 W "="
 W !,"TOTAL Inpatients (No Discharge Date) = ",RJPTIN,!,"TOTAL Patients Discharged but NOT CHECKED = ",RJPTNC,!,"TOTAL Patients CHECKED but NOT CLOSED = ",RJPTCH
 W !,"TOTAL Patients CLOSED but NOT RELEASED = ",RJPTD,!,"TOTAL Patients RELEASED = ",RJPT
 W !!! W:IO'=IO(0) @IOF
Q X ^%ZIS("C") K ^UTILITY("PTF1",$J),%DT,%IS,IO("Q"),RJPT,RJPFLAG,RJPTIN,RJPTCH,RJPTNC,RJPTD,RJPAT,X,Y Q
W Q:$D(ZTIO)  W !,"Currently Processing Record #",I,"  with  ",X-P,"  Records to do." R " Type ""^"" to quit:",R:5 I R'["^" W !,"Continuing..." Q
 S RJPFLAG=1 W !,"Stopping." Q
L I '$D(^DGPT(I,70)) S RJPTIN=RJPTIN+1 Q
 I $P(^DGPT(I,70),"^",1)="" S RJPTIN=RJPTIN+1 Q
 I '$D(^DGP(45.84,I,0)) S RJPTNC=RJPTNC+1 Q
 S RJPAT=^DGP(45.84,I,0) I $P(RJPAT,"^",2)'="",$P(RJPAT,"^",4)="" S RJPTD=RJPTD+1 Q
 I $P(RJPAT,"^",4)'="" S RJPT=RJPT+1 Q
 S RJPTCH=RJPTCH+1,^UTILITY("PTF1",$J,$E($P(^DGPT(I,70),"^",1),1,7),I)="" Q
H S X="T" D ^%DT U IO W @IOF W !,"LISTING OF CHECKED BUT UNCLOSED PATIENTS...",?65,$E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3),!!,"DISCHARGE",!,"DATE",?10,"NUMBER",?20,"PATIENT NAME",?50,"SSN",! F I=1:1:79 W "="
 Q
O U IO S Z=0 F I=1:1 S Z=$N(^UTILITY("PTF1",$J,Z)) Q:Z=-1  W !,$E(Z,4,5),"-",$E(Z,6,7),"-",$E(Z,2,3) D P
 Q
P S Y=0 F J=1:1 S Y=$N(^UTILITY("PTF1",$J,Z,Y)) Q:Y=-1  D P1
 Q
P1 S RJPAT=^DPT($P(^DGPT(Y,0),"^",1),0) W ?10,Y,?20,$P(RJPAT,"^",1),?50,$P(RJPAT,"^",9),!
 I '$D(ZTIO) I IO=IO(0) I $Y#IOSL=0 W !,"Type ""^"" to STOP, <RETURN> to CONTINUE: " R R:DTIME S:'$T R="^" D:R'["^" H I R["^" S (Z,Y)=999999999
 Q
