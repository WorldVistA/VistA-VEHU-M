RJTDVB ; ;[ 07/29/93  1:51 PM ]
 S ZERO=""
 F I=0:0 S ZERO=$O(^DVB(396,ZERO)) W !,ZERO D 1  Q:ZERO=""
 Q
1 ;
 I $D(^DVB(396,ZERO,0)) S ONE=$P(^(0),"^",1)
2 ;
 W !,$N(^DVB(396,"B",ONE,""))
