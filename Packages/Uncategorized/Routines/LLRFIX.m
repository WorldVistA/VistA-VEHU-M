LLRFIX ;ALB/LLR - OPC FILE ENTRIES ; 10/27/95 [ 10/27/95  1:23 PM ]
 ;
 N SD0
LOOP ; Loop through the OPC visit date (multiple) for null facility
 S SD0=0
 F  S SD0=$O(^SDASF(SD0)) Q:'SD0  S VISIT=0 F  S VISIT=$O(^SDASF(SD0,1,VISIT)) Q:'VISIT  S VISIT(0)=$G(^(VISIT,0))  I $P(^(0),"^",2)="     " W !,"Facility missing on entry "_SD0_" for patient "_$P(^SDASF(SD0,0),U) 
 Q
