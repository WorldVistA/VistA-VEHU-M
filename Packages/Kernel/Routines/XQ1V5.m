XQ1 ;LEX/TCS,SF/GFT,SEA/AMF - USED WITH V5 KERNEL & V6 ZTM ; 2/1/89  12:14 ;
 ;;6.0;
 S DIC=19,DIC(0)="AEQM" D ^DIC Q:Y<0  S XQM=+Y G ^XQ
DVARS S U="^" I '$D(DUZ) S DUZ=^XUTL("XQ",$J,"DUZ")
 I '$D(DT) S %H=$H D YMD^%DTC S DT=X
 I '$D(DUZ("AG")),$D(^XMB(1,1,0)) S DUZ("AG")=$P(^(0),U,8)
 I DUZ,'$D(DTIME) S DTIME=$S('$D(^DIC(3,DUZ,200)):"",1:$P(^(200),U,10)) I '$L(DTIME) S DTIME=$S('$D(^%ZIS(1,$I,"XUS")):"",1:$P(^("XUS"),U,10)) I '$L(DTIME) S DTIME=$P(^XMB(1,1,"XUS"),U,10)
 I '$D(DUZ(0)) S DUZ(0)=$P(^DIC(3,DUZ,0),U,4)
 I DUZ,'$D(DUZ("AUTO")) S DUZ("AUTO")=$S($D(^DIC(3,DUZ,200)):$P(^(200),U,6),1:0)
 Q
INIT ;
 K DIC,Y Q:$D(DUZ)[0  Q:'$D(^DIC(3,DUZ,0))
UI D DVARS S Y=XQM,(X,Y(0))=^DIC(19,XQM,0),^XUTL("XQ",$J,"T")=0,^("C")=Y,^("DUZ")=DUZ,^("XQM")=XQM,XQPSM="P"_XQM
 Q
 ;
ZTSK ;
 S DUZ=+$P(^%ZTSK(ZTSK,0),"^",3) S:'$D(XQM)&$D(^(1)) XQM=^(1) D UI Q:'$D(^DIC(19,XQM,0))  S XQ=$P(^(0),U,4) Q:XQ'="A"&(XQ'="P")&(XQ'="R")
 I $P(^(0),U,3)]"" S XQ="KILL"
 G RUN:'$D(^(200)) S D=DT,Z=^(200),^(200)=U_$P(Z,U,2,9),Z=$P(Z,U,3),%=$E(Z,$L(Z)),T=$P($S("MD"[%:$P(^%ZTSK(ZTSK,0),U,6),1:$H),",",2) G RUN:'Z
 I %="H" S T=3600*Z+T,%="S",Z=0
 I %="S" S T=T+Z G RESET:T<86400 S %="D",Z=T\86400,T=T#86400
 I %="D" S X1=D,X2=+Z D C^%DTC S D=X G RESET
 F Z=Z:-1:1 S X=$E(D,4,5)+101 S D=$S(X>112:$E(D,1,3)+1_"01",1:$E(D,1,3)_$E(X,2,3))_$E(D,6,7)
RESET S DA=XQM,DIE="^DIC(19,",DR="200////"_D_(T\60#60/100+(T\3600)+(T#60/10000)/100) D ^DIE
RUN K ^%ZTSK(ZTSK) S Y=XQM S:XQ="P"&$L(IO) IOP=IO G @XQ
A ;
 X:$D(^DIC(19,Y,20)) ^(20) G OUT
P ;
 S Z="DIC,PG,L,FLDS,BY,FR,TO,DHD,DCOPIES,DIS(0)",W=59 D SET,D1,EN1^DIP K BY,DCOPIES,DHD,DIC,DIS,DP,FLDS,FR,L,PG,TO G OUT
I ;
I1 D DIC G KILL:DA=-1 S DI=DIC,Z="DIC,DR",W=79 D SET,D1 S:$D(DIC)[0 DIC=DI
 I '$D(^(63)) S:DUZ(0)'="@" DICS="I 1 Q:'$D(^(8))  F DW=1:1:$L(^(8)) I DUZ(0)[$E(^(8),DW) Q" D EN^DIQ S Y=^XUTL("XQ",$J,"S") G I1
 W ! S FLDS=^(63),Z="DHD",W=66 D SET K ^XUTL($J),^(U,$J) S ^($J,1,DA)="",@("L=+$P("_DI_"0),U,2)"),DPP(1)=L_"^^^@",L=0,C=",",Q="""",DPP=1,DPP(1,"IX")="^XUTL(U,$J,"_DI_"^2" D N^DIP1 G KILL
E ;
E1 D DIC K DIE,DIC G KILL:DA=-1 S Z="DIE,DR",W=49 D SET S Z="DIE(""NO^""),DIE(""W"")",W=52 D SET
 S W=0 F Z=1:1 S W=$O(^DIC(19,Y,52,W)) Q:W=""  S DR(^(W,0))=^(1)
 S:DIE["(" DIE=U_DIE D ^DIE S Y=^XUTL("XQ",$J,"S") G E1
DIC W ! S ^XUTL("XQ",$J,"S")=Y K DIC S Z="DIC,DIC(0),DIC(""A""),DIC(""B""),DIC(""S""),DIC(""W""),D",W=29 D SET,D1
 D ^DIC S DA=+Y,Y=^XUTL("XQ",$J,"S") Q
D1 S:DIC["(" DIC=U_DIC Q
SET F I=1:1 S V=$P(Z,",",I) Q:V=""  K @V I $D(^DIC(19,Y,W+I)),^(W+I)]"" S @V=^(W+I)
 I $D(DIC("A")),DIC("A")]"" S DIC("A")=DIC("A")_" "
 K I,J Q
 ;
DATE S %DT="T",X="NOW" D ^%DT S %DA=Y K %DT Q
 ;
KILL K %,A,D0,D1,DA,DIC,DIE,DR G OUT
 ;
R ;
 G:'$D(^DIC(19,Y,25)) M1^XQ S Z=^(25) G:'$L(Z) M1^XQ S:Z'[U Z=U_Z I Z["[" D DO^%XUCI G OUT
 D @Z
OUT D DVARS S Y=$S($D(XQUIT):^XUTL("XQ",$J,"T"),1:^XUTL("XQ",$J,"T")-1) K XQUIT I Y'<1 S ^("T")=Y,Y=^(Y),Y(0)=$P(Y,U,2,999),XQPSM=$P(Y,U,1),Y=+XQPSM,XQPSM=$P(XQPSM,Y,2,3)
 G M1^XQ
