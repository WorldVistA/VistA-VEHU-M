VEJDICR ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 2056   GETS^DIQ, $$GET1^DIQ
 ; 
 Q
 ;
 ; The following code is cloned from ^IBCN* routines, bypassing I/O
 ; 
REJECT(RESULT,IBBUFDA) ;;
 ; Implements VEJDIC REJECT BUFFER ENTRY remote procedure
 ; Cloned from REJECT^IBCNBAR bypassing I/O
 ; 
 ; IBBUFDA=INSURANCE BUFFER file internal entry number (required)
 S RESULT="-1^INSURANCE BUFFER IEN required" Q:'$G(IBBUFDA)
 S RESULT="-1^INSURANCE BUFFER ENTRY PREVIOUSLY PROCESSED"
 Q:"~A~R~"[("~"_$$GET1^DIQ(355.33,IBBUFDA,.04,"I")_"~")
 N DFN S DFN=+$$GET1^DIQ(355.33,+IBBUFDA,60.01,"I")
 S RESULT="-1^PATIENT IEN MISSING FROM BUFFER ENTRY" Q:'DFN
 I $$GET1^DIQ(355.33,+IBBUFDA,.03,"I")=3 D IVM^VEJDICA(0,IBBUFDA)
 ;
 S RESULT=0
 D STATUS^VEJDICB3(+IBBUFDA,"R",0,0,0),DELDATA^VEJDICB3(+IBBUFDA)
 ;
 I +DFN,'$$INSURED(DFN),'$$BUFFER(DFN) D
 . I +$$PTHLD^VEJDICB3(DFN,2,1) ;W !!,"Patient has no other active Insurance.",!,"All patient bills On Hold waiting for Insurance have been released."
 . I  S RESULT=RESULT_"^Patient has no other active Insurance.  All patient bills On Hold waiting for Insurance have been released."
 . Q
 ;
 Q
INSURED(DFN,IBINDT) ; -- Is patient insured
 ; From routine ^IBCNS1
 ; --Input  DFN     = patient
 ;          IBINDT  = (optional) date insured (default = today)
 ; -- Output        = 0 - not insured
 ;                  = 1 - insured
 ;
 N J,X,IBINS S IBINS=0,J=0
 I '$G(DFN) Q IBINS
 I '$G(IBINDT) S IBINDT=DT
 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  S X=$G(^(J,0)) S IBINS=$$CHK^VEJDICB1(X,IBINDT) Q:IBINS
 Q IBINS
 ;
BUFFER(DFN) ; returns IFN of first buffer entry found for the patient, 0 otherwise
 ; From routine ^IBCNBU1
 Q +$O(^IBA(355.33,"C",+$G(DFN),0))
 ;
RPT(RET,DATA) ;RPC : VEJDIC REPORT DATA
 ; gets data from 19625 for reporting
 ; input is array
 ; DATA("START")=fileman start dt                DATA("END")=fileman end dt
 ; DATA("INDEX")=index to use                    DATA("FIELDS")=fields to return
 ; FIELDS is DD field#s separated by semi-colons only (no colon "ranged" fields)
 ; FIELDS may be suffixed with "I" for internal data vs default of external data format
 ; return is array
 ; RET(1) = -1^error message or
 ; RET(n) = p1^p2^p3^p4 where p1 = ien of record and p2-pn = fields requested
 ; If the fields to return are > 255 in length, then the data is split
 ; and the second half will be in RET(n) = $$APPEND$$overflow data
 N SDT,EDT,IEN,CNT,VEJDIX,VEJDFL
 S RET=$NA(^TMP("VEJDIC",$J)) K @RET
 S SDT=$G(DATA("SDT")) I 'SDT S @RET@(1)="-1^Missing START date" Q
 S EDT=$G(DATA("EDT")) I 'EDT S @RET@(1)="-1^Missing END date" Q
 S VEJDIX=$G(DATA("INDEX"))
 I VEJDIX="" S @RET@(1)="-1^Missing INDEX" Q
 I "CDEFH"'[VEJDIX S @RET@(1)="-1^Invalid INDEX" Q
 S VEJDFL=$G(DATA("FIELDS")) I VEJDFL="" S @RET@(1)="-1^Missing FIELDS to retrieve" Q
 S SDT=SDT-.01,EDT=EDT+.9,CNT=0
 F  S SDT=$O(^DSI(19625,VEJDIX,SDT)) Q:'SDT!(SDT>EDT)  S IEN=0 D
 .F  S IEN=$O(^DSI(19625,VEJDIX,SDT,IEN)) Q:'IEN  D DATA
 .Q
 I '$D(@RET) S @RET@(1)="-1^No records found"
 Q
DATA ;look up data, put into RET nodes
 N VEJDD,ND,I,X,NODE,IE D GETS^DIQ(19625,+IEN,"*","EI","VEJDD")
 S ND="VEJDD(19625,"""_+IEN_","")" I $D(@ND)'=10 Q  ;nothing for that ien
 S NODE=IEN_U,I=1
 F  S X=$P(VEJDFL,";",I) Q:X=""  D  S I=I+1
 .I $G(@ND@(+X,"I"))="" S NODE=NODE_U Q
 .I +X=X S NODE=NODE_$G(@ND@(X,"E"))_U Q
 .S IE=$E(X,$L(X)) I "IE"'[IE S NODE=NODE_U Q
 .S NODE=NODE_$G(@ND@(+X,IE))_U
 .Q
 I $L(NODE)<256 S CNT=CNT+1,@RET@(CNT)=NODE Q  ;data fits on return node
 N LEN,STRT,PART S LEN=254,STRT=1 ;need to parse into 255 chunk lengths
 F  S PART=$E(NODE,STRT,STRT+LEN)  Q:PART=""  D
 .S CNT=CNT+1,@RET@(CNT)=$S(STRT=1:PART,1:"$$APPEND$$"_PART)
 .S STRT=STRT+LEN+1
 .Q
 Q
