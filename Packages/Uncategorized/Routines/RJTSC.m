RJTSC ; ;[ 07/06/95  2:23 PM ]
 F I=0:0 S DD=$O(^SC(DD)) Q:DD="AAS"  D CHK 
 Q
CHK ;
 I '$D(^SC(DD,"SL")) W !,"Missing SL node for entry "_DD
 Q
