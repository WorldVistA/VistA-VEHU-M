A1A3PRE ;ALB/MIR,RMO - PRE-INIT FOR TEST SITES ; 31 JUL 89
 ;
 ;this pre-init will delete the ^DD(2,2,1,0) which was a stray node that
 ;caused an undefined when doing a fileman enter/edit for all fields in
 ;the patient file.  It will also put in the CDRs which are associated
 ;with the 2 new stop codes which were added with the 4.41 init.
 ;It will also update the Ambulatory Active/Inactive Field (#409.5)
 ;in the CPT File (#81).
 W !,"Cleaning up node in patient file..." K ^DD(2,2,1,0)
 W !,"Adding CDRs for new stop codes..." F I=513,560 S J=$O(^DIC(40.7,"C",I,0)) Q:'J  I $D(^DIC(40.7,J,0)) S $P(^(0),"^",5)="2316.00"
AMB W !,"Inactivating Ambulatory Procedure CPT's..." F DGI=1:1 S X=$P($T(CPT+DGI),";;",2) Q:X=99999  S DIC="^ICPT(",DIC(0)="MQZ" D ^DIC K DIC S DGCPT=Y(0,0) I Y>0 S DA=+Y,DIE="^ICPT(",DR="409.5///@" D ^DIE W !,"...",DGCPT K DE,DQ,DIE,DR
Q W !,"PRE-INIT COMPLETE" K DGCPT,DGI,X Q
 ;
CPT ;ENTER INACTIVE CODES
 ;;15829
 ;;17999
 ;;19499
 ;;28288
 ;;38999
 ;;D2120
 ;;D2130
 ;;D2131
 ;;D2150
 ;;D2160
 ;;D2161
 ;;D2190
 ;;D2711
 ;;D2720
 ;;D2721
 ;;D2722
 ;;D2740
 ;;D2750
 ;;D2751
 ;;D2752
 ;;D2790
 ;;D2791
 ;;D2792
 ;;D2830
 ;;D2840
 ;;D4340
 ;;D4341
 ;;D5120
 ;;D5130
 ;;D5140
 ;;D5211
 ;;D5212
 ;;D5215
 ;;D5216
 ;;D5217
 ;;D5218
 ;;D5230
 ;;D5231
 ;;D5240
 ;;D5241
 ;;D5250
 ;;D5251
 ;;D5260
 ;;D5261
 ;;D5280
 ;;D5281
 ;;D5291
 ;;D5292
 ;;D5293
 ;;D5294
 ;;D5310
 ;;D5320
 ;;D5410
 ;;D5411
 ;;D5421
 ;;D6211
 ;;D6212
 ;;D6230
 ;;D6235
 ;;D6240
 ;;D6241
 ;;D6242
 ;;D6250
 ;;D6251
 ;;D6252
 ;;D6620
 ;;D6720
 ;;D6721
 ;;D6722
 ;;D6740
 ;;D6750
 ;;D6751
 ;;D6752
 ;;D6760
 ;;D6780
 ;;D6790
 ;;D6791
 ;;D6792
 ;;D7211
 ;;D7220
 ;;D7221
 ;;D7230
 ;;D7231
 ;;D7241
 ;;D7242
 ;;D7243
 ;;D7250
 ;;D7285
 ;;D7286
 ;;D7310
 ;;D7350
 ;;D7530
 ;;D8360
 ;;99999
