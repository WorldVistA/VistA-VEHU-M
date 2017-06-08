DSDCHECK ;COUNT FOR 190.3
START K ^DSD S CNT=0 F R=0:0 S R=$O(^RTV(190.3,"B",R)) Q:R=""  D HIST 
 W !!,"Total # of entries in 190.3 is : ",CNT Q
HIST F M=0:0 S M=$O(^RTV(190.3,"B",R,M)) Q:M=""  S CNT=CNT+1 D ARRAY
 Q
ARRAY I '$D(^DSD(M)) S ^DSD(M)=0 Q
 W !,"Check for duplicate movement: ",M
 Q
 
