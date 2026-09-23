GMVPAR ; HOIFO/DP - XPARameter RPC ; Mar 22, 2023@08:09:59
 ;;5.0;GEN. MED. REC. - VITALS;**3,40**;Oct 31, 2002;Build 51
 ; Reference to ^XPAR in ICR #2263
 ; Reference to ^XUPARAM in ICR #2541
 ; Reference to ^VA(200 in ICR #10060
 ; Reference to ^DIC(4 in ICR #10090
 ; Reference to CLEAN^DILF in ICR #2054
 ; Reference to GET^DIQ in ICR #2056
 ;
 ; This routine supports/provides the following ICR:
 ; #4367 - GMV PARAMETER RPC is called at RPC (private)
 ;
DELPAR ; [Procedure] Delete single parameter value
 D DEL^XPAR(ENT,PAR,INST,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Instance deleted"
 Q
 ;
ENTVAL ; [Procedure] Return value of the entity
 I ENT="SYS" S ENT=$$KSP^XUPARAM("WHERE")
 E  I ENT="DIV" S ENT=$$GET1^DIQ(4,DUZ(2)_",",.01)
 E  I ENT="USR" S ENT=$$GET1^DIQ(200,DUZ_",",.01)
 E  S ENT=$$GET1^DIQ(+$P(ENT,"(",2),+ENT_",",.01)
 S @RESULTS@(0)=ENT
 Q
GETLST ; [Procedure] Return all instances of a parameter
 D GETLST^XPAR(.RET,ENT,PAR,"E",.ERR)
 Q:$G(ERR,0)
 S TMP="RET"
 F  S TMP=$Q(@TMP) Q:TMP=""  D
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=@TMP
 S @RESULTS@(0)=$O(@RESULTS@(""),-1)
 Q
 ;
GETPAR ; [Procedure] Returns external value of a parameter
 S @RESULTS@(0)=$$GET^XPAR(ENT,PAR,INST,"E")
 Q
 ;
RPC(RESULTS,OPTION,ENT,PAR,INST,VAL) ; [Procedure] Main RPC Hit Point
 ; RPC: [GMV PARAMETER]
 ;
 ; Requires that the parameter name in PAR
 ; be in the GMV namespace.
 ;
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;  3. ENT [Literal/Required] No description
 ;  4. PAR [Literal/Required] No description
 ;  5. INST [Literal/Required] No description
 ;  6. VAL [Literal/Required] No description
 ;
 N ERR,TMP,RET,TXT,IEN,IENS,ROOT
 S INST=$G(INST,1)
 S PAR=$G(PAR,"GMV")
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 I PAR'?1"GMV".E S ^TMP($J,0)="-1^Non Vitals Measurements Parameter" Q
 D:$T(@OPTION)]"" @OPTION
 I +$G(ERR) K @RESULTS S @RESULTS@(0)="-1^Error: "_(+ERR)_" "_$P(ERR,U,2)
 I '$D(^TMP($J)) S @RESULTS@(0)="-1^No date returned"
 D CLEAN^DILF
 Q
SETPAR ; [Procedure] Set single value into a parameter
 I PAR="GMV WEBLINK",VAL="" D  Q
 . D DEL^XPAR(ENT,PAR,INST,.ERR)
 . I '$G(ERR) S @RESULTS@(0)="1^Instance deleted"
 D EN^XPAR(ENT,PAR,INST,VAL,.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^Parameter updated"
 Q
SETLST ; [Procedure] Set parameter from list
 N GMVINS ; Instance Counter
 S GMVINS=""
 F  S GMVINS=$O(VAL(GMVINS)) Q:GMVINS=""  D
 .D EN^XPAR(ENT,PAR,$P(VAL(GMVINS),U,1),$P(VAL(GMVINS),U,2),.ERR)
 S:'$G(ERR) @RESULTS@(0)="1^List "_PAR_" updated"
 Q
