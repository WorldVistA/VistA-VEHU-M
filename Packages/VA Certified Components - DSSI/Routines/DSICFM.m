DSICFM ;DSS/SGM - BRIEF DOCS FOR DSICFM ENTRY POINTS ;01/14/2005 13:26
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;running this routine from the top in terminal mode will give you
 ;a brief description of the various entry points in the varied
 ;DSICFM* and DSICDDR* routines.  You can use the entry points in this
 ;routine to access those other entry points.  This way you just have
 ;to remember the DSICFM routine name to find what is available.
 ;
 D ^DSICFM00 Q
 ;
OUT Q:$G(FUN) DSIC Q
 ;
 ;--------------------  DSICFM01  --------------------
MSG(FLGS,OUT,WIDTH,LEFT,INPUT) ;
 G M^DSICFM01
 ;
 ;--------------------  DSICFM02  --------------------
DINUM(DSIC2,FILE,IEN,VAL,IENS) ; RPC: DSIC FM DINUM
 D INIT("FILE^IEN^VAL^IENS")
 D DINUM^DSICFM02(.DSIC2,FILE,IEN,VAL,IENS)
 Q
 ;
 ;--------------------  DSICFM03  --------------------
V1(DSIC,INPUT) ;
 D V1^DSICFM03(.DSIC,.INPUT) Q
 ;
 ;--------------------  DSICFM04  --------------------
FILE(DSIC,FILE,IENS,FLAG,INPUT) ; RPC: DSIC FM FILER
 D INIT("FILE^IENS^FLAG")
 D FILE^DSICFM04(DSIC,FILE,IENS,FLAG,.INPUT)
 Q
 ;
 ;--------------------  DSICFM05  --------------------
FIND(DSIC,INPUT) ; RPC: DSIC FM FIND
 D FIND^DSICFM05(.DSIC,.INPUT) Q
 ;
LIST(DSIC,INPUT) ; RPC: DSIC FM LIST
 D LIST^DSICFM05(.DSIC,.INPUT) Q
 ;
 ;--------------------  DSICFM06  --------------------
EXTERNAL(DSIC,FILE,FIELD,VALUE,FUN) ; rpc: DSIC FM EXTERNAL
 D INIT("FILE^FIELD^VALUE^FUN") D
 .N FUN D EXTERNAL^DSICFM06(.DSIC,FILE,FIELD,VALUE)
 .Q
 G OUT
 ;
FIELD(DSIC,FILE,FIELD,FLAG,ATT,TYPE) ; rpc: DSIC FM GET FIELD ATTRIB
 D INIT("FIELD^FILE^FLAG^TYPE")
 D FIELD^DSICFM06(.DSIC,FILE,FIELD,FLAG,.ATT,TYPE)
 Q
 ;
FIELDLST(DSIC,INPUT) ;
 D FIELDLST^DSICFM06(.DSIC,.INPUT)
 Q
 ;
ROOT(DSIC,FILE,IENS,FLAG,FUN) ;
 D INIT("FILE^IENS^FLAG^FUN") D
 .N FUN D ROOT^DSICFM06(.DSIC,FILE,IENS,FLAG)
 .Q
 G OUT
 ;
VFILE(DSIC,FILE,FUN) ; rpc: DSIC FM VERIFY FILE
 D INIT("FILE^FUN") D
 .N FUN D VFILE^DSICFM06(.DSIC,FILE)
 .Q
 G OUT
 ;
VFIELD(DSIC,FILE,FIELD,FUN) ; rpc: DSIC FM VERIFY FIELD
 D INIT("FIELD^FIELD^FUN") D
 .N FUN D VFIELD^DSICFM06(.DSIC,FILE,FIELD)
 .Q
 G OUT
 ;
VIENS(DSIC,IENS,FUN) ;
 D INIT("IENS^FUN") D
 .N FUN D VIENS^DSICFM06(.DSIC,IENS)
 .Q
 G OUT
 ;
 ;--------------------  DSICFM07  --------------------
PULL(DSIC,FILE,FIELD,STRT,MAX,MASK,FUN) ; rpc: DSIC FM PULL LIST
 ; FUN (Reserved) not implemented
 D PULL^DSICFM07(.DSIC,.FILE,.FIELD,.STRT,.MAX,.MASK)
 G OUT
 ;
 ;--------------------  DSICFM08  --------------------
MFILE(DSIC,DSICNPUT,FUN) ; rpc: DSIC FM MULTIPLE FILER
 ; FUN (Reserved) not implemented
 D MFILE^DSICFM08(.DSIC,.DSICNPUT)
 G OUT
 ;
 ;---------------  subroutines  --------------------
INIT(STR) ; list of variable names to initialize
 N I,X
 F I=1:1:$L(STR,U) S X=$P(STR,U,I) I X'="" S @X=$G(@X)
 Q
