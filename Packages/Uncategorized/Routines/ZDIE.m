DIE ; ; 17DEC1986 10:10 PM
 ;;17.32;VA FileMan; 8/19/87
 K DB,DTOUT I DIE S DIE=^DIC(DIE,0,"GL")
 S U="^",DP=+$P(@(DIE_"0)"),U,2)
GO Q:DIE?1"^DIA(".E  K DE,DOV,DIOV,DIEC S DL=1,DR(1,DP)=DR,(DQ,DIEL,DK,DP(0))=0,D0=DA D INI
MR S DK=DK+1,DH=$P(DR,";",DK) I +DH=DH S (DI,DM)=DH G S:$D(^DD(DP,DI)),MR
 S DI=$P(DH,":",1) I 'DI G K:DI=0,PB
J I DH["//" S DE(DQ+1,0)=$P(DH,"//",2,9),DI=$P(DI,"//",1),DH=""
 G K:+DI=DI S DM=+DI,Y=$P(DI,DM,2,99),DI=DM G MR:Y=""!'$D(^DD(DP,DI,0)) S DQ=DQ+1,DQ(DQ)=^(0),DIFLD(DQ)=DI
 F %=1:1 S DIG=$P(Y,$C(126),%) Q:DIG=""  S:DIG="d" $P(DQ(DQ),U,2)=$P(DQ(DQ),U,2)_DIG S:DIG'="d" $P(DQ(DQ),U,1)=$S(DIG="T"&$D(^(.1)):^(.1),1:DIG)
 K DIG G Y
K S DM=$P(DH,":",2),DM=$S(DM:DM,1:DI) I DI,$D(^DD(DP,DI)) G S
NX S DI=$N(^DD(DP,DI)) G MR:DI'>0,MR:DI>DM
S I $S<2000,DQ,'$D(DE(DQ+1)) G H
 S DQ=DQ+1,DQ(DQ)=^(DI,0),DIFLD(DQ)=DI
Y S Y=$P(DQ(DQ),"^",4),DG=$P(Y,";",1)
 I $D(^(1))!($P(DQ(DQ),U,2)["a") S DE=0,DB=DM,DM=0 F DW=1:1 S DE=$N(^DD(DP,DI,1,DE)) Q:DE<1  S DE(Y)=DQ,DE(Y,DW,1)=^(DE,1),DE(Y,DW,2)=^(2)
 I $P(DQ(DQ),U,2)["a" S DE(Y,DW,2)="S DIIX=2_U_DIFLD(DE(DQ)) D AUDIT^DIET",DE(Y,DW,1)="S DIIX=3_U_DIFLD(DE(DQ)) D AUDIT^DIET",DE(Y)=DQ
 S Y=$P(Y,";",2) I DU'=DG S D="",DU=DG,@DC G M:Y=0,B:DU=" ",EQ:DW[0 S D=^(DG)
 I Y S:$P(D,"^",Y)]"" DE(DQ)=$P(D,"^",Y)
 E  S Y=$E(D,+$E(Y,2,9),$P(Y,",",2)) S:Y'?." " DE(DQ)=Y
EQ G MR:DI=DM,NX:DM S DM=DB K DB G D
 ;
INI S DIC=DIE,DU=-1,DC="DW=$D("_DIE_DA_",DG))"
Q Q
 ;
MORE ;
 D INI G MR:DI=DM,NX:DI'[U S DI=+DI G S:$D(^DD(DP,DI)),MR
JMP ;
 D INI G J
 ;
PB I DH="" G D:$D(DR(DL,DP))<9 S:'$D(DOV) DOV=0,DR(DL,DP)=DR S DOV=$N(DR(DL,DP,DOV)) G D:DOV'>0 S DR=DR(DL,DP,DOV),DK=0 G MR
 G MR:DH?1"@".N I 'DQ G TEM:DH?1"[".E S:"Q"'=DH DQ=1,DQ(0,1)=DH G MR:$A(DH)-94 S DC=$P(DH,U,1,4) X $P(DH,U,5,999) G O^DIE0
E S DK=DK-1,(DI,DM)=1
D G DQ^DIED
 ;
H S DI=DI_U G D
 ;
M S Y=$P(DQ(DQ),U,2)_U_DG G DC:DW<9
 I $D(DSC(+Y))#2,$P(DSC(+Y),"I $D(^UTILITY(",1)="" S D=DIEL+1 D D1 X DSC(+Y) S D=$N(^(0)) S @DC S DC=$N(^(DG,0)) G DE
 S D=$S($D(^(DG,0)):$P(^(0),U,3,4),1:$N(^(0)))
DE I D>0 S Y=Y_U_D I DP(0)-Y,$D(^(+D,0)) S DE(DQ)=$P(^(0),U,1)
DC S DC=$P(^DD(+Y,0),U,4)_U_Y,%=DQ(DQ),Y=^(.01,0),DQ(DQ)="Select "_$P(Y,U,1)_U_1_$P(Y,U,2,99) G D:$P(Y,U,2)'["W"
 I DQ>1 K DQ(DQ) G E:$D(DE(DQ,0)),H
 S Y=$P(%,U,1)_U_$P(Y,U,2) D DIEN^DIWE K DQ,DG,DE S DQ=0 G MORE
 ;
D1 Q:D'>0  S @("D"_D)=0,D=D-1 G D1
 ;
B K DQ(DQ) S DQ=DQ-1,DU=-9 G EQ
 ;
TEM F Y=0:0 S Y=$N(^DIE("B",$P($E(DR,2,99),"]",1),Y)) G Q:'$D(^DIE(+Y,0)) Q:$P(^(0),U,4)=DP
 I $D(^("ROU")),^("ROU")[U G @^("ROU")
 S:$D(^("W")) DIE("W")=^("W") S %X="^DIE(+Y,""DR"",",%Y="DR(" D %XY^%RCR
 S DIE("^")=DR,DR=$S($D(^DIE(Y,"DR"))#2:^("DR"),1:DR(1,DP)) D DIE K DR S DR=DIE(U)
