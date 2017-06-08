ENLOG16 ;(WASH ISC)/DH-Edit Equipment Records Added from LOG1 ;2-OCT-91
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 S IOP="HOME" D ^%ZIS
EN S DIC="^ENG(6914,",DIC(0)="AEQM" D ^DIC G:+Y'>0 EXIT S DA=+Y
EN1 I $D(^ENG(6914,DA,2)) W:$P(^(2),U,7)]"" !,"NXRN: ",$P(^(2),U,7) S ENA=$P(^(2),U,8) I ENA]"",$D(^ENCSN(6917,ENA,0)) D NOMEN
 K ^UTILITY($J,"W") S DIWL=3,DIWR=IOM,DIWF="W"
 I $D(^ENG(6914,DA,5)) W !,"COMMENTS:"
 F ENNX=0:0 S ENNX=$O(^ENG(6914,DA,5,ENNX)) Q:ENNX'>0  I $D(^(ENNX,0)) S X=^(0) D ^DIWP
 D ^DIWW
 S DIE="^ENG(6914,",DR="1;4;5" D ^DIE
 I '$D(^XUSEC("ENEDPM",DUZ)) G NEXT
EDPM W !,"Would you like to include this item in your PM program" S %=2 D YN^DICN G:%=0 EDPM I %=1 S ENXP=1,ENDA=DA D XNPMSE^ENEQPMP
 ;
NEXT W !!,"Continue" S %=1 D YN^DICN I %=1 S DA=$O(^ENG(6914,DA)) I DA>0 W !!,"Equipment ID#: ",DA I $D(^ENG(6914,DA,3)),$P(^(3),U,6)]"" W ?40,"PM # :",$P(^(3),U,6)
 I %=1,DA>0 G EN1
 G EXIT
 ;
NOMEN K ^UTILITY($J,"W") S DIWL=1,DIWR=IOM,DIWF="W"
 F ENNX=0:0 S ENNX=$O(^ENCSN(6917,ENA,1,ENNX)) Q:ENNX'>0  I $D(^(ENNX,0)) S X=^(0) D ^DIWP
 D ^DIWW
 Q
 ;
EXIT K ENA,ENNX,ENDA
 Q
 ;ENLOG16
