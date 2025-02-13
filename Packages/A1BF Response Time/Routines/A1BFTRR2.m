A1BFTRR2 ;ALBANY ISC ; ECF ; 8 OCTOBER 1992 [ 05/19/93  9:31 AM ]
 ;;V1.0
DAILY ;Calculate previous day prime time hours
 ;Count sessions
 S A1BFDSES=0 F A1BFI=9:1:17 D
 .S A1BFDSES=A1BFDSES+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,27)=A1BFDSES
 ;Averages by hr
 S (A1BFDTI,A1BFG,A1BFDTU,A1BFDTDC,A1BFDTMJ)=0
 F A1BFI=9:1:17 D
 .I $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)>0 D
 ..S A1BFG=A1BFG+1
 ..S A1BFDTI=A1BFDTI+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTIM"),U,A1BFI)
 ..S A1BFDTU=A1BFDTU+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTUSR"),U,A1BFI)
 ..S A1BFDTDC=A1BFDTDC+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTDEV"),U,A1BFI)
 ..S A1BFDTMJ=A1BFDTMJ+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTMJ"),U,A1BFI)
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DATIM"),U,A1BFI)=$J(($P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTIM"),U,A1BFI)/$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)),1,4)
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DADEV"),U,A1BFI)=$J(($P(^UTILITY("A1BF",$J,A1BFPDAY,"DTDEV"),U,A1BFI)/$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)),1,4)
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DATMJ"),U,A1BFI)=$J(($P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTMJ"),U,A1BFI)/$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)),1,4)
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DAUSR"),U,A1BFI)=$J(($P(^UTILITY("A1BF",$J,A1BFPDAY,"DTUSR"),U,A1BFI)/$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)),1,4)
 .I $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)'>0 D
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DATIM"),U,A1BFI)=0
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DADEV"),U,A1BFI)=0
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DAUSR"),U,A1BFI)=0
 ..S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DATMJ"),U,A1BFI)=0
 ;Save avg time for previous day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DATIM"),U,27)=$J($S(A1BFDSES>0:(A1BFDTI/A1BFDSES),1:0),1,4)
 ;Save total time for previous day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTIM"),U,27)=A1BFDTI
 ;Save count of 'good' hours for timing collection
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTIM"),U,28)=A1BFG
 ;Save avg users for day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DAUSR"),U,27)=$J(($S(A1BFDSES>0:(A1BFDTU/A1BFDSES),1:0)),1,4)
 ;Save count of hours with sessions
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTUSR"),U,28)=A1BFG
 ;Save total users for day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTUSR"),U,27)=A1BFDTU
 ;Save avg devices for previous day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DADEV"),U,27)=$J($S(A1BFDSES>0:(A1BFDTDC/A1BFDSES),1:0),1,4)
 ;Save total devices for previous day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTDEV"),U,27)=A1BFDTDC
 ;Save count of 'good' hours for timing collection
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTDEV"),U,28)=A1BFG
 ;Save avg TM jobs for previous day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DATMJ"),U,27)=$J($S(A1BFDSES>0:(A1BFDTMJ/A1BFDSES),1:0),1,4)
 ;Save total TM jobs for previous day
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTMJ"),U,27)=A1BFDTMJ
 ;Save count of 'good' hours for timing collection
 S $P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTMJ"),U,28)=A1BFG
WEEKEND ;Quit if weekend day if previous day was Sat or Sun don't save
 Q:$E($P(^UTILITY("A1BF",$J,A1BFPDAY,"DAAY"),U,1),1,1)="S"
AWEEK ;Move counts to weekly cumulator
 S A1BFW=$P(^UTILITY("A1BF",$J,A1BFPDAY,"DAAY"),U,3)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"WTTIM",A1BFW),U,A1BFI)=$P(^UTILITY("A1BF",$J,"WTTIM",A1BFW),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTIM"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"WTUSR",A1BFW),U,A1BFI)=$P(^UTILITY("A1BF",$J,"WTUSR",A1BFW),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTUSR"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"WTSES",A1BFW),U,A1BFI)=$P(^UTILITY("A1BF",$J,"WTSES",A1BFW),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"WTDEV",A1BFW),U,A1BFI)=$P(^UTILITY("A1BF",$J,"WTDEV",A1BFW),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTDEV"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"WTTMJ",A1BFW),U,A1BFI)=$P(^UTILITY("A1BF",$J,"WTTMJ",A1BFW),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTMJ"),U,A1BFI)
ATOTL ;Move counts to final cumulator
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"ZRTOT","TIME"),U,A1BFI)=$P(^UTILITY("A1BF",$J,"ZRTOT","TIME"),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTIM"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"ZRTOT","USER"),U,A1BFI)=$P(^UTILITY("A1BF",$J,"ZRTOT","USER"),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTUSR"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"ZRTOT","SESS"),U,A1BFI)=$P(^UTILITY("A1BF",$J,"ZRTOT","SESS"),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTSES"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"ZRTOT","TMJ"),U,A1BFI)=$P(^UTILITY("A1BF",$J,"ZRTOT","TMJ"),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTTMJ"),U,A1BFI)
 F A1BFI=9:1:17 S $P(^UTILITY("A1BF",$J,"ZRTOT","DEV"),U,A1BFI)=$P(^UTILITY("A1BF",$J,"ZRTOT","DEV"),U,A1BFI)+$P(^UTILITY("A1BF",$J,A1BFPDAY,"DTDEV"),U,A1BFI)
EXIT ;
 K A1BFDSES,A1BFDTDC,A1BFDTI,A1BFDTMJ,A1BFDTU,A1BFG,A1BFI
 Q
