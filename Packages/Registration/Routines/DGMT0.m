DGMT0 ;ALB/JDS - MEANS TEST ;01 JAN 1986
 ;;MAS VERSION 5.1;
 D 1
EN1 S DGP=$P(^DG(41.3,DFN,0),U,2),DGS=""
 F I=0:0 S I=$N(^DG(41.3,DFN,2,I)) Q:I'>0  I '$D(DGK)!(DA'=I) S J=^(I,0) I $P(J,U,2)'=I S DGS=$P(J,U,2) Q
 I '$O(^DG(41.3,DFN,2,0)) S DIK="^DG(41.3,",DA=DFN D ^DIK K DIK G Q
 G Q:DGP=DGS I DGP]"" S DA=DFN,X=DGP F I=0:0 S I=$N(^DD(41.3,2,1,I)) Q:I'>0  X ^(I,2)
 S $P(^DG(41.3,DFN,0),U,2)=DGS I DGS]"" S DA=DFN,X=DGS F I=0:0 S I=$N(^DD(41.3,2,1,I)) Q:I'>0  X ^(I,1)
Q S X=$S($D(%X):%X,1:"") K %X F I="DA(1)","DA(2)","DA" I $D(@("DG"_I))#2 S @I=@("DG"_I) K @("DG"_I)
 Q
Q1 S X=$S($D(%X):%X,1:"") K %X,DA F I="DA(1)","DA(2)","DA" I $D(@("DGG"_I))#2 S @I=@("DGG"_I) K @("DGG"_I)
 K A,DGDA,DGNO,DGX Q
EN S %X=$S($D(X):X,1:0) F I="DA","DA(1)","DA(2)" I $D(@I)#2 S @("DGG"_I)=@I
EN2 S DGMT=0 I $D(^DPT(DFN,.36)) S:$S($D(^DIC(8,+^(.36),0)):$P(^(0),U,9),1:0)=5 DGMT=1 I $P(^DPT(DFN,.36),U,2),+$P(^(.36),"^",2)<3 S DGMT=0
 I DGMT S I=$S($D(^DPT(DFN,.321)):^(.321),1:0) S:$P(I,U,2)="Y" DGMT=0 I DGMT S:$P(I,U,3)="Y" DGMT=0 I DGMT S I=$O(^DPT(DFN,"DIS",0)),I=$S($D(^(+I,0)):^(0),1:0) I $P(I,U,12) S DGMT=0
 I DGMT S DGT=2860701 D ^DGINPW I DG1 S A=DGA1,DGT=9999999 D ^DGINPW I DG1 I DGA1=A S DGMT=0 D INP
 K DG1,DGA1,DGT
 S J=$P($S($D(^DG(41.3,DFN,0)):^(0),1:0),U,2) G Q1:(J']""&('DGMT)),Q1:J="N"&('DGMT),Q1:("ABCRP"[J&(DGMT)&(J]"")),SET:'DGMT
 I '$D(^DG(41.3,DFN,0))#2 S ^(0)=DFN,$P(^(0),U,4)=$P(^DG(41.3,0),U,4)+1,DA=DFN,X=DFN F I=0:0 S I=$N(^DD(41.3,.01,1,I)) Q:I'>0  X ^(I,1)
 S:'$D(^DG(41.3,DFN,2,0)) ^(0)="^41.33DI^"_(9999999-DT)_"^1" S DA=9999999-DT,^(DA,0)=DT_U_"R",DA(1)=DFN,X="R" F K=0:0 S K=$N(^DD(41.33,2,1,K)) Q:K'>0  X ^(K,1):^(0)'["MUMPS"!(^(0)'["TRIGGER") I ^DD(41.33,2,1,K,0)["MUMPS" D EN1
 W:'$D(DGVERSIO) !,"MEANS TEST REQUIRED",! G Q1
SET W !,"MEANS TEST NO LONGER REQUIRED",! S:'$D(^DG(41.3,DFN,2,0)) ^(0)="^41.33DI^"_(9999999-DT)_"^1" I $D(^(9999999-DT,0)) S DIK="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DA=9999999-DT D ^DIK K DIK
 I '$O(^DG(41.3,DFN,2,0)) G DEL
 S:'$D(^DG(41.3,DFN,2,0)) ^(0)="^41.33DI^"_(9999999-DT)_"^1" S ^(9999999-DT,0)=DT_U_"N",DA(1)=DFN,DA=9999999-DT,X="N" F K=0:0 S K=$N(^DD(41.33,2,1,K)) Q:K'>0  X ^(K,1):^(0)'["MUMPS"!(^(0)'["TRIGGER") I ^DD(41.33,2,1,K,0)["MUMPS" D EN1,1
 G Q1
DEL S DIK="^DG(41.3,",DA=DFN D ^DIK G Q1
1 S %X=X F I="DA","DA(1)","DA(2)" I $D(@I)#2 S @("DG"_I)=@I
 Q
INP F I=2860700:0 S I=$O(^DGPM("APCA",DFN,A,I)) Q:'I  S DGDA=+$O(^(I,0)) I $D(^DGPM(DGDA,0)) S J=$P(^DGPM(DGDA,0),U,18) I "^13^43^"[(U_J_U) S DGMT=1 Q
 Q
PRINT ;S DFN=^%ZTSK(ZTSK,"DFN"),DGT=^("DGT") K ^%ZTSK(ZTSK),IOP,IO("Q")
PRINT1 W @IOF S DIC(0)="LM",X="DG1010F",DIC="^DIC(47," D ^DIC G Q:Y'>0 S DGY=+Y
 S DGLY=$E(DGT,1,3)-1_"0000" F I=1:1:5 S X(I)=$S($D(^DG(41.3,DFN,1,DGLY,1,I,0)):^(0),1:"")
 S DG0=$S($D(^DG(41.3,DFN,1,DGLY,0)):^(0),1:""),X(6)="" F I=2:1:15 F J=1:1:5 S $P(X(6),U,I)=$P(X(6),U,I)+$P(X(J),U,I)
 F I=12:1:14 F J=1:1:6 S $P(X(J),U,16)=$P(X(J),U,16)+$P(X(J),U,I)
 F I=1:1:6 S $P(X(I),U,17)=$P(X(I),U,16)-$P(X(I),U,15)
 S DGR=1 I $D(^DG(41.3,DFN,2,9999999-DGT,0)) S:$P(^(0),U,14) DGR=" CAT C"
 S (L,DGL)=0 F I=0:0 S I=$N(^DIC(47,+DGY,1,I)) Q:I'>0!(DGL=I)  S J=^(I,0),X="" W ! F K=1:1 W $E($P(J,"{}",K),$S(K=1:1,X']"":1,1:$L(X)-1),999) S X=$P(J,"{",K+1) Q:X']""  S L=L+1 D SE^DGMT2
 I '$D(DGOPT) D CLOSE^DGUTQ
 Q
