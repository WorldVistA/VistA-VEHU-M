ZZSTFD1 ;HRN/ART ; STS Text File Deployment ; 19-SEP-2008
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
 Q
 ;
CONFIG ; Entry Point to Define Configuration Parameters
 ; Inputs: none
 ; Output: none
 ;May not be used on a production system
 I $$PROD^XUPROD() D  Q
 . W !!,"ERROR: This tool may not be used on a production system."
 . D CONT^ZZSTFDU
 N HDOS,HDHOST,HDHDIR,HDLDIR,HDTDIR,HDFSPEC,HDROOT,HDCKSUM,HDMODE
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 D INIT(HDROOT)
 S HDOS=+$G(@HDROOT@("OS"))
 I 'HDOS D  Q
 . W !!,"ERROR: Only OpenVMS, MS Windows, and Linux operating systems are supported.",!!
 . D CONT^ZZSTFDU
 ;Choose mode of operation
 D GETMODE(HDROOT)
 Q:@HDROOT@("MODE")=""
 D SAVEMODE^ZZSTFDU(HDROOT)
 ;Display parameter values
 W @IOF
 W !,"STS Text File Deployment",!
 W "User Defined Parameters",!!
 D PDISPLAY^ZZSTFDU(HDROOT)
 S DIR(0)="Y"
 S DIR("A")="Do you want to modify any parameters"
 S DIR("B")="NO"
 S DIR("?")="Answer YES to modify any of the configuration parameters."
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 Q:'Y
 W !
 ;Prompt for parameter values
 S (HDHOST,HDHDIR,HDLDIR,HDTDIR,HDFSPEC,HDCKSUM)=""
 S HDMODE=$G(@HDROOT@("MODE"))
 I (HDMODE="R")!(HDMODE="F") D
 . S HDHOST=$$GETHOST(HDROOT)
 . I HDHOST=-1 Q
 . S @HDROOT@("HOST")=HDHOST
 . ;
 . S HDHDIR=$$GETHDIR(HDROOT)
 . I HDHDIR=-1 Q
 . S @HDROOT@("HOST DIR")=HDHDIR
 I (HDHOST=-1)!(HDHDIR=-1) G CFGEXIT
 ;
 S HDLDIR=$$GETLDIR(HDROOT)
 I HDLDIR=-1 G CFGEXIT
 S @HDROOT@("LOCAL DIR")=HDLDIR
 ;
 I (HDMODE="R")!(HDMODE="F") D
 . S HDTDIR=$$GETTDIR(HDROOT)
 . I HDTDIR=-1 Q
 . S @HDROOT@("TEMP DIR")=HDTDIR
 I HDTDIR=-1 G CFGEXIT
 ;
 ;S HDFSPEC=$$GETFLSP(HDROOT)
 ;I HDFSPEC=-1 G CFGEXIT
 ;S @HDROOT@("FILE NAME")=HDFSPEC
 ;
 ;I HDMODE="F" D
 ;. S HDFSPEC=$$GETFOF(HDROOT)
 ;. I HDFSPEC=-1 Q
 ;. S @HDROOT@("FOF FILE")=HDFSPEC
 ;I HDFSPEC=-1 G CFGEXIT
 ;
 I HDMODE="F" D
 . S HDCKSUM=$$GETCKSUM(HDROOT)
 . I HDCKSUM=-1 Q
 . S @HDROOT@("CHECKSUMS")=HDCKSUM
 ;
CFGEXIT ;
 ;Save prarameters in HDIS Parameter File
 D SAVEPARM^ZZSTFDU(HDROOT)
 Q
 ;
INIT(HDROOT) ; Initialization
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDOS,HDOPT
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 ;Load prarameters from HDIS Parameter
 D GETPARM^ZZSTFDU(HDROOT)
 ;Determine OS
 S HDOS=$$OS^%ZOSV()
 S @HDROOT@("OS")=$S(HDOS["VMS":"1-VMS",HDOS["NT":"2-MSW",HDOS["UNIX":"3-LINUX",1:"0-")
 S HDOS=$G(@HDROOT@("OS"))
 ;Define temp file names
 S:+HDOS=1 @HDROOT@("CMD FILE")="HDISFTP.COM"
 S:+HDOS=2 @HDROOT@("CMD FILE")="HDISFTP.TXT"
 S:+HDOS=3 @HDROOT@("CMD FILE")="HDISFTP.TXT"
 ;Define ftp session log file name
 S @HDROOT@("LOG FILE")="HDISFTPLOG.TXT"
 Q
 ;
GETMODE(HDROOT) ; Choose Mode of Operation
 ; >>>>>> NOTE: File of Files Mode is DISABLED <<<<<<<
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S HDOPT=$G(@HDROOT@("MODE"))
 S HDOPT=$S(HDOPT="L":1,HDOPT="R":2,HDOPT="F":3,1:"")
 W @IOF
 W !,"STS Text File Deployment"
 W !,"Select Mode of Operation"
 ;S DIR(0)="S^1:;2:;3:"
 S DIR(0)="S^1:;2:"
 S DIR("A")="  Select an option"
 S DIR("B")=HDOPT
 S DIR("L",1)="    1 - Load local files only (no ftp)"
 S DIR("L")="    2 - Download files from remote server"
 ;S DIR("L")="    3 - Download files from server based on a File of Files"
 S DIR("T")=300
 S DIR("?",1)="  Option 1 assumes that the files to be processed have been downloaded"
 S DIR("?",2)="    to the local test system independently from this tool.  It will"
 S DIR("?",3)="    search a local directory for files to process."
 S DIR("?",4)="  Option 2 will allow downloading files from the ftp server for processing"
 S DIR("?",5)="    on the local test system."
 ;S DIR("?",6)="  Option 3 will use a File of Files located on the ftp server to determine"
 ;S DIR("?",7)="    which files are downloaded for processing on the local test system."
 S DIR("?",8)="  "
 S DIR("?")="  Enter a menu option number."
 D ^DIR
 ;S HDOPT=$S(Y=1:"L",Y=2:"R",Y=3:"F",1:"")
 S HDOPT=$S(Y=1:"L",Y=2:"R",1:"")
 S:($D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))) HDOPT=""
 S @HDROOT@("MODE")=HDOPT
 Q
 ;
GETHOST(HDROOT) ; Get ftp Host Name or IP Address
 ; Inputs: HDROOT - Configuration global root
 ; Output: Host Name or IP Address
 N HDHOST
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="   Ftp Server Name or IP Address: "
 S DIR("B")=$G(@HDROOT@("HOST"))
 S DIR("?",1)="   The name or IP address of the remote ftp server where the HL7 text"
 S DIR("?")="   files are stored."
 D ^DIR
 S HDHOST=$$UP^XLFSTR(Y)
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDHOST=-1
 Q HDHOST
 ;
GETHDIR(HDROOT) ; Get ftp Server Directory Name
 ; Inputs: HDROOT - Configuration global root
 ; Output: Host Directory Name
 N HDDIR
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="   Ftp Server Directory Name: "
 S DIR("B")=$G(@HDROOT@("HOST DIR"))
 ;S DIR("T")=60
 S DIR("?",1)="   The name of the directory on the remote ftp server where the HL7"
 S DIR("?")="   text files are stored."
 D ^DIR
 S HDDIR=Y
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDDIR=-1
 Q HDDIR
 ;
GETLDIR(HDROOT) ; Get Local Directory Name
 ; Inputs: HDROOT - Configuration global root
 ; Output: Local Directory Name
 N HDDIR
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="   Local Directory Name: "
 S DIR("B")=$G(@HDROOT@("LOCAL DIR"))
 S DIR("?",1)="   The name of the directory on the local system where the HL7"
 S DIR("?",2)="   text files are stored."
 S DIR("?")="   Please ensure a valid, existing directory name is used."
 D ^DIR
 S HDDIR=$$CHKDIRNM^ZZSTFDU(HDROOT,Y)
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDDIR=-1
 Q HDDIR
 ;
GETTDIR(HDROOT) ; Get Temp Directory Name
 ; Inputs: HDROOT - Configuration global root
 ; Output: Temp Directory Name
 N HDDIR
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="   Temporary Directory Name: "
 S DIR("B")=$G(@HDROOT@("TEMP DIR"))
 S DIR("?",1)="   The name of the directory on the local system where"
 S DIR("?",2)="   temporary files are stored."
 S DIR("?")="   Please ensure a valid, existing directory name is used."
 D ^DIR
 S HDDIR=$$CHKDIRNM^ZZSTFDU(HDROOT,Y)
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDDIR=-1
 Q HDDIR
 ;
GETFLSP(HDROOT) ; Get File Name Root
 ; Inputs: HDROOT - Configuration global root
 ; Output: File Name Root
 N HDFSPEC
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="   File Name Root: "
 S DIR("B")=$G(@HDROOT@("FILE NAME"))
 S DIR("?")="   The file name prefix used for the HL7 text file names."
 D ^DIR
 S HDFSPEC=$$UP^XLFSTR(Y)
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDFSPEC=-1
 Q HDFSPEC
 ;
GETFOF(HDROOT) ; Get File of Files Name
 ; Inputs: HDROOT - Configuration global root
 ; Output: File of Files Name
 N HDFSPEC
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="   File of Files Name: "
 I $G(@HDROOT@("FOF FILE"))'="" D
 . S DIR("B")=@HDROOT@("FOF FILE")
 E  D
 . S DIR("B")="TFDFILEOFFILES.TXT"
 S DIR("?")="   The name of the file containing a list of HL7 text files on the ftp server."
 D ^DIR
 S HDFSPEC=$$UP^XLFSTR(Y)
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDFSPEC=-1
 Q HDFSPEC
 ;
GETCKSUM(HDROOT) ; Get Checksum Processing Flag
 ; Inputs: HDROOT - Configuration global root
 ; Output: Checksum Processing Flag
 N HDCKSUM
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA"
 S DIR("A")="   Turn on checksum processing: "
 S DIR("B")=$S($G(@HDROOT@("CHECKSUMS"))=1:"YES",$G(@HDROOT@("CHECKSUMS"))=0:"NO",1:"")
 S DIR("?",1)="   Answer YES to perform checksum processing,"
 S DIR("?")="           NO to omit checksum processing."
 D ^DIR
 S HDCKSUM=Y
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDCKSUM=-1
 Q HDCKSUM
 ;
GETUID() ; Get FTP User ID
 ; Inputs: none
 ; Output: ftp User ID or null
 N HDUID
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FA"
 S DIR("A")="FTP User ID: "
 S DIR("B")="anonymous"
 S DIR("?")="Enter the FTP User ID."
 D ^DIR
 S HDUID=Y
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) D
 . S HDUID=""
 Q HDUID
 ;
GETPWD(HDUID) ; Get FTP Password
 ; Inputs: HDUID - ftp User ID
 ; Output: ftp Password
 ; Note: maximum VMS password is 32 characters - a-z, A-Z, 0-9, _, $
 N HDEOFF,HDEON,HDPWD
 I $$LOW^XLFSTR(HDUID)="anonymous" D  Q HDPWD
 . N XMDUZ,XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 . D INIT^XMVVITAE
 . S HDPWD=$TR($E(XMV("NETNAME"),1,32),".@-","___")
 S HDEOFF=^%ZOSF("EOFF")
 S HDEON=^%ZOSF("EON")
 X HDEOFF
 W !,"FTP Password: "
 S HDPWD=$$ACCEPT^XUS() ;ICR 5510
 X HDEON
 I HDPWD["^"!('$L(HDPWD)) S HDPWD="" Q HDPWD
 ;S HDPWD=$$UP^XLFSTR(HDPWD)
 Q HDPWD
 ;
