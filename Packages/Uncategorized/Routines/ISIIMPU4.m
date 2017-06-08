ISIIMPU4 ;ISI GROUP/MLS -- PROBLEM IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 30
 Q
 ;
 ; Column definitions for MISCDEF table (below):
 ; NAME=        name of parameter
 ; TYPE =       categories of values provided
 ;                      'PARAM' is internal used value 
 ;                      'FIELD' is a literal import value
 ;                      'MASK' is dynamic value w/ * wildcard
 ; DESC  =      description of value
 ;
 ; Array example: 
 ;      MISC(1)="PROBLEM|DIABETES"
 ;      MISC(2)="PROVIDER|ONE,DOCTOR"
 ;      MISC(4)="PAT_SSN|555005555"
 ;
MISCDEF ;;+++++ DEFINITIONS OF PROBLEM MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD    |DESC
 ;;-----------------------------------------------------------------------
 ;;PROBLEM          |FIELD      |#757.01,.01   |PROBLEM Description
 ;;PROVIDER         |FIELD      |#9000011,1.04 |PROVIDER NAME
 ;;PAT_SSN          |FIELD      |#2,.09        |PATIENT SSN
 ;;STATUS           |FIELD      |#9000011,.12  |'A'ctive or 'I'active 
 ;;ONSET            |FIELD      |#9000011,.13  |Onset DATE
 ;;TYPE             |FIELD      |#9000011,1.14 |PRIORITY ('A'ccute or 'C'hronic)
 Q
 ;
PROBMISC(MISC,ISIMISC) 
 ;
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$PROBMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
PROBMISC1(DSTNODE) 
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="ONSET" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid ONSET date." Q
 . . S VALUE=RESULT
 . I EXIT Q
 . S @DSTNODE@(PARAM)=VALUE
 . Q
 Q ISIRC ;return code
 ;
LOADMISC(MISCDEF) ;
 N BUF,FIELD,I,NAME,TYPE
 K MISCDEF
 F I=3:1  S BUF=$P($T(MISCDEF+I),";;",2)  Q:BUF=""  D
 . S NAME=$$TRIM^XLFSTR($P(BUF,"|"))  Q:NAME=""
 . S TYPE=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S FIELD=$$TRIM^XLFSTR($P(BUF,"|",3))
 . S MISCDEF(NAME)=TYPE_"|"_FIELD
 Q
 ;
VALPROB(ISIMISC)
 ; Entry point to validate content of PROBLEM create/array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("PROBLEM")="DIABETES" 
 ;
 ; Output - ISIRC [return code]
 ; 
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,MISCDEF,EXIT,OUT,Y
 N MAJCON,CODE,ICD,ICDIEN,EXPIEN,DFN,EXPNM
 S EXIT=0,(MAJCON,CODE,ICD,ICDIEN,EXPIEN,DFN,EXPNM)=""
 ;
 ;-- PROBLEM (required) --
 I '$D(ISIMISC("PROBLEM")) Q "-1^Missing PROBLEM param."
 I $G(ISIMISC("PROBLEM"))="" Q "-1^Missing value for PROBLEM."
 S VALUE=ISIMISC("PROBLEM") 
 S (OUT,EXPIEN)="" F  S EXPIEN=$O(^LEX(757.01,"B",VALUE,EXPIEN)) Q:'EXPIEN  D  Q:OUT=1
 . S EXPNM=$G(^LEX(757.01,EXPIEN,0)) Q:EXPNM=""
 . S MAJCON=$P($G(^LEX(757.01,EXPIEN,1)),"^") Q:MAJCON=""
 . S CODE="" F  S CODE=$O(^LEX(757.02,"AMC",MAJCON,CODE)) Q:'CODE  D  Q:OUT=1
 . . S ICD=$P($G(^LEX(757.02,CODE,0)),"^",2) Q:ICD=""
 . . S Y=$P($G(^LEX(757.03,$P($G(^LEX(757.02,CODE,0)),"^",3),0)),"^")
 . . I Y="ICD9" S OUT=1 Q
 . . Q
 I EXPNM="" S EXIT=1
 I EXPIEN="" S EXIT=1
 I MAJCON="" S EXIT=1
 I ICD="" S EXIT=1
 S ICDIEN=$O(^ICD9("AB",ICD_" ","")) I ICDIEN="" S EXIT=1
 I EXIT Q "-1^Invalid data for PROBLEM."
 S ISIMISC("EXPIEN")=EXPIEN,ISIMISC("MAJCON")=MAJCON,ISIMISC("ICD")=ICD
 S ISIMISC("ICDIEN")=ICDIEN,ISIMISC("EXPNM")=EXPNM
 ;
 ;-- PROVIDER (required)-- 
 I $D(ISIMISC("PROVIDER")) D  
 . S VALUE=$G(ISIMISC("PROVIDER")) I VALUE="" S EXIT=1 Q
 . I '$D(^VA(200,"AK.PROVIDER",VALUE)) S EXIT=1 Q
 . S ISIMISC("PROVIDER")=$O(^VA(200,"AK.PROVIDER",VALUE,""))
 . Q
 I EXIT Q "-1^Invalid data for PROVIDER."
 ;
 I '$D(ISIMISC("PROVIDER")) Q "-1^Missing PROVIDER (#2,.01)"  
 ;
 ;-- PAT_SSN (required) --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN (#2,.09)."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=ISIMISC("PAT_SSN") I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 I EXIT=1 Q "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ;-- STATUS (not required, if none, use 'A'ctive)--
 I $G(ISIMISC("STATUS"))="" S ISIMISC("STATUS")="A"
 S ISIMISC("STATUS")=$TR(ISIMISC("STATUS"),"ai","AI")
 I "AI"'[ISIMISC("STATUS") S ISIMISC("STATUS")="A"
 ;
 ;-- ONSET (not required, if none use today) --
 I $G(ISIMISC("ONSET"))="" S ISIMISC("ONSET")=DT
 I $G(ISIMISC("ONSET"))'="" D  
 . S FILE=2,FIELD=.03,FLAG="",VALUE=ISIMISC("ONSET")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 I EXIT=1 Q "-1^Invalid ONSET date."
 ;
 ;-- TYPE (not required, if none use 'A'ccute) --
 I $G(ISIMISC("TYPE"))="" S ISIMISC("TYPE")="A"
 S ISIMISC("TYPE")=$TR(ISIMISC("TYPE"),"ac","AC")
 I "AC"'[ISIMISC("TYPE") S ISIMISC("TYPE")="A" ;default
 ;
 Q 1
 ;
