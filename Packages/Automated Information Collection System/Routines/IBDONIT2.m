IBDONIT2 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 ;
 ;
 K ^UTILITY("ORVROM",$J),DIC
 Q
DT W !
 I '$D(DTIME) S DTIME=999
 K %DT D NOW^%DTC S DT=X
 K DIK,DIC,%I,DICS Q
 ;
