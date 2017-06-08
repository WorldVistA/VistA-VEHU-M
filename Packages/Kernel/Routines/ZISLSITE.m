ZISLSITE ;WILM/RJ - Get Site Variables; 12-1-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S (ZISLSITE,X)="" Q:'$D(^%ZOSF("VOL"))  S ZISLCPU=^("VOL") Q:'$D(^%ZIS("Z",108,ZISLCPU,0))  S ZISLSITE=^(0)
 F X=2,3 S $P(ZISLSITE,"^",X)=$S($P(ZISLSITE,"^",X)="":"",$D(^%ZIS(1,$P(ZISLSITE,"^",X),0)):$P(^(0),"^",2),1:"")
 Q
