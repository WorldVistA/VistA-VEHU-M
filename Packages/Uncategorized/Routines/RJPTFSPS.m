RJPTFSPS ;RJ WILM DE -SINGLE PATIENT STATUS; 12-12-85
 ;;4.0
 D:'$D(DUZ) DT^DICRW S DIC="^DGPT(",DIC(0)="QEAMN" W ! D ^DIC G:Y=-1 Q S DA=+Y
 W !,"PATIENT NAME: ",$P(^DPT($P(^DGPT(DA,0),"^",1),0),"^",1)
 W !!,"STATUS  CHECKED    CLOSED    RELEASED TO AUSTIN",!?8,"---------------------------------------",!
 I '$D(^DGP(45.84,DA,0)) W ?10,"NO",?20,"NO",?35,"NO" G Q
 S I=^DGP(45.84,DA,0) W ?10,"YES" I $P(I,"^",2) W ?20,"YES"
 I $P(I,"^",4) W ?35,"YES"
 G RJPTFSPS
Q K DIC,DA,I Q
