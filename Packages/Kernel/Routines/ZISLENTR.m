ZISLENTR ;WILM/RJ - Entry to send command to Micom (R=Command^[1 if output]; Output is in X; 1-20-87
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 W !,"Enter Command> " R R:300 G:'$T!(R="")!(R["^") E1 S ZISLFLA1=1,R=R_"^"_1 W " ..."
GO ;Entry point if R is already defined
 S ZISLFLAG=$S($P(R,"^",2)=1:1,1:0),R=$P(R,"^",1) D 1^%ZISLVR I X=U S XX="No connection" G E
 D T U IO(0) S XX=Y W:ZISLFLAG Y D CP^%ZISLDIS
E X ^%ZIS("C") G:$D(ZISLFLA1) ZISLENTR S X=XX K ZISLCPU,ZISLSITE,I,J,XX,ZISLFLAG Q
E1 K ZISLFLA1 G E
T U IO X ^%ZOSF("XY") S Y="" F J=1:1 D P S X=$E(R,J) Q:X=""  W X
 W *13 F J=0:0 U IO R *X:1 Q:X=-1  S Y=Y_$C(X) S:$L(Y)>200 Y=""
 Q
P F P=1:1:100
 Q
