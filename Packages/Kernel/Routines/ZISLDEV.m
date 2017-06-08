ZISLDEV ;WILM/RJ - Enter, Edit Micom Contention Devices (File:106); 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S (DIC,DIE)="^%ZIS(""Z"",106,",U="^"
1 S DIC(0)="QEALM" W ! D ^DIC G:Y=-1 E S DA=+Y,DR=".01:2" D ^DIE G 1
E K DA,DIC,DIE,DR,Y Q
