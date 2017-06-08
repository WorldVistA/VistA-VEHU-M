VEJDSR02 ;DSS/SGM - GET SCHEDULE OF OPERATIONS ;12/04/2002 14:04
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
OP(RET,CASE,VEJDTX) ;  RPC: VEJD SR FILE OP NOTE
 ;  copied from SRSTRAN - file operation note as if dictated
 ;  CASE - required - case# (or ien) to SURGERY file (#130)
 ;  VEJDTX - required - list array containing the text of the op note
 ;           VEJDTX[n] = text to be uploaded where n = 1,2,3,4,...
 ;  Return 1^OP Note successfully filed   or   -1^error message
 N X,Y,Z,DIERR,VEJD,VEJDERR
 S CASE=$G(CASE) I CASE="" S RET="-1^No case number received" Q
 E  I '$D(^SRF(CASE,0)) S RET="-1^Case number "_CASE_" not found" Q
 I $O(VEJDTX(""))="" S RET="-1^No operation note text received" Q
 D STAT^VEJDSR01(.VEJD,CASE) S VEJDERR="",Z="Case "_CASE_" "
 I +VEJD=-1 S RET=VEJD Q
 I VEJD["LOCKED" S VEJDERR=Z_"is locked, text not uploaded; "
 I $O(^SRF(CASE,12,0)) S VEJDERR=VEJDERR_"already has text on file, text not uploaded"
 I VEJDERR]"" S RET="-1^"_VEJDERR Q
 K VEJD,VEJDERR
 L +^SRF(CASE):3 E  S RET="-1^Unable to lock case record, try later" Q
 D WP^DIE(130,CASE_",",1.15,,"VEJDTX","VEJDERR") L -^SRF(CASE)
 I '$D(DIERR) S RET="1^OP Note successfully filed"
 E  S RET="-1^"_$$MSG^DSICFM01("V",,,,"VEJDERR")
 Q
 ;
SCH(RET,SDT,EDT,SORT,DFN,CHK) ; RPC: VEJD SR GET SCHEDULE
 ;  copied from SRSCD, SRSCDS, SRSCDS1 - get surgery schedule
 ;   SDT - optional - start date - default = DT
 ;   EDT - optional -   end date - default = DT+7
 ;  SORT - optional - code indicating sort by criteria
 ;         L - default sort by medical center division, hospital loc
 ;         S - sort by medical center division, speciality
 ;   DFN - optional - pointer to PATIENT file
 ;         return all patients unless DFN is passed
 ;   CHK - optional - screen schedules
 ;         if DATA is not passed, then return all operations for dates
 ;         format of DATA(n) = code ^ value  where
 ;            n = 1,2,3,4,...
 ;         code = D, I, L, O, OS, NS, or S  where
 ;                D - medical center division (#40.8)
 ;                I - institution (#4)
 ;                L - hospital location (#44)
 ;                O - operating room (#131.7)
 ;               OS - OR specialities (#137.45)
 ;               NS - Non-OR specialities (#723)
 ;                S - 3-digit stop code
 ;        value = name or ien from appropriate file
 ;                if code="S", then value must be the 3-digit stop code
 ;
 ;  Return on error @RET@(1) = -1^error message
 ;  Else return @RET@(OR/NON,MCD,SORT,DATE.TIME,CASE#)=p11^p12^...^p17
 ;              @RET@(OR/NON,MCD,SORT,DATE.TIME,CASE#,0)=p21^p22
 ;    p11 = case#                 p16 = ien;medical center div name
 ;    p12 = int;ext date.time     p17 = status1;status2;status3,...
 ;    p13 = ien;hospital loc      p21 = pricipal procedure (text)
 ;    p14 = dfn;patient name      p22 = ien;cpt code
 ;    p15 = ssn;dashed-ssn
 ;    note: date.time is time patient in OR or if that is null then the
 ;          scheduled date.time
 N X,Y,Z,DATE,DIERR,FILE,FLDS,FLG,IDX,IENS,ROOT,SCR,STOP,VEJD,VEJDERR,ZSCR
 S SDT=$G(SDT) S:'SDT SDT=DT S:$G(DFN)<1 SDT=SDT-.000001
 S EDT=$G(EDT) S:'EDT EDT=$$FMADD^XLFDT(DT,7) S:$G(DFN)<1 EDT=EDT+.25
 S SORT=$G(SORT) S:SORT="" SORT="L"
 S RET=$NA(^TMP("VEJD",$J)) K @RET
 S CHK="" F  S CHK=$O(CHK(CHK)) Q:CHK=""  D
 .K DIERR,VEJDERR
 .S X=$P(CHK(CHK),U),VEJD=$P(CHK(CHK),U,2) Q:VEJD=""
 .S FILE=$S(X="D":40.8,X="I":4,X="L":44,X="O":131.7,X="OS":137.45,X="NS":723,X="S":40.7,1:0)
 .Q:'FILE  S (ZSCR,IDX)="",FLG="AMX"
 .I FILE=4 S ZSCR="I $P(^(0),U,11)'=""I"""
 .I FILE=40.7 S IDX="C",FLG="AX"
 .S X=$$FIND1^DIC(FILE,,FLG,VEJD,IDX,ZSCR,"VEJDERR")
 .I X>0 S:FILE=40.7 X=VEJD S SCR(FILE,X)=""
 .Q
 S FLDS=".01;.015;.02;.04;.09;.205;.232;10;11;17;18;24;118;119;125"
 S STOP=0
 I $G(DFN)<1 S ROOT=$NA(^SRF("AC",SDT))
 E  S ROOT=$NA(^SRF("ADT",DFN,9999999.999999-(EDT+.000001)))
 I $G(DFN)>0 F  S ROOT=$Q(@ROOT) Q:$QS(ROOT,1)'="ADT"  D  Q:STOP
 .I $QS(ROOT,2)'=DFN S STOP=1 Q
 .S DATE=$QS(ROOT,3) I SDT>(9999999.999999-DATE) S STOP=1 Q
 .S IENS=$QS(ROOT,4)_","
 .D SET
 .Q
 I $G(DFN)<1 F  S ROOT=$Q(@ROOT) Q:$QS(ROOT,1)'="AC"  D  Q:STOP
 .S DATE=$QS(ROOT,2) I DATE>EDT!'DATE S STOP=1 Q
 .S IENS=$QS(ROOT,3)_","
 .D SET
 .Q
 I '$D(@RET) S @RET@(1)="-1^No cases found for input criteria"
 Q
 ;
 ;  -----------------------  subroutines  ---------------------------
TIME(X) Q X_";"_$$FMTE^XLFDT(X,"5PZ")
SET ;
 N A,X,Y,Z,ASSN,DIERR,LOC,MCD,NON,PAT,SPEC,STATUS,TIME,VEJD,VEJDERR,VEJDX
 S (ASSN,LOC,MCD,PAT,STATUS,TIME)=""
 D GETS^DIQ(130,IENS,FLDS,"IE","VEJDX","VEJDERR") Q:'$D(VEJDX)
 M VEJD=VEJDX(130,IENS)
 S NON=$G(VEJD(118,"I"))="Y"
 ;  screen for speciality
 S X=$S(NON:125,1:.04),FILE=$S(NON:723,1:131.7)
 I $G(VEJD(X,"I")),$D(SCR(FILE)),'$D(SCR(FILE,VEJD(X,"I"))) Q
 S SPEC=$G(VEJD(X,"E")) S:SPEC="" SPEC="~z"
 S PAT=$G(VEJD(.01,"I"))_";"_$G(VEJD(.01,"E"))
 D STAT^VEJDSR01(.STATUS,+IENS) S:+STATUS=-1 STATUS=""
 S X=$$GET^DSICDPT1(+PAT) S:X>0 ASSN=$P(X,U,3)
 S Y=0 I NON S Y=$G(VEJD(119,"I"))
 E  S X=$G(VEJD(.02,"I")) I X S Y=+$G(^SRS(X,0))
 S Z="" I Y D LOC^VEJDSD01(.Z,Y) S:+Z=-1 Z=""
 ;  screen for medical center division
 S MCD=$P(Z,U,5) I +MCD,$D(SCR(40.8)),'$D(SCR(408,+MCD)) Q
 ;  screen for hospital location
 S LOC=$TR($P(Z,U,1,2),U,";") I +LOC,$D(SCR(44)),'$D(SCR(44,+LOC)) Q
 ;  screen for institution
 S X=+$P(Z,U,4) I X,$D(SCR(44)),'$D(SCR(44,X)) Q
 ;  screen for stop code
 S X=$P(Z,U,3) I X]"",$D(SCR(40.7)),'$D(SCR(40.7,X)) Q
 I $G(VEJD(.205,"I")) S TIME=$$TIME(VEJD(.205,"I"))
 I '$G(VEJD(.205,"I")),$G(VEJD(10,"I")) S TIME=$$TIME(VEJD(10,"I"))
 S X=+IENS_U_TIME_U_LOC_U_PAT_U_ASSN_U_MCD_U_STATUS
 S MCD=$P(MCD,";",2) S:MCD="" MCD="~z"
 S LOC=$P(LOC,";",2) S:LOC="" LOC="~z"
 S Z=$S(SORT="S":SPEC,1:LOC),@RET@(NON+1,MCD,Z,+TIME,+IENS)=X
 Q
