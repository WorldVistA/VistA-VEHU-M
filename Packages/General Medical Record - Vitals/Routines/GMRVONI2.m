GMRVONI2 ; ; 07-SEP-1995
 ;;3.0;Vitals/Measurements;;Jan 24, 1996
 ;
 ;
 K ^UTILITY("ORVROM",$J),DIC
 Q
DT W !
 I '$D(DTIME) S DTIME=999
 K %DT D NOW^%DTC S DT=X
 K DIK,DIC,%I,DICS Q
 ;
