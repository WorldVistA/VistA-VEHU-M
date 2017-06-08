DGV50PT ;ALB/RMO - DG POST-INIT FOR VERSION 5.0 DRIVER ; 2 MAY 90 2:55 pm
 ;;MAS VERSION 5.0;
 S DGPM=$S($D(^DG5(1,"ID")):^("ID"),1:"") I 'DGPM D NOW^%DTC S ^DG5(1,"ID")=% F I="L","LST","ME","SC" K ^DG5(1,I)
 I DGVCUR<4.82 D MG,DEL^DGV50PT1,EN^DGV50PT2,ELIG,PTYPE,AMIE
 I DGVCUR<4.86 D ^DGV50PT3
 I DGVCUR<4.87 D ^DGV50PT4
 Q
 ;
MG ;Add mailgroup for building managment
 W !!,">>> Checking for 'DG BLDG MANAGEMENT' mailgroup..." S Y=$O(^XMB(3.8,"B","DG BLDG MANAGEMENT",0)) I $D(^XMB(3.8,+Y,0)) W "Mailgroup already exists...",$S($O(^XMB(3.8,+Y,1,0))]"":"Members already",1:"No members")," defined..."
 I '$D(^XMB(3.8,+Y,0)) S DIC("DR")="4///public;5////"_DUZ_";",DIC="^XMB(3.8,",DIC(0)="L",X="DG BLDG MANAGEMENT" D FILE^DICN W !?4,"Mailgroup ADDED...No members defined..."
 K DIC,X,Y
 Q
 ;
ELIG ; -- update elig file to point to 8.1 and 8.2
 ;
 W !!,">>> Will now point ELIGIBILITY CODE entries to MAS ELIGIBILITY CODE entries..."
 S DGFMT=+$O(^DIC(8.2,"B","VA STANDARD",0)) S:'$D(^DIC(8.2,DGFMT,0)) DGFMT=""
 F DGI8=0:0 S DGI8=$O(^DIC(8,DGI8)) Q:'DGI8  I $D(^(DGI8,0)),'$P(^(0),"^",9) S DG8=^(0),DGI81=+$O(^DIC(8.1,"B",$P(DG8,"^"),0)) I $D(^DIC(8.1,DGI81,0)) S DG81=^(0) I $P(DG8,"^")=$P(DG81,"^") D DIE
 K DGFMT,DGI8,DGI81,DG8,DG81
 W !,">>> Pointing complete."
 Q
 ;
DIE ; -- actual update
 S DA=DGI8,DR="8////"_DGI81_$S('$P(DG8,"^",10):";9////"_DGFMT,1:""),DIE="^DIC(8,"
 W !?4,".",$P(DG8,"^") D ^DIE
 K DA,DR,DIE
 Q
 ;
PTYPE ;Fix Collateral Entry in the Patient Type file (#391)
 W !!,">>> Fixing Collateral Entry in Patient Type file"
 S X=$O(^DG(391,"B","COLLATERAL",0))
 I X,$D(^DG(391,X,0)) S ^DG(391,X,"DR")="S DGRPX=$O(^DIC(8,""D"",13,0)) S DR=""[DGRP COLLATERAL REGISTER]"""
 K X Q
 ;
AMIE ;Changes the name of 3 AMIE discharge types
 W ! S DIE="^DIC(42.2," F DGX=1:1:3 S X=$P($T(TYPES+DGX),";;",2),Y=$O(^DIC(42.2,"B",$P(X,"^",1),0)) I $D(^DIC(42.2,+Y,0)) S DA=Y,DR=".01///"_$P(X,"^",2) W !,">>> Changing ",$P(X,"^",1)," discharge type to ",$P(X,"^",2) D ^DIE
 K DA,DR,DIE,X,Y,DGX
 Q
 ;
TYPES ;list of types to change       old^new
 ;;REGULAR TO NHCU FROM DOM^TO NHCU FROM DOM
 ;;REGULAR TO NHCU FROM HOSP^TO NHCU FROM HOSP
 ;;REGULAR TO DOM FROM HOSP^TO DOM FROM HOSP
 Q
