DGV50PP ;ALBISC/TET;PRE-CONVERSION - CK DATA VALIDITY;1/28/91 ;4/12/91  14:07
 ;;MAS VERSION 5.0;
 ;Routine checks entries in file 392.3 to make sure OK
 ;TMP("DGBT")=0 - if pre-init is begun
 ;           =1 - if pre-init is completed
 ;           =2 - if conversion is begun
 ;           =3 - if conversion is completed
 ;S U="^"
 ;W !,"I expect your entries to have the following account names and numbers:" D ACCT W !! S DIR(0)="Y",DIR("A")="Do you wish to continue" D ^DIR K DIR G:'Y!$D(DIRUT) EXIT
EN S U="^" ;entry tag for pre-init
 I $D(^TMP("DGBT")) S DGBTTMP=^TMP("DGBT") I DGBTTMP>0 W !!,"PRE-INIT has already been run.",!! G EXIT
 W !,">>> I will first check your existing entries in file 392.3, Beneficiary Travel",!?5,"Account to make sure everything is OK.",!!
 S ^TMP("DGBT")=0
 I '$D(^DGBT(392.3)) W !!,"You do not already have file 392.3, skipping the rest of the pre-init" S ^TMP("DGBT")=1 G EXIT
 I '$O(^DGBT(392.3,0)) W "No entries exist in file 392.3" S ^TMP("DGBT")=1 G EXIT
 S J=0 F I=0:1 S J=$O(^DGBT(392.3,J)) Q:J'>0  I $D(^DGBT(392.3,J,0)) S DGBTZ=^(0),DGBT(J)=$P(DGBTZ,U)_";"_$P(DGBTZ,U,2)
CHECK ;I I'=5 S DGBTER=1 W !,"The number of entries in your Beneficiary Travel Account file",!?5,"is "_$S(I>5:"more than",1:"less than")_" what was nationally distributed.",!
 I I F K=1:1:5 D VALID
 I I>5 F K=5:0 S K=$O(DGBT(K)) Q:K'>0  D VALID
 I $D(DGBTER) W !!,">>>",?10,"Discrepancies exist in your Beneficiary Travel Account file.",!?10,"Please correct before you continue with installation.",!?10,"Contact your ISC if you require assistance." G EXIT
 K I,J,K,DGBT
 W !!,">>> The Beneficiary Travel Account file seems in order.",!
 S ^TMP("DGBT")=1
EXIT ;Exit from pre-init
 S DGBTTMP=$S('$D(^TMP("DGBT")):0,1:^TMP("DGBT"))
 I 'DGBTTMP W !!!!,">>> DGBT Pre-init must complete successfully before the init and post-init is run.",*7 K DIFQ
 E  W !!!!,">>> DGBT Pre-init has successfully completed.",!!!
 I $D(DIFQ) D DD
 K DGBT,DGBTER,DGBTTMP,DGBTZ,DTOUT,DUOUT,DIRUT,I,J,K,NK,Y
 Q
VALID ;make sure first five entries have correct data
 S NK=$S(K'>5:K,K=6:3,K=7:5,K=8:4,K=9:2,1:0)
 I 'NK S DGBTER=1 W !,"Entry ",K,", '"_$P(DGBT(K),";",2)_" "_$P(DGBT(K),";",1)_"', should not be entered into your Account file (392.3).",! Q
 I '$D(DGBT(K)) S DGBTER=1 W !,"Entry ",K," does not exist in your file.",!,"The correct value for this entry should be "_$P($T(ACCT+NK),";",4)_" "_$P($T(ACCT+NK),";",3) Q
 I DGBT(K)=$P($T(ACCT+NK),";;",2)!(DGBT(K)=$P($T(ACCT+NK),";;",3))!(DGBT(K)=($P($T(ACCT+NK),";",4)_" "_$P($T(ACCT+NK),";;",2))) Q
MSSG S DGBTER=1 W !,"Entry ",K," is "_$P(DGBT(K),";",2)_" "_$P(DGBT(K),";",1)_" in your file.",!,"The correct value for this entry should be",!?2,"Account #: "
 W:K<6 $P($T(ACCT+NK),";",4),?25,"Account name: ",$P($T(ACCT+NK),";",3),!
 W:K>5 $P($T(ACCT+NK),";",7),?25,"Account name: ",$P($T(ACCT+NK),";",6),!
 Q
ACCT W !?5,"ACCOUNT NUMBER",?22,"ACCOUNT NAME",! F I=1:1:5 W !?11,$P($T(ACCT+I),";",4),?23,$P($T(ACCT+I),";",3) ;old;;new account names & numbers
 ;;EMERGENCY;825;;825 EMERGENCIES;825
 ;;INTERFACILITY;826;;921 INTERFACILITY;921
 ;;SPECIAL MODE;827;;826 SPECIAL MODE - NON-EMERGENT;826
 ;;ALL OTHER;828;;829 ALL OTHER;829
 ;;C&P;829;;827 C&P EXAMINATIONS;827
 Q
 ;
 ;
DD ;correct name of PTF TRANSFERRING FACILITY file
 I $O(^DIC("B","PTF TRANSFERING FACILITY",0))'=45.2 Q
 S DIE=1,DA=45.2,DR=".01///PTF TRANSFERRING FACILITY" D ^DIE
 K DA,DIE,DR
 Q
