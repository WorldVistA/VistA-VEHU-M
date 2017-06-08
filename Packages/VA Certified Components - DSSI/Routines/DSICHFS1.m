DSICHFS1 ;DSS/SGM - HOST FILE UTILITIES ;05/08/2007 15:20
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;THIS ROUTINE IS NOT DIRECTLY INVOKABLE.  SEE DSICHFS ROUTINE
 ;
CLOSE ;  assumes you opened a HFS file using OPEN subroutine
 ;D CLOSE^%ZISH(HANDLE)
 D CLOSE^%ZISUTL(HANDLE)
 I IO]"" U IO
 Q
 ;
DEL ;  delete files
 ; some M implementations will error if you try to delete a file
 ; that does not exist.  Do LIST first.
 N X,Y,Z,NX,DSICIN,DSICOUT
 S X="" F  S X=$O(DSIDEL(X)) Q:X=""  S:X'["*" DSICIN(X)=""
 I $D(DSICIN) D LIST
 I $O(DSICOUT(0))'="" S DSICMSG=$$DEL^%ZISH(PATH,"DSICOUT")
 Q
 ;
DELALL ;  delete all files starting with DSIC
 N DSIDEL S DSIDEL("DSIC*")="" D DEL
 Q
 ;
FTG ;  move HFS file to array DSICHFS
 N I,X,Y,Z,DSICHX
 S DSICHX=$NA(^TMP("DSICHFS-HX",$J)) K @DSICHX
 D FTG2 I +DSICMSG=-1 Q
 ; successfully retrieved file
 I CTRL D STRIP(DSICHX)
 S Z=$TR(DSICHX,")",","),X=DSICHX,I=0
 F  S X=$Q(@X) Q:X'[Z  S I=I+1,@DSICHFS@(I)=@X
 I '$D(@DSICHFS) D FTG1(2),FTG3(0) Q
 D FTG3(1) S DSICMSG=1
 Q
 ;
GET ; open file, run routine, close file, move file
 N X,Y,Z
 ;following for EN1^DIP or any other program that does its own OPEN
 I RTN="EN1^DIP" D RTNDIP
 ;following is for any program that does not do its own OPEN
 I RTN'="EN1^DIP" D RTN
 D Q^DSICHFS0
 I DSICMSG>-1 D FTG I DSICMSG>-1 S DSICMSG=FILE
 Q
 ;
LIST ; get list of files or determine if file exists
 S DSICMSG=$$LIST^%ZISH(PATH,"DSICIN","DSICOUT")
 Q
 ;
OPEN ;  open a HFS file and USE it
 ;Return filename if successfully open file, else return -1
 ;D OPEN^%ZISH("FILEX",PATH,FILE,MODE)
 N X,Y,Z,IOP,POP
 I MODE="W" N DSIDEL S DSIDEL(FILE)="" D DEL
 D IOP
 S Z("HFSNAME")=PATH_FILE,Z("HFSMODE")=MODE
 D OPEN^%ZISUTL(HANDLE,IOP,.Z) I POP D ERR(3) Q
 D USE^%ZISUTL(HANDLE)
 S DSICMSG=FILE
 Q
 ;
STRIP(ROOT) ;  strip control characters from data in ROOT
 N I,X,Y,Z,CTRL,SP,STOP,STR,TAB
 S TAB=$C(9),CTRL="",SP="        "
 F X=0:1:8,10:1:31,127 S CTRL=CTRL_$C(X)
 Q:$G(ROOT)=""
 I ROOT'["(" S STOP=ROOT_"("
 E  S STOP=$E(ROOT,1,$L(ROOT)-1)_","
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  S Z=@ROOT D:Z?.E1C.E
 .S Z=$TR(Z,CTRL) I Z'[TAB S @ROOT=Z Q
 .S STR="" F I=1:1:$L(Z,TAB) S Y=$P(Z,TAB,I) D
 ..S STR=STR_Y,X=$L(STR)#8,STR=STR_$E(SP,1,8-X)
 ..Q
 .S @ROOT=Z
 .Q
 Q
 ;
VER ;  verify that file exists in path
 N DSICIN,DSICOUT
 S DSICIN(FILE)="" D LIST
 I DSICMSG>-1 S DSICMSG=$S($D(DSICOUT(FILE)):1,1:0)
 Q
 ;
 ;--------------- Private Subroutines ---------------
ERR(A) ; error messages
 N X I A=1 S X="Failed to read the file back in: "_FILE
 I A=2 S X="No report generated or unexpected problem encountered"
 I A=3 S X="Unable to open file "_FILE
 I A=4 S X="No filename received"
 I A=5 S X="Expected a file, but file did not exist"
 S DSICMSG="-1^"_X
 Q
 ;
IOP ;
 S IOP="OR WORKSTATION"
 I VRM'=-1 S $P(IOP,";",2)=VRM
 I VPG'=-1 S $P(IOP,";",3)=VPG
 Q
 ;
 ;Isolate the error trap setting to make sure error conditions exit at
 ;the proper STACK level.  If an error occurs inside the D TAG, then
 ;that DO STACK will be popped and the code execution will return to
 ;the module at the point which executed the D TAG command.
 ;DO NOT NEW ANY LOCAL VARIABLES
FTG1(A) D:A ERR(A) S @DSICHFS@(1)=DSICMSG Q
 ;
FTG2 ; +dsicmsg=-1 if fail
 N $ES,$ET,X,DSIECODE
 S DSIECODE=$EC,$EC="",$ETRAP="D ETRAP^DSICHFS1 Q"
 S X=$$VER^DSICHFS(PATH,FILE) I X<0 S DSICMSG=X D FTG1(0),FTG3(0) Q
 I X=0 D FTG1(5),FTG3(0) Q
 I '$$FTG^%ZISH(PATH,FILE,$NA(@DSICHX@(1)),3) D FTG1(1),FTG3(0) Q
 I '$D(@DSICHX) D FTG1(1),FTG3(0)
 S $EC=DSIECODE
 Q
 ;
FTG3(Y) ; check to see if file needs to be deleted
 I ((DEL=2)!(DEL=1&Y)) N DSICMSG,DSIDEL S DSIDEL(FILE)="" D DEL
 K @DSICHX
 Q
 ;
RTN ; run user defined routine
 N $ES,$ET,DSIECODE
 S DSIECODE=$EC,$EC="",$ETRAP="D ETRAP^DSICHFS1 Q"
 D OPEN I DSICMSG>-1 D @RTN I DSICMSG>-1 D CLOSE S $EC=DSIECODE
 Q
 ;
RTNDIP ; run the Fileman print utility
 N $ES,$ET,%ZIS,DSIECODE,IOP,POP
 S DSIECODE=$EC,$EC="",$ETRAP="D ETRAP^DSICHFS1 Q"
 S %ZIS("HFSNAME")=PATH_FILE,%ZIS("HFSMODE")="W"
 D IOP,EN1^DIP I DSICMSG>-1 D ^%ZISC S $EC=DSIECODE
 Q
 ;
 ;--------------- Interactive Modules ---------------
ASK(DIR) ;  DIR prompter
 N I,X,Y,Z,DIROUT,DIRUT,DTOUT,DUOUT
 W ! D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="" S DSICMSG=Y
 Q
 ;
ASKFILE ;  interactive entry to prompt for file name
 N Z S Z(0)="FO^3:80",Z("A")="Enter file name" D ASK(.Z)
 Q
 ;
ASKPATH ;  interactive entry to prompt for path name
 N Z,TMP
 S Z(0)="FO^3:100",Z("A")="Enter directory name or path"
 S Z("A",1)="Format of path name is not verified as valid"
 S Z("A",2)="Examples:  c:\hfs\   SPL$:[SPOOL]"
 S Z("A",3)="",Z("B")=$$PATH
 D ASK(.Z)
 Q
 ;
 ;------------------- ERROR TRAP -------------------
ETRAP ;Error trap
 S X=$$EC^%ZOSV
 S Y=$ECODE
 S Z=$G(FILE)
 S DSICMSG="-1^Error trap: |$ZE|"_X_"|$EC|"_Y_"|FILE|"_Z
 D ^%ZTER
 N %ZIS S %ZIS="0N"
 I $G(RTN)="EN1^DIP" D ^%ZISC
 I $G(HANDLE)'="" D CLOSE
 ; upon error always delete the file
 Q:$G(FILE)=""  Q:$G(PATH)=""
 N DSIDEL S DSIDEL(FILE)="" S X=DSICMSG D DEL S DSICMSG=X
 Q
 ;
 ;--------------- Utilities for DSICHFS ---------------
FILE() ; create a unique filename
 N X S X=$G(TMP("FILE"))
 I X="",'$G(FILEREQ) S X="DSIC"_$$CRC32^XLFCRC($H_"-"_DUZ_"-"_$J)_".txt"
 I X="",$G(FILEREQ) D ERR^DSICHFS(3)
 Q X
 ;
HANDLE() ; get handle name
 N X S X=$G(TMP("HANDLE")) S:X="" X="DSICF"_$P($H,",",2)
 Q X
 ;
PATH() ; get default path
 N X S X=$G(TMP("PATH")) S:X="" X=$$PWD^%ZISH
 Q X
