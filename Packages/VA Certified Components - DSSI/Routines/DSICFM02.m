DSICFM02 ;DSS/SGM - FILEMAN UTILITES ;01/14/2005 13:26
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#   SUPPORTED
 ; -----   ----------------------------
 ;  2055   VFILE^DILFD
 ;  2052   ^DID: FIELD, GET1
 ;  2051   FIND1^DIC
 ;  2053   UPDATE^DIE
 ;
DINUM(DSIC2,FILE,IEN,VAL,IENS) ; RPC: DSIC FM DINUM
 ;  This will add a entry to a VEJD or DSI* file if the that file
 ;  is configured for DINUMing.
 ;  FILE - required - file number
 ;       Either IEN or VAL must be passed.
 ;       IEN will take precedence if both are passed
 ;   IEN - internal entry number from pointed to file
 ;   VAL - external lookup value for pointed to file
 ;
 ; Return:  DSIC2 = ien if entry is created or already exists,
 ;                  else return -1^error message
 ;
 N X,Y,Z,ATT,DIERR,ERR,FILEX,LOOK,ROOT,DSIC
 I +$G(IEN),IEN=+IEN S LOOK="`"_IEN
 I '$D(LOOK),$G(VAL)]"" S LOOK=VAL
 I '$D(LOOK) S X=1 G ERR
 I '$G(FILE) S X=2 G ERR
 I +FILE'=FILE S X=3 G ERR
 I '$$VFILE^DILFD(FILE) S X=4 G ERR
 S ROOT=$$GET1^DID(FILE,,,"GLOBAL NAME",,"ERR")
 I $G(ROOT)="" S X=5 G ERR
 I $E(LOOK)="`",$D(@(ROOT_"IEN,0)")) S DSIC2=IEN Q
 S ATT="INPUT TRANSFORM;TYPE;POINTER;SPECIFIER"
 D FIELD^DID(FILE,.01,,ATT,"DSIC","ERR")
 I $D(DIERR) S X=6 G ERR
 S Y="" I DSIC("TYPE")'="POINTER" S Y="Not a Pointer field; "
 I DSIC("INPUT TRANSFORM")'["DINUM" S Y=Y_"Not a DINUM field"
 I Y]"" S X=7 G ERR
 S FILEX=+$P(DSIC("SPECIFIER"),"P",2) I 'FILEX S X=8 G ERR
 S Y=$S($E(LOOK)="`":"A",1:"MO")
 S IEN=$$FIND1^DIC(FILEX,,Y,LOOK,,,"ERR")
 S X=0 I IEN'>0!$D(DIERR) S X=9 G ERR
 K ATT,DSIC S DSIC(FILE,"+1,",.01)=IEN,ATT(1)=IEN
 L +@(ROOT_"0)"):3 E  S X=10 G ERR
 D UPDATE^DIE(,"DSIC","ATT","ERR") L -@(ROOT_"0)")
 I $D(DIERR) S X=11 G ERR
 S DSIC2=IEN
 Q
 ;
ERR ;  set error message for single instance RPC
 ;  Expects X to be defined
 N Z I X=1 S Z="No lookup value received"
 I X=2 S Z="No file number received"
 I X=3 S Z="Invalid file number: "_FILE
 I X=4 S Z="File "_FILE_" does not exist"
 I X=5 S Z="Error encountered retrieving file attributes"
 I X=6 S Z="Error encountered retrieving .01 field attributes"
 I X=7 S Z="The .01 field is "_Y
 I X=8 S Z="The .01 field does not have a proper specifier"
 I X=9 S Z="Error encountered looking up "_LOOK_" on file "_FILEX
 I X=10 S Z="Unable to add "_Z_" at this time, try again"
 I X=11 S Z="Error encountered trying to add "_IEN
 S DSIC2="-1^"_$G(Z)
 Q
