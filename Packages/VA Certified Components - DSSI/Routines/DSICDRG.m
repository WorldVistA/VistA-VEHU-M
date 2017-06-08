DSICDRG ;DSS/SGM - ICD9 UTILITIES ;09/05/2003 11:20
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this contains RPC calls for retrieving ICD9 information
 ;  It is code set versioning compliant in that it looks for
 ;  the ICDCODE routine.
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  --------------------------------------------------
 ;   2056      x      GETS^DIQ
 ;   3990      x      ICDCODE: $$ICDDX, $$CODEN, $$CODEC
 ;   3991      x      ICDAPIU: $$STATCHK
 ;  10082      x      Direct global/FM read of file 80 of entire 0th
 ;                    node, fields .01;3;5;9.5;100;102;10, & "BA" index
 ;  10096      x      All nodes in ^%ZOSF are uesable
 ;  10103      x      $$FMTE^XLFDT
 ;  10104      x      ^XLFSTR: $$TRIM, $$UP
 ;
 ;  Common notation on input parameters
 ;   CDT - opt - default to DT
 ;         date used by ICD code to return date specific data
 ;   FUN - opt - I +$G(FUN) then extrinisc function call
 ;                    do not return data in local array
 ;  VICD - req - ien to file 80 or ICD9 name
 ;   SRC - opt - Flag to indicate if Level III codes need to be screened
 ;               out. If SRC=0 or null, Level III codes not processed as
 ;               valid input; if SRC>0, Level III codes are accepted.
 ;
ACTICD(DSIC,VICD,CDT,FUN) ; RPC: DSIC ICD9 ACTIVE
EN ;  for input params see ICD9
 ;  Return: 1 if active, 0^message if inactive
 ;    else return -1^error message
 N X S X=$$INIT I X<1 S DSIC=X G OUT
 I $$CSV D
 .S X=$$STATCHK^ICDAPIU(VICD,CDT)
 .S DSIC=$S(X>0:1,'X:X,1:"-1^Code "_VICD_" not found")
 .Q
 E  S DSIC=$$ICD9(,$G(VICD),,CDT,,1) S:DSIC>0 DSIC=1
OUT Q:$G(FUN) DSIC Q
 ;
ICD9(DSIC,VICD,FLDS,CDT,SCR,FUN) ; RPC: DSIC ICD9 GET DIAGNOSIS
EN1 ; FLDS - opt - only relevant to pre ICD v20.0 - see OLD1
 ; pre v20 code will return some, not all, of the fields below
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
 N I,X,Y,Z S X=$$INIT I X<1 S DSIC=X G OUT
 I '$$CSV G OLD1
 S DSIC=$$ICDDX^ICDCODE(VICD,CDT) I +DSIC=-1 G OUT
 S X=$P(DSIC,U,12) I X S X=X_";"_$$FMTE^XLFDT(X),$P(DSIC,U,12)=X
 S X=$$INACT S:X'="" DSIC=X
 G OUT
 ;
LIST(DSIC,DSIX,SCR,DSIA) ;  RPC: DSIC ICD9 GET LIST
 ;Integration Agreements: LOOK^LEXA 2950 supported, ICDONE^LEXU 1573 Private AICS
 ;DSS/CDP 07/03/2007 Start Mod - Replaced subroutine LIST with a new version using the Lexicon.
 ;This subroutine returns a list of ICD9 codes matching LOOKUP value (piece 2 of 0 node will
 ;tell how many matches there were, gui can tell user to do better input)
 ;
 ; New method for calling this subroutine:
 ;    An input array "DSIA" will have to be set up in the format "Mnemonic^Input Value".  
 ;    The mnemonic is the tag that defines to the subroutine what input parameter is being 
 ;    passed, and the input value is the actual data, as follows:
 ;
 ;    DSIC - Return array for your ICD9 codes
 ;           If nothing found in Lexicon for code or error, return @DSIC@(1)=-1^error message
 ;           else return @DSIC@(#) = ien ^ icd9 code ^ short description
 ;    DSIX - Leave NULL
 ;    SCR  - Leave NULL
 ;    DSIA(0) = "LOOKUP^Value"
 ;           user input lookup value
 ;    DSIA(1) = "CHKSCR^Value"
 ;           If value set to "P", only valid ICD9 codes that are eligible to be principle 
 ;           diagnosis will be returned.
 ;    DSIA(2) = "ACTDATE^Value" (ACTDATE is in Fileman format, NULL dates will be set to Today)
 ;           The eligibility date of the ICD9 code.
 ;    DSIA(3) = "MAX^Value" (100 is the default)   
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
 ;                 D LIST^DSICDRG(.RR,,,.SS)  Return: RR ="^TMP("DSIC",5876)
 ; 
 ;Old method of call this subroutine:
 ;    DSIC - Return array for your ICD9 codes
 ;           If nothing found in Lexicon for code or error, return @DSIC@(1)=-1^error message
 ;           else return @DSIC@(#) = ien ^ icd9 code ^ short description
 ;    DSIX - required - user input lookup value
 ;     SCR - optional - this RPC will only allow selection of active codes
 ;           as of TODAY.  If SCR="P", the additional screen to only allow
 ;           diagnoses acceptable as a principal diagnosis.
 ;           **note** this field is not used yet!!
 ;    DSIA - Leave NULL
 ;
 ;     ***No totals are returned
 ;
 N I,X,Y,Z,SCRN,TEMP,LEX,CNT,LOOKUP,CHKSCR,ACTDATE,TOTALS,PAR,VAL,MAX
 S TOTALS=0 I $D(DSIA) D
 . S X="" F  S X=$O(DSIA(X)) Q:X=""  D  S TOTALS=1
 .. S Z=DSIA(X),PAR=$P(Z,U),VAL=$P(Z,U,2) I PAR?.E1L.E S PAR=$$UP^XLFSTR(PAR)
 .. S @PAR=$G(VAL)
 S:$G(LOOKUP)="" LOOKUP=$G(DSIX) S:$G(CHKSCR)="" CHKSCR=$G(SCR)
 S:$G(MAX)="" MAX=100 S:($G(ACTDATE)=""!($G(ACTDATE)?1"T".E)) ACTDATE=$G(DT)
 ;
 S DSIC=$NA(^TMP("DSIC",$J)),TEMP=$NA(^TMP("DSICX",$J))
 K @DSIC,@TEMP I $G(LOOKUP)="" S @DSIC@(1)="-1^No lookup value received" Q
 ;
 D LOOK^LEXA(LOOKUP,"ICD",MAX,12,ACTDATE)
 I '$O(LEX("LIST",0)) S @DSIC@(1)="-1^No matches found for "_LOOKUP Q
 S I=0,CNT=0 F  S I=$O(LEX("LIST",I)) Q:'I  S Z=$$ICDONE^LEXU(+LEX("LIST",I)) I Z]"" D
 .K LEX("LIST",I) I $D(@TEMP@(Z)) Q  ;already have this icd-9
 .S @TEMP@(Z)="" ;set up x-ref to check for dupes returned by ^LEXA call
 .S Y=$$ICD9^DSICDRG(,Z,,,ACTDATE,1) Q:Y=""
 .I $G(CHKSCR)="P",$P(Y,U,5)=1 Q
 .S CNT=CNT+1,@DSIC@(CNT)=$P(Y,U)_U_Z_U_$P(Y,U,4)
 ;
 K @TEMP
 I '$O(@DSIC@(0)) S @DSIC@(1)="-1^No matches found for "_LOOKUP Q
 I TOTALS S @DSIC@(0)=CNT_U_+$G(LEX("MAT"))
 Q
 ;
 ;  --------------------  subroutines  --------------------
CEI(DSI,FILE) ;  convert external code to ien - v20 or later
 ;  It will also verify that ien exist (DSI = code or ien)
 ;  DSI = ien for FILE    FILE = opt - 80 or 80.1 - default to 80
 ;  return: if active,   1^ien
 ;          if inactive  0^ien
 ;          problems,   -1^error message
 I $G(DSI)="" Q "-1^No ICD9 code received"
 S FILE=$G(FILE) S:'FILE FILE=80
 N X S X=$TR($$CODEN^ICDCODE(DSI,FILE),"~",U)
 Q X
 ;
CIE(DSI) ;  convert ien to external - v20 or later
 ;  return code name or -1^error message
 I $G(DSI)="" Q "-1^No ICD9 code received"
 N Y S Y=$$CODEC^ICDCODE(DSI) I Y=-1 S Y="-1^Code not found: "_DSI
 Q Y
 ;
CSV() ;  verify that routine ICDCODE exists
 Q $$PATCH^XPDUTL("ICD*18.0*6")
 ;
INACT(F) ;  check for active
 ; expects SCR and DSIC (see ICD9 above)
 ; If $G(F) coming from OLD1
 ; if active return <null>, if inactive return 0^message
 N X,Y,Z,DATE,INACT,NM,PRIN
 I '$G(F) D
 .S INACT='$P(DSIC,U,10),DATE=$P($P(DSIC,U,12),";"),PRIN=$P(DSIC,U,5)
 .S NM=$P(DSIC,U,2)
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
 ;  --------------------  pre-csv code  --------------------
OLD1 ;  pre v20.0 ICD release
 N I,X,Y,Z,DIERR,DSI,DSIERR,FIELDS,VIEN,TMP
 S Z="^.01^3^5^9.5^10^15^100^101^102^"
 S FIELDS=$TR($P(Z,U,2,99),U,";")
 S:FLDS="" FLDS=".01;3" S Y=""
 F I=1:1:$L(FLDS,";") S X=$P(FLDS,";",I) S:Z[X FLDS(X)=""
 ;  check to see if VICD is ICD9 name
 S VIEN=$O(^ICD9("BA",VICD_" ",0))
 ;  if 'VIEN then VICD must be a pointer, verify
 I VIEN<1 S VIEN=$S($D(^ICD9(VICD,0)):VICD,1:0)
 I 'VIEN S DSIC="-1^Unable to find "_VICD G OUT
 S VIEN=VIEN_","
 D GETS^DIQ(80,VIEN,FIELDS,"EI","DSI","DSIERR")
 I '$D(DSI) S DSIC="-1^"_$$MSG^DSICFM01("VE",,,,"DISERR") G OUT
 M TMP=DSI(80,VIEN)
 S X=$$INACT(1) I X'="" S DSIC=X G OUT
 S DSIC=+VIEN_U_TMP(.01,"E")_U_U_TMP(3,"E")
 I $D(FLDS(101)) S $P(DSIC,U,5)=TMP(101,"I")
 I $D(FLDS(5)) S $P(DSIC,U,6)=TMP(5,"I")
 I $D(FLDS(9.5)) S $P(DSIC,U,11)=TMP(9.5,"I")
 I $D(FLDS(15)) S $P(DSIC,U,16)=TMP(15,"I")
 I $D(FLDS(100)) S $P(DSIC,U,10)='TMP(100,"I")
 S X=TMP(102,"I")_";"_TMP(102,"E")
 I $D(FLDS(102)),+X S $P(DSIC,U,12)=X
 ;I $D(FLDS(10)) S $P(DSIC,U,10)=TMP(10,"E")
 G OUT
