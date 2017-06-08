ZCTR ;GET RID OF 'CTR' NODES
 ;
 ; loop thru title file starting at ien 31
 ; if no zero node of title entry kill 'ctr' node
 N IEN S IEN=30
 F  S IEN=$O(^GMR(121.2,IEN)) Q:'IEN  D
 .  I $D(^GMR(121.2,IEN,0)) Q
 .  K ^GMR(121.2,IEN,"CTR")
 Q
