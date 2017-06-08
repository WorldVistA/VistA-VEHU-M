DSICLOCK ;DSS/DBB -GENERIC LOCK/UNLOCK UTILITY ;01/14/2005 19:19
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  Supported Reference
 ; -----  -------------------
 ; 10016  ^DIM
 ;
LOCK(DSIC,REF,IFN,FLAG,FUN) ; RPC: DSIC LOCK
 ; Lock or unlock a global reference from a GUI client
 ;  REF - req - FM file number or $NAME(global) to be locked
 ;  IFN - opt - required if REF is a file (or subfile) number
 ;              If REF is the top level file number, then IFN is the
 ;                IEN of the record
 ;              If REF is a subdictionary number for a multiple, then
 ;                IFN must be the appropriate IENS for that multiple
 ;                level
 ; FLAG - opt - default to 1 - 1:lock global; -1:unlock global
 ;  FUN - opt - Boolean flag - [1:extrinsic function; 0:RPC call]
 ; RETURN: 1:operation successful; -1^msg
 ;
 ;NOTE: if you issue a lock you must issue the subsequent unlock
 ;
 N X,Y,Z,ROOT
 I $G(REF)="" D ERR(1) G OUT
 I REF=+REF,$G(IFN)="" D ERR(2) G OUT
 S FLAG=$G(FLAG,1) S:'FLAG FLAG=1 S FLAG=+FLAG
 I $G(IFN)'="",$E(IFN,$L(IFN))'="," S IFN=IFN_","
 I REF=+REF D  I $D(DSIC) G OUT
 .S X=$$ROOT^DSICFM06(,REF,$G(IFN),0,1) I +X=-1 S DSIC=X Q
 .S REF=X_(+IFN)_")"
 .Q
 I REF'?1"^"1U.UN,REF'?1"^"1U.UN1"(".E1")" D ERR(4,REF) G OUT
 S X="L "_REF D ^DIM I '$D(X) D ERR(4,REF) G OUT
 I FLAG=-1 L -@REF S DSIC=1 G OUT
 L +@REF:2 I  S DSIC=1 G OUT
 D ERR(3,REF)
OUT Q:$G(FUN) DSIC
 Q
 ;
 ;---------------  subroutines  ---------------
ERR(X,Y) ;
 ;;No filenumber or global reference received
 ;;No record number received
 ;;Unable to lock global: 
 ;;Invalid global reference received: 
 I +X=X S X="-1^"_$P($T(ERR+X),";",3) S:$G(Y)'="" X=X_Y
 S DSIC=X
 Q
