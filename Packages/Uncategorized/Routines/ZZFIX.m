ZLLRFIX ;ALB/LLR;Fix for Duplicates in 45.85;11/07/94
 S X=2940930 F  X=$P(^DG(45.85,D0,0),"^",1) F  0:0 W X,!,?15,$P(^DG(45.85,0),"^",12)
