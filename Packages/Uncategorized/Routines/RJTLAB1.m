RJTLAB1 ; ;[ 06/21/95  4:41 PM ]
 S DD=0,EE=0,FF=0
 F J=0:0 S EE=$O(^LRO(68,EE)) Q:EE="AC"  W !,"EE="_EE F K=0:0 S FF=$O(^LRO(68,EE,1,FF)) Q:FF=""  W !,"FF="_FF F I=0:0 S DD=$O(^LRO(68,EE,1,FF,1,DD)) Q:DD=""!(DD="AC")!(DD="D")  W !,"DD value is "_DD D SWT
 ;F I=0:0 S DD=$O(^LRO(68,EE,1,FF,1,DD)) Q:DD=""  W !,DD D SWT
 Q
SWT ;
 I $D(^LRO(68,EE,1,FF,1,DD,3)),$P(^(3),"^",6) S $P(^LRO(68,EE,1,FF,1,DD,3),"^",5)=$P(^LRO(68,EE,1,FF,1,DD,3),"^",6) S $P(^(3),"^",6)="" W !,"switched entry "_$ZR
 Q
