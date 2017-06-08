PXPTPREI ; SLC/MKB,DLT -- Patient/IHS pre-init rtn ;9/27/94  14:18
 ;;1.0;PCE Patient/IHS Subset;;Nov 01, 1994
 ;
 N %,%H,%I,X,Y
 D NOW^%DTC,YX^%DTC S PXPTSTRT=Y ; start time
 W !!,"Starting PXPT Initialization now"
 Q
 ;
