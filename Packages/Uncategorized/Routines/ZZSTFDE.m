ZZSTFDE ;HRN/ART ; STS Text File Deployment ; 29-JAN-2009
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 Q
 ;
EN(HDROOT,HDOPT) ; Main Entry Point for Local and Remote Modes
 ; Inputs: HDROOT - Configuration global root
 ;         HDOPT  - Location of files
 ;                  1 = local
 ;                  2 = remote
 ; Output: none
 Q:HDROOT=""
 Q:HDOPT=""
 D:HDOPT=1 LOCAL(HDROOT)
 D:HDOPT=2 REMOTE(HDROOT)
 ;Update tracking file with file names
 D TRACKUPD(HDROOT,HDOPT)
 ;Display tracking file
 D EN^ZZSTFDB
 Q
 ;
LOCAL(HDROOT) ; Get a List of Local Files
 ; Store list of file names in ^TMP("HDISTFD",$J,"FLIST"
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDFILENM,HDFLIST,HDLOCDIR,HDTEMP,HDFILE
 ;Clear download flag in tracking file
 D CLRDLFLG^ZZSTFDU
 ;Get local file list
 S HDLOCDIR=$G(@HDROOT@("LOCAL DIR"))
 S HDFILENM=$P($G(@HDROOT@("FILE NAME")),".",1)
 S HDTEMP(HDFILENM_"*.*")=""
 I $$LIST^%ZISH(HDLOCDIR,"HDTEMP","HDFLIST") D
 . S HDFILE=""
 . F  S HDFILE=$O(HDFLIST(HDFILE)) Q:HDFILE=""  D
 . . S ^TMP("HDISTFD",$J,"FLIST",$P(HDFILE,";",1))=""
 E  D
 . W !,"WARNING: No files were found in the local directory - ",HDLOCDIR,!
 . W "         Ensure the directory name is valid.",!
 . D CONT^ZZSTFDU
 Q
 ;
REMOTE(HDROOT) ;Download List of Files from Remote Server
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDOS,HDRET,HDTMPDIR,HDCMDFIL,HDCFILE,HDLOGFIL,HDLOGCK
 N HDFILENM,HDFLIST,HDLOCDIR,HDTEMP,HDFILE
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S HDOS=$G(@HDROOT@("OS"))
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDCMDFIL=$G(@HDROOT@("CMD FILE"))
 S HDLOGFIL=$$FILENAME^ZZSTFDU($G(@HDROOT@("LOG FILE")))
 ;Get list of files from ftp server
 U 0
 W !!,"Download list of HL7 files from remote ftp server."
 ;Create ftp command file
 S HDRET=$$CR8CMD(HDROOT)
 Q:'HDRET
 U 0 W !
 ;Execute ftp command file
 W "Downloading list of files.",!
 S HDRET=-1
 ; If VMS, execute DCL command file
 S:+HDOS=1 HDRET=$ZF(-1,"@"_HDTMPDIR_HDCMDFIL,HDTMPDIR_HDLOGFIL)
 ; If MS Windows, execute ftp command with redirected input
 S:+HDOS=2 HDRET=$ZF(-1,"ftp -i -n -s:"_HDTMPDIR_HDCMDFIL_" >"_HDTMPDIR_HDLOGFIL)
 ; If Linux, execute script
 S:+HDOS=3 HDRET=$ZF(-1,"ftp -i -n -v <"_HDTMPDIR_HDCMDFIL_" >"_HDTMPDIR_HDLOGFIL)
 I HDRET=-1 D  Q
 . W !!,"ERROR: The ftp process failed to execute.",!
 . D CONT^ZZSTFDU
 ;Check ftp session log for errors
 S HDLOGCK=$$CHECKLOG^ZZSTFDU(HDTMPDIR,HDLOGFIL)
 I HDLOGCK D
 . W "Download complete.",!
 . S DIR("B")="NO"
 E  D
 . W "Download error or warning occurred.",!
 . S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("A")="Do you want to view the ftp session log"
 S DIR("?")="Answer YES to view the ftp session log."
 D ^DIR
 ;Display ftp session log
 I Y D
 . D FULL^VALM1
 . D DISPLOG^ZZSTFDU(HDTMPDIR,HDLOGFIL)
 . D CONT^ZZSTFDU
 ;Clear download flag in tracking file
 D CLRDLFLG^ZZSTFDU
 ;Get list of files from ftp session log
 D GETLIST(HDROOT,HDTMPDIR,HDLOGFIL)
 ;Flag files already in local directory
 S HDLOCDIR=$G(@HDROOT@("LOCAL DIR"))
 S HDFILENM=$P($G(@HDROOT@("FILE NAME")),".",1)
 S HDTEMP(HDFILENM_"*.*")=""
 I $$LIST^%ZISH(HDLOCDIR,"HDTEMP","HDFLIST") D
 . S HDFILE=""
 . F  S HDFILE=$O(HDFLIST(HDFILE)) Q:HDFILE=""  D
 . . I $D(^TMP("HDISTFD",$J,"FLIST",$P(HDFILE,";",1))) D
 . . . S ^TMP("HDISTFD",$J,"FLIST",$P(HDFILE,";",1))=1
 ;Cleanup-delete ftp command file
 S HDCFILE(HDCMDFIL)=""
 I '$$DEL^%ZISH(HDTMPDIR,$NA(HDCFILE)) D
 . W !!,"WARNING: The file: ",HDTMPDIR_HDCMDFIL,", was not deleted.",!
 . W "         Ensure the directory name is valid.",!
 . D CONT^ZZSTFDU
 Q
 ;
CR8CMD(HDROOT) ;Create FTP Command File
 ; Inputs: HDROOT - Configuration global root
 ; Output: 1 = success
 ;         0 = error
 N HDRET,HDOS,HDDIR,HDFNAME,HDUID,HDPWD,HDFILE
 S HDRET=0
 S HDOS=$G(@HDROOT@("OS"))
 S HDDIR=$G(@HDROOT@("TEMP DIR"))
 S HDFNAME=$G(@HDROOT@("CMD FILE"))
 ;Get user ID & password
 S HDUID=$$GETUID^ZZSTFD1()
 Q:(HDUID="") 0
 S HDPWD=$$GETPWD^ZZSTFD1(HDUID)
 ;S HDUID=""
 ;S HDPWD=""
 ;Create the command file to get list of remote files
 I $$OPEN^ZZSTFDU("FILE",HDDIR,HDFNAME,"W") D
 . U IO
 . I +HDOS=1 D  ;VMS DCL file
 . . W "$! ",HDFNAME," - DCL file, created by ZZSTFDE",!
 . . W "$ SET DEFAULT ",$G(@HDROOT@("LOCAL DIR")),!
 . . W "$ FTP ",$G(@HDROOT@("HOST"))
 . . W " /USERNAME=",HDUID
 . . W " /PASSWORD=",HDPWD,!
 . . W "SET DEFAULT ",$G(@HDROOT@("HOST DIR")),!
 . . W "ls ",$G(@HDROOT@("FILE NAME")),"*.*",!
 . . W "EXIT",!
 . I +HDOS=2 D  ;MSWin ftp commands
 . . ;W "rem ",HDFNAME," - ftp commands file, created by ZZSTFDA",!
 . . W "open ",$G(@HDROOT@("HOST")),!
 . . W "user ",HDUID,!
 . . W HDPWD,!
 . . ;Truncate trailing '\' in dir name
 . . W "lcd ",$E($G(@HDROOT@("LOCAL DIR")),1,($L($G(@HDROOT@("LOCAL DIR")))-1)),!
 . . W "cd ",$G(@HDROOT@("HOST DIR")),!
 . . W "ls ",$G(@HDROOT@("FILE NAME")),"*.*",!
 . . W "quit",!
 . I +HDOS=3 D  ;Linux ftp commands
 . . W "open ",$G(@HDROOT@("HOST")),!
 . . W "user ",HDUID,!
 . . W HDPWD,!
 . . ;Truncate trailing '/' in dir name
 . . W "lcd ",$E($G(@HDROOT@("LOCAL DIR")),1,($L($G(@HDROOT@("LOCAL DIR")))-1)),!
 . . W "cd ",$G(@HDROOT@("HOST DIR")),!
 . . W "ls ",$G(@HDROOT@("FILE NAME")),"*.*",!
 . . W "quit",!
 . D CLOSE^ZZSTFDU("FILE")
 . S HDRET=1
 Q HDRET
 ;
GETLIST(HDROOT,HDDIR,HDFILE) ;Get List of Files from ftp Session Log
 ; Store list of file names in ^TMP("HDISTFD",$J,"FLIST"
 ; Inputs: HDROOT - Configuration global root
 ;         HDDIR  - Directory name
 ;         HDFILE - File name
 ; Output: none
 N HDREC,HDKEEP
 S HDKEEP=0
 I $$OPEN^ZZSTFDU("FILE",HDDIR,HDFILE,"R") D
 . F  Q:$$EOF^ZZSTFDU  U IO R HDREC:DTIME D
 . . Q:HDREC=""
 . . S:$E(HDREC,1,3)=226 HDKEEP=0 ;end of file list
 . . I HDKEEP,$E(HDREC,1,$L(@HDROOT@("FILE NAME")))=@HDROOT@("FILE NAME")  D
 . . . S ^TMP("HDISTFD",$J,"FLIST",$P(HDREC,";",1))=""
 . . S:$E(HDREC,1,3)=150 HDKEEP=1 ;file list starts with next record
 . D CLOSE^ZZSTFDU("FILE")
 Q
 ;
TRACKUPD(HDROOT,HDLOC) ; Update Tracking File
 ; Inputs: HDROOT - Configuration global root
 ;         HDLOC  - Location of files
 ;                  1 = local
 ;                  2 = new remote
 ;                  3 = all remote
 ; Output: none
 N HDFILE,HDIEN,HDIENS,HDFDA,HDEMSG
 S HDFILE=""
 F  S HDFILE=$O(^TMP("HDISTFD",$J,"FLIST",HDFILE)) Q:HDFILE=""  D
 . S HDIEN=$$FINDFILE^ZZSTFDU(HDFILE)
 . I HDIEN="" D
 . . ;add record
 . . S HDFDA(7118.27,"+1,",.01)=HDFILE
 . . S HDFDA(7118.27,"+1,",1)=""
 . . S HDFDA(7118.27,"+1,",2)=""
 . . S HDFDA(7118.27,"+1,",3)=""
 . . S HDFDA(7118.27,"+1,",4)=0
 . . I HDLOC=1 D
 . . . S HDFDA(7118.27,"+1,",5)=1
 . . E  D
 . . . I ^TMP("HDISTFD",$J,"FLIST",HDFILE)=1 D
 . . . . S HDFDA(7118.27,"+1,",5)=1
 . . . E  D
 . . . . S HDFDA(7118.27,"+1,",5)=0
 . . S HDFDA(7118.27,"+1,",6)=""
 . . D UPDATE^DIE("","HDFDA",,"HDEMSG")
 . . ;Keep names of new remote files
 . . K:HDLOC=1 ^TMP("HDISTFD",$J,"FLIST",HDFILE)
 . E  D
 . . ;update record
 . . S HDIENS=HDIEN_","
 . . ;S HDFDA(7118.27,HDIENS,.01)=HDFILE
 . . I HDLOC=1 D
 . . . S HDFDA(7118.27,HDIENS,5)=1
 . . E  D
 . . . I ^TMP("HDISTFD",$J,"FLIST",HDFILE)=1 D
 . . . . S HDFDA(7118.27,HDIENS,5)=1
 . . . E  D
 . . . . S HDFDA(7118.27,HDIENS,5)=0
 . . D FILE^DIE("","HDFDA","HDEMSG")
 . . K:HDLOC<3 ^TMP("HDISTFD",$J,"FLIST",HDFILE)
 ;Cleanup
 D CLEAN^DILF
 Q
 ;
