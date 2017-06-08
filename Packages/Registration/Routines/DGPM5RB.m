DGPM5RB ;ALB/MRL - CREATE ROOM (405.4) FILE ; 6 JAN 89
 ;;MAS VERSION 5.0;
 ;
 W !!,"Moving ROOM-BEDS into file 405.4"
GO K ^UTILITY("DGPMRB",$J) S X=^DG(405.4,0),X=$P(X,"^",1,2)_"^^" K ^DG(405.4),^DG5(1,"RE") S ^DG(405.4,0)=X,X=^DG(405.6,0),X=$P(X,"^",1,2)_"^^" K ^DG(405.6) S ^DG(405.6,0)=X,(IFN,DIFN,TIFN)=0,L="",$P(L,"=",79)=""
 S R="" F I=0:0 S R=$O(^DIC(42,"R",R)),(C,W)=0 Q:R=""  F I1=0:0 S W=$O(^DIC(42,"R",R,W)),N=0 Q:W'>0  S C=C+1,WN=$P(^DIC(42,+W,0),"^",1) F I2=0:0 S N=$O(^DIC(42,"R",R,W,N)) Q:N'>0  D SET
Q W ! K ^UTILITY("DGPMRB",$J),D,D1,DGPMRB,DGPGM,DGVAR,DIFN,B,BN,C,I,I1,I2,I3,IFN,L,L1,L2,N,R,RB,RBIFN,RN,T,T1,TIFN,W,WN,X,Z,Z1 D CLOSE^DGUTQ Q
SET S Z=$S($D(^DIC(42,+W,2,+N,0)):^(0),1:"") I Z']"" Q
 S $P(Z,"^",3)=$S($P(Z,"^",3)]"":$E($P(Z,"^",3),1,30),1:"NO DESCRIPTION") S:$P(Z,"^",3)'?1P.E $P(Z,"^",3)="NO DESCRIPTION" S D=$O(^DG(405.6,"B",$P(Z,"^",3),0)) I D>0,$D(^DG(405.6,+D,0)) S D=D_"^"_$P(Z,"^",3)
 E  S X=$P(Z,"^",3),DIFN=DIFN+1,^DG(405.6,DIFN,0)=X,^DG(405.6,"B",X,DIFN)="",X=^DG(405.6,0),X=$P(X,"^",1,2)_"^"_DIFN_"^"_DIFN,^DG(405.6,0)=X,D=DIFN_"^"_$P(Z,"^",3)
 S RN=R I R'?.UN S X="" X "F I3=1:1:$L(R) S I4=$E(R,I3) I I4?.UN S X=X_I4" S RN=X
 S B=0 F I3=0:0 S B=$O(^DIC(42,W,2,N,1,B)) Q:B'>0  I $D(^(B,0)) S BN=$P(^(0),"^") D BED,TMP
 Q
BED S RB=RN_"-"_BN I 'DGPMRB,$D(^UTILITY("DGPMRB",$J,RB)) S RBIFN=+^(RB) D WARD Q
 S IFN=IFN+1,^DG(405.4,IFN,0)=RB_"^"_+D,^DG(405.4,"B",RB,IFN)="" S:BN]"" ^DG(405.4,"BD",BN,IFN)="" S $P(^(0),"^",3,4)=IFN_"^"_($P(^DG(405.4,0),"^",4)+1)
 W:'(IFN#10) "."
 S RBIFN=IFN D WARD S ^UTILITY("DGPMRB",$J,RB)=RBIFN
 Q
 ;
WARD S:'$D(^DG(405.4,RBIFN,"W",0)) ^(0)="^405.41P^^" S ^DG(405.4,RBIFN,"W",W,0)=W,^DG(405.4,RBIFN,"W","B",W,W)="",^DG(405.4,"W",W,RBIFN,W)=""
 S $P(^(0),"^",3,4)=W_"^"_($P(^DG(405.4,RBIFN,"W",0),"^",4)+1)
 Q
 ;
TMP ;Store 'Old' Room-bed and 'New' Room-bed Relationship in File 405.9
 S:'$D(^DG5(1,"RE",0)) ^(0)="^405.9003A^^" S TIFN=TIFN+1,^DG5(1,"RE",TIFN,0)=RN_"^"_BN_"^"_W_"^"_RBIFN,^DG5(1,"RE","B",R,TIFN)="",$P(^(0),"^",3,4)=TIFN_"^"_($P(^DG5(1,"RE",0),"^",4)+1)
 S ^DG5(1,"RE","R",W,R_"-"_BN,RBIFN)=""
 Q
