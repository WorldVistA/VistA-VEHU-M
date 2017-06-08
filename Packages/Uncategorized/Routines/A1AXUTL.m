A1AXUTL ;SLL/ALB ISC; EXT REV UTILITIES; 3/21/88
 ;;VERSION 1.0
FLAG ;
 W !,"FLAGS-  +: High Priority, U: Contingency Removed, C: Contingency, R: Repeat, RC: Repeat Contingency"
 W !,"        M: Implementation Monitoring"
 Q
DATES ; REVIEW DATES
 S X=$E(A1AXLDT,4,5)_"/"_$E(A1AXLDT,6,7)_"/"_$E(A1AXLDT,2,3),Y=$E(A1AXUDT,4,5)_"/"_$E(A1AXUDT,6,7)_"/"_$E(A1AXUDT,2,3)
 S X="(REVIEW DATE- FROM "_X_" TO "_Y_")"
 W !!,?(IOM-$L(X)\2),X,!,A1AXL
 Q
TDATES ; TARGET DATES
 S X=$E(A1AXLDT,4,5)_"/"_$E(A1AXLDT,6,7)_"/"_$E(A1AXLDT,2,3),Y=$E(A1AXUDT,4,5)_"/"_$E(A1AXUDT,6,7)_"/"_$E(A1AXUDT,2,3)
 S X="(TARGET DATE- FROM "_X_" TO "_Y_")"
 W !!,?(IOM-$L(X)\2),X,!,A1AXL
 Q
WAIT ;
 I IOST["C-" R !!,"PRESS '^' TO STOP ",A1AXSTOP:DTIME S:A1AXSTOP["^" A1AXEND=""
 Q
CLOSE ;
 ;I $D(IO("C")) U IO(0) W !!,"EXIT",! U IO C IO(0)
 I $D(IO("C")) U IO(0) W !!,"EXIT",! S A1AXIO=IO,(A1AXIO(0),IO)=IO(0),IO(0)=A1AXIO X ^%ZIS("C") S IO=A1AXIO,IO(0)=A1AXIO(0) U IO S IOP=IO D ^%ZIS
 Q
CLOSE1 ;
 G H^XUS:$D(IO("C")) X ^%ZIS("C") U IO(0)
 Q
OPT ;
 W !,"    F- to sort print out by facility",!,"    O- to sort print out by review organization"
 Q
DICW ;
 S DIC("W")="W ""          "",$P(^DIZ(11837,+^DIZ(11830,+Y,""F""),0),""^"",1),""     "",$P(^DIZ(11831,+^DIZ(11830,+Y,""O""),0),""^"",1) I $D(^DIZ(11830,+Y,""D"")) W ""   (released)"""
 Q
