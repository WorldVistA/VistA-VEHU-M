DSIVICR ;DSS/LM - Insurance card RPC's ;07/16/2012 11:24
 ;;2.2;INSURANCE CAPTURE BUFFER;**7**;May 19, 2009;Build 1
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 2056   GETS^DIQ
 ; 10063  %ZTLOAD,$$TM^%ZTLOAD
 ; 10103  $$NOW^XLFDT
 ; 5353  REJECAPI^IBCNICB
 Q
 ;
REJECT(RESULT,IBBUFDA,IVMREPTR) ;RPC: DSIV REJECT BUFFER ENTRY
 S IVMREPTR=$G(IVMREPTR) ;2.2T10 variable misspelled
 ;Call IB API to reject buffer entry
 D REJECAPI^IBCNICB(.RESULT,IBBUFDA,IVMREPTR)
 Q
PRPT(DSIVRET,DSIVHNDL,DSIVRPT,DATA) ; RPC: DSIV REPORT QUEUE
 ; DSIVHNDL can be used to check if a report has been queued, or can be blank
 ; DSIVRPT is the report# the user selected to run
 ; DATA("SDT")=fileman start dt                  DATA("EDT")=fileman end dt
 ; DATA("INDEX")=index to use                    DATA("FIELDS")=fields to return
 ; note: NUMS and MORE are not needed for this call.  Use NUMS in the POLL call
 N DSIVSDT,DSIVEDT,DSIVIX,DSIVFL,RET         ;added DSIV*2.2*7 T1 NCR 07/16/2012
 S DSIVSDT=$G(DATA("SDT")) I 'DSIVSDT S DSIVRET="-1^Missing START date" Q
 S DSIVEDT=$G(DATA("EDT")) I 'DSIVEDT S DSIVRET="-1^Missing END date" Q
 S DSIVIX=$G(DATA("INDEX")) I DSIVIX="" S DSIVRET="-1^Missing INDEX" Q
 I "CDEFH"'[DSIVIX S DSIVRET="-1^Invalid INDEX" Q
 S DSIVFL=$G(DATA("FIELDS")) I DSIVFL="" S DSIVRET="-1^Missing FIELDS to retrieve" Q
 S DSIVRPT=$G(DSIVRPT) I DSIVRPT="" S DSIVRET="-1^Missing REPORT field" Q
 I '$G(DSIVHNDL) D
 .S DSIVHNDL=DUZ_"~"_$J_"~"_$TR($J($R(10000),4)," ",0) ; Create handle
 .Q
 I $D(^XTMP("DSIVICR",DSIVHNDL)) D  Q
 .S DSIVRET="-1^Duplicate request^"_DSIVHNDL_U_$G(^XTMP("DSIVICR",DSIVHNDL,"RPTINFO"))
 .Q
 S RET=$NA(^XTMP("DSIVICR",DSIVHNDL))
 I '$D(@RET@(0)) S @RET@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;;SACC required node
 S @RET@(1)=DT ;keep track of report progress
 ;
 I '$$TM^%ZTLOAD S DSIVRET="-1^TaskMan not running^"_DSIVHNDL Q
 S ^XTMP("DSIVICR",DSIVHNDL,0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;;SACC required node
 S ^XTMP("DSIVICR",DSIVHNDL,"RPTINFO")=DSIVRPT_"~"_DSIVSDT_"~"_DSIVEDT
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="DSIV Report Data "_DSIVHNDL
 S ZTDTH=$H,ZTIO="",ZTRTN="DQ^DSIVICR"
 S ZTSAVE("DSIV*")="" F X="CNT","NUMS","MORE" S ZTSAVE(X)=""
 D ^%ZTLOAD I $G(ZTSK)>0 S DSIVRET=ZTSK_U_DSIVHNDL Q
 S DSIVRET="-1^Attempt to schedule task failed^"_DSIVHNDL
 Q
DQ ;come in from new tasked call
 N ZZ
 S RET=$NA(^XTMP("DSIVICR",DSIVHNDL))
 I '$D(@RET@(0)) S @RET@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1 ;;SACC required node
 S @RET@(1)=DT_"^^"_$$NOW^XLFDT ;keep track of report progress
 S CNT=1,NUMS=9999999,DSIVFLDS=$TR($G(DSIVFL,".01"),"IE"),EDT=DSIVEDT
 D LOOP(DSIVSDT,0)
 I +$G(@RET@(1))=-1 S @RET@(1)=DT_"^1^^"_@RET@(1) Q
 S ZZ=$G(@RET@(1)) S $P(ZZ,U,2)=1,$P(ZZ,U,5)=$$NOW^XLFDT                               ;2.2*7S7T1 NCR added $G() to prevent undefined condition
 I '$G(@RET@(1)) S @RET@(1)=DT_"^1^^Report complete, but missing progress node^"_ZZ Q  ;2.2*7S7T1 NCR added message if progress node is missing
 S @RET@(1)=ZZ
 Q
POLL(RESULT,DSIVHNDL,NUMS,MORE) ;RPC: DSIV POLLED DATA
 ; DSIVHNDL =Handle (required) NUMS=# of records to return per call
 ;           MORE=0 (first call), =1 (subseq calls), =9 (delete ^XTMP)
 ; RESULT   = formatted report data or RESULT(1)=0^Results not ready 
 ;     or -1^Error message
 ;
 N CNT,I,R,X,DSIVICN,DSIVICEN,QUIT,STDT,ETDT
 S CNT=0,NUMS=$G(NUMS,999),MORE=+$G(MORE),QUIT=0
 S RESULT=$NA(^TMP("DSIVIC",$J)) K @RESULT
 I '$L($G(DSIVHNDL)) S @RESULT@(1)="-1^Invalid Handle" Q
 S R=$NA(^XTMP("DSIVICR",DSIVHNDL)) ;Data
 S X=$G(@R@(1)) I X="" S @RESULT@(1)="-1^List not found" Q
 I $P(X,U,4) S @RESULT@(1)="-1^Error in background^"_$P(@R,U,4,5) Q
 I '$P(X,U,2) S @RESULT@(1)="0^Results not ready" Q
 I MORE=9 K @R S @RESULT@(1)="0^Remaining report data removed from saved area" Q
 N DSIVICN,DSIVICEN,I,X S DSIVICN=R,DSIVICEN=$E(DSIVICN,1,$L(DSIVICN)-1)
 F I=1:1 S DSIVICN=$Q(@DSIVICN) Q:'(DSIVICN[DSIVICEN)!QUIT  D
 .I +$QS(DSIVICN,3)<2 D  Q  ;the housekeeping nodes shouldn't print
 ..S X=@DSIVICN I $QS(DSIVICN,3)=0 S STDT=$P(X,U,2) Q
 ..I $QS(DSIVICN,3)=1 S ETDT=$P(X,U,3)_U_$P(X,U,5)
 ..Q
 .S CNT=CNT+1,@RESULT@(CNT)=@DSIVICN K @DSIVICN
 .I CNT=NUMS S QUIT=1
 .Q
 I '$O(@R@(1)) S @RESULT@("~")="$END$"_$G(STDT)_U_$G(ETDT) K @R
 Q
 ;
RPT(RET,DATA) ;RPC: DSIV REPORT DATA
 ; gets data from 19625 for reporting
 ; input is array
 ; DATA("SDT")=fileman start dt                  DATA("EDT")=fileman end dt
 ; DATA("INDEX")=index to use                    DATA("FIELDS")=fields to return
 ; DATA("NUMS")=number of recs to return         DATA("MORE")=1 for addtl records
 ; FIELDS is DD field#s separated by semi-colons only (no colon "ranged" fields)
 ; FIELDS may be suffixed with "I" for internal data vs default of external data format
 ; return is array
 ; RET(1) = -1^error message or
 ; RET(n) = p1^p2^p3^p4 where p1 = ien of record and p2-pn = fields requested
 ; If the fields to return are > 255 in length, then the data is split
 ; and the second half will be in RET(n) = $$APPEND$$overflow data
 N SDT,EDT,IEN,CNT,DSIVIX,DSIVFL,NUMS,MORE,I,QUIT,DSIVFLDS,RESTMP  ;New'd DSIVFLDS,RESTMP DSIV*2.2*7 T1 NCR 07/16/2012
 S RET=$NA(^TMP("DSIVIC",$J)) K ^TMP("DSIVIC",$J)
 S RESTMP=$NA(^XTMP("DSIVICRR"_$J)) ;3.20.06 KC get batches of data
 S SDT=$G(DATA("SDT")) I 'SDT S ^TMP("DSIVIC",$J,1)="-1^Missing START date" Q
 S EDT=$G(DATA("EDT")) I 'EDT S ^TMP("DSIVIC",$J,1)="-1^Missing END date" Q
 S DSIVIX=$G(DATA("INDEX"))
 I DSIVIX="" S ^TMP("DSIVIC",$J,1)="-1^Missing INDEX" Q
 I "CDEFH"'[DSIVIX S ^TMP("DSIVIC",$J,1)="-1^Invalid INDEX" Q
 S DSIVFL=$G(DATA("FIELDS")) I DSIVFL="" S ^TMP("DSIVIC",$J,1)="-1^Missing FIELDS to retrieve" Q
 S DSIVFLDS=$TR(DSIVFL,"IE")
 S CNT=0,NUMS=$G(DATA("NUMS"),99999),MORE=+$G(DATA("MORE")) ;3.20.06 KC
 I MORE,$D(@RESTMP) D  S:'$O(@RESTMP@(0)) ^TMP("DSIVIC",$J,"~")="$END$" Q
 .S X=$G(@RESTMP@(1)) Q:'X  S SDT=+X,IEN=$P(X,U,2)
 .K @RESTMP I $G(SDT),$G(IEN) D LOOP(SDT,IEN)
 .Q
 D LOOP(SDT,0)
 I '$D(@RET) S ^TMP("DSIVIC",$J,1)="-1^No records found" Q
 I $D(@RESTMP) S @RESTMP@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1
 I CNT<NUMS S ^TMP("DSIVIC",$J,"~")="$END$"
 I CNT=NUMS,'$D(@RESTMP) S ^TMP("DSIVIC",$J,"~")="$END$"
 Q
DATA ;look up data, put into RET nodes
 N DSIV,I,X,NODE,IE K DSIVD
 I '$P($G(^DSI(19625,+IEN,0)),U,2) Q  ;buffer ien=0, don't send this one!
 D GETS^DIQ(19625,+IEN,DSIVFLDS,"EI","DSIVD")
 M DSIV=DSIVD(19625,IEN_",") K DSIVD I $D(DSIV)'=10 Q  ;nothing for that ien
 S NODE=IEN_U,I=1
 F  S X=$P(DSIVFL,";",I) Q:X=""  D  S I=I+1
 .I $G(DSIV(+X,"I"))="" S NODE=NODE_U Q
 .I +X=X S NODE=NODE_$G(DSIV(X,"E"))_U Q
 .S IE=$E(X,$L(X)) I "IE"'[IE S NODE=NODE_U Q
 .S NODE=NODE_$G(DSIV(+X,IE))_U
 .Q
 I CNT=NUMS D OVFL Q
 I $L(NODE)<256 S CNT=CNT+1,@RET@(CNT)=NODE Q  ;data fits on return node
 N LEN,STRT,PART S LEN=254,STRT=1 ;need to parse into 255 chunk lengths
 F  S PART=$E(NODE,STRT,STRT+LEN)  Q:PART=""  D
 .S CNT=CNT+1,@RET@(CNT)=$S(STRT=1:PART,1:"$$APPEND$$"_PART)
 .S STRT=STRT+LEN+1
 .Q
 Q
OVFL S @RESTMP@(1)=SDT_U_IEN,QUIT=1 Q  ;overflow the NUMS param
 ;
LOOP(SDT,IENST) ;loop to get data
 S EDT=EDT+.9,QUIT=0
 I IENST,$D(^DSI(19625,DSIVIX,SDT,IENST)) S IEN=IENST D DATA
 I IENST,IEN F  S IEN=$O(^DSI(19625,DSIVIX,SDT,IEN)) Q:'IEN!QUIT  D DATA
 S IENST=0
 F  S SDT=$O(^DSI(19625,DSIVIX,SDT)) Q:'SDT!(SDT>EDT)!QUIT  D
 .S IEN=0 F  S IEN=$O(^DSI(19625,DSIVIX,SDT,IEN)) Q:'IEN!QUIT  D DATA
 .Q
 Q
