DSICSDA0 ;DSS/SGM - PARSE INPUT DATA FROM CALLS TO DSICSDA
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; This is not directly invokable.  It is only called from ^DSICSDA
 ; All the entry points in ^DSICSDA share a common input array.
 ; This routine will parse that input array and will set local
 ; variables as needed. It will not define unnecessary local variables.
 ;
 ;Note: dgr := direct global read
 ;DBIA# Supported Reference
 ;----- ---------------------------------------------------------------
 ;  557 dgr of .01;1 fields and C-index on file 40.7 - controlled subsc
 ; 2051 $$FIND1^DIC
 ; 2438 FM read of .01;1 fields of file 40.8 - controlled subsc
 ;10003 ^%DT
 ;10040 dgr of .01 and B-index on file 44
 ;10104 $$UP^XLFSTR
 ;
 ; return 1 if all parsing successfully completed
 ; Else return -1^msg
 ; Z301 - opt - boolean, 1:if calling SDAMA301; 0:otherwise
 ; This may set some local variables without killing them:
 ;   DSICL(ien)  = Hospital Location name [ #44 ]
 ;   DSIDFN(dfn) = patient name ^ ssn;ssn-dashed
 ;   DSIDIV(ien) = "" [Med Ctr Div file 40.8 ien]
 ;   DSISTOP(3-dig stop code) = file 40.7 ien
 ;   END         = fm end date
 ;   FLDS        = string of field number of data to return
 ;   MAX         = maximum number of entries to return
 ;   NOKILL      = flag indicating to not kill a global
 ;   SORT        = number {sort by criteria}
 ;   START       = fm start date
 ;   STATUS      = ';'-delimited string of codes of appts to return
 ;   TYPE        = single character (I or o) indicates to return only
 ;                   in or out-patient appts.
 ;
PARSE(Z301) ;  parse input array - see notes at end of this routine
 N I,J,X,Y,Z,FLG,NAME,RET,VAL
 S Z301=($G(Z301,0)>0)
 S RET=1
 S I="" F  S I=$O(INPUT(I)) Q:I=""  S X=INPUT(I) D:X'=""
 .N I
 .S NAME=$$UP($P(X,U)) Q:NAME=""
 .S VAL=$$UP($P(X,U,2)) Q:VAL=""&(NAME'="TYPE")
 .S NAME=U_NAME_U
 .I "^DFN^PAT^SSN^"[NAME D PAT Q
 .I NAME="FIELDS" D FIELDS Q
 .I NAME="STATUS" D STATUS Q
 .I "^START^END^"[NAME D DATE Q
 .I NAME="TYPE" D TYPE Q
 .I NAME="CLINIC" D CLINIC Q
 .I NAME="STOP" D STOP Q
 .I NAME="DIV" D DIV Q
 .I NAME="NOKILL" S NOKILL=(VAL>0)
 .Q:'Z301
 .I NAME="MAX" S:VAL MAX=VAL\1 Q
 .I NAME="SORT" D SORT
 .Q
 ;  now do qa on data passed
 D QA1 ; validate start/end dates
 D:Z301 QA2
 Q RET
 ;
ERR(X) ;
 ;;Patient lookup value is null
 ;;Only one patient lookup value is allowed
 ;;Invalid field ids received
 ;;Field ids are required
 ;;Invalid appt status code received
 ;;Invalid patient type flag received
 ;;Patient type flag not supported for this call
 ;;One or more clinic iens or names were invalid
 ;;One or more stop codes were invalid
 ;;One or more medical center divisions were invalid
 ;;This call requires field IDs for data to return
 ;;To return canceled appts you must pass in at least one patient
 ;;The Max parameter can be only used with a single patient and/or single clinic
 ;;Received an END date but no START date
 ;;Received a START date but no END date
 ;;Starting date is later than the ending date
 ;;Sort criteria must be a whole number from 1-13
 S:RET=1 RET="-1^"
 S:+X=X X=$P($T(ERR+X),";",3) S RET=RET_X_"; "
 Q
 ;
CLINIC ;  setup up clinic array
 N J,X,Y,Z,ERR S ERR=0
 F J=1:1:$L(VAL,";") S X=$P(VAL,";",J) D:X'=""  Q:ERR
 .S Y=0 I +X=X,$D(^SC(X,0)) S Y=X_U_$P(^(0),U)
 .I Y=0 S Z=$O(^SC("B",X,0)) S:Z>0 Y=Z_U_X
 .I Y>0 S DSICL(+Y)=$P(Y,U,2)
 .E  D ERR(8) S ERR=1 K DSICL
 .Q
 Q
 ;       
DATE ;  check start/end dates
 N %DT,X,Y S %DT="",X=VAL D ^%DT S:Y>0 @$P(NAME,U,2)=Y
 Q
 ;
DIV ;  check for divisions
 N J,X,Y,Z,DIERR,DSIER,DSIX
 F J=1:1:$L(VAL,";") S X=$P(VAL,";",J) D:X'=""
 .I NAME="DFN" S X="`"_X
 .K DIERR,DSIER S Y=$$FIND1^DIC(40.8,,"AMOQ",X,"B^C",,"DSIER")
 .I '$D(DIERR) S:Y>0 DSIDIV(Y)="" Q
 .D ERR(10) K DSIDIV
 .Q
 Q
 ;
FIELDS ;  process field IDs
 N J,X,Y,Z,ARR,ERR,MAX
 S MAX=11*Z301+13,ERR=0
 I Z301,VAL="" D ERR(4) Q
 I 'Z301,VAL="" S FLDS="" Q
 F J=1:1:$L(VAL,";") S X=$P(VAL,";",J) D  Q:ERR
 .I X?1.2N,X>0,X<MAX S ARR(X)=""
 .E  S ERR=1
 .Q
 Q:ERR  S Y="" F J=0:0 S J=$O(ARR(J)) Q:'J  S Y=Y_";"_J
 S FLDS=$E(Y,2,999)
 Q
 ;
PAT ;  process patient lookup variables
 N J,Z,DSIP,ERR,FLG
 S FLG=NAME="SSN",ERR=0
 I 'Z301,VAL="" D ERR(1) Q
 I 'Z301,VAL[";" D ERR(2) Q
 I Z301,VAL="" Q
 F J=1:1:$L(VAL,";") S Z=$P(VAL,";",J) D:Z'=""  Q:ERR
 .N J,VAL S DSIP=$$GET^DSICDPT1(Z,FLG)
 .I +DSIP'>0 D ERR($P(DSIP,U,2)) S ERR=1 K DSIDFN Q
 .;  when phase II of sched replace implemented
 .;S X=$$ICN^DSICDPT3(+DSIP)
 .;I +X=-1 D ERR($P(DSIP,U,2_" - "_$P(X,U,2)) S ERR=1 K DSIDFN Q
 .S DSIDFN(+Z)=$P(Z,U,2,3)
 .Q
 Q
 ;
QA1 ;  validate start/end
 I '$G(START),'$G(END) Q
 I '$G(START) D ERR(14) Q
 I '$G(END) D ERR(15) Q
 I START>END D ERR(16)
 Q
 ;
QA2 ;  validate relationships for patch 316
 I $G(FLDS)="" D ERR(11)
 I $G(STATUS)[";C",'$O(DSIDFN(0)) D ERR(12)
 Q:'$G(MAX)  S (X,Y)=0
 F I=0:0 S I=$O(DSIDFN(I)) Q:'I  S X=X+1
 F I=0:0 S I=$O(DSICL(I)) Q:'I  S Y=Y+1
 I X>1!(Y>1) D ERR(13)
 Q
 ;
SORT ;  validate sort
 I VAL,VAL<0!(VAL>13)!(VAL\1'=VAL) D ERR(17) Q
 S SORT=VAL
 Q
 ;
STATUS ;  process appt status flags
 N J,X,Y,Z,ARR,ERR
 S ERR=0
 F J=1:1:$L(VAL,";") S X=$P(VAL,";",J) D:X'=""  Q:ERR
 .I 'Z301 S:"^R^N^C^NT^"'[(U_X_U) ERR=1 S:'ERR ARR(X)="" Q
 .S:"^R^I^NS^NSR^CP^CPR^CC^CCR^NT^"[(U_X_U) ERR=1 S:'ERR ARR(X)=""
 .Q
 I ERR D ERR(5) Q
 S (X,Y)="" F  S X=$O(ARR(X)) Q:X=""  S Y=Y_";"_X
 S STATUS=$E(Y,2,999)
 Q
 ;
STOP ;  check for valid stop codes
 N J,X,Y,Z,ERR
 S ERR=0
 F J=1:1:$L(VAL,";") S X=$P(VAL,";",J) D:X'=""  Q:ERR
 .S Y=$O(^DIC(40.7,"C",X,0)) I Y>0 S DSISTOP(X)=Y Q
 .I $D(^DIC(40.7,X,0)) S Y=$P(^(0),U,2) I Y'="" S DSISTOP(Y)=X Q
 .S ERR=1 D ERR(9) K DSISTOP
 .Q
 Q
 ;
TYPE ;
 I Z301 D ERR(7) Q
 I VAL="" S TYPE="" Q
 I VAL="I"!(VAL="O") S TYPE=VAL Q
 I VAL="IO"!(VAL="OI")!(VAL="O;I")!(VAL="I;O") S TYPE="" Q
 D ERR(6)
 Q
 ;
UP(Z) S:Z?.E1L.E Z=$$UP^XLFSTR(Z) Q Z
 ;
 ;list of local variable names to be NEW'd in ^DSICSDA
VAR ;;DSICL,DSIDFN,DSIDIV,DSISTOP,END,FLDS,MAX,NOKILL,SORT,START,STATUS,TYPE
 ;
 ;Notes: patient lookup values can be multiple separated by ';' if
 ;         calling the 301 APIs only
 ;INPUT(x) = p1^p2  where x is any subscript and
 ;P1 of input    P2 of input (value)
 ;-----------    ---------------------------------------------------
 ;DFN            pointer to the patient file
 ;PAT            name of patient or any text lookup value as long as
 ;                 the value uniquely resolves to a single patient
 ;SSN            9 digit SSN
 ;CLINIC         string of hospital locations separated by ';'
 ;                 hopsital locations can be either iens or names
 ;DIV            string of medical center divisions separated by ';'
 ;                 mcd(s) can be iens to file 40.8, or mcd name, or
 ;                 mcd facility number
 ;END            ending date - any format that ^%DT accepts
 ;FLDS           a string of numbers separated by ';'
 ;MAX            number indicating maximum nuber of entries to return
 ;                 if max>0 then return first N appts
 ;                 if max<0 then return last N appts
 ;NOKILL         if NOKILL>0 then do not Kill the return array upon
 ;                 entry into the RPC.  Default is 0 which means KILL
 ;                 the return array upon entry.
 ;SORT           for Z301 - number from 1-13 for sort by criteria
 ;               default value = 3
 ;                 1 := patient name, appt date earliest to latest
 ;                 2 := patient name, appt date latest to earliest
 ;                 3 := patient name, clinic name, appt
 ;                 4 := patient name, clinic ien, appt
 ;                 5 := patient dfn, appt date early to late
 ;                 6 := patient dfn, appt date late to early
 ;                 7 := patient dfn, clinic name, appt
 ;                 8 := patient dfn, clinic ien, appt
 ;                 9 := clinic name, appt
 ;                10 := clinic name, patient name, appt
 ;                11 := clinic name, patient dfn, appt
 ;                12 := clinic ien, patient name, appt
 ;                13 := clinic ien, patient dfn, appt
 ;START          starting date - any format that ^%DT accepts
 ;STATUS         string of characters separated by ';'
 ;STOP           string of stop codes separated by ';'
 ;                 stop code can be the 3-digit stop code or
 ;                 the ien to file 40.7
 ;TYPE           single character indicating in/out patient
