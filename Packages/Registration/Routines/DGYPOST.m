DGYPOST ;ALB/MIR - POST INIT FOR PRE-5 PACKAGE ; 4 FEB 91
 ;;MAS VERSION 4.7;;**25**;
 ;
 ;
 I '$D(^DG5(1)) S X=1,DIC(0)="L",DIC="^DG5(" D FILE^DICN ; create entry 1
RCD ;stuff recalc date as 10/1/90...can be changed later
 S DIE="^DG5(",DR="10.01///2901001",DA=1 D ^DIE
 ;
MVT ;stuff MOVEMENT TYPE into NEW MOVEMENT TYPE and $E(NAME,1,20) into PRINT NAME
 S DR="S DGX=^DIC(DGI,DA,0);I $P(DGX,""^"",7) S Y=""@1"";.07///^S X=$P(DGX,""^"",6);@1;I $P(DGX,""^"",8)]"""" S Y="""";.08///^S X=$E($P(DGX,""^"",1),1,20);"
 F DGI=42.1,42.2,42.3 S DIE="^DIC("_DGI_"," F DGJ=0:0 S DGJ=$O(^DIC(DGI,DGJ)) Q:'DGJ  I $D(^(DGJ,0)) S DA=DGJ D ^DIE
MVTQ K DA,DGI,DGJ,DGX,DIC,DIE,DR
 Q
