ZISLSTA2 ;WILM/RJ - Print Daily Statistics and Store Data; 7-30-86 ;1/20/93  15:57
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 D ^%ZISLSIT I $P(ZISLSITE,"^",6)["N"&($P(ZISLSITE,"^",8)["N") G Q
 S ZISLW=$S($P(ZISLSITE,"^",8)["N":0,1:1) D H S (T1,X)=0 F I=1:1 S X=$O(^%ZISL(107,"S","R",X)) Q:X=""  S D=^%ZISL(107,"S","R",X),$P(T1,"^",1)=$P(T1,"^",1)+1 D O
 G:'ZISLW Q S T=$P(T1,"^",27),Z=T\3600,Z2=T#3600,Z1=Z2\60,Z2=Z2#60 S:$L(Z)=1 Z="0"_Z S:$L(Z1)=1 Z1="0"_Z1 S:$L(Z2)=1 Z2="0"_Z2 S T=Z_":"_Z1_":"_Z2
 S C="=" D 1 W !,$P(T1,"^",1),?8,T,?18,"||" F J=2:1:9 S C=(J+3)*4 W ?(C+1),$P(T1,"^",J)
 W ?53,"|" F J=10:1:12 S C=(J+3)*4 W ?(C+3),$P(T1,"^",J)
 W ?67,"|" F J=13:1:15 S C=(J+4)*4 W ?(C+1),$P(T1,"^",J)
 W ?81,"|" F J=16:1:25 S C=(J+4)*4 W ?(C+3),$P(T1,"^",J)
 W ?123,"||  ",$P(T1,"^",26)
 W ! F J=1:1:132 W "="
 D A:$P(ZISLSITE,"^",4)'["N",L:$P(ZISLSITE,"^",5)'["N"
Q D:$P(ZISLSITE,"^",9)="Y" ^ZISLSTIM K ^%ZISL(107,"S") Q
O S T=0 W:ZISLW !,X,?8,$P(D,"^",1),?18,"||" F J=2:1:9 I $P(D,"^",J)'="" S T=T+$P(D,"^",J),$P(T1,"^",J)=$P(T1,"^",J)+$P(D,"^",J),C=(J+3)*4 W:ZISLW ?(C+1),$P(D,"^",J)
 W:ZISLW ?53,"|" F J=10:1:12 I $P(D,"^",J)'="" S T=T+$P(D,"^",J),$P(T1,"^",J)=$P(T1,"^",J)+$P(D,"^",J),C=(J+3)*4 W:ZISLW ?(C+3),$P(D,"^",J)
 W:ZISLW ?67,"|" F J=13:1:15 I $P(D,"^",J)'="" S T=T+$P(D,"^",J),$P(T1,"^",J)=$P(T1,"^",J)+$P(D,"^",J),C=(J+4)*4 W:ZISLW ?(C+1),$P(D,"^",J)
 W:ZISLW ?81,"|" F J=16:1:25 I $P(D,"^",J)'="" S T=T+$P(D,"^",J),$P(T1,"^",J)=$P(T1,"^",J)+$P(D,"^",J),C=(J+4)*4 W:ZISLW ?(C+3),$P(D,"^",J)
 W:ZISLW ?123,"||  ",T S $P(T1,"^",26)=$P(T1,"^",26)+T,$P(T1,"^",27)=$P(T1,"^",27)+$P(D,"^",27)
 D:$P(ZISLSITE,"^",6)'["N" S S C="-" G:ZISLW 1
 Q
H U IO D NOW^%DTC S Y=% X ^DD("DD") W:ZISLW @IOF,!!?51,"M I C O M  S T A T I S T I C S",!?57,Y,!!?41,"Log Period: " S L=$S($D(^%ZISL(107,"START")):^("START"),1:^%ZISL(107,"END"))_"^"_^%ZISL(107,"END") Q:'ZISLW
 W $P(L,"^",1)," -> ",$P(L,"^",2),!!?7,"Total time",?57,"D I S -",!,"Line/",?7,"connected",?29,"C O N N E C T S",?57,"C O N N",?71,"B U S Y",?83,"F A I L U R E S   T O   C O N N E C T"
 S C="=" W !,"Port",?8,"HH:MM:SS",?18,"||"," C   CQ  CL  CP  CT  CF  C1  C2  | D   DF  DT  | Q   Q1  Q2  | F1  F2  F3  F4  F5  F6  F7  F8  F9  FA  || TOTALS"
1 W ! F I=1:1:18 W C
 W "||" F I=1:1:33 W C
 W "|" F I=1:1:13 W C
 W "|" F I=1:1:13 W C
 W "|" F I=1:1:41 W C
 W "||" F I=1:1:7 W C
 Q
A W !!,"ACTION DEFINITIONS:",!,"===================" F I=1:1:14 S X=$S($D(^%ZISL(107.1,I,0)):^(0),1:"") W !,$P(X,"^",1),?7,$P(X,"^",2) S X=$S($D(^%ZISL(107.1,I+14,0)):^(0),1:"") W:$P(X,"^",1)["F" ?68,$P(X,"^",1),?75,$P(X,"^",2)
 Q
L W !!,"LINE ASSIGNMENTS:",!,"=================" S X=0 F I=1:1 D L1 Q:X=""  S Y=X D L1,L2 Q:X=""
 Q
L1 S X=$O(^%ZISL(107.2,"B",X)) Q:X=""  S X=$O(^%ZISL(107.2,"B",X,0))  Q:X=""  S X=^%ZISL(107.2,X,0) Q
L2 W !,$P(Y,"^",1),?7,$P(Y,"^",2) I X'="",X'?.N W ?68,$P(X,"^",1),?75,$P(X,"^",2)
 Q
S S S=$O(^%ZISL(107.2,"B",X,0)) Q:S=""  I '$D(^%ZISL(107.2,S,1,0)) S ^(0)="^107.21A^"
 S Z=^(0),J=$P(Z,"^",3)+1,^(0)=$P(Z,"^",1,2)_"^"_J_"^"_($P(Z,"^",4)+1),^%ZISL(107.2,S,1,J,0)=L_"^"_$P(D,"^",1),^%ZISL(107.2,S,1,"B",$P(L,"^",1),J)=""
 Q
