ZZORPHAN ; Routine for checking mismatch Visit-Note patient
 
CKALL N TD,TIU
 S COUNT=0
 ;S I=0
 S TD=0,TIU=0
 F  S TIU=$O(^TIU(8925,"B",81,TIU)) Q:'TIU  S TD=TD+1 D
 .I '$D(^TIU(8925,+$P(^TIU(8925,TIU,0),"^",6),0)) D
 ..W !!,"ADDENDUM: ",TIU,"  is an orphan Parent IEN: ",+$P(^TIU(8925,TIU,0),"^",6)," STATUS= ",+$P(^TIU(8925,TIU,0),"^",5)
 ..W !,"PARENT DOC TYPE: ",+$P($G(^TIU(8925,TIU,0)),"^",4),"  ENTRY D/T : ",+$P($G(^TIU(8925,TIU,12)),"^",1)
 ..S COUNT=COUNT+1
 W !,"TOTAL ORPHANS:  ",COUNT
 Q
