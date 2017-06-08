%ZUCI ;
 ;4.3
 ;FOR DSM
1 R !,"What UCI: ",%UCI,"  " Q:%UCI=""  G 2
 ;
2 ;
 I %UCI="PROD"!(%UCI="MGR") S %UCI=^%ZOSF(%UCI)
 S X=%UCI X ^%ZOSF("UCICHECK") G ERR:0[Y
V D SWAP
U W *7,!,"YOU'RE IN UCI: ",Y,!
 S $ZT="",%ST=$D(^%ZZ)
K K %ST Q
 ;
SWAP F %ST=1:1 Q:$ZU(%ST)=X
 V 148:$J:$V(148,$J)#256+(%ST*256) Q
 ;
ENT G 2:$D(%UCI)#2,1
 ;
START ;
 O $I S $ZT="^%ET" G N:$D(DUZ)
 S U="^",X=$S($D(^%ZIS(1,"AN",$I)):^($I),1:""),DUZ=+X,PGM=$P(X,U,2),DUZ(0)=$P(X,U,3),DTIME=$P(X,U,4)
N S USER=DUZ,PGM="^"_PGM K ^%ZIS(1,"AN",$I)
 G %BJ:PGM="^",%BJ:PGM="^%XUS1",@PGM
%BJ G PRGMODE^%ZTMS
GO ;
 D 2 G @(U_PGM)
 ;
DO S %UCI=$P(Z,"[",2,9),PGM=$P(Z,"[",1),%UCI=$E(%UCI,1,$L(%UCI)-1)
 I %UCI="PROD"!(%UCI="MGR") S %UCI=^%ZOSF(%UCI)
 E  S X=%UCI X ^%ZOSF("UCICHECK") G ERR:0[Y
 X ^%ZOSF("UCI") D D S %UCI=Y G 2
D N Y D 2 G @PGM
 ;
ERR W !?9,"'"_X_"' IS AN INVALID UCI!",!
