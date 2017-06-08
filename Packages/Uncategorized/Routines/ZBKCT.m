%ZBKCT ;GJL/SF ;13 FEB 1985@12:35;GLOBAL BLOCK COUNT
 ;4.3
 ;X = FULL Global Reference: "NAME(SUB1,...,SUBn)"
 ;
 S XX=""
READ W !!,"Block Count for Global ^" I XX'="" W XX,"//"
 R X,! I X["?" G SYNTAX
 I X="" S X=XX
STRIP I X?1"^".E S X=$E(X,2,256) G STRIP
 I X="" K XX Q
 I X?1"(".E S XX="" G SYNTAX
 S XX=X D ENCOUNT I X'=+X W !,X G READ
 W !,"^",XX," " I X<0 W "doesn't exist"
 E  W "has ",X," data block" W:X-1 "s"
 W "." S XX="" G READ
SYNTAX W !,"Enter: a FULL Global Reference, or"
 W !,"       ^ " W:XX="" "or NULL " W "to quit."
 G READ
ENCOUNT ;
 S %T=-1,%A=^%ZOSF("OS") I X?1"^".E S X=$E(X,2,255)
 I %A="DSM-3" D ^%ZBKCT1 G EXIT
 I %A="M/11" D ^%ZBKCT2 G EXIT
 I %A="M/11+" D ^%ZBKCT3 G EXIT
 I %A="M/VX" G EXIT
EXIT S X=%T K %A,%T
