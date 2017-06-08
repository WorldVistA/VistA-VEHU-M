RJTDVB1 ;
 S DD="",FF=""
 F I=0:0 S DD=$O(^DVB(396,"B",DD)) Q:DD=""   D 1
 Q
1 ;
 S FF=$O(^DVB(396,"B",DD,"")) I '$D(^DVB(396,FF,0)) W !,"internal entry number"_" "_FF_" does not have a zeroth node"
 Q
 
