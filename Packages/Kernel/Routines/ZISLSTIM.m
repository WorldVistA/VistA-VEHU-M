ZISLSTIM ;WILM/RJ - Calculate Time Versus Activity; 12-10-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 I '$D(IO) D ^%ZIS Q:POP
 S H=0 F I=0:1:24 S ZISL(I)=$S($D(^%ZISL(107,"S","TIME",I)):^(I),1:0) S:ZISL(I)>H H=ZISL(I)
 D NOW^%DTC S Y=% X ^DD("DD") S H=H/10+1\1*10,X=H\10
 D H F I=0:1:24 D:ZISL(I)'=0 W
 W !?20 F I=1:1:10 W "|" F J=1:1:9 W "-"
 W "|",! F I=0:1:9 W ?(I+2*10),I*X
 W !!?20,"TOTAL NUMBER OF ACTIVITIES"
 W @IOF K ZISL,X,Y,Z Q
W W !?10 W:I=0 "24:01 " W:I'=0 $J(I,2),":00 " W:I<13 "AM" W:I>12 "PM" W ?19,"-|"
 S Y=ZISL(I)\X*10,Z=ZISL(I)#X/X*10+Y F J=1:1:Z W "*"
 S Z=Z+21\1 F J=Z:1:111 I $E(J,$L(J))=0 W ?J,"|"
 W ?120,"|",?123,ZISL(I),!,?20,"|"
 Q
H U IO W @IOF,!?40,"T I M E   V E R S U S   M I C O M   A C T I V I T Y",!,?55,Y,!! F I=0:1:9 W ?(I+2*10),I*X
 W !?20 F I=1:1:10 W "|" F J=1:1:9 W "-"
 W "|",!,"TIME",?20,"|"
 Q
