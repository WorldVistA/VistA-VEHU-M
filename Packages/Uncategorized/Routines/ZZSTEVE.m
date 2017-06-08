ZZSTEVE ; ;[ 11/01/94  8:53 AM ]
 ;S N=""
 ;F I=0:0 S N=$O(^DGPM("B",N)) Q:N=""  S M="" S M=$O(^DGPM("B",N,M)) D EVAL
 F I=0:0 S I=$O(^DGPM(I)) Q:'I  D EVAL
 Q
EVAL ;
 I '$P($G(^DGPM(I,0)),"^",14) W !,I
 Q
