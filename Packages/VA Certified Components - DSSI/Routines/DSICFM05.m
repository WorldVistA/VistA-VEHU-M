DSICFM05 ;DSS/SGM - RPC FOR LIST^DIC ;03/02/2005 17:18
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; this routine provides for most of the features of LIST^DIC
 ; DBIA#  SUPPORTED
 ; -----  ---------  ------------------------------
 ;  2051      x      LIST^DIC
 ;  2052      x      FILE^DID
 ;  2055      x      ^DILFD: $$VFIELD, $$VFILE
 ; 10104      x      $$UP^XLFSTR
 ;
 ;  description of the INPUT array
 ;INPUT(sub) = variable name ^ value  where sub can be anything
 ;             [Example: INPUT(1) = "FILE^200"]
 ;variable name   REQ   DEFAULT
 ;-------------   ---   -------
 ;FILE            YES
 ;   this is the number of the file (or subfile) for which the lookup is
 ;   to be done
 ;
 ;IENS            Y/N
 ;   this is the standard Fileman IENS for LIST^DIC. It is only required
 ;   when doing a lookup on a subfile
 ;
 ;FIELDS          NO    .01
 ; 1. A string of fields (#s) to be returned
 ; 2. Field #s are separated by a ';'
 ; 3. For external values, use only the field #
 ; 4. For internal values, use the field # followed by 'I'
 ; 5. Example: .01;.09;.03i;.03 from PATIENT file.  This will return
 ;             dfn^patient name^SSN^DOB (FM format)^DOB external format
 ;
 ;FLAGS           NO    MP
 ;   1. a string of codes that affects how the lookup is done.
 ;   2. This RPC always packs output (P flag)
 ;   3. 'I' - internal values returned is obsolete but still honored
 ;      Use I if you want all field values returned as internal values
 ;
 ;NUMBER          NO    100
 ;   the maximum number of entries to be return
 ;
 ;INDEX           NO
 ;   The name of the index from which to build the list
 ;   Default value is 'B' index unless the K flag is passed
 ;   If INDEX="#" then loop through file by internal record number
 ;
 ;FROM            NO     [applicable to LIST only]
 ;   1. The index entry from which to begin the list (e.g., a FROM value
 ;      of "XQ" would list entries following XQ).
 ;   2. The FROM values must be passed as they appear in the index, not
 ;      in external value
 ;   3. The index entry for the FROM value itself is not included in the
 ;      returned list
 ;   4. If the INDEX parameter specifies a compound index (i.e., one
 ;      with more than one data-valued subscript), then the FROM
 ;      parameter should be passed by reference as an array where
 ;      FROM(n) represents the "nth" subscript on the compound index.
 ;
 ;PART            NO     [applicable to LIST only]
 ;   The partial match restriction. For example, a PART value of "DI"
 ;   would restrict the list to those entries starting with the letters
 ;   "DI".  Again, this value must be a partial match to an index value,
 ;   not the external value of a field.  This can be passed by reference
 ;   PART(n) and subscripted the same as the FROM parameter so that PART
 ;   values can be specified for any subscript in a compound index.
 ;
 ;SCREEN          NO
 ;   The screen to apply to each potential entry in the returned list to
 ;   decide whether or not to include it. This may be set to any valid M
 ;   code that sets $TEST to 1 if the entry should be included, to 0 if
 ;   not. This is exactly equivalent to the DIC("S") input variable to
 ;   Classic FileMan lookup ^DIC. The Lister will execute this screen in
 ;   addition to any SCR node (whole-file screen) defined for the file.
 ;   Optionally, the screen can be defined in an array entry subscripted
 ;   by "S" (for example, SCR("S")), allowing additional screen entries
 ;   to be defined for variable pointer fields as described below.
 ;
 ;VAL            YES     [applicable to FIND only]
 ;   The lookup value for FIND.  It can be an array
 ;
 ;RETURN
 ;  Return DSIC=$NA(^TMP("DSIC",$J,"DILIST"))
 ;    ^TMP("DSIC",$J,"DILIST",n,0)=p1^p2^p3^... for n=1,2,3,...
 ;    where p1 = record ien
 ;          p2 = .01 field internal value
 ;          p3 = value of field specified in 1st ^-piece of FIELDS
 ;          p4 = value of field specified in 2nd ^-piece of FIELDS
 ;          etc. for p4,p5,p6,...
 ;  If no matches found, @DSIC@(1,0) = -1^No matches found
 ;  If errors, one or more lines may be returned
 ;    @DSIC@(1,0) = -1^Problems encountered
 ;    @DSIC@(n,0) = detailed text of problem if available
 ;                  where n = 2,3,4,5,...
 ;
FIND(DSIC,INPUT) ; RPC: DSIC FM FIND
 N I,X,Y,Z,DIERR,DSIERR,ERR,FIELDS,FILE,FLAGS,IENS,INDEX,NUMBER
 N ROU,VAL,SCREEN
 K ^TMP("DSIC",$J) S DSIC=$NA(^TMP("DSIC",$J))
 I '$D(INPUT) D ERR(1) Q
 ;
 ;  get fileman variables
 Q:'$$EVAL("^FILE^IENS^FIELDS^FLAGS^NUMBER^INDEX^VAL^SCREEN^")
 K ERR Q:'$$FILE  ;  validate file (or subfile#)
 Q:'$$FLD(.01)  ;    validate field numbers
 D FLG("ABCKMOPQUX"),OTH
 ;
 ;  at this point let LIST^DIC validate rest of inputs
 ;  if '$D(fm_variable) then construct LIST^DIC with ',,'
 S ROU="D FIND^DIC(FILE,"
 S:$G(IENS)'="" ROU=ROU_"IENS" S ROU=ROU_","
 S ROU=ROU_"FIELDS,FLAGS,.VAL,NUMBER,"
 S:$G(INDEX)'="" ROU=ROU_"INDEX" S ROU=ROU_","
 S ROU=ROU_".SCREEN,,DSIC,""DSIERR"")"
 G DOIT
 ;
LIST(DSIC,INPUT) ; RPC: DSIC FM LIST
 N I,X,Y,Z,DIERR,DSIERR,ERR,FIELDS,FILE,FLAGS,FROM,IENS,INDEX,NUMBER
 N PART,ROU,SCREEN
 S DSIC=$NA(^TMP("DSIC",$J)) K @DSIC
 I '$D(INPUT) D ERR(1) Q
 ;
 ;  get fileman variables
 Q:'$$EVAL("^FILE^IENS^FIELDS^FLAGS^NUMBER^INDEX^FROM^PART^SCREEN^")
 K ERR Q:'$$FILE  ;  validate file (or subfile#)
 Q:'$$FLD(.01)  ;    validate field numbers
 D FLG("BIKMPQU"),OTH1
 ;  at this point let LIST^DIC validate rest of inputs
 ;  if '$D(fm_variable) then construct LIST^DIC with ',,'
 S ROU="D LIST^DIC(FILE,"
 S:$G(IENS)'="" ROU=ROU_"IENS" S ROU=ROU_","
 S ROU=ROU_"FIELDS,FLAGS,NUMBER,.FROM,.PART,"
 S:$G(INDEX)'="" ROU=ROU_"INDEX" S ROU=ROU_","
 S ROU=ROU_".SCREEN,,DSIC,""DSIERR"")"
DOIT X ROU S DSIC=$NA(^TMP("DSIC",$J,"DILIST"))
 I $D(DIERR) S X=$$MSG^DSICFM01("VE",,,,"DSIERR") D ERR(X) Q
 K @DSIC@(0) I '$D(@DSIC) D ERR(7)
 Q
 ;
 ;   --------------------  subroutines  --------------------
ERR(X,Y) ;
 I X=1 S X="No input array received"
 I X=2 S X="IENS received, but file "_FILE_" is not a subfile"
 I X=3 S X="Invalid IENS value: "_IENS
 I X=6 S X="Invalid FIELDS value received for file "_FILE
 I X=7 S X="No matches found matching input value"
 I X=8 S X="Input parameter value exceeds 511 bytes: "_Z
 I $G(Y) S ERR=$G(ERR)_X_"; " Q
 S Y=1+$O(^TMP("DSIC",$J,"DILIST","A"),-1)
 I Y=1 S ^TMP("DSIC",$J,"DILIST",1,0)="-1^Problems encountered" S Y=2
 S ^TMP("DSIC",$J,"DILIST",Y,0)=X
 S DSIC=$NA(^TMP("DSIC",$J,"DILIST"))
 Q
 ;
EVAL(STR) ;  evaluate INPUT string and set FM variables
 ;  if no problems return 1, else return 0
 N I,X,Y,Z,ERR
 S I="",ERR="Invalid input variable names received:"
 F  S I=$O(INPUT(I)) Q:I=""  S Z=INPUT(I) D
 .S Y=$P(Z,U,2,999),Z=$P(Z,U) S:Z?.E1L.E Z=$$UP^XLFSTR(Z)
 .I STR'[(U_$P(Z,"(")_U) S ERR=ERR_" "_Z_";" Q
 .I $L(Y)<512 S @Z=Y Q
 .D ERR(8)
 .Q
 K INPUT S X=1 I $P(ERR,":",2)'="" D ERR(ERR) S X=0
 Q X
 ;
FILE() ;  validate file (or subfile number)
 ;  Return 1 if a valid file/subfile, else return 0
 N X,Y,Z,DSI,DSIERR
 S X=$$VFILE^DSICFM06(,$G(FILE),1)
 I +X=-1 D ERR($P(X,U,2)) Q 0
 ;  check to see if file is a subfile, if DIERR then a subfile
 D FILE^DID(FILE,,"NAME","DSI","DSIERR")
 S Z=1
 I $G(IENS)'="",'$D(DIERR) D ERR(2) S Z=0
 I +$G(IENS) D ERR(3) S Z=0
 Q Z
 ;
FLD(DF) ;  validate field numbers
 ;  DF = default value for FIELDS
 ;  return 1 if no problems, else return 0
 N I,X,Y,Z,DSI,DSIERR,DSIX,FLD,FLG
 S FIELDS=$G(FIELDS,$G(DF)) I FIELDS="",DF'="" S FIELDS=DF
 S DSIERR="Invalid field numbers received: "
 I FIELDS'="" S DSI="" D
 .I FIELDS?.E1L.E S FIELDS=$$UP^XLFSTR(FIELDS)
 .F I=1:1:$L(FIELDS,";") S DSIX=$P(FIELDS,";",I) D:+DSIX
 ..S FLD=+DSIX,FLG=$P(DSIX,FLD,2)
 ..I '$$VFIELD^DILFD(FILE,FLD) S DSIERR=DSIERR_FLD_","
 ..S DSI=DSI_FLD S:FLG="I" DSI=DSI_"I" S DSI=DSI_";"
 ..Q
 .I $P(DSIERR,": ",2)="",DSI'="" S FIELDS="@;"_DSI
 .Q
 I $P(DSIERR,": ",2)="" Q 1
 D ERR(DSIERR) Q 0
 ;
FLG(Z) ;  set FLAGS parameter
 S FLAGS=$G(FLAGS,"MP") S:FLAGS="" FLAGS="MP"
 S:FLAGS'="" FLAGS=$$CNVT^DSICUTL(FLAGS,Z,"U")
 S:FLAGS'["P" FLAGS="P"_FLAGS
 Q
 ;
OTH ;  set up other parameters
 S NUMBER=$G(NUMBER,100) S:NUMBER="" NUMBER=100
 I $G(INDEX)="",FILE=2 S INDEX="B^BS^BS5^SSN"
 Q
OTH1 ;  set up other parameters
 S NUMBER=$G(NUMBER,100) S:NUMBER="" NUMBER=100
 ; multiple indices do not work for LIST^DIC
 ;I $G(INDEX)="",FILE=2 S INDEX="B^BS^BS5^SSN"
 S INDEX=$P($G(INDEX),U,1)
 Q
