VEJDSR01 ;DSS/SGM - SURGERY RPCS FOR COM SERVER ;12/04/2002 14:04
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
STAT(RET,CASE) ;  RPC: VEJD SR GET CASE STATUS
 ;  this will return the statuses of a case as it appears in surgery pkg
 ;  Logic taken from SRSTRAN - Transcribe Surgeon's Dictation
 ;  CASE - required - ifn to SURGERY file (#130)
 ;  Return:
 ;    on error - RET = -1^error message
 ;    else  RET = status1;status2;status3
 ;  Logic copied from ^SRSTRAN
 ;  Statuses from SROP1
 ;  NON-OR PROCEDURE   LOCKED     COMPLETED    NOT COMPLETED
 ;  ABORTED            CANCELLED  SCHEDULED    REQUESTED 
 N I,X,Y,Z,DIERR,ERM,FLDS,IENS,INOR,NON,TMP,VEJD,VEJDERR
 I '$G(CASE) S X=1 G SOUT
 I '$D(^SRF(CASE,0)) S X=2 G SOUT
 S IENS=CASE_","
 ;  .205 - time pat in or [.2;10]
 ;    24 - lock case [LOCK;1]
 ;    26 - principal procedure - free [OP;1]
 ;    54 - OCCURRENCE/NO PROCEDURE - 1/0 [37;1]
 ;   118 - non-or procedure - Y/N [NON;1]
 S FLDS=".205;24;26;54;118"
 D GETS^DIQ(130,IENS,FLDS,"IE","VEJD","VEJDERR")
 I $D(DIERR) S X=3 G SOUT
 M TMP=VEJD(130,IENS) K VEJD S VEJD=""
 S NON=$G(TMP(118,"I"))="Y",INOR=$G(TMP(.205,"I"))
 I 'NON,'INOR S X=4 G SOUT
 I $G(TMP(26,"I")) S X=5 G SOUT
 I NON S VEJD("NON-OR PROCEDURE")="Non-OR Procedure"
 E  D
 .N SR,SROP,SROPER,SRSTAT,SRSTATUS
 .S SROPER="",SROP=CASE D ^SROP1 Q:SROPER=""
 .F I=1:1:$L(SROPER,"(") D
 ..S X=$P($P(SROPER,"(",2),")"),Y=$E(X)_$$LOW^XLFSTR($E(X,2,99))
 ..S VEJD(X)=Y
 ..Q
 .Q
 I $G(TMP(24,"I")) S VEJD("LOCKED")="Locked"
 S RET="",Z="" F  S Z=$O(VEJD(Z)) Q:Z=""  S RET=RET_VEJD(Z)_";"
 S X=0
SOUT ;  status exit - expects X to be defined
 I X=1 S Z="No surgical case number received"
 I X=2 S Z="Surgery case "_CASE_" does not exist"
 I X=3 S Z=$$MSG^DSICFM01("V",,,,"VEJDERR")
 I X=4 S Z="Surgical Case "_CASE_" does not have Time in OR"
 I X=5 S Z="Case has occurrence but no porcedures"
 S:X RET="-1^"_Z
 Q
