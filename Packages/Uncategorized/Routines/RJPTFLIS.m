RJPTFLIS ;RJ WILM DE -PTF FILE PATIENT LIST BY NUMBER; 12-12-85
 ;;4.0
 S:'$D(DUZ(0)) DUZ(0)="@" S (DIC,DIE)="^DGPT(",U="^",DIC(0)="QEALM",DIC("A")="Enter PTF Patient to start list: " S:'$D(DTIME) DTIME=300 D ^DIC G:Y=-1 Q W !,?18,"***  PATIENT NUMBER = ",+Y,?47,"***" S X=+Y
 W !,"Number",?10,"Patient",?35,"Social Security Number",?60,"Admission Date",! F I=1:1:79 W "-"
 S Z=$P(^DGPT(0),U,3) F I=X:1:Z I $D(^DGPT(I,0)) W !,?2,I,?7,$P(^DPT($P(^DGPT(I,0),U,1),0),U,1),?42,$P(^DPT($P(^DGPT(I,0),U,1),0),U,9) D D W ?63,D I ((I-X)#20=0&(I'=X))!(I=Z) R !,"Type ""^"" to stop, <RET> to continue:",R:DTIME S:'$T R=U G:R=U Q
Q K D,DIC,DIE,I,R,X,Y,Z Q
D S D=$P(^DGPT(I,0),U,2),D=$E(D,4,5)_"-"_$E(D,6,7)_"-"_$E(D,2,3) Q
