A1AXCNSM ;SLL/ALB ISC; JCAHO CONTINGENCY REPORT SUM DATA; 12/30/88
 ;;VERSION 1.0
 ;
 F FAC=0:0 S FAC=$O(^UTILITY($J,"CN",FAC)) Q:FAC=""  S ^UTILITY($J,"CN",FAC,"TOT")=0 D:$D(^UTILITY($J,"CN",FAC,"C")) CTC D:$D(^UTILITY($J,"CN",FAC,"RC")) CTRC D:$D(^UTILITY($J,"CN",FAC,"PLUS")) CTPLUS
 Q
CTC ;
 F CAT=1:1:NCAT S $P(^UTILITY($J,"CN",FAC,"C"),"^",1)=$P(^UTILITY($J,"CN",FAC,"C"),"^",1)+$P(^UTILITY($J,"CN",FAC,"C"),"^",CAT+1)
 S ^UTILITY($J,"CN",FAC,"TOT")=^UTILITY($J,"CN",FAC,"TOT")+$P(^UTILITY($J,"CN",FAC,"C"),"^",1)
 Q
CTRC ;
 F CAT=1:1:NCAT S $P(^UTILITY($J,"CN",FAC,"RC"),"^",1)=$P(^UTILITY($J,"CN",FAC,"RC"),"^",1)+$P(^UTILITY($J,"CN",FAC,"RC"),"^",CAT+1)
 S ^UTILITY($J,"CN",FAC,"TOT")=^UTILITY($J,"CN",FAC,"TOT")+$P(^UTILITY($J,"CN",FAC,"RC"),"^",1)
 Q
CTPLUS ;
 F CAT=1:1:NCAT S $P(^UTILITY($J,"CN",FAC,"PLUS"),"^",1)=$P(^UTILITY($J,"CN",FAC,"PLUS"),"^",1)+$P(^UTILITY($J,"CN",FAC,"PLUS"),"^",CAT+1)
 S ^UTILITY($J,"CN",FAC,"TOT")=^UTILITY($J,"CN",FAC,"TOT")+$P(^UTILITY($J,"CN",FAC,"PLUS"),"^",1)
 Q