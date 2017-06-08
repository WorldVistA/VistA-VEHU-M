RJTDDP ;
 S I="P"
 N I
 F I=0:0 S I=$O(^DIBT(I)) Q:'I  S X=$P($G(^(I,0)),U) I $D(^TMP($J,X))
 Q
