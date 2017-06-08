DSICXU ;DSS/SGM - CALLS TO KERNEL SYSTEM UTILS ;03/15/2005 14:46
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- -------------------
 ; 4440 $$PROD^XUPROD
 ;
 ;Internal variables:
 ; DSIC - return parameter passed by reference
 ;  FLG - opt - if $G(FLG) then extrinsic function, else RPC
 ;
OUT Q:$G(FLG) DSIC
 Q
 ;
PROD(DSIC,FLG) ; rpc: DSIC XUPROD
 ; Return Boolean value: 1:PRODUCTION SYSTEM; 0:TEST ACCT
 S DSIC=$$PROD^DSICXU01 G OUT
