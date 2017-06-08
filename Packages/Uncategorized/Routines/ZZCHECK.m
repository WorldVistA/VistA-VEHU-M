ZZCHECK ;;ISC1/DSD/JRF  - COUNT AND DUP CHECK FOR 190.3  ;;[ 04/01/93  10:47 AM ]
 ;;CLASS3 ; 25 FEB 93
START K ^ZZRTM W !,"This will count the number of B indexes in RTV(190.3) "
 W !,"and check for duplicate movement history numbers "
 R !,"Would you like to continue " S %=2 D YN^DICN Q:%'=1
 S CNT=0,DUP=0 F R=0:0 S R=$O(^RTV(190.3,"B",R)) Q:'R  D HIST
 W !!,"Total # of of ""B"" indexes in 190.3 is : ",CNT  W !!,"Total # of duplicates is/are: ",DUP K ^ZZRTM,CNT,DUP,M,R,% Q
HIST F M=0:0 S M=$O(^RTV(190.3,"B",R,M)) Q:'M  S CNT=CNT+1 D ARRAY
 Q
ARRAY I '$D(^ZZRTM(M)) S ^ZZRTM(M)=R Q
 W !!,"Check for duplicate movement: ",M," Record numbers: ",R,", ",^ZZRTM(M) S DUP=DUP+1
 Q
