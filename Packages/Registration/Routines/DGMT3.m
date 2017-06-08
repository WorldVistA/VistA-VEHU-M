DGMT3 ;ALB/JDS - MEANS TEST ;01 JAN 86
 ;;MAS VERSION 5.1;
IN K DGMTERR D UP^DGHELP S L=X,X="" F I=1:1:31 S K=0 D SET S X=X_$S($L(K)=1:K,1:0)
 I $D(DGMTERR) W !,"Not in proper format" K Y Q
 S Y(0)=X D OUT W "  ",Y K Y Q
 Q
SET F J=1:1 S M=$P(L,",",J) Q:M']""  I M D L:M["-" Q:K  I +M=I S K=1 Q
 Q:'K  S M=$S(M["(":M,1:$P($E(L,$F(L,M),99),")",1))
 I K,'DGO S:M["(A" K="A" F J=1:1:9 Q:K="A"  I M[("("_$P("M^SU^SC^P^NH^I^R^B^N",U,J)) S K=J Q
 I K,(DGO=1) F J=1:1:3 I M[("("_$P("A^U^R",U,J)) S K=J Q
 I K,(DGO=2) S:M["(S" K=2
 Q
L I +M'<$P(M,"-",2) S M=0,DGMTERR=1 Q
 I +M'>I&($P(M,"-",2)'<I) S K=1 Q
 Q
OUT S (Y,S,S1)="",(C1,C2)=0
 F Z=1:1:33 S C=$E(Y(0),Z) S:C?1U C=$A(C)-55 D S:(C'=C1) S:'C1&('C) C2=0 S:(C1!C) A=C=C1,B=C1=C2,Y=Y_$S(C:$S('C1:$S(Y]"":$S(S1=S:"",1:S1)_","_Z,1:Z),A&('B):"-",A&B:"",'A&(B):(Z-1)_S1_","_Z,1:S1_","_Z),1:$S(C1&B:(Z-1),1:"")) S C2=C1,C1=C
 S Y=Y_S Q
S S S1=S
 Q:'C  I DGO=2 S S="(N)" S:C=2 S="(SPE)" Q
 S S="("_$P($S(DGO:"APP^UNS^REG",1:"MED^SUR^SCI^PSY^NH^INT^REH^BLI^NEU^ALC"),U,C)_")" Q
 Q
DGSD K DGIN S $P(DGIN,"0",32)="",DGIS=DGIN S I=$O(^DGPM("ATID1",DFN,(9999999.9999999-DGED))) G DIA:'I
 F I=0:0 S I=$O(^DGPM("APTT1",DFN,I)) Q:'I  S DGCA=+$O(^DGPM("APTT1",DFN,I,0)) I $D(^DGPM(DGCA,0)) S DGNO=^(0) S X=$S($D(^DGPM(+$P(DGNO,"^",17),0)):$P(^(0),"^"),1:"") G INP:'X!(X>DGSD)
 G DIA
INP S (P,S)=0 F DGT=DGSD+1.9:1:DGED Q:DGT>(DT+.9)  D ^DGINPW I DG1 I "^1^2^3^25^26^43^45^"'[(U_($S($P(DG1,U,3)]"":$P(DG1,U,3),1:0))_U) S I=+$E(DGT,6,7) D SER:DG1'=P!(S=4) S DGIN=$E(DGIN,0,I-1)_S_$E(DGIN,I+1,31),P=DG1
 F I=9999998.99999-DGED:0 S I=$N(^DGPM("ATID1",DFN,I)) Q:I'>0  F DGDO=0:0 S DGDO=$N(^DGPM("ATID1",DFN,I,DGDO)) Q:DGDO'>0  S DGT=9999999.9999999-I Q:DGT<DGSD  I $D(^DGPM(DGDO,0)),$P(^(0),"^",17) S D1=$P(^(0),"^",17) D OD
DIA I $D(^DG(41.2,DFN)) F DGT=DGSD:1:DGED I $D(^DG(41.2,DFN,DGT)) S I=+$E(DGT,6,7) I '$E(DGIN,I) S DGIN=$E(DGIN,0,I-1)_1_$E(DGIN,I+1,31)
 Q
SER S S=$S($D(^DIC(42,+DG1,0)):$P(^(0),U,3),1:0),S=+$P("^M;1^S;2^P;4^I;6^R;7^D;0^B;8^NH;5^NE;9^SCI;3",(U_S_";"),2) I S=4 D TREAT^DGINPW S:DG2=72 S="A"
 Q
OD I +^DGPM(+D1,0)\1=(+^DGPM(DGDO,0)\1) S DG1=+$P(^(0),U,6) D SER S J=+$E(DGT,6,7),DGIN=$E(DGIN,0,J-1)_S_$E(DGIN,J+1,31) Q
