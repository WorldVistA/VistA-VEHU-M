ABS1PST ;VAMC ALTOONA/CTB - PATCH INSTALLATION POST INIT ;12/22/94  8:40 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**3**;JULY 6, 1994
FMV21 ;CORRECTION FOR V21
 N X,Y
 W !!! S X="Correcting Entires in File 503331." D MSG^ABSVQ
 S Y=($P(^ABS(503331,0),"^",4)\16000)+1
 W ! S X="This process will paint less than "_Y_" row"_$S(Y>1:"s",1:"")_" of 'dots'." D MSG^ABSVQ
 S N=0 F  D FMFIX  Q:'N  W "."
 W ! S X="Correcting Entries in File 503335" D MSG^ABSVQ
 S Y=($P(^ABS(503335,0),"^",4)\16000)+1
 W ! S X="This process will paint less than "_Y_" row"_$S(Y>1:"s",1:"")_" of 'dots'." D MSG^ABSVQ
 S N=0 F  D FMFIX1  Q:'N  W "."
 K ^ABS(503331,"AH")
 K ^ABS(503335,"AG")
 K ^ABS(503335,"AM")
 QUIT
FMFIX ;
 F I=1:1:200 S N=$O(^ABS(503331,N)) Q:'N  I $D(^ABS(503331,N,0)) S $P(^(0),"^",9)=""
 QUIT
FMFIX1 ;
 F I=1:1:200 S N=$O(^ABS(503335,N)) Q:'N  I $D(^ABS(503335,N,0)) S $P(^(0),"^",13)="",$P(^(0),"^",15)=""
 QUIT
