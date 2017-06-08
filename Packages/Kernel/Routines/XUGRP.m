XUGRP ;ROUTINE TO PRINT OUT WHAT 'DUZ USER GROUPS' CAN DO -- MJK 5/1/83 -- ; 16 MAY 83  4:40 PM
 ;VERSION #2 -- 5/12/83;5.01;
1 S U="^" R !!,"ENTER SYSTEM OR 'ALL': ",X:$S($D(DTIME):DTIME,1:60) S:'$T X=U Q:X=U!(X="")  I X="?" S DIC="^DIC(18,",DIC(0)="QE" D ^DIC W !,?4,"or 'ALL'" G 1
 S XX=X D BEG S X=XX G:X="ALL" ALL
 S DIC="^DIC(18,",DIC(0)="M" D ^DIC Q:Y<0  S SYS=+Y D PRT,KILL G END
ALL F SYS=0:0 S SYS=$N(^DIC(18,SYS)) Q:SYS'>0  D PRT
 D KILL G END
 ;
PRT Q:'$D(^DIC(18,SYS,50))  U IO W #!!,?18,"*********** USER GROUP PRIVILEGS ***********",!,"SYSTEM: ",$P(^DIC(18,SYS,0),U,1),! D HD
 F I=0:0 S I=$N(^DIC(18,SYS,50,I)) Q:I'>0  S CODE=$P(^(I,0),U,1),STG=$P(^(0),U,2) W !,CODE,?15,STG F J=0:0 S J=$N(^DIC(18,SYS,100,J)) Q:J'>0  D PRT1
 Q
 ;
PRT1 I STG[$P(^(J,0),U,6) W !,?35,$P(^(0),U,1) F M=0:0 S M=$N(^DIC(18,SYS,100,J,100,M)) Q:M'>0  I STG[$P(^(M,0),U,6) W !,?55,$P(^(0),U,1)
 Q
 ;
HD W !!!,"GROUP",?15,"DUZ STRING",?35,"OPTION",?55,"ROUTINE",!,"-----",?15,"----------",?35,"------",?55,"-------"
 Q
 ;
BEG W !! K IO S (IO,IO(0))=$I S %IS="F" D ^%IS I $D(IO("C")) W !!,"EXIT",! C IO(0) D KILL^XUOPT
 Q
 ;
END H:$D(IO("C"))  C:IO'=IO(0) IO U IO(0) Q
 ;
KILL K CODE,I,J,M,STG,SYS,X,XX,Y Q
