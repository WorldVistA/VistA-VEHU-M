RJTQA ;
 S GG="",FF=""
 F I=0:0 S FF=$O(^QA(741,"B",FF)) Q:FF=""   D 1
 W !,"done..."
 Q
1 ;
 F J=0:0 S GG=$O(^QA(741,"B",FF,GG)) Q:GG=""  D 2
 Q
2 ;
 I $P(^QA(741,GG,0),"^",1)'=FF W !,"bad record "_GG
 Q
