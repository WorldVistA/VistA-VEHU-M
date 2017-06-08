RJPTFCL ;RJ WILM DE -WHO CODED RECORD; 04-16-86
 ;;4.0
 D:'$D(DUZ) DT^DICRW
S S DIC="^DGPT(",DIC(0)="QEAMN" W ! D ^DIC G:Y=-1 Q S DA=+Y
 D H S Z1=0 F I=0:1 S Z1=$O(^DGPT(DA,1,Z1)) Q:Z1=""  D SHOW S Z2=Z1
 S:I'=0 ^DGPT(DA,1,0)=$P(^DGPT(DA,1,0),"^",1,2)_"^"_Z2_"^"_I I I=0 W !,"No coder information."
 G S
Q K DIC,X,Y,Z,DA,I,Z1,Z2 Q
SHOW I $D(^DGPT(DA,1,Z1,0)) S Z=^(0),Z=$S(Z="":"?",$D(^DIC(3,Z,0)):$P(^(0),"^",1),1:Z) W !,?5,Z
 Q
H W !!,"Coders: ",!,"-------" Q
