DGV50PR ;ALB/RMO - DG PRE-INIT FOR VERSION 5.0 ; 2 MAY 90 2:55 pm
 ;;MAS VERSION 5.0;
 ;
 D BT,WARD W !!
 Q
 ;
WARD ;Update Ward Location Field (Global should allow 1-30 chars)
 W !!,">>>Updating Ward Location in PATIENT File (#2)..."
 S DGDD=".1;E1,30",DA(1)=2,DA=.1,DIE="^DD(2,",DR=".4////^S X=DGDD" D ^DIE K DA,DE,DQ,DIE,DR,DGDD
 Q
 ;
 ;
BT ;bene travel pre-init (clean-up files)
 W !!,">>> I will now delete all the data from your Beneficiary Travel Account file.",!,"Data will be brought back in with the init."
 K ^DGBT(392.3) W !,"   ...Done!"
 W !!,">>> I will now delete your .001 field from the same file." S DIK="^DD(392.3,",DA(1)=392.3,DA=.001 D ^DIK K DA,DIK W "   ...Done!"
 Q
