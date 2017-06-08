ZISLSTA1 ;WILM/RJ - Calculate Daily Statistics Totals; 12-10-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 K ^%ZISL(107,"RUN") S X=0 F I=1:1 S X=$O(^%ZISL(107,X)) Q:X=""!(X'?.N)  D 1
 G:I=1 Q D NOW^%DTC S Y=% X ^DD("DD") S ^%ZISL(107,"END")=Y D R,^ZISLSTA2
Q X "J ^ZISLSTAT" Q
1 S D=^%ZISL(107,X,0),T=$P(D,"^",2) Q:T=""!($P(D,"^",7)'?.NP)!($L($P(D,"^",7))=0)!($L(T)>2)!(T'?.AN)  S Z=+$E($P(D,"^",7),1,2),L=$P(D,"^",3),P=$P(D,"^",4),Z1=$P(D,"^",7)
 W "." S ^%ZISL(107,"S",T)=$S($D(^%ZISL(107,"S",T)):^(T)+1,1:1),^%ZISL(107,"S","TIME",Z)=$S($D(^%ZISL(107,"S","TIME",Z)):^(Z)+1,1:1)
 I L["P" S L=P,P=$P(D,"^",3)
 Q:$L(L)'=5!(L'?.NA)
 I T["C" S ^%ZISL(107,"S",L,"C",Z1)=P G 2
 I T="DF" S ^%ZISL(107,"S",L,"D",Z1)="" G 2
 I T["D" S ^%ZISL(107,"S",L,"D",Z1)=P G 2
 I T["F" G 2
 Q
2 S ^%ZISL(107,"S",L,"TT",T)=$S('$D(^%ZISL(107,"S",L,"TT",T)):1,1:^(T)+1)
 Q
R S X="L" F I=1:1 S X=$O(^%ZISL(107,"S",X)) Q:X="R"!(X="")  D R1
 Q
R1 S (Y,Z2)=0 F J=1:1 S Y=$O(^%ZISL(107,"S",X,"C",Y)) Q:Y=""  D R2
 S T1=Z2,Z1=Z2\3600,Z3=Z2#3600,Z4=Z3\60,Z3=Z3#60 S:$L(Z1)=1 Z1="0"_Z1 S:$L(Z4)=1 Z4="0"_Z4 S:$L(Z3)=1 Z3="0"_Z3
 S Z2=Z1_":"_Z4_":"_Z3,^%ZISL(107,"S","R",X)=Z2,$P(^%ZISL(107,"S","R",X),"^",27)=T1,Y=0 F J=1:1 S Y=$O(^%ZISL(107,"S",X,"TT",Y)) Q:Y=""  D R4
 Q
R2 S Z=$O(^%ZISL(107,"S",X,"D",Y)) Q:Z=""  F K="Y","Z" S @(K_1)=($P(@K,":",1)*3600)+($P(@K,":",2)*60)+$P(@K,":",3)
 S:Z1<Y1 Z1=Z1+86400 S Z2=Z2+Z1-Y1
 Q
R4 S Z1=$O(^%ZISL(107.1,"B",Y,0)) Q:Z1=""  S Z1=Z1+1,$P(^%ZISL(107,"S","R",X),"^",Z1)=$P(^%ZISL(107,"S","R",X),"^",Z1)+^%ZISL(107,"S",X,"TT",Y)
 Q
