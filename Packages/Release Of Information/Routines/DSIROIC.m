DSIROIC ;DSS/EWL - UTILITIES TO REPLACE DSIC CALLS ;07/11/2011 14:10
 ;;8.2;RELEASE OF INFORMATION - DSSI;;JUL 1, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;ICR#  SUPPORTED External References
 ;----- ----------------------------------------------------
 ;2053  WP^DIE
 ;2056  GETS^DIQ
 ;2056  $$GET1^DIQ
 ;10103 $$FMTE^XLFDT
 ;3618  POSTAL^XIPUTIL
 ;10056 Entire STATE file supported for READ access
 Q
DOD(DSIRRET,IEN) ; RPC: DSIROIC DOD GET DATE OF DEATH
 ;INPUT
 ;IEN = The DFN of the patient
 ;
 ;RETURNS A single date or a null if no date found
 ; OR AN ERROR
 ; -1^ERROR MESSAGE
 ;
 I '$G(IEN) S DSIRRET="-1^A valid IEN must be provided" Q
 N IENS,GET S IENS=IEN_","
 D GETS^DIQ(2,IENS,.351,"IE","GET")
 S DSIRRET=$S(GET(2,IENS,.351,"I"):$P(GET(2,IENS,.351,"E"),"@"),1:"")
 Q
PATINFO(DSIRRET,IEN) ; RPC: DSIROIC PATID GET DFN AND NAME
 ;INPUT
 ;IEN = The IEN of the request being looked up
 ;
 ;RETURNS A 2 PIECE STRING FORMATTED AS FOLLOWS
 ;IEN of patient^NAME of patient
 ; OR AN ERROR
 ; -1^ERROR MESSAGE
 ;
 I '$G(IEN) S DSIRRET="-1^A valid IEN must be provided" Q
 N IENS,DSIRGETS,EMSG S IENS=IEN_","
 D GETS^DIQ(19620,IENS,.01,"EI","DSIRGETS","EMSG")
 I $D(EMSG) D
 .I $D(EMSG("DIERR",1,"TEXT",1)) S DSIRET="-1^"_EMSG("DIERR",1,"TEXT",1)
 .E  S DSIRET="-1^Lookup failed for request #"_IEN
 S:'$D(EMSG) DSIRRET=DSIRGETS(19620,IENS,.01,"I")_U_DSIRGETS(19620,IENS,.01,"E")
 Q
CLKDAT(DSIRRET,IEN) ; RPC: DSIROIC CLKDAT GET CLERK INFO
 ;INPUT
 ;IEN = The IEN of the clerk to lookup
 ;
 ;RETURNS A 5 PIECE STRING FORMATTED AS FOLLOWS
 ;NAME^OFFICE PHONE^SIGNATURE BLOCK NAME^SIGNATURE BLOCK TITLE^SERVICE/SECTION
 ; OR AN ERROR
 ; -1^ERROR MESSAGE
 ;
 I '$G(IEN) S DSIRRET="-1^A valid IEN must be provided" Q
 N IENS,DSIRGETS,EMSG S IENS=IEN_","
 D GETS^DIQ(200,IENS,".01;.132;20.2;20.3;29","EI","DSIRGETS","EMSG")
 S DSIRRET=DSIRGETS(200,IENS,.01,"E")_U_DSIRGETS(200,IENS,.132,"E")_U_DSIRGETS(200,IENS,20.2,"E")
 S DSIRRET=DSIRRET_U_DSIRGETS(200,IENS,20.3,"E")_U_DSIRGETS(200,IENS,29,"E")_U_DSIRGETS(200,IENS,29,"I")
 Q
GETSTLST(DSIRRET) ; RPC: DSIROIC GETSTLST STATE LIST
 ;Gets state information from file 5.
 ;RETURNS State information as an array of strings as follows:
 ; IEN^STATE NAME^ABREVIATION
 ; or
 ; -1^Error Message
 ;
 N IEN,IENS,DSIRGETS S IEN=0,DSIRRET=$NA(^TMP("DSIRSTATES",$J)) K @DSIRRET
 F  S IEN=$O(^DIC(5,IEN)) Q:'IEN  S IENS=IEN_"," D
 .D GETS^DIQ(5,IENS,".01;1",,"DSIRGETS")
 .S @DSIRRET@(IEN)=IEN_U_DSIRGETS(5,IENS,.01)_U_DSIRGETS(5,IENS,1)
 Q
ZIP(DSIRRET,PCODE,ACTDATE) ;  RPC: DSIROIC ZIP CODE LOOKUP
 ;    PCODE - required - 5 or 9 digit zip code - must be a string
 ;  ACTDATE - optional - Fileman date for which the zip code must have
 ;            been active - default is to ignore date sndn return all
 ;  RETURN: on error return -1^error message
 ;          else return p1^p2^p3^p4^p5^p6^p7^p8  where
 ;          p1 = inputted zip code     p5 = FIPS county code
 ;          p2 = city                  p6 = state abbreviation
 ;          p3 = state (full name)     p7 = ptr to STATE file (#5)
 ;          p4 = county (full name)    p8 = ptr to COUNTY CODE file (#5.13)
 ;
 ; return value is for the primary location associated with the ZIP code
 ;
 N X,Y,Z,DIERR,DSIRERR,DSIRXIP,ST
 I $G(PCODE)="" S AXY="-1^No zipcode received"
 E  D
 .D POSTAL^XIPUTIL(PCODE,.DSIRXIP)
 .I $D(DSIRXIP("ERROR")) S DSIRRET="-1^"_DSIRXIP("ERROR")
 .E  D
 ..S X=DSIRXIP("INACTIVE DATE") S:X Y=$$FMTE^XLFDT(X)
 ..I X,$G(ACTDATE),ACTDATE'<X S DSIRRET="-1^"_PCODE_" inactive as of "_Y
 ..E  D
 ...S X=DSIRXIP("STATE POINTER"),ST=""
 ...I X S ST=$$GET1^DIQ(5,X_",",1,,,"DSIRERR") S:$D(DSIRERR) ST=""
 ...S DSIRRET=PCODE
 ...F Z="CITY","STATE","COUNTY","FIPS CODE" S DSIRRET=DSIRRET_U_DSIRXIP(Z)
 ...S $P(DSIRRET,U,6)=ST_U_DSIRXIP("STATE POINTER")_U_DSIRXIP("COUNTY POINTER")
 Q
WPFILER(RET,IEN,TYPE,STRLIST) ; RPC - DSIROIC WPFILER WP FILER
 ; Input parameters
 ;   IEN     - Internal entry number
 ;   TYPE    - Must be "C", "I", "A", OR "R" as follows:
 ;             Regular comments (19620,.31)(C)
 ;             Internal Comments (19620,.32)(I)
 ;             Annotations (19620.98,100)(A)
 ;             Released Document Comment (19620.1,1)(R)
 ;   STRLIST - List (ARRAY) of lines to be filed
 ;
 ; Retun
 ;   IEN if successful
 ;   -1^error message if not successful
 ;
 N FILE,FIELD,FLAGS,EMSG
 ;
 S IEN=$G(IEN) I 'IEN S RET="-1^A missing or invalid IEN was specified." Q
 S ^TMP("DSIR","IEN")=IEN
 S TYPE=$G(TYPE) I (TYPE']"")!($L(TYPE)>1)!("CIAR"'[TYPE) S RET="-1^Invalid type specified. Must be ""C"", ""I"", ""A"", or ""R""" Q
 S ^TMP("DSIR","TYPE")=TYPE
 S FIELD=$S(TYPE="C":.31,TYPE="I":.32,TYPE="A":100,1:1)
 S ^TMP("DSIR","FIELD")=FIELD
 S RET=IEN,FILE=$S("CI"[TYPE:19620,TYPE="A":19620.98,1:19620.1)
 S ^TMP("DSIR","FILE")=FILE ;
 ;
 I '$D(STRLIST) S RET="-1^Invalid word processing data passed.  Must be a list of lines" Q
 M ^TMP("DSIR",$J,"WP")=STRLIST
 S FLAGS="K"
 D WP^DIE(FILE,IEN_",",FIELD,FLAGS,"STRLIST","EMSG")
 I $D(EMSG) S RET=$S($D(EMSG("DIERR",1,"TEXT",1)):"-1^"_EMSG("DIERR",1,"TEXT",1),1:"-1^Filing of the word processing data failed") Q
 Q
