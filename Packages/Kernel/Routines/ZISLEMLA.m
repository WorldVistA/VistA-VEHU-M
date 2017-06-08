ZISLEMLA ;WILM/RJ - Edit Micom Line Assignments (File 107.2); 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S (DIC,DIE)="^%ZISL(107.2,",DR=".01:2" F J=1:1 W ! D Y I $D(Y) Q:Y=-1
 K DIC,DIE,DR,J,X,Y,%X,%Y,D0,D1,DA,DQ Q
Y S DIC(0)="QEALMZ" D ^DIC Q:Y=-1  S DA=+Y D ^DIE Q
