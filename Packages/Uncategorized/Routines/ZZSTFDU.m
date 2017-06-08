ZZSTFDU ;HRN/ART ; STS Text File Deployment ; 25-SEP-2008
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 Q
 ; Common sub-routines and functions
 ;
MENU ; Menu for Common Sub-routines and Functions
 ; Inputs: none
 ; Output: none
 N HDROOT,HDOPT
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 D INIT^ZZSTFD1(HDROOT)
 ; Display Menu and Get Option
 S HDOPT=1
 F  Q:HDOPT=""  D
 .W @IOF
 .W !,"STS Text File Deployment"
 .W !,"Dev/Test Utilities"
 .S DIR(0)="SO^1:;2:;3:;4:;5:;6:;7:;8:;9:;10:"
 .S DIR("A")="  Select an option"
 .S DIR("L",1)="    1 - Display all configuration parameters"
 .S DIR("L",2)="    2 - Delete configuration parameters"
 .S DIR("L",3)="    3 - Clear tracking file flags"
 .S DIR("L",4)="    4 - Delete all tracking file records"
 .S DIR("L",5)="    5 - Update tracking file records (roll & scroll)"
 .S DIR("L",6)="    6 - Update tracking file records (Screenman)"
 .S DIR("L",7)="    7 - Delete all downloaded HL7 files"
 .S DIR("L",8)="    8 - Delete ftp session log files"
 .S DIR("L",9)="    9 - Update HL7 File Name Prefix"
 .S DIR("L")="   10 - Update File of Files File Name"
 .S DIR("T")=300
 .S DIR("?")="  Enter a menu option number."
 .D ^DIR
 .S HDOPT=Y
 .S:($D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))) HDOPT=""
 .W !
 .D:HDOPT=1 ALLPARAM(HDROOT),CONT
 .D:HDOPT=2 DELPARAM
 .D:HDOPT=3 CLRFLAGS
 .D:HDOPT=4 CLRFILE
 .D:HDOPT=5 UPDATE1
 .D:HDOPT=6 UPDATE2
 .D:HDOPT=7 P2^ZZSTFDA(HDROOT)
 .D:HDOPT=8 P3^ZZSTFDA(HDROOT)
 .D:HDOPT=9 FNMPRFX()
 .D:HDOPT=10 FOFNAME()
 W @IOF
 Q
 ;
PARAMCK(HDROOT) ;Check Required Parameters
 ; Determine if required parameters have been defined.
 ; Inputs: HDROOT - Configuration global root
 ; Output: 1 if parameters are defined
 ;         0 if a parameter is missing
 N HDRET,HDMODE
 S HDRET=1
 S HDMODE=$G(@HDROOT@("MODE"))
 S:(HDMODE="") HDRET=0
 S:($G(@HDROOT@("OS"))="") HDRET=0
 S:($G(@HDROOT@("LOCAL DIR"))="") HDRET=0
 S:($G(@HDROOT@("FILE NAME"))="") HDRET=0
 I (HDMODE="R")!(HDMODE="F") D
 . S:($G(@HDROOT@("HOST"))="") HDRET=0
 . S:($G(@HDROOT@("HOST DIR"))="") HDRET=0
 . S:($G(@HDROOT@("TEMP DIR"))="") HDRET=0
 I HDMODE="F" D
 . S:($G(@HDROOT@("FOF FILE"))="") HDRET=0
 . S:($G(@HDROOT@("CHECKSUMS"))="") HDRET=0
 I 'HDRET D
 . W !!,"ERROR: One or more required parameters are not defined.",!
 . W "       Choose the DEF Menu Option to define configuration parameters.",!!
 . D PDISPLAY(HDROOT)
 . D CONT
 Q HDRET
 ;
PDISPLAY(HDROOT) ;Display Parameter Values
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDMODE
 S HDMODE=$G(@HDROOT@("MODE"))
 W $S(HDMODE="L":"Local File",HDMODE="R":"Remote File",HDMODE="F":"File of Files",1:"?")," Mode",!!
 I (HDMODE="R")!(HDMODE="F") D
 . W "   Ftp Server Name:      ",$G(@HDROOT@("HOST")),!
 . W "   Ftp Server Directory: ",$G(@HDROOT@("HOST DIR")),!
 W "   Local Directory:      ",$G(@HDROOT@("LOCAL DIR")),!
 I (HDMODE="R")!(HDMODE="F") D
 . W "   Temp Directory:       ",$G(@HDROOT@("TEMP DIR")),!
 W "   File Name Root:       ",$G(@HDROOT@("FILE NAME")),!
 I HDMODE="F" D
 . W "   File of Files:        ",$G(@HDROOT@("FOF FILE")),!
 . W "   Checksums:            ",$S($G(@HDROOT@("CHECKSUMS"))=1:"YES",$G(@HDROOT@("CHECKSUMS"))=0:"NO",1:""),!
 Q
 ;
GETPARM(HDROOT) ; Get parameters from HDIS Parameter File
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDIENS
 S HDIENS="1,"
 S @HDROOT@("MODE")=$$GET1^DIQ(7118.29,HDIENS,61,"I")
 S @HDROOT@("LOCAL DIR")=$$GET1^DIQ(7118.29,HDIENS,62,"I")
 S @HDROOT@("FILE NAME")=$$GET1^DIQ(7118.29,HDIENS,63,"I")
 S @HDROOT@("HOST")=$$GET1^DIQ(7118.29,HDIENS,64,"I")
 S @HDROOT@("HOST DIR")=$$GET1^DIQ(7118.29,HDIENS,65,"I")
 S @HDROOT@("TEMP DIR")=$$GET1^DIQ(7118.29,HDIENS,66,"I")
 S @HDROOT@("FOF FILE")=$$GET1^DIQ(7118.29,HDIENS,67,"I")
 S @HDROOT@("CHECKSUMS")=$$GET1^DIQ(7118.29,HDIENS,68,"I")
 Q
 ;
SAVEMODE(HDROOT) ; Save parameters in HDIS Parameter File
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDIENS,HDFDA,HDEMSG
 S HDIENS="1,"
 S HDFDA(7118.29,HDIENS,61)=$G(@HDROOT@("MODE"))
 D FILE^DIE("","HDFDA","HDEMSG")
 Q
 ;
SAVEPARM(HDROOT) ; Save parameters in HDIS Parameter File
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDIENS,HDFDA,HDEMSG
 S HDIENS="1,"
 ;S HDFDA(7118.29,HDIENS,61)=$G(@HDROOT@("MODE"))
 S HDFDA(7118.29,HDIENS,62)=$G(@HDROOT@("LOCAL DIR"))
 ;S HDFDA(7118.29,HDIENS,63)=$G(@HDROOT@("FILE NAME"))
 S HDFDA(7118.29,HDIENS,64)=$G(@HDROOT@("HOST"))
 S HDFDA(7118.29,HDIENS,65)=$G(@HDROOT@("HOST DIR"))
 S HDFDA(7118.29,HDIENS,66)=$G(@HDROOT@("TEMP DIR"))
 ;S HDFDA(7118.29,HDIENS,67)=$G(@HDROOT@("FOF FILE"))
 S HDFDA(7118.29,HDIENS,68)=$G(@HDROOT@("CHECKSUMS"))
 D FILE^DIE("","HDFDA","HDEMSG")
 Q
 ;
FILETYPE(HDROOT) ; Determine File of Files Type
 ; Inputs: HDROOT - Configuration global root
 ; Output: X=XML
 ;         D=Delimited
 ;         null=undetermined
 N HDTMPDIR,HDFNAME,HDREC,HDRET
 S HDRET=""
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDFNAME=$G(@HDROOT@("FOF FILE"))
 I $$OPEN^ZZSTFDU("FILE",HDTMPDIR,HDFNAME,"R") D
 . U IO
 . R HDREC:DTIME
 . I $E(HDREC,1,5)="<?xml" D
 . . S HDRET="X"
 . E  D
 . . S HDRET="D"
 . D CLOSE^ZZSTFDU("FILE")
 Q HDRET
 ;
FINDFILE(HDFILE) ; Get a File Name from Tracking File Using B X-ref
 ; Inputs: HDFILE - File name
 ; Output: HDIEN - File IEN
 N HDIEN,HDHIT
 S HDHIT=0
 S HDIEN=""
 F  Q:HDHIT  S HDIEN=$O(^HDISF(7118.27,"B",$E(HDFILE,1,30),HDIEN)) Q:HDIEN=""  D
 . I HDFILE=$$GET1^DIQ(7118.27,HDIEN_",",.01,"I") S HDHIT=1
 Q HDIEN
 ;
CHECKLOG(HDTMPDIR,HDLOGFIL) ;Check ftp Session Log File for Errors
 ; Inputs: HDTMPDIR - Directory name
 ;         HDLOGFIL - File name
 ; Output: 1 = no error found
 ;         0 = error found
 N HDREC,HDERR
 S HDERR=1
 I $$OPEN("FILE",HDTMPDIR,HDLOGFIL,"R") D
 . F  Q:$$EOF  U IO R HDREC:DTIME D
 . . Q:HDREC=""
 . . S:HDREC["%DCL-W" HDERR=0
 . . S:HDREC["%DCL-E" HDERR=0
 . . S:HDREC["%CLI-W" HDERR=0
 . . S:HDREC["%TCPIP-E-FTP_LOGREJ" HDERR=0
 . . S:HDREC["550 file not found" HDERR=0
 . . S:HDREC["550-Failed to open" HDERR=0
 . . S:HDREC["File not found" HDERR=0
 . . S:HDREC["425 Not logged in" HDERR=0
 . . S:HDREC["Invalid command" HDERR=0
 . . ;S:HDREC["%PURGE-W" HDERR=0 ;could not find the file to purge
 . D CLOSE("FILE")
 E  D
 . S HDERR=0
 Q HDERR
 ;
DISPLOG(HDDIR,HDFILE) ;Display ftp Log
 ; Inputs: HDDIR - Directory name
 ;         HDFILE - File name
 ; Output: none
 N HDDCNT,HDREC
 S HDDCNT=0
 I $$OPEN("FILE",HDDIR,HDFILE,"R") D
 . F  Q:$$EOF  U IO R HDREC:DTIME D
 . . Q:HDREC=""
 . . U 0 W !,HDREC
 . . S HDDCNT=HDDCNT+1
 . . I HDDCNT>18 D
 . . . S HDDCNT=0
 . . . D CONT
 . D CLOSE("FILE")
 Q
 ;
CHKDIRNM(HDROOT,HDDIR) ; Append Missing Directory Name Terminator
 ; Inputs: HDROOT - Configuration global root
 ;         HDDIR - Directory name
 ; Output: HDDIR - Directory name
 Q:$L(HDDIR)=0 HDDIR
 N HDOS
 S HDOS=$G(@HDROOT@("OS"))
 Q:+HDOS=1 HDDIR
 I +HDOS=2 D  ;MS Windows
 . I $E(HDDIR,$L(HDDIR))'="\" D
 . . S HDDIR=HDDIR_"\"
 I +HDOS=3 D  ;Linux
 . I $E(HDDIR,$L(HDDIR))'="/" D
 . . S HDDIR=HDDIR_"/"
 Q HDDIR
 ;
OPEN(HDFILE,HDDIR,HDFILENM,HDMODE) ;Open a File
 ; Inputs - HDFILE - File tag to open
 ;          HDDIR - Host File Directory Name
 ;          HDFILENM - File Name
 ;          HDMODE - Open mode - R=Read, W=Write, A=Append
 ; Output - 1 if file was opened
 ;          0 if not opened
 ;          IO - opened device designator
 ;
 N POP
 D OPEN^%ZISH(HDFILE,HDDIR,HDFILENM,HDMODE)
 I POP D  Q 0
 . U 0
 . W !,"ERROR: Could not open the file: ",HDDIR,HDFILENM,!
 . W "       Ensure the directory name is valid.",!
 . D CONT
 Q 1
 ;
CLOSE(HDFILE) ;Close a File
 ; Input  - HDFILE - File tag to close
 ; Output - none
 ;
 D CLOSE^%ZISH(HDFILE)
 Q
 ;
EOF() ;Test for EOF
 ; Input  - none
 ; Output - 1 if end of file has been reached
 ;
 Q $$STATUS^%ZISH
 ;
HLON(HDLINE) ;Turn on Highlight for a Line - VA List Manager
 ; Inputs: HDLINE - line number
 ; Output: none
 D SELECT^VALM10(HDLINE,1)
 S @VALMAR@(HDLINE,0)=$$SETSTR^VALM1("*",@VALMAR@(HDLINE,0),1,1)
 D WRITE^VALM10(HDLINE)
 Q
 ;
HLOFF(HDLINE) ;Turn off Highlight for a Line - VA List Manager
 ; Inputs: HDLINE - line number
 ; Output: none
 D SELECT^VALM10(HDLINE,0)
 S @VALMAR@(HDLINE,0)=$$SETSTR^VALM1(" ",@VALMAR@(HDLINE,0),1,1)
 D WRITE^VALM10(HDLINE)
 Q
 ;
SURE() ;Prompts: Are you sure?
 ; Inputs: none
 ; Output: 1=yes
 ;         0=no
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y"
 S DIR("A")="Are you sure"
 S DIR("B")="NO"
 S DIR("?")="Answer YES or NO."
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S VALMBCK="R" Q 0
 Q Y
 ;
CONT ;Continue Prompt
 ; Inputs: none
 ; Output: none
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="FO^1:1"
 S DIR("A")="Press return to continue"
 S DIR("?")="Press return to continue."
 D ^DIR
 Q
 ;
TRIM(INSTR,MODE) ; Remove Leading and/or Trailing Spaces from a String
 ; Inputs: INSTR - a string
 ;         MODE  - L=Left, R=Right, B=Both, defaults to B
 ; Output: trimmed string
 N OUTSTR,STOP
 S:$G(MODE)="" MODE="B"
 S OUTSTR=INSTR
 S STOP=0
 F  Q:STOP  D
 . I ((MODE="L")!(MODE="B")),$E(OUTSTR,1)=" " S OUTSTR=$E(OUTSTR,2,$L(OUTSTR)) Q
 . I ((MODE="R")!(MODE="B")),$E(OUTSTR,$L(OUTSTR))=" " S OUTSTR=$E(OUTSTR,1,$L(OUTSTR)-1) Q
 . S STOP=1
 Q OUTSTR
 ;
FILENAME(HDFNAME) ; Add a Date/Time Stamp to a File Name
 ; Inputs: HDFNAME - base file name
 ; Output: unique file name
 N HDNOW,HDTAG,HDFN1,HDFN2,HDFNAMEO
 S HDNOW=$TR($$NOW^XLFDT(),".","")
 S HDTAG=$E(HDNOW_"000000",1,13)_"."
 S HDFN1=$P(HDFNAME,".",1)
 S HDFN2=$P(HDFNAME,".",2)
 S HDFN2=$S(HDFN2'="":HDFN2,1:"TXT")
 S HDFNAMEO=HDFN1_HDTAG_HDFN2
 Q HDFNAMEO
 ;
DELPARAM ;Delete All Parameters
 ; Inputs: none
 ; Output: none
 W !,"Delete All Parameters"
 Q:'$$SURE
 N HDIENS,HDFDA,HDEMSG
 S HDIENS="1,"
 ;S HDFDA(7118.29,HDIENS,61)=$G(@HDROOT@("MODE"))
 S HDFDA(7118.29,HDIENS,62)="@"
 ;S HDFDA(7118.29,HDIENS,63)=$G(@HDROOT@("FILE NAME"))
 S HDFDA(7118.29,HDIENS,64)="@"
 S HDFDA(7118.29,HDIENS,65)="@"
 S HDFDA(7118.29,HDIENS,66)="@"
 ;S HDFDA(7118.29,HDIENS,67)=$G(@HDROOT@("FOF FILE"))
 S HDFDA(7118.29,HDIENS,68)="@"
 D FILE^DIE("","HDFDA","HDEMSG")
 Q
 ;
ALLPARAM(HDROOT) ;List All Parameters
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDPARAM
 D GETPARM(HDROOT)
 W @IOF
 W !,"STS Text File Deployment",!
 W "Configuration Parameters",!!
 S HDPARAM=""
 F  S HDPARAM=$O(@HDROOT@(HDPARAM)) Q:HDPARAM=""  D
 . W ?3,HDPARAM,?13,"= ",@HDROOT@(HDPARAM),!
 Q
 ;
CLRFILE ;Delete All Tracking File Records
 ; Inputs: none
 ; Output: none
 W !,"Delete All Tracking File Records"
 Q:'$$SURE
 K ^HDISF(7118.27)
 S ^HDISF(7118.27,0)="HDIS TEXT FILE DEPLOYMENT TRACKING^7118.27^0^0"
 Q
 ;
CLRFLAGS ;Clear Tracking File - All Flags
 ; Inputs: none
 ; Output: none
 W !,"Clear Tracking File Flags"
 Q:'$$SURE
 N HDIDX,HDIENS,HDFDA,HDEMSG
 S HDIDX=0
 ;Set flag values to NO
 F  S HDIDX=$O(^HDISF(7118.27,HDIDX)) Q:'HDIDX  D
 . S HDIENS=HDIDX_","
 . S HDFDA(7118.27,HDIENS,4)=0
 . S HDFDA(7118.27,HDIENS,5)=0
 . S HDFDA(7118.27,HDIENS,6)=""
 . D FILE^DIE("","HDFDA","HDEMSG")
 D CLEAN^DILF
 Q
 ;
CLRDLFLG ;Clear Tracking File - Download Flag
 ; Inputs: none
 ; Output: none
 N HDIDX,HDIENS,HDFDA,HDEMSG
 S HDIDX=0
 F  S HDIDX=$O(^HDISF(7118.27,HDIDX)) Q:'HDIDX  D
 . S HDIENS=HDIDX_","
 . S HDFDA(7118.27,HDIENS,5)=0
 . D FILE^DIE("","HDFDA","HDEMSG")
 D CLEAN^DILF
 Q
 ;
UPDATE1 ;Modify Tracking File Records (roll & scroll)
 ; Inputs: none
 ; Output: none
 N DIC,DIE,DIR,DA,DR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 N HDIEN,HDFILE,HDQUIT
 U 0
 W @IOF
 W !,"STS Text File Deployment",!
 W "Update Tracking File Records",!
 S DIR(0)="Y"
 S DIR("A")="Update all records"
 S DIR("B")="NO"
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 I 'Y D
 . S HDQUIT=0
 . F  Q:HDQUIT  D
 . . S DIC=7118.27
 . . S DIC(0)="AEMQ"
 . . D ^DIC
 . . I ((+Y<0)!$D(DTOUT)!$D(DUOUT)) S HDQUIT=1 Q
 . . S DIE=7118.27
 . . S DA=+Y
 . . S DR=".01:6"
 . . D ^DIE
 . . W !
 . . S DIR(0)="Y"
 . . S DIR("A")="Update another"
 . . S DIR("B")="YES"
 . . D ^DIR
 . . S:'Y HDQUIT=1
 . . S:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) HDQUIT=1
 E  D
 . K Y
 . S DIE=7118.27
 . S DR=".01:6"
 . S HDIEN=0
 . F  S HDIEN=$O(^HDISF(7118.27,HDIEN)) Q:('HDIEN)!$D(Y)  D
 . . S DA=HDIEN
 . . S HDFILE=$$GET1^DIQ(7118.27,HDIEN_",",.01,"I")
 . . W !!,"File Name: ",HDFILE
 . . D ^DIE
 Q
 ;
UPDATE2 ;Modify Tracking File Records (Screenman)
 ; Inputs: none
 ; Output: none
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 N DIC,DR,DA,DDSPARM,DDSFILE,DDSPAGE
 N HDQUIT,HDIEN
 U 0
 W @IOF
 W !,"STS Text File Deployment",!
 W "Update Tracking File Records",!
 S DIR(0)="Y"
 S DIR("A")="Update all records"
 S DIR("B")="NO"
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 I 'Y D
 . S HDQUIT=0
 . F  Q:HDQUIT  D
 . . S DIC=7118.27
 . . S DIC(0)="AEMQ"
 . . D ^DIC
 . . I ((+Y<0)!$D(DTOUT)!$D(DUOUT)) S HDQUIT=1 Q
 . . S DA=+Y
 . . S DDSFILE=7118.27
 . . S DR="[HDIS TFD EDIT 1]"
 . . S DDSPAGE=1
 . . D ^DDS
 . . W @IOF
 . . W !,"STS Text File Deployment",!
 . . W "Update Tracking File Records",!
 . . S DIR(0)="Y"
 . . S DIR("A")="Update another"
 . . S DIR("B")="YES"
 . . D ^DIR
 . . S:'Y HDQUIT=1
 . . S:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) HDQUIT=1
 E  D
 . S HDIEN=0
 . F  S HDIEN=$O(^HDISF(7118.27,HDIEN)) Q:'HDIEN  D
 . . S DA=HDIEN
 . . S DDSFILE=7118.27
 . . S DR="[HDIS TFD EDIT 1]"
 . . S DDSPAGE=1
 . . D ^DDS
 Q
 ;
FNMPRFX(HDNAME) ;Update HL7 File Name Prefix in HDIS Parameter File
 ; Inputs: HDNAME - file name prefix
 ; Output: none
 N DIE,DA,DR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 I $G(HDNAME)="" D
 . U 0
 . W @IOF
 . W !,"STS Text File Deployment",!
 . W "Update HL7 File Name Prefix",!
 . S DR=63
 E  D
 . S DR="63///"_HDNAME
 S DIE=7118.29
 S DA=1
 D ^DIE
 Q
 ;
FOFNAME(HDNAME) ;Update File of Files File Name in HDIS Parameter File
 ; Inputs: HDNAME - File of Files File Name
 ; Output: none
 N DIE,DA,DR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 I $G(HDNAME)="" D
 . U 0
 . W @IOF
 . W !,"STS Text File Deployment",!
 . W "Update File of Files File Name",!
 . S DR=67
 E  D
 . S DR="67///"_HDNAME
 S DIE=7118.29
 S DA=1
 D ^DIE
 Q
 ;
