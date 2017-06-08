ZISLSIT ;WILM/RJ - Get Site Variables; SAVE AS %ZISLSIT IN MGR UCI; 12-1-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S (ZISLSITE,X)="" Q:'$D(^%ZOSF("VOL"))  S ZISLCPU=^("VOL") S ZISLSITE=$O(^%ZIS("Z",108,"B",ZISLCPU,0)) Q:ZISLSITE<1  S ZISLSITE=$S($D(^%ZIS("Z",108,ZISLSITE,0)):^(0),1:"")
 F X=2,3 S $P(ZISLSITE,"^",X)=$S($P(ZISLSITE,"^",X)="":"",$D(^%ZIS(1,$P(ZISLSITE,"^",X),0)):$P(^(0),"^",2),1:"")
 Q
