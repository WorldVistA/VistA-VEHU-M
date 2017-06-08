ZISLAUTO ;WILM/RJ - Load a Configuration; 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S DIC("A")="Select Configuration to Auto Load: ",DIC="^%ZIS(""Z"",105,",DIC(0)="AENQZ" W ! D ^DIC G:Y=-1 E S DA=+Y
ST S S="*",DX=0 S ZISLOS=$S($D(^%ZOSF("OS")):^("OS"),1:""),DY=0
 D 1^%ZISLVR I X=U W !,"No connection made." G E
 S ZISLPAUS=$S(ZISLTYPE=6600:100,1:500),ZISLRET=X_$S(ZISLTYPE=6600:"",1:" ") I '$D(^%ZIS("Z",105,DA,1,0)) U IO(0) W !,"NO COMMANDS FOUND." G M1
 U IO(0) W !,"======================  L O A D I N G   C O M M A N D S  ======================",!,ZISLRET
 I ZISLOS["M11" U IO R X:1
 S ZISL=0 F I=0:0 S ZISL=$O(^%ZIS("Z",105,DA,1,ZISL)) Q:+ZISL=0  S C=$P(^(ZISL,0),";",1) D TYPE,T,R D:X=S X
M1 U IO(0) W !,"======================  L O A D I N G   M E S S A G E S  ======================",!,ZISLRET
 I ZISLTYPE[6600 G ^ZISLAUT1
 S ZISL="^%ZIS(""Z"",105,"_DA_",2,",M=0 S:$D(@(ZISL_"0)")) M=$P(@(ZISL_"0)"),U,3) I 'M W !,"NO CLASS 0 MESSAGE FOUND." G CM
 I '$D(^%ZIS("Z",105,DA,2,1,0)) W !,"NO WELCOME MESSAGE FOUND." G CM
 S C="MSG 0",(ZISLRET,R)=">" D T,R I X=S G M
 S ZISLTYPE=6600,ZISL=0 F I=0:0 S ZISL=$O(^%ZIS("Z",105,DA,2,ZISL)) Q:+ZISL=0  S C=^(ZISL,0) D T,R
 S ZISLRET="? ",ZISLTYPE="" G:X=S M S C="",R="TASK COMPLETE" D T,R G:X=S M S ZISLPAUS=600,C="MSG 0 C0" D T,R
M I X=S U IO(0) W !,"** ERROR LOADING CLASS 0 MESSAGE **",! G E
CM S DA(1)=0 F K=1:1 S DA(1)=$O(^%ZIS("Z",105,DA,3,DA(1))) Q:+DA(1)=0  S C="MSG "_K_" C"_$P(^(DA(1),0),"^",1),R="ENTER CLASS MESSAGE" D T,R Q:X=S  S C=$S($D(^%ZIS("Z",105,DA,3,DA(1),1,1,0)):^(0),1:""),R="TASK COMPLETE" D T,R Q:X=S
 U IO(0) I '(X=S) W !!,"AUTO LOAD COMPLETE.",!
 E  W !,"** ERROR LOADING MESSAGE **",!
 I $D(Y),Y'=-1 D CP^%ZISLDIS
 U IO(0) W !!,"*** END OF AUTO LOAD FOR MICOM 600 ***"
E X ^%ZIS("C") K C,ZISL,ZISLF,ZISLG,ZISLS,DA,DIC,I,J,M,N,S,X,Y,ZISLSITE,ZISLRET,ZISLCPU,ZISLTYPE,ZISLPAUS Q
T U IO X ^%ZOSF("XY") U IO(0) F I=1:1 D P S X=$E(C,I) Q:X=""  U IO W X
 U IO W *13 Q
P F P=1:1:ZISLPAUS
 Q
R F I=1:1:4 U IO R X:1 U IO(0) Q:X[R  W $S(ZISLTYPE=6600:$P(X,$C(10)),ZISLOS["M11":X,1:$P(X,$C(10),2))
 I X[R U IO(0) W !,$S(ZISLTYPE=6600:$P(X,$C(10)),1:$P(X,$C(10),2)) W:ZISLTYPE'=6600 !,ZISLRET U IO R X:1 R:ZISLOS["M11" X:1 Q
 S X=S Q
X I IO(0) W !,"** COMMAND: ",C,"  REJECTED BY MICOM **",! H 1 Q
TYPE ;determine how the micom should respond to messages
 G:ZISLTYPE=6600 6600
 I C?1"LIM T".N1" "1"I".E!(C?1"LIM T".N1" "1"E".E) S R="ENTER CLASSES" Q
 S R="TASK COMPLETE"
 Q
6600 ;look for these responses from a 6600
 I C?1"SET AG ".N1" "1"RCL"!(C?1"A ".N)!(C="K")!(C?1"D ".N1":".N) S R="* " Q
 S R=ZISLRET
 Q
