DSICFM03 ;DSS/SGM - VARIOUS FILEMAN UTILITIES ;06/09/2004 15:37
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine calls $$FIND1^DIC
 ;  The full functionality of $$FIND1^DIC is supported
 ;  However all that is needed at a minumum is FILE and VALUE
 ;  It is designed to quickly lookup an entry by internal value or to
 ;     verify that a IFN record actually exists
 ;
 ;  DBIA#   SUPPORTED
 ;  -----   -----------------------------------
 ;   2051   FIND1^DIC
 ;
V1(DSIC,INPUT) ; RPC: 
 ;  this is specialized to verify that a record exists in a file
 ;  INPUT - required - see line tag PARSE for details
 ;   DSIC - return variable
 ;          return internal file number if successful
 ;          else, return -1^error message
 ;
V11 ;  temporary entry point until VEJDFM03 can be retired
 N X,X1,X2,Y,Z,DIERR,DSIER,FILE,FLG,IDX,IENS,IFN,INTERNAL,SCR,TYPE,VALUE
 S X=$$PARSE I X]"" S DSIC=X Q:'TYPE  Q X
 S X=$$FIND1^DIC(FILE,IENS,FLG,.VALUE,.IDX,.SCR,"DSIER")
 I X>0 S DSIC=X
 I X=0 S DSIC="-1^No matches found for input value"
 I X="" S DSIC="-1^"_$$MSG^DSICFM01("VE ",,,,"DSIER")
 Q:'TYPE  Q DSIC
 ;
PARSE() ;  parse the INPUT array passed in V1
 ;  expects INPUT(sub)=value where sub are:
 ;    FILE - required - file or subfile number to do lookup on
 ;    IENS - optional - required if passing a subfile number
 ;                      standard FM iens for ^DIC calls
 ;   VALUE - required - lookup value, maybe internal file number,
 ;           internally stored format (e.g., pointer value), or external
 ;           format.  If value starts with '`' then assume it is the
 ;           internal file number
 ;INTERNAL - optional - if +$G(INTERNAL), then value is in internally
 ;                      stored format
 ;  IFN - optional - if +$G(IFN), then VALUE is the internal file number
 ; TYPE - optional - default value = "" - if "1fFeE"[TYPE then this call
 ;         is an extrinsic function, else it is called by DO with params
 ;  FLG - optional - default value will be determined from other input
 ;                   values - this is the Fileman FLAGS param
 ;  IDX - optional - this is equivalent to the [.]INDEXES fileman param
 ;                   M INDEXES=INPUT("IDX")
 ;  SCR - optional - this is equivalent to the [.]SCREEN fileman param
 ;                   M SCREEN=INPUT("SCR")
 ; 
 ;  return "" if no problems encountered, else return -1^error msg
 N X,Z S Z="-1^No "
 F X="FILE","FLG","IENS","IFN","INTERNAL","TYPE" S @X=$G(INPUT(X))
 F X="IDX","SCR","VALUE" I $D(INPUT(X)) M @X=INPUT(X)
 I '$D(INPUT) Q Z_"input values received"
 S TYPE=$S("1eEfF"[$E(TYPE):1,1:0)
 I FILE="" S Z=Z_"file number, "
 I '$D(VALUE) S Z=Z_"lookup value"
 I Z'="-1^No " Q Z_" received"
 I IFN,$G(VALUE)]"",$E(VALUE)'="`" S VALUE="`"_VALUE
 I FLG]"" Q ""
 I $E($G(VALUE))="`" S FLG="AQX" Q ""
 I +INTERNAL S FLG="QX"
 I '$D(IDX) S FLG=FLG_"M"
 Q ""
