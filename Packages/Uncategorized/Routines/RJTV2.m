RJTQA ;
 S DA=""
 S GG="",FF=""
 F I=0:0 S FF=$O(^VA(200,"B",FF)) Q:FF=""   D 1
 W !,"done..."
 Q
1 ;
 F J=0:0 S DA=$O(^VA(200,"B",FF,DA)) Q:DA=""  D 2
 Q
2 ;
 X ^DD(200,.01,1,10,1)
 Q
