ZINTEG ;$A OF PROGRAMS ;JDS
 K ^UTILITY($J) D ^%RSEL Q:'$D(%GO)
EN1 S I="" D CC
EN S I=$N(^UTILITY($J,I)) Q:I=-1  S T=0 W !,I X "ZL @I F Y=1:1:99 S L=$T(+Y),LN=$L(L) X CC S:'LN Y=99" S ^UTILITY($J,I)=T W !,I,?15,T G EN
 Q
CC S CC="F C=1:1:LN S T=$A(L,C)+T" Q
IN S A=$N(^UTILITY($J,A)) Q:A=-1  S X=A_" ;"_^(A) X "ZL DGINTEG ZR @(A) ZI X ZS DGINTEG" G IN
