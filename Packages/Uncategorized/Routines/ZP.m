LLRFIX ;ALB/LLR - OPC FILE ENTRIES ; 10/27/95
 ;
 N SD0,DIV
LOOP ; Loop through the OPC visit date (multiple) for null facility
 S SD0=0
 F  S SD0=$O(^SDASF(SD0)) Q:'SD0  D
 S SD0=$G(^(SD0,0)) D
 ..I $P(^SDASF(SD0,0),"^",2)="" W !,"Facility missing on entry "_SD0_"for patient "_$P(^SDASF(SD0,0),U)
 Q
