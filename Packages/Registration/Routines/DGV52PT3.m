DGV52PT3 ;ALB/MTC - DG POST INIT FOR MAS 5.2 CONT ; 4/3/92
 ;;5.2;REGISTRATION;;JUL 29,1992
 ;
EN ;
 D DEL,MTINC,PDXCHK,AMIS419,COMPT
 Q
 ;
DEL ;delete stray ROUTINEs from options that have changed
 ;
 S DIE="^DIC(19,",DR="25///@" F DGI=1:1 S DGX=$P($T(OPT+DGI),";;",2) Q:DGX="QUIT"  S DA=$O(^DIC(19,"B",DGX,0)) I DA D ^DIE
 K DA,DGI,DGX,DIE,X,Y
 Q
 ;
 ;
OPT ;options to edit...remove run routine
 ;;DG ADMIT PATIENT
 ;;DG TRANSFER PATIENT
 ;;DG DISCHARGE PATIENT
 ;;DG TREATING TRANSFER
 ;;DG PATIENT TYPE PARAMETER EDIT
 ;;QUIT
 ;
MTINC ;Add Child's Income Exclusion for Means Test
 N DA,DIE,DR
 W !!,">>> Adding Child's Income Exclusion to the MAS Parameter file"
 S DA(1)=1,DIE="^DG(43,"_DA(1)_",""MT"","
 I $D(^DG(43,1,"MT",2910000,0)) S DA=2910000,DR="17////5500" D ^DIE W !?4,"...1991 $5500"
 I $D(^DG(43,1,"MT",2920000,0)) S DA=2920000,DR="17////5900" D ^DIE W !?4,"...1992 $5900"
 Q
 ;
PDXCHK ;-check if PDX has been installed, if not del 'VAQMAS5' routine
 W !!,">>> Checking if PDX has been loaded."
 I '$D(^DD(394.2)) S X="VAQMAS5" X ^%ZOSF("TEST") I $T W !,"...removing VAQMAS5..." X ^%ZOSF("DEL")
 Q
 ;
AMIS419 ;Sets INACTIVATION DATE to 10/1/91;INACTIVATION to 1
 W !!,">>> Setting AMIS 419 Inactivation date."
 S DIE="^DG(391.1,",DA=419,DR=".02////1;.03////^S X=2911001"
 D ^DIE
 K DR,DA,DIE,DIC,Y,X
 Q
 ;
COMPT ; This tag will recompile templates
 W !!,">>> Re-compiling input templates :"
 N I,TEMPLN
 F I=1:1 S TEMPLN=$P($T(TEMP+I),";;",2) Q:TEMPLN="QUIT"  S X=$P(TEMPLN,U,2),Y=$O(^DIE("B",$P(TEMPLN,U),0)) I Y S DMAX=5000 D EN^DIEZ
 Q
 ;
TEMP ;-- templates to recompile
 ;;DVBHINQ UPDATE^DVBHCE^I
 ;;DVBC ADD 2507 PAT^DVBCPAT^
 ;;QUIT
