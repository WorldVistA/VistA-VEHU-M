RJTMM ; ;[ 07/02/97  11:32 AM ]
 F I=0:0 S G=$O(^XMB(3.7,G)) Q:G="AB"  W !,G D CNT W !,CNT I '$D(^XMB(3.7,G,2,0)) S ^XMB(3.7,G,2,0)="^3.701^"_CNT_"^"_CNT
 Q
CNT ;
 S CNT=0
 F I=0:0 S H=$O(^XMB(3.7,G,2,"B",H)) Q:H=""  S CNT=CNT+1 W !,H  
 Q
CNT1 ;
 S CNT=CNT+1 W !,CNT
 Q
