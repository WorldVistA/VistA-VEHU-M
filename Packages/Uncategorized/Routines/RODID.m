RODID ; ; 21AUG84 17:16
 ;16.41
 D KL F DUB=40.15,40.1,40.2,40.3,40.4,40.7,40.8,44 S IOP="Q;LINE PR",DFF=DUB W !!,"File ",DUB," - ",$P(^DIC(DUB,0),"^",1) D DIPMK
 Q
KL K DICMX,DIOEND,FLDS,DFF,DID,DUB,DHD,DIC,DICS,POP,DA,DR,S,F,J,K,Z,W,X,Y,M,G,N,I,DJ,IOF,IOM,IOSL,IOBS,IOT Q
 ;
SUB S DFF=+Y,DIC="^DD("_+Y_"," G O:$N(^DD(+Y,"SB",0))'>0 S DIC(0)="AEQZ",DIC("A")="Select SUB-FILE: ",DIC("S")="I $P(^(0),U,2)" D ^DIC I Y>0 S Y=$P(Y(0),U,2) G SUB
 G KL:X[U S Y=DFF
O S DIK="^DOPT(""DID""," G DIP:$D(^DOPT("DID",3)) S ^(0)="LISTING FORMAT^1.01",^(1,0)="STANDARD",^DOPT("DID",2,0)="BRIEF",^DOPT("DID",3,0)="CUSTOM-TAILORED" D IXALL^DIK
DIP K DIC S DIC=DIK,DIC(0)="AEQ",DIC("B")=1 D ^DIC G KL:Y<0
DIPMK S Y=1 K DIC,DIK S DIC="^DD(DFF," G EN^DIP:+Y=3
 S FLDS="",DHIT="D ^DID1",DHD="W """" D ^DIDH",L=0,BY="@.001",(FR,TO)="",DIOEND="D END^DID"
 I +Y=2 S DHIT="D ^DIDX",DID=0,%=1 W !,"ALPHABETICALLY BY LABEL" D YN^DICN Q:%<1  S:%=1 BY="@.01",DID=1
 G EN1^DIP
 ;
END ;
 G D:'$D(^UTILITY($J,"P")) S F=0 W !!!?6,"FILES POINTED TO",?44,"FIELDS",!
 F I=0:0 S F=$N(^UTILITY($J,"P",F)) Q:F<0  W !,F F %=0:0 S %=$N(^UTILITY($J,"P",F,%)) Q:%<0  W ?33," ",$S(%=F(1):"",1:$P(^DD(%,0)," SUB-FIELD",1)_":") F S=0:0 S S=$N(^UTILITY($J,"P",F,%,S)) Q:S<0  W ?34,$P(^DD(%,S,0),U,1)," (#"_S_")",!
D I DC=1,$N(^DD(DFF,"GL",0))<0,@("$N("_DIC_"0))>0") S W=0 F DA=1:1:20 S W=$N(^(W)) I W<0 K DJ,DR W !!!?9,"CURRENT ENTRIES",!?9,"------- -------" F DUB=0:0 S @("DUB=$N("_DIC_"DUB))") Q:DUB'>0  S DA=DUB D EN^DIQ S DA=99
 G IOF:DHIT["DIDX" S @("A=$P("_DIC_"0),U,1)")
 F S=1:1:3 W !! S DA=0,W=$P("INPUT^PRINT^SORT",U,S)_" TEMPLATE(S):",DFF="^DI"_$P("E^PT^BT",U,S) X "F %=0:0 S DA=$N("_DFF_"(""F"_F(1)_""",DA)) Q:DA=-1  F DUB=0:0 S DUB=$N("_DFF_"(""F"_F(1)_""",DA,DUB)) Q:DUB'>0  I $D("_DFF_"(DUB,0)) D TEMPL"
IOF W:IOST'?1"C".E @IOF G KL
 ;
TEMPL W W,!,$P(^(0),U,1),?32 S W="",Y=$P(^(0),U,2) D DT^DIO2 W ?44,"USER #",+$P(^(0),U,5) I $D(^("H")) S Y=^("H"),%=$L(Y) W:55+%>IOM ! W "   ",?IOM-%-1,$E(Y,1,IOM-4)
 I $D(^(2)) S D0=DUB,DICMX="W !?4,X" X $P(^DD(.401,1620,0),U,5,99)
 I DFF="^DIBT" F Y=1:1 Q:'$D(^DIBT(DUB,"O",Y,0))  W "  " S %=^(0) W:$L(%)+$X+5>IOM !?4 W %
