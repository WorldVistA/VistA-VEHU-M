DENTVICD ;DSS/AJ - Dental ICD Utilities;10/1/2013 9:12
 ;;1.2;DENTAL;**66**;Aug 10, 2001;Build 36
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this contains RPC calls for retrieving ICD information
 ;  It is code set versioning compliant in that it looks for
 ;  the ICDCODE routine.
 ;
 ;   ICR#  SUPPORTED
 ;  -----  ---------  --------------------------------------------------
 ;   2056      x      GETS^DIQ
 ;   5679      x      $$IMPDATE^LEXU
 ;   5681      x      $$DIAGSRCH^LEX10CS
 ;   5747             ICDEX: $$ICDDX, $$CODEN, $$CODEC, $$STATCHK
 ;  10096      x      All nodes in ^%ZOSF are uesable
 ;  10103      x      $$FMTE^XLFDT
 ;  10104      x      ^XLFSTR: $$TRIM, $$UP
 ;
 ;  Common notation on input parameters
 ;   CDT - opt - default to DT
 ;         date used by ICD code to return date specific data
 ;   FUN - opt - I +$G(FUN) then extrinisc function call
 ;                    do not return data in local array
 ;  VICD - req - ien to file 80 or ICD-10 name
 ;   SRC - opt - Flag to indicate if Level III codes need to be screened
 ;               out. If SRC=0 or null, Level III codes not processed as
 ;               valid input; if SRC>0, Level III codes are accepted.
 ;   SYS - opt - default to ICD-10 Dx
 ;               This is the coding system in which you wish to search
 ;               30 = ICD-10 Diagnosic Codes
 ;               31 = ICD-10 Procedure Codes
 ;
ACTICD(DENTV,VICD,CDT,FUN,SYS) ; RPC: DENTV ICD ACTIVE
 ;  Return: 1 if active, 0^message if inactive
 ;    else return -1^error message
 N X S X=$$INIT I X<1 S DENTV=X G OUT
 I $G(SYS)="" S SYS=$S($$IMPDATE^LEXU(30)>CDT:1,1:30)
 S X=$$STATCHK^ICDEX($G(VICD),$G(CDT),$G(SYS,30))
 S DENTV=$S(X>0:1,'X:X,1:"-1^Code "_VICD_" not found")
OUT Q:$G(FUN) DENTV Q
 ;
ICD(DENTV,VICD,CDT,FUN) ; RPC: DENTV ICD GET DIAGNOSIS
 ; Return: on error, -1^error message
 ;         else return p1^p2^...^p18
 ;  p1 = ien
 ;  p2 = code number
 ;  p3 = IDENTIFIER (#2)
 ;  p4 = DIAGNOSIS (#3)
 ;  p5 = UNACCEPTABLE AS PRINCIPAL DX (#101) (1:yes)
 ;  p6 = MAJOR DIAGNOSTIC CATEGORY ien (#5)
 ;  p7 = MDC13 (#5.5)
 ;  p8 = COMPLICATION/COMORBIDITY (#70)
 ;  p9 = ICD EXPANDED (#8)
 ; p10 = STATUS where 0:inactive;1:active
 ; p11 = SEX (#9.5) [M/F]          p15 = AGE LOW (#14)
 ; p12 = INACTIVE DATE [int;ext]   p16 = AGE HIGH (#15)
 ; p13 = MDC24 (#5.7)              p17 = ACTIVATION DATE
 ; p14 = MDC25 (#5.9)              p18 = NOTICE OF TEXTUAL INACCURACY 
 ;
 N DENTERR,FLD,I,IEN,SYS,X,Y,Z S X=$$INIT I X<1 S DENTV=X G OUT
 I $G(CDT)="" D NOW^%DTC S CDT=$G(%)
 I $$IMPDATE^LEXU(30)>CDT S SYS=1
 S DENTV=$$ICDDX^ICDEX($G(VICD),$G(CDT),$G(SYS,30),,1) I +DENTV=-1 G OUT
 S X=$P(DENTV,U,12) I X S X=X_";"_$$FMTE^XLFDT(X),$P(DENTV,U,12)=X
 S X=$$INACT S:X'="" DENTV=X
 G:$G(SYS)=1 OUT
 S IEN=$P(DENTV,U)
 S $P(DENTV,U,4)=$$GET1^DIQ(80.068,"1,"_IEN_",",1,,,"DENTERR")
 S:$D(DENTERR) DENTV="-1^"_DENTERR("DIERR","1","TEXT",1)
 G OUT
 ;
LIST(DENTV,DENTVA) ;  RPC: DENTVICD LIST
 ;Integration Agreements: LOOK^LEXA 2950 supported, ICDONE^LEXU 1573 Private AICS
 ;DSS/CDP 07/03/2007 Start Mod - Replaced subroutine LIST with a new version using the Lexicon.
 ;This subroutine returns a list of ICD codes matching LOOKUP value (piece 2 of 0 node will
 ;tell how many matches there were, gui can tell user to do better input)
 ;
 ; New method for calling this subroutine:
 ;    An input array "DENTVA" will have to be set up in the format "Mnemonic^Input Value".  
 ;    The mnemonic is the tag that defines to the subroutine what input parameter is being 
 ;    passed, and the input value is the actual data, as follows:
 ;
 ;    DENTV - Return array for your ICD codes
 ;           If nothing found in Lexicon for code or error, return @DENTV@(1)=-1^error message
 ;           else return @DENTV@(#) = ien ^ icd code ^ short description
 ;    DENTVA(0) = "LOOKUP^Value"
 ;           user input lookup value
 ;    DENTVA(1) = "CHKSCR^Value"
 ;           If value set to "P", only valid ICD codes that are eligible to be principle 
 ;           diagnosis will be returned.
 ;    DENTVA(2) = "ACTDATE^Value" (ACTDATE is in Fileman format, NULL dates will be set to Today)
 ;           The eligibility date of the ICD code.
 ;    DENTVA(3) = "MAX^Value" (100 is the default)   
 ;            The maximum number of diagnosis you want returned.
 ;             
 ;             TOTALS = RR(0)= P1^P2 - Will only be returned for new call method
 ;                  P1 = # of codes returned
 ;                  P2 = total number of codes considered 
 ;                 Example:
 ;                        SS(0)="LOOKUP^137"
 ;                        SS(1)="CHKSCR^P"  
 ;                        SS(2)="ACTDATE^"  
 ;                        SS(3)="MAX^N"     
 ;                 D LIST^DENTVICD(.RR,.SS)  Return: RR ="^TMP("DENTV",5876)
 ; 
 N I,X,Y,Z,SCRN,TEMP,LEX,CNT,LOOKUP,CHKSCR,ACTDATE,TOTALS,PAR,VAL,MAX
 S TOTALS=0 I $D(DENTVA) D
 . S X="" F  S X=$O(DENTVA(X)) Q:X=""  D  S TOTALS=1
 .. S Z=DENTVA(X),PAR=$P(Z,U),VAL=$P(Z,U,2) I PAR?.E1L.E S PAR=$$UP^XLFSTR(PAR)
 .. S @PAR=$G(VAL)
 S:$G(MAX)="" MAX=100 S:($G(ACTDATE)=""!($G(ACTDATE)?1"T".E)) ACTDATE=$G(DT)
 I $$IMPDATE^LEXU(30)<ACTDATE D LIST10(.DENTV,$G(LOOKUP),$G(ACTDATE),$G(MAX),$G(CHSCR)) Q
 ;
LIST9 ; ICD-9 LIST
 S DENTV=$NA(^TMP("DENTV",$J)),TEMP=$NA(^TMP("DENTV",$J,"AC"))
 K @DENTV,@TEMP I $G(LOOKUP)="" S @DENTV@(1)="-1^No lookup value received" Q
 ;
 D LOOK^LEXA(LOOKUP,"ICD",MAX,12,ACTDATE)
 I '$O(LEX("LIST",0)) S @DENTV@(1)="-1^No matches found for "_LOOKUP Q
 S I=0,CNT=0 F  S I=$O(LEX("LIST",I)) Q:'I  S Z=$$ICDONE^LEXU(+LEX("LIST",I)) I Z]"" D
 .K LEX("LIST",I) I $D(@TEMP@(Z)) Q  ;already have this icd-9
 .S @TEMP@(Z)="" ;set up x-ref to check for dupes returned by ^LEXA call
 .S Y=$$ICD^DENTVICD(,Z,ACTDATE,1) Q:Y=""
 .I $G(CHKSCR)="P",$P(Y,U,5)=1 Q
 .S CNT=CNT+1,@DENTV@(CNT)=$P(Y,U)_U_Z_U_$P(Y,U,4)
 ;
 K @TEMP
 I '$O(@DENTV@(0)) S @DENTV@(1)="-1^No matches found for "_LOOKUP Q
 ;I TOTALS S @DENTV@(0)=CNT_U_+$G(LEX("MAT"))
 Q
 ;
LIST10(DENTV,SRCHV,SRCHDT,SRCHLL,SRCHF) ;ICD-10 Advanced Search Functionality
 ;
 ; Input Parameters:
 ;   SRCHV   Search Text (Required)
 ;   SRCHDT  Search Date (Optional, Default TODAY)
 ;   SRCHLL  List Length 8-30 (Optional, Default 30)
 ;   SRCHF   Coding System View (Optional, Default 10D)
 ;
 ; Return:
 ;   @DENTV@(0)    = # of matches found OR
 ;                  -1 ^ Error Message
 ;   @DENTV@(1..n) = DATA
 ;                  Piece
 ;                  0     IEN of Code
 ;                  1     Code or Code Category
 ;                  2     Date Effective
 ;                  3     # of Entries in layer below, if 0 it is a Code
 ;                  4     Description
 ;
 N AXY,CNT,NUMFND
 S DENTV=$NA(^TMP("DENTVLEX",$J)) K @DENTV
 I $G(SRCHV)="" S @DENTV@(0)="-1^Search Value is a Required Input Parameter" Q
 S:'$G(SRCHDT) SRCHDT=DT
 S SRCHLL=$S('$G(SRCHLL):30,SRCHLL<8:8,1:SRCHLL)
 S:$G(SRCHF)="" SRCHF="10D"
 S:$L(SRCHF)<4 SRCHF="I $$SO^LEXU(Y,"""_SRCHF_""",+($G(SRCHDT)))"
 S NUMFND=$$DIAGSRCH^LEX10CS(SRCHV,.AXY,SRCHDT,SRCHLL,SRCHF)
 I NUMFND<0 S @DENTV@(0)=NUMFND Q
 ;S @DENTV@(0)=+NUMFND
 F CNT=1:1:+NUMFND D
 . S $P(AXY(CNT,0),"^",3)=+$P(AXY(CNT,0),"^",3)
 . S @DENTV@(CNT)=$O(^ICD9("AB",$P(AXY(CNT,0),U)_" ",0))_U_AXY(CNT,0)_"^"_AXY(CNT,"MENU")
 Q
 ;
ICD10(DENTV) ;RPC: DENTVICD ICD10 ACTIVATION DATE
 S DENTV=$$IMPDATE^LEXU(30)
 Q
 ;  --------------------  subroutines  --------------------
CEI(DSI,FILE) ;  convert external code to ien - v20 or later
 ;  It will also verify that ien exist (DSI = code or ien)
 ;  DSI = ien for FILE    FILE = opt - 80 or 80.1 - default to 80
 ;  return: if active,   1^ien
 ;          if inactive  0^ien
 ;          problems,   -1^error message
 I $G(DSI)="" Q "-1^No ICD code received"
 S FILE=$G(FILE) S:'FILE FILE=80
 N X S X=$TR($$CODEN^ICDEX(DSI,FILE),"~",U)
 Q X
 ;
CIE(DSI) ;  convert ien to external - v20 or later
 ;  return code name or -1^error message
 I $G(DSI)="" Q "-1^No ICD code received"
 N Y S Y=$$CODEC^ICDEX(DSI) I Y=-1 S Y="-1^Code not found: "_DSI
 Q Y
 ;
INACT(F) ;  check for active
 ; expects SCR and DENTV (see ICD above)
 ; If $G(F) coming from OLD1
 ; if active return <null>, if inactive return 0^message
 N X,Y,Z,DATE,INACT,NM,PRIN
 I '$G(F) D
 .S INACT='$P(DENTV,U,10),DATE=$P($P(DENTV,U,12),";"),PRIN=$P(DENTV,U,5)
 .S NM=$P(DENTV,U,2)
 .Q
 E  D
 .S NM=TMP(.01,"E"),INACT=TMP(100,"I")
 .S DATE=TMP(102,"I"),PRIN=TMP(101,"I")
 .Q
 S Y="" I SCR="N" Q Y
 S X="" S:DATE X=$$FMTE^XLFDT(DATE)
 S X="inactive as of "_X_"; "
 I SCR["A",$S(INACT:1,1:DATE) S Y=X
 I SCR["U",PRIN S Y=Y_"not acceptable as a principal diagnosis"
 I Y'="" S Y="0^"_NM_" "_Y
 Q Y
 ;  
INIT() S CDT=$G(CDT) S:'CDT CDT=DT S FUN=$G(FUN)
 S FLDS=$G(FLDS),X=$G(SCR,"A")
 S:X?.E1L.E X=$$UP^XLFSTR(X)
 I X["N" S SCR="N"
 E  S SCR="" S:X["U" SCR="U" S:X["A" SCR=SCR_"A" S:SCR="" SCR="A"
 Q $S($G(VICD)'="":1,1:"-1^No ICD code received")
 ;
