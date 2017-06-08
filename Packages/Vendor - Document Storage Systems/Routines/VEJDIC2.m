VEJDIC2 ;DSS/CC - Insurance card RPC's ;12/14/2004 [3/9/05 1:00pm]
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;
 ; 
 Q
GETIEN(RET,PAT,BUF,CDT) ;;Retrieve ICB Audit IEN
 ; Implements VEJDIC GET ICB AUDIT remote procedure call
 S RET="-1^Missing input parameter"
 I '$G(PAT)!('$G(BUF))!('$G(CDT)) Q
 N O S O=$O(^DSI(19625,"G",PAT,BUF,CDT,""))
 S RET="-1^No data found"
 S:+O=O RET=O
 Q
