DGV51PT ;ALB/RMO - DG POST-INIT FOR VERSION 5.1 DRIVER ;7/5/91  09:55
 ;;MAS VERSION 5.1;
EN I DGVCUR<5.01 D DEL^DGV51PT1
 D CENSUS,GEC,MG,ROUT,PRO,MTINC
 I DGVCUR>5 D VAR,PHYS
 Q
CENSUS ;--- add new census date
 W !!,">>> Updating Census Dates..."
 S X=$O(^DG(45.86,"AC",0)) I X S X=$O(^DG(45.86,"AC",X,0)),DIE="^DG(45.86,",DA=X,DR=".04////0" D ^DIE K DIE,DR,DA
 S DIC="^DG(45.86,",X=2910930,DIC(0)="L" K DD,DO D ^DIC K DIC
 S DIE="^DG(45.86,",DA=+Y,DR=".02////2911207;.03////2911215;.04////1;.05////2901001" D ^DIE K DIE,DR,DA
 Q
 ;
GEC W !!,">>> Re-building Generic Code Sheet Template Maps for Inpatient AMIS Segments...",!!
 F DGI=1:1 S X=$P($T(GECTEM+DGI),";;",2) Q:X="QUIT"  W ?4 D A^GECSX5 K DA,DIC,GECSMAP,I
 K DGI,X
 Q
 ;
GECTEM ;Generic Code Sheet Inpatient AMIS Templates
 ;;DG AMS1 AMIS
 ;;DG AMS1 AMIS 334
 ;;DG AMS1 AMIS 336
 ;;DG AMS1 AMIS 345
 ;;QUIT
 ;
MG ; -- add new mail groups
 F DGMG="OPA" D MG1
 K DGMG
 Q
 ;
MG1 S DIC="^XMB(3.8,",DIC(0)="L",DIC("DR")="4////PU;5////"_DUZ,X=DGMG D ^DIC K DIC
 G MG1Q:'$P(Y,U,3)
 S ^XMB(3.8,+Y,2,0)="^^2^2^2900625^"
 S ^XMB(3.8,+Y,2,1,0)="This mail group will receive confirmation messages from Austin for the"
 S ^XMB(3.8,+Y,2,2,0)="Q-"_DGMG_" queue."
 W !!,">>> New '",DGMG,"' confirmation mail group added..."
MG1Q Q
 ;
ROUT ;add 'OPA' to file 407.7, Tranmission Router file
 S U="^",DIC="^VAT(407.7,",DIC(0)="MLZ",DLAYGO=407.7,X="OPA" D ^DIC I Y>0,+$P(Y,U,3)=1 S DA=$P(Y,U),DIE=DIC,DR=".02////150;.03////50" D ^DIE W !!,">>> New 'OPA' transmission router added ..."
 K DA,DE,DIC,DIE,DLAYGO,DQ,DR,U,X,Y Q
 ;
PRO ;Delete obsolete OE/RR event protocols
 W !,">>> Deleting obsolete DG protocols from the Protocol file (#101)..."
 F DGI=1:1 S DGP=$P($T(OBS+DGI),";;",2) Q:DGP="QUIT"  D DEL
 K DGI,DGP,Y Q
 ;
DEL ;Delete protocol
 W !?4,"...",DGP,"..." S Y=+$O(^ORD(101,"B",DGP,0)) W:'Y "already deleted."
 I Y S DA=Y,DIK="^ORD(101," D ^DIK K DA,DIK W "deleted."
 Q
 ;
OBS ;Obsolete Protocols
 ;;DGOERR ADMIT EVENTS
 ;;DGOERR BED SWITCH EVENTS
 ;;DGOERR DISCHARGE EVENTS
 ;;DGOERR TRANSFER EVENTS
 ;;QUIT
 ;
MTINC ;means test income date 
 ; - 10/1/91 for verified version
 W !!," >>> Will now add the MT INCOME DATE to your parameter file ...",!
 I $D(^DG(43,1,0)) S DA=1,DIE="^DG(43,",DR="206.2////2911001" D ^DIE W !?8,"... MT Income Date added ..."
 K DA,DIE,DR,DE,DQ Q
 ;
VAR W !!,">>>Converting the TRANSCRIBED BY field of the INCOMPLETE"
 W !,"   Records file..."
 F I=0:0 S I=$O(^VAS(393,I)) Q:'I  I $D(^VAS(393,+I,"DT")),$P(^("DT"),"^",4)]"" S $P(^("DT"),"^",4)=$S($P(^("DT"),"^",4)[";":$P(^("DT"),"^",4),1:$P(^("DT"),"^",4)_";VA(200,")
 K I Q
 ;
PHYS W !!,">>>Populating the PHYSICIAN RESPONSIBLE field of the"
 W !,"   INCOMPLETE RECORDS file..."
 F I=0:0 S I=$O(^VAS(393,I)) Q:'I  I $D(^VAS(393,I,0)),$P(^(0),"^",9),'$P(^(0),"^",12) S $P(^(0),"^",12)=$P(^(0),"^",9)
 K I Q
