A1AXCNP1 ;SLL/ALB ISC; JCAHO CONTINGENCY REPORT PRINT PROCESSING; 12/1/87
 ;;VERSION 1.0
 ;HEADER
HD ;
 W # S X="JCAHO CONTINGENCY REPORT" W !!!?(IOM-$L(X)\2),X S %DT=+$H D %CDS^%H S Y=$P(%DAT1,"-",2)_" "_$P(%DAT1,"-",1)_",19"_$P(%DAT1,"-",3) S X="AS OF "_Y W !?(IOM-$L(X)\2),X
 S Y=$P(^DIZ(11833,1,0),"^",1)_" - DISTRICT "_A1AXDS
 W !?(IOM-$L(Y)\2),Y
 I Q>21 S X="-continued-" W !,?(IOM-$L(X)\2),X
 W !,"DATES:   Latest JCAHO Facility Review Dates"
 W !,"KEYS:   (+)  High Priority      (C) Contingency      (RC) Repeat Contingency   (M) Implementation Monitoring"
 Q
THD ;TABLE HEADER
 S $P(A1AXL,"=",(S-Q+1)*5+16)="" W !,A1AXL
 W !,"VAMC" S L=0 F I=Q:1:S S C=5*L+15,L=L+1 W ?C,$P(A1AXNB(I)," ",1)
 I S=A1AX S C=C+6 W ?C,"| FAC  FAC  |"
 W !,"SITE" S L=0 F I=Q:1:S S C=5*L+15,L=L+1 W ?C,$P(A1AXNB(I)," ",2)
 I S=A1AX S C=C+6 W ?C,"| TOT  RANK |"
 W !,A1AXL
 Q
