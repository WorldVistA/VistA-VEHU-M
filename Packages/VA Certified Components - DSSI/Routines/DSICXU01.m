DSICXU01 ;DSS/SGM - CALLS TO KERNEL SYSTEM UTILS ;03/18/2005 06:41
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DO NOT INVOKE THIS ROUTINE DIRECTLY, SEE ^DSICXU
 ;
 ;DBIA# Supported Reference
 ;----- -------------------
 ; 4440 $$PROD^XUPROD
 ;
 ;Internal variables:
 ; DSIC - return parameter passed by reference
 ;  FLG - opt - if $G(FLG) then extrinsic function, else RPC
 ;
PROD() ; Return 1:PRODUCTION SYSTEM; 0:TEST ACCT; -1:UNABLE TO DETERMINE
 Q $S($$PATCH("XU*8.0*284"):$$PROD^XUPROD,1:-1)
 ;
 ;---------------  subroutines  ---------------
PATCH(X) Q $$PATCH^DSICXPDU(,X,1)
