ZISLMSP ;WILM/RJ - Enter, Edit Micom Site Parameters (File 108); 3-1-87
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 I '$D(^%ZOSF("VOL")) W !,"First, you need to set %ZOSF(""VOL"") to the 1-10 char volume set of this cpu." Q
 S ZISLCPU=^%ZOSF("VOL") I '$O(^%ZIS("Z",108,"B",ZISLCPU,0)) W !,"You do not have this cpu entry in your Micom Site Parameters File." D SN
 W !,"Site Name: ",ZISLCPU S Y=$O(^%ZIS("Z",108,"B",ZISLCPU,0))
 S (DIE,DIC)="^%ZIS(""Z"",108,",DR="1:4.1",DA=Y D ^DIE
 K D,DA,DIC,DIE,DR,X,Y,ZISLCPU Q
SN W !,"I am going to add the cpu volume set: ",ZISLCPU," as your site entry." S U="^",DIC="^%ZIS(""Z"",108,",DIC(0)="L",X=ZISLCPU,DIC("DR")="" D FILE^DICN Q
