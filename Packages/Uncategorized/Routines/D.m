RJTMON ;
 S D=1
 F I=0:0 S D=$O(^DGCR(399,D)) Q:D="ABNDT"  I $D(^DGCR(399,D,"M")) D WRT
 Q
WRT ;
 I $P(^DGCR(399,D,"M"),"^",1)="" W !,$P(^DGCR(399,D,"M"),"^",3)
 Q       
