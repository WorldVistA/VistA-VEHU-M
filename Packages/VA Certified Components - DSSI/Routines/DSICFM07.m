DSICFM07 ;DSS/LM - FILEMAN DD UTILITIES ;03/18/2005 19:37
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;this routine invokes various Fileman utilites for
 ;accessing the DD structure
 ;
 ;  DBIA#  Supported References
 ;  -----  -----------------------------------------------------
 ;   2051  $$LIST^DIC
 ;
 ;Common description of input parameters
 ;---------------------------------------------------------
 ;  FILE - req - file (or subfile) number or full file name
 ;   FUN - opt - if $G(FUN) then extrinsic function
 ; FIELD - req - field number or full field name
 ;
OUT Q:$G(FUN) DSIC Q
 ;
PULL(DSIC,FILE,FIELD,STRT,MAX,MASK) ; rpc: DSIC FM PULL LIST - from PULL^DSICFM
 ; Optional parameters STRT and MAX apply to pointer and variable pointer
 ; fields only.  All values will be returned for set-of-code fields.
 ;
 ; STRT - [Optional] Starting value (Default="").  For variable pointer VALUE^FILE#
 ; MAX  - [Optional] Maximum number of entries to return (Default=200)
 ; MASK - [Optional] Partial match restriction string
 ;
 S DSIC=$NA(^TMP("DSIC",$J)) K @DSIC
 I $G(FILE)=+$G(FILE),$G(FIELD)=+$G(FIELD) S STRT=$G(STRT),MAX=$G(MAX,200)
 E  S @DSIC@(0)="-1^Missing or invalid FILE or FIELD parameter" Q
 N DSICDD D FIELD^DSICFM(.DSICDD,FILE,FIELD,,"TYPE;POINTER;SPECIFIER",1)
 I $G(DSICDD(1))<0 S @DSIC@(0)=DSICDD(1) Q
 I DSICDD("TYPE")="SET" D SET Q
 I DSICDD("TYPE")="POINTER" D POINTER Q
 I DSICDD("TYPE")="VARIABLE-POINTER" D VPOINTER Q
 S @DSIC@(0)="-1^Unsupported FIELD type for RPC"
 Q
SET ; [Private] SET OF CODES
 N I,N S N=$L(DSICDD("POINTER"),";")-1
 S @DSIC@(0)=N_U_"S" F I=1:1:N S @DSIC@(I)=$TR($P(DSICDD("POINTER"),";",I),":",U)
 Q
POINTER ; [Private] POINTER
 N DSICFILE,DSICLIST S DSICFILE=+$P(DSICDD("SPECIFIER"),"P",2)
 I 'DSICFILE S @DSIC@(0)="-1^Pointer-Cannot compute pointed-to file" Q
 D LIST^DIC(DSICFILE,,"@;.01",,MAX,$P(STRT,U),$G(MASK),,,,"DSICLIST")
 N I,N S N=+$G(DSICLIST("DILIST",0))
 I 'N S @DSIC@(0)="-1^No entries found" Q
 S @DSIC@(0)=N_"^P"
 F I=1:1:N S @DSIC@(I)=$G(DSICLIST("DILIST",2,I))_U_$G(DSICLIST("DILIST","ID",I,.01))
 Q
VPOINTER ; [Private] VARIABLE-POINTER
 N DSICOUNT,DSICF,DSICFILE,DSICSF,DSICSV,DSICLIST,I,J,N D VFILE
 I '($D(DSICFILE)>1) S @DSIC@(0)="-1^Variable Pointer-Cannot compute pointed-to files" Q
 S (J,DSICOUNT)=0,DSICSF=$P(STRT,U,2),DSICSV=$P(STRT,U) ;Count, starting file, starting value
 S DSICF="" F  S DSICF=$O(DSICFILE("B",DSICF)) Q:'DSICF!(DSICOUNT=MAX)  D
 .Q:DSICSF>DSICF
 .K DSICLIST D LIST^DIC(DSICF,,"@;.01",,MAX-DSICOUNT,DSICSV,$G(MASK),,,,"DSICLIST")
 .S N=+$G(DSICLIST("DILIST",0)),DSICOUNT=DSICOUNT+N,DSICSV="" F I=1:1:N D
 ..S J=J+1,@DSIC@(J)=$G(DSICLIST("DILIST",2,I))_U_$G(DSICLIST("DILIST","ID",I,.01))_U_DSICF
 ..Q
 .Q
 S @DSIC@(0)=DSICOUNT_"^V"
 Q
VFILE ; [Private] Pointed-to File List
 ; To do: Replace next with supported call if possible
 N I,J S (I,J)=0 F  S I=$O(^DD(FILE,FIELD,"V",I)) Q:'I  D
 .S J=J+1,DSICFILE(J)=+$G(^(I,0)),DSICFILE("B",DSICFILE(J))="",DSICFILE(0)=J
 .Q
 Q
