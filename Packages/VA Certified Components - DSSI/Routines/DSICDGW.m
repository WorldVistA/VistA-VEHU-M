DSICDGW ;DSS/SGM - UTILITIES FOR WARD DATA ;07/30/2003 22:21
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ---------------------------------------
 ;  2051      x      $$FIND1^DIC
 ;  2056      x      ^DIQ: $$GET1, GETS
 ; 10039      x      direct global read of NAME from file 42
 ;                   NOT CURRENTLY SUBSCRIBED TO
 ;  1337  cont sub   direct global read of fields .01,3, file 42.4
 ;  2652             Fileman read .01 field, file 42.4 [pointer allowed]
 ;
 ;
SPEC(DSIC,WARD,FUN) ;  RPC: DSIC WARD PTF SPECIALTY
 ;  return the ptf specialty info for a ward
 ;  WARD - required - name of WARD or pointer to file 42
 ;   FUN - optional - default to 0 - Boolean
 ;         if FUN=1 then extrinsic function, else RPC
 ;  RETURN:
 ;    ptf code ^ specialty name ^ specialty service  [from file 42.4]
 ;    if problems return -1^message
 N X,Y,Z,DIERR,DSI,DSIERR,IEN,RET
 I $G(WARD)="" S RET="-1^No ward received" G OUT
 S X=$$FIND1^DIC(42,,"AQX",WARD,"B",,"DSIERR")
 I X<1,'$D(DIERR) S RET="-1^Ward '"_WARD_"' not found" G OUT
 I $D(DSIERR) S RET="-1^"_$$MSG^DSICFM01("VE",,,,"DSIERR") G OUT
 S X=$$GET1^DIQ(42,X_",",.017,"I",,"DSIERR")
 I X<1,'$D(DIERR) S RET="-1^No PTF Specialty code found for ward: "_WARD G OUT
 I $D(DSIERR) S RET="-1^"_$$MSG^DSICFM01("VE",,,,"DSIERR") G OUT
 S IEN=X_"," D GETS^DIQ(42.4,IEN,".001;.01;3",,"DSI","DSIERR")
 I $D(DSIERR) S RET="-1^"_$$MSG^DSICFM01("VE",,,,"DSIERR") G OUT
 K Z M Z=DSI(42.4,IEN)
 S RET=(+IEN)_U_$G(Z(.01))_U_$G(Z(3))
 ;
OUT I $G(DSIC)="" S DSIC=$G(RET)
 Q:$G(FUN) DSIC Q
