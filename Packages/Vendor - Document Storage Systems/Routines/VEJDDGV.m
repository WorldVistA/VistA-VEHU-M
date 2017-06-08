VEJDDGV ;DSS/SGM - MEDICAL CENTER DIVISION TOOLS ;01/17/2003 10:57
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine contains various utilities for data about
 ;  medical center division
 ;
 ;  DBIA#  Supported
 ;  -----  ---------  ----------------------------------------
 ;   2051      x      LIST^DIC
 ;   2171      x      $$STA^XUAF4
 ;  10112      x      $$PRIM^VASITE
 ;                    $$ALL^VASITE
 ;                    Fileman read file 40.8, fields .01,.07,1
 ;
ALL(VEJDR,SORT,DATE) ;  RPC: VEJD DG GET MCD
 ;  this returns information about all medical center divisions
 ;  DATE - optional - default to TODAY - Fileman date to determine
 ;         if a division is active or not
 ;  SORT - optional - default value is "S" - a single character indicating
 ;         how the return array should be sorted.  If called by a M program
 ;         this will determine the subscript value of the return array
 ;         I - sort by INSTITUTION file ien
 ;         M - sort by MEDICAL CENTER FILE ien
 ;         N - sort by name of the Institution
 ;         S - sort by station number
 ;  Return  VEJDR(sub) = p1^p2^p3^p4^p5^p6 where
 ;          p1 = pointer to MEDICAL CENTER DIVISION file (#40.8)
 ;          p2 = pointer to INSTITUTION file (#4)
 ;          p3 = Institution name
 ;          p4 = station number (file 4, field 99)
 ;          p5 = 1 if this division is active as of input date
 ;          p6 = 1 or 0: 1 if division is primary as of date
 ;  On error, return VEJDR(1) = -1 ^ error message
 ;
 N X,Y,Z,DIERR,INST,NM,PRIM,RET,STA,VASITE,VEJD,VEJDER,VEJDIEN
 S DATE=$G(DATE) S:'DATE DATE=DT
 S SORT=$G(SORT) S:SORT="" SORT="S" S:SORT?.E1L.E SORT=$$UP^XLFSTR(SORT)
 S SORT=$E(SORT) S:"IMNS"'[SORT SORT="S"
 S PRIM=$$PRIM^VASITE(DATE) S:'PRIM PRIM=-1 ; pointer to file 40.8
 ;  get all active division as of date
 S X=$$ALL^VASITE(DATE) ; changed 2-27-03 by DBB per Steve
 D LIST^DIC(40.8,,"@;.07I;.01;1","PQ",,,,,,,"VEJD","VEJDER")
 I $D(DIERR) S VEJDR(1)="-1^"_$$MSG^DSICFM01("V",,,,"VEJDER") Q
 F VEJD=0:0 S VEJD=$O(VEJD("DILIST",VEJD)) Q:'VEJD  D
 .S RET=VEJD("DILIST",VEJD,0)
 .I $P(RET,U,2) S Z=$$SITE^VASITE(DATE,+RET) I +Z>0 S RET=+RET_U_Z
 .S STA=$P(RET,U,4),INST=$P(RET,U,2),NM=$P(RET,U,3)
 .I INST]"",$D(VASITE(INST)) S $P(RET,U,5)=1
 .S:PRIM=+RET $P(RET,U,6)=1 S:STA="" STA="Z"_(+RET)
 .S STA=STA_" " S:'INST INST="A"
 .S X=$S(SORT="S":STA,SORT="I":INST,SORT="M":+RET,1:NM)
 .I $D(VEJDR(X)) F  S X=X_" " Q:'$D(VEJDR(X))
 .S VEJDR(X)=RET
 .Q
 Q
