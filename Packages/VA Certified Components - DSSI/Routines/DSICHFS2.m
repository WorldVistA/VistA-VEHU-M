DSICHFS2 ;DSS/SGM - HOST FILE UTILITIES - CONT ;03/04/2004 15:17
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  This routine is not directly invokable.
 ;  Please use the entry points in the DSICHFS routine.
 ;  This routine should only be invoked from DSICHFS1
 ;  All input parameters are defined in DSICHFS routine
 ;
DIP ;  run routine that issues its own OPEN call (e.g., EN1^DIP)
 N X,Y,Z,%ZIS,IOP
 Q:$G(RTN)=""
 ;N:$G(VRM)="" VRM N:$G(VPG)="" VPG N:$G(FILE)="" FILE N:$G(PATH)="" PATH
 D SET("VRM^VPG^FILE^PATH")
 S %ZIS("HFSNAME")=PATH_FILE,%ZIS("HFSMODE")="W"
 S IOP="OR WORKSTATION;"_VRM_";"_VPG
 D @RTN,^%ZISC
 Q
 ;
GET(DSI) ;  get report from HFS file and return it GUI
 ;  return 1 if successful, else retrun -1^message
 N X,Y,Z,DSIERR,DSIROOT,VAL
 S DSIROOT=$NA(^TMP("DSICHFS1",$J))
 K @DSIROOT
 N $ET,$ES S $ET="D ETRAP^DSICHFS1 Q $G(DSIERR,-1)"
 ;N:'$D(FILE) FILE N:'$D(PATH) PATH N:'$D(DEL) DEL
 D SET("FILE^PATH^DEL")
 S Z("FILE")=FILE,Z("PATH")=PATH
 S VAL=$$FTG^DSICHFS1($NA(^TMP("DSICHFS1",$J,1)),.Z) I VAL<0 Q VAL
 I DEL=2!(DEL=1&VAL) S X=$$DEL^DSICHFS1(PATH,FILE)
 I $G(CTRL) D STRIP^DSICHFS1(DSIROOT)
 M @DSI=@DSIROOT
 I DSI'=DSIROOT K @DSIROOT
 S X=1 S:'$D(@DSI) X="-1^Either no report generated or unexpected problem encountered"
 I X'=1 S @DSI@(1)=X
 Q X
 ;
RUN(PATH,FILE,MODE,VRM,VPG) ;
 ;  open hfs file, run routine to write to file, close hfs file
 ;  return 1 if succesful, else return -1^message
 N X,Y,Z,%ZIS,IOP
 ;N:$G(VRM)="" VRM N:$G(VPG)="" VPG N:$G(FILE)="" FILE N:$G(PATH)="" PATH N:$G(MODE) MODE
 D SET("VRM^VPG^FILE^PATH^MODE")
 I $G(RTN)="" Q "-1^No program received to run [no RTN]"
 S X=$$OPEN^DSICHFS1(PATH,FILE,MODE,VRM,VPG)
 I X=-1 Q "-1^Failed to open file"
 S FILE=X D @RTN,CLOSE^DSICHFS1
 Q 1
 ;
SET(X) ;  initialize any variable just in case not defined
 I X["VRM",'$G(VRM) S VRM=80
 I X["VPG",'$G(VPG) S VPG=66
 I X["FILE",$G(FILE)="" S FILE=$$FILE^DSICHFS1
 I X["PATH",$G(PATH)="" S PATH=$$PATH^DSICHFS1
 I X["MODE",$G(MODE)="" S MODE="W"
 I X["DEL",'$G(DEL) S DEL=2
 Q
