DSICDDBR ;DSS/SGM - UTILITY USING FM BROWSER ;23 Apr 2008 22:30
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this utility is for terminal mode only, not for RPCs
 ;
 ;  DBIA#  Supported  Description
 ;  -----  ---------  ----------------------------------
 ;   2198      x      $$BROKER^XWBLIB
 ;   2051      x      $$FIND1^DIC
 ;   2055      x      DILFD: VFILE,VFIELD, $$ROOT
 ;   2056      x      $$GET1^DIQ
 ;   2607      x      BROWSE^DDBR
 ;  10005      x      DT^DICRW
 ;  10086      x      HOME^%ZIS,%ZIS
 ;  10089      x      %ZISC
 ;
BROWSE(SOURCE,TITLE,OUT) ;
 ;   TITLE - optional - text centered on Browser screen title line
 ;     OUT - optional - default to B
 ;           if B then display text in Fileman Browser window
 ;           if T then display text on terminal window with
 ;              no press return to continue prompts
 ;  SOURCE - required - either
 ;           1. closed root form of array containing the text 
 ;           2. string in format p1;p2;p3;p4
 ;              p1 = required - file (or subfile #)
 ;              p2 = required - word processing field # that
 ;                   contains the text to be displayed
 ;              p3 = name or look up value
 ;              p4 = iens for that file or subfile
 ;              NOTE: either p3 or p4 must have a value
 ;
 Q:$$BROKER^XWBLIB
 N I,J,X,Y,Z,DIERR,DSIERR,TEXT
 S OUT=$E($G(OUT))
 S OUT=$S(OUT="":"","Bb"[OUT:1,"Tt"[OUT:0,1:"")
 S TITLE=$G(TITLE)
 I $G(SOURCE)="" W !!,"No source received",!! Q
 I SOURCE[";" D RESOLVE Q:'$D(SOURCE)
 I OUT="" S OUT=$$OUT Q:OUT<0
 I OUT=1 D BROWSE^DDBR(SOURCE,"N",TITLE) Q
 I OUT=2 D DT^DICRW,HOME^%ZIS W @IOF
 I OUT=3 U IO
 S I=0 F  S I=$O(@SOURCE@(I)) Q:'I  D
 .W !,$S($D(@SOURCE@(I))#2:@SOURCE@(I),1:$G(@SOURCE@(I,0)))
 .Q
 D ^%ZISC
 Q
 ;
OUT() ;  ask for which output
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="SO^1:Fileman Browser;2:Terminal;3:HFS Device"
 S DIR("A")="Select display mode",DIR("B")=1
 S DIR("?",1)="Enter 1 to display the text in Fileman's Browser"
 S DIR("?",2)="Enter 2 to display the text on the screen"
 S DIR("?",3)="Enter 3 to send to a HFS file"
 S DIR("?")="   "
 W ! D ^DIR I Y=""!$D(DTOUT)!$D(DUOUT) S Y=-1
 I Y<3 Q Y
 W !!,"Select your HFS Device File name",!!
 N %ZIS,POP
 S %ZIS("B")="HFS" D ^%ZIS S DIR=$S('POP:3,1:-1) D:POP ^%ZISC
 Q DIR
 ;
RESOLVE ;  resolve input into a source array
 N X,Y,DIERR,DSIC,DSIERR,FILE,FLD,GLB,IENS,NAME,SPEC
 S FILE=$P(SOURCE,";"),FLD=$P(SOURCE,";",2),NAME=$P(SOURCE,";",3)
 S IENS=$P(SOURCE,";",4)
 K SOURCE
 I FILE'=+FILE W !!,"No file number received",!! Q
 I FLD'=+FLD W !!,"No field number received",!! Q
 I '$$VFILE^DILFD(FILE) W !!,FILE_" does not exist",!! Q
 I '$$VFIELD^DILFD(FILE,FLD) W !!,FLD_" does not exist in "_FILE,!! Q
 S SPEC=$$GET1^DID(FILE,FLD,,"SPECIFIER",,"DSIERR")
 I $D(DSIERR)!$D(DIERR) W !!,$$MSG^DSICFM01("VE",,,,"DSIERR"),!! Q
 S GLB=$$GET1^DID(FILE,FLD,,"GLOBAL SUBSCRIPT LOCATION",,"DSIERR")
 I $D(DSIERR)!$D(DIERR) W !!,$$MSG^DSICFM01("VE",,,,"DSIERR"),!! Q
 S DSIC=$NA(^DD(FILE,FLD))_" is not a word processing field"
 I $P(GLB,";",2) W !!,DSIC,!! Q
 S SPEC=$$GET1^DID(SPEC,.01,,"SPECIFIER",,"DSIERR")
 I SPEC'["W" W !!,DSIC,!! Q
 I NAME'="" D  Q:'$D(IENS)
 .K DIERR,DSIERR
 .S X=$$FIND1^DIC(FILE,IENS,"AMO",NAME,,,"DSIERR")
 .I X>0 S IENS=X_IENS Q
 .K IENS W !!
 .I '$D(DIERR) W "Did not find "_NAME,!!
 .E  W $$MSG^DSICFM01("VE",,,,"DSIERR"),!!
 .Q
 S SOURCE=$$ROOT^DILFD(FILE)_(+IENS)_","_(+GLB)_")"
 Q:TITLE'=""  I FILE'=9.2 S FLD=.01
 S X=$$GET1^DIQ(FILE,IENS,FLD,,,"DSIERR")
 I $L(X),'$D(DIERR) S TITLE=X
 Q
