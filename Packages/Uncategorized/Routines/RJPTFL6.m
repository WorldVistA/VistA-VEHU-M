RJPTFL6 ;RJ WILM DE -LISTING CLOSED BUT UNRELEASED (NOT DISCHARGE DATE ORDER); 12-12-85
 ;;4.0
 D ^%ZIS Q:POP  D H S (T,X)=0 F I=1:1 S X=$N(^DGP(45.84,X)) Q:X'?.N  D C
 W ! F I=1:1:79 W "="
 W !,"TOTAL=",T W:IO'=IO(0) @IOF X ^%ZIS("C") K X,T,D1,D,I Q
 Q
C Q:$P(^DGP(45.84,X,0),"^",3)=""  Q:$P(^DGP(45.84,X,0),"^",4)
 W !,X,?8,$P(^DPT($P(^DGPT(X,0),"^",1),0),"^",1),?30 S D1=^DGP(45.84,X,0),D=$P(D1,"^",2),D=$E(D,4,5)_"-"_$E(D,6,7)_"-"_$E(D,2,3),W=$S($D(^DIC(3,$P(D1,"^",3),0)):$P(^(0),"^",1),1:$P(D1,"^",3)) D C1
 Q
C1 W ?30,D,?45,W,?65 S D=$P(^DGPT(X,70),"^",1) W $E(D,4,5),"-",$E(D,6,7),"-",$E(D,2,3) S T=T+1 Q
 Q
H U IO W !,"NUMBER",?8,"PATIENT NAME",?30,"DATE CLOSED",?45,"BY WHO",?65,"DISCHARGE DATE",! F I=1:1:79 W "="
 W ! Q
