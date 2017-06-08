RJPTFOU1 ;RJ WILM DE -LIST DRG'S PER DX PER MOVEMENT; 12-12-85
 ;;4.0
 S RJPTF=^DGPT(I,0),RJPAT=^DPT($P(RJPTF,U,1),0) U IO
 W ! F L=1:1:131 W "="
 W !,I,?6,$E($P(RJPAT,U,1),1,20),?24,$E($P(RJPAT,U,9),6,9),?33 S D=$P(RJPTF,U,2),X2=D D D W Z(2),?45 I $D(^DGPT(I,70)) S D=$P(^DGPT(I,70),U,1),X1=D D D W Z(2),?59 D ^%DTC W X,?66 S D=$P(RJPAT,U,3) D D W Z(2)
 W ?80,"STATUS:" I '$D(^DGP(45.84,I,0)) W ?92,"NO",?103,"NO",?115,"NO" Q
 W ?92,"YES" S D=$P(^(0),U,2) W:D="" ?103,"NO" W:D'="" ?103,"YES" S D=$P(^(0),U,4) W:D="" ?115,"NO" W:D'="" ?115,"YES"
 W !,?6 F K=1:1:71 W "-"
 W ?80 F K=81:1:131 W "#"
 Q:'$D(^DGPT(I,70))  Q:$P(^(70),U,10)=""
 W !,?6,"DXLS ",$P(^ICD9($P(^(70),U,10),0),U,1),?19,$E($P(^ICD9($P(^DGPT(I,70),U,10),0),U,3),1,25),?45 W:$D(^DGPT(I,"RJ",0)) ^(0)
 I $D(^DGPT(I,"RJ",0)) S RJDRG=^ICD(^DGPT(I,"RJ",0),0),G=$J($P(RJDRG,U,2)*(RJPTFUN),0,2) W ?53,$P(RJDRG,U,3),?63,$P(RJDRG,U,4),?72,$P(RJDRG,U,2),?80,G,?98,"NA" S:'$D(^DGPT(I,"MO")) ^DGPT(I,"MO")=G
 S K=0 F K=0:0 S K=$O(^DGPT(I,"M",K)) Q:K=""!(K'?.N)  D M
 S K=0 F K=0:0 S K=$O(^DGPT(I,"S",K)) Q:K=""!(K'?.N)  D S
 W ! F L=1:1:125 W "+"
 I $D(^DGPT(I,"401P")) F K=1:1 Q:$P(^DGPT(I,"401P"),U,K)=""  S L=$P(^DGPT(I,"401P"),U,K) W !,?11,$P(^ICD0(L,0),U,1),?19,$P(^ICD0(L,0),U,4)
 Q
M W !,?6 F L=1:1:125 W "-"
 W !,?5,K,?6,"****" S RJPTF=^DGPT(I,"M",K,0),D=$P(RJPTF,U,10) D D W Z(2),?30,$P(^DIC(42.4,$P(RJPTF,U,2),0),U,1)
 F Z=5:1:9,11:1:15 D DXL
 Q
DXL S:Z<11 L=Z-4 S:Z>10 L=Z-5 Q:$P(^DGPT(I,"M",K,0),U,Z)=""  W !,?6,"dx",L,?11,$P(^ICD9($P(^DGPT(I,"M",K,0),U,Z),0),U,1),?19,$E($P(^ICD9($P(^DGPT(I,"M",K,0),U,Z),0),U,3),1,25) W:$D(^DGPT(I,"RJ",K)) ?45,$P(^(K),U,L)
 I $D(^DGPT(I,"RJ",K)) S:$P(^(K),U,L)'="" RJDRG=^ICD($P(^(K),U,L),0),G1=$J($P(RJDRG,U,2)*(RJPTFUN),0,2) S:$P(^DGPT(I,"RJ",K),U,L)="" G1=0
 I G1>G&($D(^DGPT(I,"RJ",K))) W ?53,$P(RJDRG,U,3),?63,$P(RJDRG,U,4),?72,$P(RJDRG,U,2),?80,G1,?96,$J(G1-G,8,2)
 I $D(^DGPT(I,"RJ",K)) W:$P(^DGPT(I,"RJ",K),U,L)="" "**DRG Calculator has not been run for this diagnosis."
 Q
S W !,?6 F L=1:1:125 W "-"
 W !,?5,K,"====" S RJPTF=^DGPT(I,"S",K,0),D=$P(RJPTF,U,1) D D W Z(2) F L=8:1:12 Q:$P(RJPTF,U,L)=""  W !,?6,"op#",L-7,?11,$P(^ICD0($P(RJPTF,U,L),0),U,1),?19,$P(^ICD0($P(RJPTF,U,L),0),U,4)
 Q
D Q:D=""  S Z(2)=$S($E(D,1)=1:18,$E(D,1)=2:19),Z(2)=$P(Z(1),U,$E(D,4,5))_" "_$E(D,6,7)_","_Z(2)_$E(D,2,3)
 Q
H U IO W @IOF,"Pat",?22,"Last four",?33,"Date of",?45,"Date of",?57,"Length",?66,"Date of",?80,"Record",?90,"Data",?100,"DRG",?112,"Released"
 W !,"Num",?6,"Patient Name",?22,"of SSN",?33,"Admission",?45,"Discharge",?57,"of Stay",?66,"Birth",?80,"STATUS:",?90,"Checker",?100,"Calculator",?112,"to Austin"
 W !,?6 F L=1:1:71 W "-"
 W ?80 F L=81:1:131 W "#"
 W !,?6,"DXLS",?11,"ICD9#",?19,"Description",?45,"DRG",?51,"Low Trim",?60,"High Trim",?72,"WWU",?80,"Funding",?98,"NA"
 W !,?6 F L=1:1:125 W "-"
 W !,?5,"#**** Movement date",?30,"Losing bedsection"
 W !,?6,"dx#",?11,"ICD9#",?19,"Description",?45,"DRG",?51,"Low trim",?60,"High trim",?72,"WWU",?80,"Funding",?92,"Potential Gain"
 W !,?6 F L=1:1:125 W "-"
 W !,?5,"#==== Surgery Procedure Date",!,?6,"op#",?11,"OPcode",?19,"Description"
 W !,?6 F L=1:1:125 W "+"
 W !,?6,"Procedures"
 Q
