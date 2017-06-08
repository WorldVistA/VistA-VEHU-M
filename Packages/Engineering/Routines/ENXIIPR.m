ENXIIPR ;WIRMFO/SAB-PRE INIT ;4/22/96
 ;;7.0;ENGINEERING;**29**;Aug 17, 1993
 N DA,ENFX,ENI
 Q:'$D(DIFROM)
 W !,"Performing Pre-Init...",!
DSCR ; delete DJ edit screens
 S DIK="^ENG(6910.9,"
 F ENI="ENEQ1","ENEQ1D","ENEQ1E","ENEQ1S","ENEQ2","ENEQ2D","ENEQ2E","ENEQ2S","ENEQ3","ENEQ3D","ENEQ3S","ENEQNX1","ENEQNX2","ENEQNX3" D
 . S DA=$O(^ENG(6910.9,"B",ENI,0)) W "."
 . D:DA>0 ^DIK
 K DIK
DSCREND ; end delete DJ edit screens
 W !,"Completed Pre-Init",!
 Q
 ;ENXIIPR
