GMRAPEM4 ;HIRMFO/WAA-EDIT OF DATA TO HISTORICAL STORAGE ; 12/24/91
 ;;4.0;Adverse Reaction Tracking;**51**;Mar 29, 1996;Build 190
EDIT ; Add/Edit Reaction data
 N GMRAOUT1
 W @IOF
 D SITE^GMRAUTL
 S GMRADRUG=$S($P(GMRAPA(0),U,20)["D":1,1:0),GMRACNT=GMRACNT+1
 G:GMRANEW NEW
 I '$P(GMRAPA(0),"^",12),$P(GMRAPA(0),"^",5)'=DUZ,'$D(^XUSEC("GMRA-SUPERVISOR",DUZ)),'$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) D  Q
 .W !,$C(7),"THE PERSON INITIALLY ENTERING THIS ALLERGY/ADVERSE REACTION HAS NOT",!,"FINISHED ENTERING THE MANDATORY FIELDS, YOU CANNOT EDIT"
 .D UNLOCK^GMRAUTL(120.8,GMRAPA)
 .Q
 I $P(GMRAPA(0),"^",12) D UNLOCK^GMRAUTL(120.8,GMRAPA) Q
NEW S DR="6(O)bserved or (H)istorical Allergy/Adverse Reaction",DIE="^GMR(120.8,",DA=GMRAPA D ^DIE I $D(Y) S GMRAOUT=1 Q
 S GMRANEW(0)=$S($D(^GMR(120.8,GMRAPA,0)):^(0),1:"") W:$P(GMRANEW(0),"^",6)']"" $C(7),"  Required??"
 G NEW:$P(GMRANEW(0),"^",6)']"",EDAT:$P(GMRANEW(0),"^",6)=$P(GMRAPA(0),"^",6)
YNNW I $P(GMRAPA(0),"^",6)]"" W !,"Are you sure you want to make that change" S %=1 D YN^DICN I '% W !?4,$C(7),"ANSWER YES IF THE CHANGE IS OK, ELSE ANSWER NO." G YNNW
 I $P(GMRAPA(0),"^",6)]"" I %'=1 S GMRAOUT=(%=-1),DIE="^GMR(120.8,",DR="6////"_$P(GMRAPA(0),"^",6),DA=GMRAPA D ^DIE G NEW:%=2 Q
 S $P(GMRAPA(0),"^",6)=$P(GMRANEW(0),"^",6)
EDAT I $P(GMRAPA(0),"^",6)="o" D EN1^GMRAPEO0
 I $P(GMRAPA(0),"^",6)="h" S GMRAOUT1=0 D EN1^GMRAPEH0 I GMRAOUT1 S GMRAOUT=1
 K GMRAVER S GMRAVER=0
 I 'GMRAOUT D
 .I '$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) Q 
 .I $$VFY^GMRASIGN(.GMRAPA) W !,"This Causative Agent will be Auto-verified when it is signed off." Q
 .N GMRAPRNT
 .D EN1^GMRAVFY K GMRALLER,GMRAMEC,GMRAY
 .Q
 Q
