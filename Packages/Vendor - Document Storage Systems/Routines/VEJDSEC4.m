VEJDSEC4 ;ALB/MM,JAP - Utilities for record access & sensitive record processing;10/6/99 ; 1/5/00 2:41pm
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;
NOTICE(RESULT,AADUZ,DFN,DGOPT,ACTION) ;RPC/API entry point for log entry and message generation
 ;Input parameters:  
 ;  DFN    = Patient file DFN
 ;  DGOPT  = Option name^Menu text (Optional)
 ;  ACTION = 1 - Set DG Security Log entry, 2 - Generate mail 
 ;           message, 3 - Both (Optional - Defaults to both)
 ;
 ;Output:  RESULT = 1 - DG Security Log updated and/or Sensitive Record msg sent (Determined by ACTION value)
 ;                  "-1^message" - Required variable undefined (PATIENT IFN or no DUZ)
 I $G(DFN)="" S RESULT="-1^No PATIENT defined" Q
 I $G(AADUZ)="" S RESULT="-1^No PROVIDER (DUZ) defined" Q
 I '$D(^VA(200,AADUZ,0)) S RESULT="-1^PROVIDER (DUZ) #"_AADUZ_", not valid)." Q
 S DGOPT=$G(DGOPT)
 I $G(ACTION)="" S ACTION=3
 I ACTION'=1 D BULTIN1^DGSEC(DFN,AADUZ,DGOPT)
 I ACTION'=2 D SETLOG1^DGSEC(DFN,AADUZ,,DGOPT)
 S RESULT=1
 Q
