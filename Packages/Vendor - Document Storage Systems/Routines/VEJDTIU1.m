VEJDTIU1 ;DSS/SGM - VARIOUS TIU UTILITIES ;03/16/2005 12:00
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#  References   [cs := controlled subscription]
 ;-----  -------------------------------------------------------
 ; 2056  $$GET1^DIQ [supported]
 ; 3201  RPC - TIU IS THIS A CONSULT? calls ISCNSLT^TIUCNSLT [cs]
 ;       ====== following are not subscribed to ======
 ; 3351  $$WHATITLE^TIUPUTU [cs]
 ; 3923  RPC: TIU GET DOCUMENT TITLE calls GETTITLE^TIUSRVA [cs]
 ;       FM read of .07 field of file 8925.1
 ;       Direct global read of ^GMR(123,DA,0)
 ;       PROCESS^GMRCSTS1
 ;
 ;
ACTIVE(VEJD,VAL,TIUIFN) ; RPC: VEJDTIU GET DOC DEF STATUS
 ;  Return the ifn and status of a TIU DOCUMENT DEFINTION #8925.1
 ;  If multiple matches found, return error message
 ;  Either VAL or TIUIFN must be passed
 ;     VAL = name or ifn of a TIU DOCUMENT DEFINITION #8925.1
 ;  TIUIFN = ifn of a TIU DOCUMENT #8925
 ;  Return: -1^error message  or  8925.1 ifn^doc name^status   where
 ;           status = A:active  I:inactive  T:test
 N X,Y,DIERR,IENS,VEJ,VEJERR
 S TIUIFN=$G(TIUIFN),VAL=$G(VAL)
 I VAL="",'TIUIFN S X=1 G OUT
 I +TIUIFN S VAL=$$DEF(TIUIFN) I VAL<1 S X=2 G OUT
 S VEJD=$$GET(VAL) I VEJD<1 S X=3 G OUT
 S $P(VEJD,U,3)=$E($$GET1(8925.1,+VEJD,.07,"E"))
 Q
 ;
CNSLT(VEJD,TIUIFN,COM) ; RPC: VEJDTIU ADMIN COMPLETE CONSULT
 ;this allows DocMananger or any DSS application to "administratively"
 ;complete a consult.  This bypasses all security on who can complete a
 ;consult.  This was developed because CPRS did not complete the
 ;associated consult when the TIU title was administratively closed.
 ;It put the consult in a partial results state.  This RPC will not be
 ;needed once CPRS fixes their "bug".
 ;  TIUIFN - req - pointer to file 8925
 ;  VEJCOM - opt - local array passed by reference
 ;           VEJCOM(n)=text   for n=1,2,3,4,...
 ;           comments to be filed with consult as to why this was
 ;           administratively completed
 ;  Return: 1 if successful, else return -1^msg
 K ^TMP("GMRCLS",$J)
 N X,Y,Z,VEJ,VEJCOM
 I $G(TIUIFN)<1 S X=4 G OUT
 S (X,Y)="" F  S X=$O(COM(X)) Q:X=""  S Y=Y+1,VEJCOM(Y,0)=COM(X)
 ; get tiu document type
 S Y=$$DEF(TIUIFN) I Y<1 S X=2 G OUT
 D ISCNSLT^TIUCNSLT(.VEJ,Y) I 'VEJ S X=5 G OUT
 S VEJ=$$GET1(8925,TIUIFN,1405,"I")
 I VEJ'[";GMR(123," S X=9 G OUT
 S Y=$G(^GMR(123,+VEJ,0)) I Y="" S X=6 G OUT
 S Y=$P(Y,U,12) ; cprs status
 I Y=1 S X=7 G OUT
 I Y=2 S X=8 G OUT
 S ^TMP("GMRCLS",$J,+VEJ)="" D PROCESS^GMRCSTS1(2,.VEJCOM)
 S VEJD=1
 Q
 ;
OUT ; come here if problem, then quit RPC call by setting VEJD
 I X=1 S X="No lookup value received"
 I X=2 S X="TIU# "_TIUIFN_" does not have a TIU DOCUMENT DEFINITION"
 I X=3 S X="TIU DOCUMENT DEFINITION entry "_VAL_" not found"
 I X=4 S X="No TIU record number received"
 I X=5 S X="TIU# "_TIUIFN_" is not a consult title"
 I X=6 S X="Consult ifn "_VEJ_" does not exist"
 I X=7 S X="Consult associated with TIU# "_TIUIFN_" is discontinued"
 I X=8 S X="Consult associated with TIU# "_TIUIFN_" is already completed"
 I X=9 S X="TIU# "_TIUIFN_" does not have a consult link"
 S VEJD="-1^"_X
 Q
 ;
 ;---------------  subroutines  ---------------
DEF(Y) ; get tiu document type
 ; Y - req - pointer to file 8925
 ; return pointer to 8925.1 or zero
 N X,VEJ D GETTITLE^TIUSRVA(.VEJ,Y)
 Q VEJ
 ;
GET(Y) ; get tiu doc definition for lookup value
 ; Y - req - 8925.1 lookup value
 ;     if +Y=Y then assume ifn lookup value
 ; return ifn^name or -1
 I $G(Y)="" Q -1
 I +Y=Y S Y="`"_Y
 Q $$WHATITLE^TIUPUTU(Y)
 ;
GET1(FILE,IEN,FIELD,FLAG) ; return value for a field
 N X,Y,DIERR,IENS,VEJERR,VEJDX
 S IENS=IEN_","
 Q $$GET1^DIQ(FILE,IENS,FIELD,FLAG,,"VEJERR")
