ZZCHKVS ; Routine for checking mismatch Visit-Note patient
 
CKALL N I,T0
 S I=0
 F  S I=$O(^TIU(8925,I)) Q:'I  I $D(^TIU(8925,I,0)),$P(^(0),U,3)>0 S T0=$G(^(0)) D
 . I $P(T0,U,2)'=$P($G(^AUPNVSIT(+$P(T0,U,3),0)),U,5) D
 . . W !,"TIU IEN: ",I,"  Patient: ",$P(T0,U,2),"  Status: ",$P(T0,U,5),"VISIT IEN: ",+$P(T0,U,3),"  Patient: ",$P($G(^AUPNVSIT(+$P(T0,U,3),0)),U,5)
 Q
 
