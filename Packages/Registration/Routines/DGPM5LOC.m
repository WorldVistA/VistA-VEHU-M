DGPM5LOC ;ALB/AS - V5 PRE-INIT TO CHECK FOR LOCAL FIELDS,X-REF ; 12/5/89 @12
 ;;MAS VERSION 5.0;
 ;
 D Q S DGLOCAL="",X="^.01^.015^.017^.02^.03^.04^.045^.06^.07^.08^.09^.1^.101^.9^1.01^1.02^1.025^1.027^1.03^1.05^1.11^1.12^1.13^1.14^1.15^1.5^1.6^1.7^1.8^1.9^2^3.1^3.2^5^10^19^20^"
 F I=0:0 S I=$O(^DD(2.95,I)) Q:I'>0  S J=U_I_U I X'[J S DGF(2.95,I)=$S($D(^DD(2.95,I,0)):$P(^(0),U,1),1:"")
 S (X,DGX)="^AA^AAR^AINPT^AMIS^AOUPT^ASCHADM^",K=""
 F I=0:0 S K=$O(^DD(2.95,0,"IX",K)) Q:K']""  S J=U_K_U I X'[J S D=2.95 D DGC
 S X="^.01^.02^.04^.045^.05^.06^.07^.08^.09^.11^.12^.99^" F I=0:0 S I=$O(^DD(2.96,I)) Q:I'>0  S J=U_I_U I X'[J S DGF(2.96,I)=$S($D(^DD(2.96,I,0)):$P(^(0),U,1),1:"")
 S (X,DGY)="^AC^AD^AE^AT^ATT^",K=""
 F I=0:0 S K=$O(^DD(2.96,0,"IX",K)) Q:K']""  S J=U_K_U I X'[J S D=2.96 D DGC
 S X="^.01^2^3^10^1000^1001^" F I=0:0 S I=$O(^DD(2.9501,I)) Q:I'>0  S J=U_I_U I X'[J S DGF(2.9501,I)=$S($D(^DD(2.9501,I,0)):$P(^(0),U,1),1:"")
 F I=2.9502,2.951 F J=0:0 S J=$O(^DD(I,J)) Q:J'>0  S K=U_J_U I "^.01^"'[K S DGF(I,J)=$S($D(^DD(I,J,0)):$P(^(0),U,1),1:"")
 I $D(^DD(2.9501,0,"IX")) S K="",D=2.9501 F I=0:0 S K=$O(^DD(D,0,"IX",K)) Q:K']""  D DGC
 I $D(^DD(2.9502,0,"IX")) S K="",D=2.9502 F I=0:0 S K=$O(^DD(D,0,"IX",K)) Q:K']""  D DGC
 I $D(^DD(2.951,0,"IX")) S K="",D=2.951 F I=0:0 S K=$O(^DD(D,0,"IX",K)) Q:K']""  D DGC
 S K="",D=2 F I=0:0 S K=$O(^DD(2,0,"IX",K)) Q:K']""  S J=$O(^(K,0)) I $S(J=2.9501:1,J=2.9502:1,J=2.951:1,J=2.95&(DGX'[K):1,J=2.96&(DGY'[K):1,1:0) D DGC
 I $D(DGC)!($D(DGF)) S DGLOCAL=1,DGPGM="PRINT^DGPM5LOC",DGVAR="DGF^DGC" D ZIS^DGUTQ I 'POP U IO D PRINT
Q K DGF,DGC,DGPGM,DGVAR,D,I,J,K,L,M,X,POP Q
DGC S L=$O(^DD(D,0,"IX",K,0)),M=$O(^DD(D,0,"IX",K,+L,0)),DGC(L,+M)=$S($D(^DD(L,+M,0)):$P(^(0),U),1:"")_U_K
 Q
PRINT ;
 W @IOF,"SUB-FILE #",?15,"FIELD #",?25,"FIELD NAME" I $D(DGC) W ?60,"CROSS-REFERENCE"
 I $D(DGF) F I=0:0 S I=$O(DGF(I)) Q:I'>0  F J=0:0 S J=$O(DGF(I,J)) Q:J'>0  W !,I,?15,J,?25,$P(DGF(I,J),U)
 I $D(DGC) F I=0:0 S I=$O(DGC(I)) Q:I'>0  F J=0:0 S J=$O(DGC(I,J)) Q:J'>0  W !,I,?15,J,?25,$P(DGC(I,J),U),?55,$P(DGC(I,J),U,2)
 W ! G Q
