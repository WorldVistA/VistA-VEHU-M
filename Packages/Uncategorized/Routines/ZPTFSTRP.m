PTFSTRP ;XAK/ALBANY ; 14 AUG 84  9:07 am
 S A=0,U="^" K ^DPT("B")
N S A=$N(^DPT(A)) Q:A'>0  W "." W:A#100=0 !,"DFN = ",A
 I $D(^DPT(A,0)) I $L($P(^DPT(A,0),U,1))>0 S X=$P(^(0),U,1) D S S ^(0)=X_U_$P(^DPT(A,0),U,2,99),^DPT("B",X,A)=""
 I $D(^DPT(A,.11)) S STATE=$P(^(.11),"^",5) F I=1:1:4 I $L($P(^(.11),U,I))>0 S X=$P(^(.11),U,I) D S,S1 S $P(^DPT(A,.11),U,I)=X
 I $D(^DPT(A,.3)) I $L($P(^(.3),U,5))>0 S X=$P(^(.3),U,5) D S S $P(^DPT(A,.3),U,5)=X
 I $D(^DPT(A,.31)) I $P(^(.31),U,3)]"" S X=$P(^(.31),U,3) D S S $P(^DPT(A,.31),U,3)=X
 I $D(^DPT(A,.362)) S $P(^(.362),U,1,2)="^" K:^(.362)="^" ^(.362)
 I $D(^DPT(A,.3)),+$P(^(.3),"^",3) S $P(^(.3),"^",3)=$P(^(.3),"^",3)\100
 G N
S S X1=$E(X,$L(X)) S:X1=" " X=$E(X,1,$L(X)-1) Q:X1'=" "  G S
 Q
S1 S X1=$E(X,$L(X)-2,$L(X)) I X1=" NY",STATE=36 S X=$E(X,1,$L(X)-3) Q
 S X1=$E(X,$L(X)-3,$L(X)) I X1=" N Y",STATE=36 S X=$E(X,1,$L(X)-4)
 Q
