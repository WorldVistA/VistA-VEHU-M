XUUSER ;ROUTINE TO PRINT OUT WHAT A USER CAN DO -- MJK 5/1/83 -- ; 25APR84 17:38
 ;;5.01;
1 K X S U="^",HD=0 R !!,"ENTER USER OR 'ALL': ",X:$S($D(DTIME):DTIME,1:60) S:'$T X=U Q:X=U!(X="")  I X="?" S DIC="^DIC(3,",DIC(0)="QE" D ^DIC W !,?4,"or 'ALL'" G 1
 S XX=X D BEG S X=XX I X="ALL" S I="" G ALL
 S DIC="^DIC(3,",DIC(0)="ZM" D ^DIC G:Y<0 1 S US=+Y D HLD,PRT,KILL G END
ALL S I=$N(^DIC(3,"B",I)) G:I<0 ALLF S US=$N(^(I,0)),Y(0)=^DIC(3,US,0) D HLD,PRT W:'$D(FL) *7,!!,"***** This user has no access privileges. *****",! G ALL
ALLF D KILL G END
 ;
PRT U IO D HD0 K FL S HD=1,JJ=""
PRT1 S JJ=$N(HLDX(JJ)) Q:JJ<0  S DIC="^DIC(18,",DIC(0)="",D="D",X=JJ D IX^DIC G:Y<0 PRT1 S FL="",SY=+Y D HD0:$Y'<(IOSL-5) W !,$E($P(^DIC(18,SY,0),U,1),1,14)
 W ?15,HLDX(JJ) F M=0:0 S M=$N(^DIC(18,SY,100,M)) G:M'>0 PRT1 D PRT2
 Q
 ;
PRT2 I HLDX(JJ)[$P(^(M,0),U,6) D HD0:$Y'<(IOSL-5) W !,?35,$P(^(0),U,1) F N=0:0 S N=$N(^DIC(18,SY,100,M,100,N)) Q:N'>0  I HLDX(JJ)[$P(^(N,0),U,6) D HD0:$Y'<(IOSL-5) W !,?55,$P(^(0),U,1)
 Q
 ;
HD0 I $E(IOST,1)="C",HD=1 W !!,*7,"Press 'RETURN' to continue!" R X:$S($D(DTIME):DTIME,1:60) S:'$T X=U Q:X=U
HD W #,?18,"******* ACCESS PRIVILEGES FOR ",$P(Y(0),U,1)," *******",!
 W !!!,"SYSTEM",?15,"DUZ STRING",?35,"OPTION",?55,"ROUTINE",!,"------",?15,"----------",?35,"------",?55,"-------"
 Q
 ;
BEG W !! K IO S (IO,IO(0))=$I S %ZIS="F" D ^%ZIS I $D(IO("C")) W !!,"EXIT",! C IO(0) D KILL^XUOPT
 Q
 ;
END H:$D(IO("C"))  C:IO'=IO(0) IO U IO(0) Q
 ;
KILL K CODE,HLDX,HD,GRP,FL,D,JJ,I,K,M,N,PKG,SY,UCI,US,XX,Y Q
 ;
HLD K HLDX X ^%ZOSF("UCI") S UCI=Y Q:'$D(^DIC(3,US,.2,UCI,0))
 F N=0:0 S N=$N(^DIC(3,US,.2,UCI,1,N)) Q:N<1  S PKG=^(N,0) D GRP S HLDX($P(PKG,U,1))=$P(PKG,U,2)_$S(GRP]"":" "_GRP,1:"")
 Q
 ;
GRP S GRP="" Q:$P(PKG,U,4)']""  S X=$P(PKG,U,1),DIC="^DIC(18,",DIC(0)="",D="D" D IX^DIC Q:Y<0  S SY=+Y Q:'$D(^DIC(18,SY,50))
 F K=0:0 S K=$N(^DIC(18,SY,50,K)) Q:K'>0  I $P(^(K,0),U,1)=$P(PKG,U,4) S GRP=$P(^(0),U,2) Q
