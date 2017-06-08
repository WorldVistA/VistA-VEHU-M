DSIVIC4 ;DSS/AMC - Insurance card RPC's;12/9/2008
 ;;2.2;INSURANCE CAPTURE BUFFER;;May 19, 2009;Build 12
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2056   $$GET1^DIQ
 Q
ENST(AXY) ;RPC - DSIV LIST ENTERED STATUS
 ;Input Parameters
 ;    None
 ;Return Array
 ;    IEN (File 355.33) ^ Date Entered (I;E)
 ;    -1 ^ No Entries Found!
 ;    
 S AXY=$NA(^TMP("DSIVIC4",$J)) K @AXY
 N ENDT,IEN,IENS,GET,LOGL,YY S YY=0,LOGL=$NA(^IBA(355.33,"AEST","E"))
 S ENDT=0 S ENDT=$O(@LOGL@(ENDT)) Q:'ENDT  S IEN=0 S IEN=$O(@LOGL@(ENDT,IEN)) Q:'IEN  D
 .S YY=YY+1,@AXY@(YY)=IEN_U_ENDT_";"_$$GET1^DIQ(355.33,IEN,.01)
 I 'YY S @AXY@(YY)="-1^No Entries Found!"
 Q
