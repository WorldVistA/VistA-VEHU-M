ZZSTFDA ;HRN/ART ; STS Text File Deployment ; 19-SEP-2008
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
EN ; Main Entry Point to Deploy Files
 ;May not be used on a production system
 I $$PROD^XUPROD() D  Q
 . W !!,"ERROR: This tool may not be used on a production system."
 . D CONT^ZZSTFDU
 N HDROOT,HDMODE
 K ^TMP("HDISTFD",$J)
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 D INIT^ZZSTFD1(HDROOT)
 ;Check if parameters are defined
 Q:'$$PARAMCK^ZZSTFDU(HDROOT)
 S HDMODE=$G(@HDROOT@("MODE"))
 ;I HDMODE="F" D FOF(HDROOT)
 I HDMODE="L" D EN^ZZSTFDE(HDROOT,1)
 I HDMODE="R" D EN^ZZSTFDE(HDROOT,2)
 Q
 ;
FOF(HDROOT) ; File of Files Processing
 ;; Inputs: HDROOT - Configuration global root
 ;; Output: none
 ;N HDFTYPE
 ;N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 ;W @IOF
 ;W !,"STS Text File Deployment",!
 ;S DIR(0)="Y"
 ;S DIR("A")="  Do you want to refresh the file of files"
 ;S DIR("B")="NO"
 ;S DIR("?")="  Answer YES to download the most current file of files."
 ;D ^DIR
 ;Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 ;I Y D
 ;. ;Download file of files
 ;. I $$DOWNLOAD(HDROOT,1,"") D
 ;. . S HDFTYPE=$$FILETYPE^ZZSTFDU(HDROOT)
 ;. . ;update tracking file #7118.27
 ;. . I HDFTYPE="D" D TRCKUPDD(HDROOT)
 ;. . I HDFTYPE="X" D TRCKUPDX(HDROOT)
 ;;Display tracking file
 ;D EN^ZZSTFDB
 ;;
 Q
 ;
DOWNLOAD(HDROOT,HDTYPE,HDSELECT) ;Download Selected Files from ftp Server
 ; Inputs: HDROOT - Configuration global root
 ;         HDTYPE - type of file to pull
 ;                  1 = file of files
 ;                  2 = list of files
 ;         HDSELECT - List of files global root (required only for HDTYPE=2)
 ; Output: 1 = success
 ;         0 = error
 N HDOS,HDRET,HDTMPDIR,HDCMDFIL,HDLOGFIL,HDLNBR,HDLOGCK
 N HDFDA,HDIENS,HDEMSG
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:HDROOT="" 0
 Q:HDTYPE="" 0
 Q:((HDTYPE=2)&(HDSELECT="")) 0
 S HDOS=$G(@HDROOT@("OS"))
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDCMDFIL=$G(@HDROOT@("CMD FILE"))
 S HDLOGFIL=$$FILENAME^ZZSTFDU($G(@HDROOT@("LOG FILE")))
 S HDRET=0
 ;Build ftp command file
 S:HDTYPE=1 HDRET=$$CR8CMD(HDROOT,HDTYPE)
 S:HDTYPE=2 HDRET=$$CR8CMD(HDROOT,HDTYPE,HDSELECT)
 Q:'HDRET 0
 I HDRET=2 D DLCLNUP(HDTMPDIR,HDCMDFIL) Q 1
 U 0 W !
 ;Execute ftp command file
 W:HDTYPE=1 "Downloading file of files.",!
 W:HDTYPE=2 "Downloading selected file(s).",!
 S HDRET=-1
 ; If VMS, execute DCL command file
 S:+HDOS=1 HDRET=$ZF(-1,"@"_HDTMPDIR_HDCMDFIL,HDTMPDIR_HDLOGFIL)
 ; If MS Windows, execute ftp command with redirected input
 S:+HDOS=2 HDRET=$ZF(-1,"ftp -i -n -s:"_HDTMPDIR_HDCMDFIL_" >"_HDTMPDIR_HDLOGFIL)
 ; If Linux, execute script
 S:+HDOS=3 HDRET=$ZF(-1,"ftp -i -n -v <"_HDTMPDIR_HDCMDFIL_" >"_HDTMPDIR_HDLOGFIL)
 I HDRET=-1 D  Q 0
 . W !!,"ERROR: The ftp process failed to execute.",!
 . D CONT^ZZSTFDU
 ;Check ftp log for errors
 S HDLOGCK=$$CHECKLOG^ZZSTFDU(HDTMPDIR,HDLOGFIL)
 I HDLOGCK D
 . W "Download complete.",!
 . S DIR("B")="NO"
 E  D
 . W "Download error or warning.",!
 . S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("A")="Do you want to view the ftp session log"
 S DIR("?")="Answer YES to view the ftp session log."
 D ^DIR
 I Y D
 . D FULL^VALM1
 . D DISPLOG^ZZSTFDU(HDTMPDIR,HDLOGFIL)
 . D CONT^ZZSTFDU
 I 'HDLOGCK D DLCLNUP(HDTMPDIR,HDCMDFIL) Q 0
 ;If downloading files, update file download status in tracking file
 I HDTYPE=2 D
 . S HDLNBR=""
 . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . S HDIENS=$P(@HDSELECT@(HDLNBR),U,1)_","
 . . I HDLOGCK,$P(@HDSELECT@(HDLNBR),U,3)'=1 D
 . . . S $P(@HDSELECT@(HDLNBR),U,4)=1
 . . . S HDFDA(7118.27,HDIENS,5)=1
 . . . D FILE^DIE("","HDFDA","HDEMSG")
 . . ;E  D
 . . ;. S $P(@HDSELECT@(HDLNBR),U,4)=0
 . . ;. S HDFDA(7118.27,HDIENS,5)=0
 . . ;. D FILE^DIE("","HDFDA","HDEMSG")
 . D CLEAN^DILF
 ;
 D DLCLNUP(HDTMPDIR,HDCMDFIL)
 Q 1
 ;
DLCLNUP(HDTMPDIR,HDCMDFIL) ; Cleanup - Delete ftp Command File
 N HDDFILE
 S HDDFILE(HDCMDFIL)=""
 I '$$DEL^%ZISH(HDTMPDIR,$NA(HDDFILE)) D
 . W !!,"WARNING: The file: ",HDTMPDIR_HDCMDFIL,", was not deleted.",!
 . D CONT^ZZSTFDU
 Q
 ;
CR8CMD(HDROOT,HDTYPE,HDSELECT) ; Create FTP Command File - VMS & MS Windows only
 ; Inputs: HDROOT - Configuration global root
 ;         HDTYPE - type of file to pull
 ;                  1 = file of files
 ;                  2 = list of files
 ;         HDSELECT - List of files global root (required only for HDTYPE=2)
 ; Output: 1 = success
 ;         2 = no files
 ;         0 = error
 N HDRET,HDOS,HDDIR,HDFNAME,HDUID,HDPWD,HDLNBR,HDFILE,HDSTAT,HDDL,HDHIT
 Q:HDROOT="" 0
 Q:HDTYPE="" 0
 Q:((HDTYPE=2)&($G(HDSELECT)="")) 0
 S HDRET=0
 S HDHIT=0
 S HDOS=$G(@HDROOT@("OS"))
 S HDDIR=$G(@HDROOT@("TEMP DIR"))
 S HDFNAME=$G(@HDROOT@("CMD FILE"))
 ;Get user ID & password
 S HDUID=$$GETUID^ZZSTFD1()
 Q:(HDUID="") 0
 S HDPWD=$$GETPWD^ZZSTFD1(HDUID)
 ;S HDUID=""
 ;S HDPWD=""
 ;Build ftp command file
 I $$OPEN^ZZSTFDU("FILE",HDDIR,HDFNAME,"W") D
 . U IO
 . I +HDOS=1 D  ;VMS DCL file
 . . W "$! ",HDFNAME," - DCL file, created by ZZSTFDA",!
 . . W "$ SET DEFAULT ",$G(@HDROOT@("LOCAL DIR")),!
 . . W "$ FTP ",$G(@HDROOT@("HOST"))
 . . W " /USERNAME=",HDUID
 . . W " /PASSWORD=",HDPWD,!
 . . W "SET DEFAULT ",$G(@HDROOT@("HOST DIR")),!
 . . ;W "SET TYPE ASCII",!
 . . I HDTYPE=1 D
 . . . W "GET ",$G(@HDROOT@("FOF FILE")),!
 . . . W "EXIT",!
 . . . W "$ PURGE ",$G(@HDROOT@("FOF FILE")),!
 . . . S HDHIT=1
 . . I HDTYPE=2 D
 . . . S HDLNBR=""
 . . . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . . . S HDFILE=$P($G(@HDSELECT@(HDLNBR)),U,2)
 . . . . S HDSTAT=$P($G(@HDSELECT@(HDLNBR)),U,3)
 . . . . S HDDL=$P($G(@HDSELECT@(HDLNBR)),U,4)
 . . . . I ((HDSTAT'=1)&(HDDL'=1))!(HDSTAT<0) D
 . . . . . W "GET ",HDFILE,!
 . . . . . S HDHIT=1
 . . . W "EXIT",!
 . . . S HDLNBR=""
 . . . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . . . S HDFILE=$P($G(@HDSELECT@(HDLNBR)),U,2)
 . . . . S HDSTAT=$P($G(@HDSELECT@(HDLNBR)),U,3)
 . . . . S HDDL=$P($G(@HDSELECT@(HDLNBR)),U,4)
 . . . . I HDSTAT'=1,HDDL'=1 D
 . . . . . W "$ PURGE ",HDFILE,!
 . I +HDOS=2 D  ;MSWin ftp commands
 . . ;W "rem ",HDFNAME," - ftp commands file, created by ZZSTFDA",!
 . . W "open ",$G(@HDROOT@("HOST")),!
 . . W "user ",HDUID,!
 . . W HDPWD,!
 . . ;Truncate trailing '\' in dir name
 . . W "lcd ",$E($G(@HDROOT@("LOCAL DIR")),1,($L($G(@HDROOT@("LOCAL DIR")))-1)),!
 . . W "cd ",$G(@HDROOT@("HOST DIR")),!
 . . W "ascii",!
 . . I HDTYPE=1 D
 . . . W "get ",$G(@HDROOT@("FOF FILE")),!
 . . . S HDHIT=1
 . . I HDTYPE=2 D
 . . . S HDLNBR=""
 . . . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . . . S HDFILE=$P($G(@HDSELECT@(HDLNBR)),U,2)
 . . . . S HDSTAT=$P($G(@HDSELECT@(HDLNBR)),U,3)
 . . . . S HDDL=$P($G(@HDSELECT@(HDLNBR)),U,4)
 . . . . I ((HDSTAT'=1)&(HDDL'=1))!(HDSTAT<0) D
 . . . . . W "get ",HDFILE,!
 . . . . . S HDHIT=1
 . . W "quit",!
 . I +HDOS=3 D  ;Linux ftp commands
 . . W "open ",$G(@HDROOT@("HOST")),!
 . . W "user ",HDUID,!
 . . W HDPWD,!
 . . ;Truncate trailing '/' in dir name
 . . W "lcd ",$E($G(@HDROOT@("LOCAL DIR")),1,($L($G(@HDROOT@("LOCAL DIR")))-1)),!
 . . W "cd ",$G(@HDROOT@("HOST DIR")),!
 . . W "ascii",!
 . . I HDTYPE=1 D
 . . . W "get ",$G(@HDROOT@("FOF FILE")),!
 . . . S HDHIT=1
 . . I HDTYPE=2 D
 . . . S HDLNBR=""
 . . . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . . . S HDFILE=$P($G(@HDSELECT@(HDLNBR)),U,2)
 . . . . S HDSTAT=$P($G(@HDSELECT@(HDLNBR)),U,3)
 . . . . S HDDL=$P($G(@HDSELECT@(HDLNBR)),U,4)
 . . . . I ((HDSTAT'=1)&(HDDL'=1))!(HDSTAT<0) D
 . . . . . W "get ",HDFILE,!
 . . . . . S HDHIT=1
 . . W "quit",!
 . ;
 . D CLOSE^ZZSTFDU("FILE")
 . S HDRET=1
 . S:'HDHIT HDRET=2
 Q HDRET
 ;
TRCKUPDD(HDROOT) ; Update Tracking File - Delimited Records
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDTMPDIR,HDFNAME,HDREC,HDFILE,HDDOM,HDPRECS,HDPSTCS,HDIEN
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDFNAME=$G(@HDROOT@("FOF FILE"))
 I $$OPEN^ZZSTFDU("FILE",HDTMPDIR,HDFNAME,"R") D
 . F  Q:$$EOF^ZZSTFDU  U IO R HDREC:DTIME D
 . . Q:HDREC=""  ;skip blank lines
 . . S HDFILE=$P(HDREC,U,1)
 . . S HDDOM=$P(HDREC,U,2)
 . . S HDPRECS=$P(HDREC,U,3)
 . . S HDPSTCS=$P(HDREC,U,4)
 . . S HDIEN=$$FINDFILE^ZZSTFDU(HDFILE)
 . . I HDIEN="" D
 . . . ;add record
 . . . D ADDREC(HDFILE,HDDOM,HDPRECS,HDPSTCS)
 . . E  D
 . . . ;update record
 . . . D UPDTREC(HDIEN,HDFILE,HDDOM,HDPRECS,HDPSTCS)
 . D CLOSE^ZZSTFDU("FILE")
 ;Cleanup-delete downloaded file of files
 D CLEAN^DILF
 D DELFILE(HDTMPDIR,HDFNAME)
 Q
 ;
TRCKUPDX(HDROOT) ; Update Tracking File - XML
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDINDX1,HDPARR
 N HDTMPDIR,HDFNAME,HDREC,HDFILE,HDDOM,HDPRECS,HDPSTCS,HDIEN
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDFNAME=$G(@HDROOT@("FOF FILE"))
 K ^TMP($J,"FOF")
 K ^TMP($J,"FOFPAR")
 ;Read FOF(XML format) into ^TMP
 I $$OPEN^ZZSTFDU("FILE",HDTMPDIR,HDFNAME,"R") D
 . F HDINDX1=1:1 Q:$$EOF^ZZSTFDU  U IO R HDREC:DTIME D
 . . Q:HDREC=""  ;skip blank lines
 . . S ^TMP($J,"FOF",HDINDX1)=$$TRIM^ZZSTFDU(HDREC)
 . D CLOSE^ZZSTFDU("FILE")
 ;Call SAX Processor
 D SAX^HDISVM01($NA(^TMP($J,"FOF")),$NA(^TMP($J,"FOFPAR")))
 ;Get data from array returned by SAX
 S HDPARR=$NA(^TMP($J,"FOFPAR","DATA"))
 S HDINDX1=""
 F  S HDINDX1=$O(@HDPARR@(1,HDINDX1)) Q:HDINDX1=""  D
 . S HDFILE=$G(@HDPARR@(1,HDINDX1,2,1,"V"))
 . S HDDOM=$G(@HDPARR@(1,HDINDX1,3,1,"V"))
 . S HDPRECS=$G(@HDPARR@(1,HDINDX1,4,1,"V"))
 . S HDPSTCS=$G(@HDPARR@(1,HDINDX1,5,1,"V"))
 . S HDIEN=$$FINDFILE^ZZSTFDU(HDFILE)
 . I HDIEN="" D
 . . ;add record
 . . D ADDREC(HDFILE,HDDOM,HDPRECS,HDPSTCS)
 . E  D
 . . ;update record
 . . D UPDTREC(HDIEN,HDFILE,HDDOM,HDPRECS,HDPSTCS)
 ;Cleanup-delete downloaded file of files
 D CLEAN^DILF
 D DELFILE(HDTMPDIR,HDFNAME)
 Q
 ;
ADDREC(HDFILE,HDDOM,HDPRECS,HDPSTCS) ; Add a Record to the Tracking File
 ; Inputs: HDFILE - File Name
 ;         HDDOM - Domain Name
 ;         HDPRECS - Pre-Load Checksum
 ;         HDPSTCS - Post-Load Checksum
 ; Output: none
 N HDFDA,HDEMSG
 S HDFDA(7118.27,"+1,",.01)=HDFILE
 S HDFDA(7118.27,"+1,",1)=HDDOM
 S HDFDA(7118.27,"+1,",2)=HDPRECS
 S HDFDA(7118.27,"+1,",3)=HDPSTCS
 S HDFDA(7118.27,"+1,",4)=0
 S HDFDA(7118.27,"+1,",5)=0
 S HDFDA(7118.27,"+1,",6)=""
 D UPDATE^DIE("","HDFDA",,"HDEMSG")
 Q
 ;
UPDTREC(HDIEN,HDFILE,HDDOM,HDPRECS,HDPSTCS) ; Update a Record in the Tracking File
 ; Inputs: HDIEN - Record Number
 ;         HDFILE - File Name
 ;         HDDOM - Domain Name
 ;         HDPRECS - Pre-Load Checksum
 ;         HDPSTCS - Post-Load Checksum
 ; Output: none
 N HDIENS,HDFDA,HDEMSG
 S HDIENS=HDIEN_","
 ;S HDFDA(7118.27,HDIENS,.01)=HDFILE
 S HDFDA(7118.27,HDIENS,1)=HDDOM
 S HDFDA(7118.27,HDIENS,2)=HDPRECS
 S HDFDA(7118.27,HDIENS,3)=HDPSTCS
 D FILE^DIE("","HDFDA","HDEMSG")
 Q
 ;
DELFILE(HDTMPDIR,HDFNAME) ; Delete a File
 ; Inputs: HDTMPDIR - Directory Name
 ;         HDFNAME - File Name
 ; Output: none
 N HDDFILE
 S HDDFILE(HDFNAME)=""
 I '$$DEL^%ZISH(HDTMPDIR,$NA(HDDFILE)) D
 . W !!,"WARNING: The file: ",HDTMPDIR_HDFNAME,", was not deleted.",!
 . D CONT^ZZSTFDU
 Q
 ;
PURGFILE ; Entry Point to Delete Obsolete Files
 ; Inputs: none
 ; Output: none
 ;May not be used on a production system
 I $$PROD^XUPROD() D  Q
 . W !!,"ERROR: This tool may not be used on a production system."
 . D CONT^ZZSTFDU
 N HDROOT,HDOPT
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 ;Load prarameters from HDIS Parameter
 D INIT^ZZSTFD1(HDROOT)
 ;Check parameters
 Q:'$$PARAMCK^ZZSTFDU(HDROOT)
 ; Display Menu and Get Option
 W @IOF
 W !,"STS Text File Deployment"
 W !,"Delete Obsolete Files"
 S DIR(0)="SO^1:;2:;3:"
 S DIR("A")="  Select an option"
 S DIR("L",1)="    1 - Delete loaded HL7 files prior to a date"
 S DIR("L",2)="    2 - Delete all downloaded HL7 files"
 S DIR("L")="    3 - Delete ftp session log files"
 S DIR("T")=180
 S DIR("?")="  Enter a menu option (1, 2, or 3)."
 D ^DIR
 S HDOPT=Y
 Q:($D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)))
 W !
 D:HDOPT=1 P1(HDROOT)
 D:HDOPT=2 P2(HDROOT)
 D:HDOPT=3 P3(HDROOT)
 Q
 ;
P1(HDROOT) ; Purge by Date
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDDIR,HDPDATE,HDIDX,HDIENS,HDFILENM,HDSTAT,HDDATE,HDFILE,HDCNT
 N HDILIST,HDFDA,HDEMSG
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S HDDIR=$G(@HDROOT@("LOCAL DIR"))
 ;Get purge date
 S DIR(0)="DA^:NOW:ETX"
 S DIR("A")="  Delete files loaded prior to: "
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT($$NOW^XLFDT(),-7),"D")
 S DIR("?")="  The maximum value allowed is today's date."
 S DIR("?",1)="  Enter a date and optional time, or relative date (T-n)."
 S DIR("?",2)="  Files loaded prior to this date will be deleted from the local directory."
 S DIR("?",3)="  Enter NOW to delete all loaded files."
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 S HDPDATE=Y
 S DIR(0)="Y"
 S DIR("A")="  Are you sure"
 S DIR("B")="NO"
 S DIR("?")="  Answer YES to delete."
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 Q:'Y
 ;Build a list of files to delete based on date criteria and status
 S HDCNT=0
 S HDIDX=0
 F  S HDIDX=$O(^HDISF(7118.27,HDIDX)) Q:'HDIDX  D
 . S HDIENS=HDIDX_","
 . S HDFILENM=$$GET1^DIQ(7118.27,HDIENS,.01,"I")
 . S HDSTAT=$$GET1^DIQ(7118.27,HDIENS,4,"I")
 . S HDDATE=$$GET1^DIQ(7118.27,HDIENS,6,"I")
 . ;Create list of files to delete
 . I HDSTAT=1,HDDATE'="",HDDATE<HDPDATE D
 . . S HDFILE(HDFILENM)=""
 . . S HDCNT=HDCNT+1
 . . S HDILIST(HDIDX)=""
 I 'HDCNT D  Q
 . W !!,"WARNING: No files were found to delete.",!
 . D CONT^ZZSTFDU
 ;Delete files in the list
 I '$$DEL^%ZISH(HDDIR,$NA(HDFILE)) D  Q
 . W !!,"WARNING: One or more files were not deleted.",!
 . D CONT^ZZSTFDU
 ;Update tracking file
 S HDIDX=""
 F  S HDIDX=$O(HDILIST(HDIDX)) Q:HDIDX=""  D
 . S HDIENS=HDIDX_","
 . S HDFDA(7118.27,HDIENS,5)=0
 . D FILE^DIE("","HDFDA","HDEMSG")
 W !!,"HL7 files have been deleted."
 D CLEAN^DILF
 D CONT^ZZSTFDU
 Q
 ;
P2(HDROOT) ; Delete All HL7 Files
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDOS,HDDIR,HDFILE,HDTEMP,HDFLIST
 N HDIDX,HDIENS,HDFDA,HDEMSG
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="Y"
 S DIR("A")="  Are you sure"
 S DIR("A",1)="  This will delete all HL7 text files in the local directory."
 S DIR("B")="NO"
 S DIR("?")="  Answer YES to delete all HL7 text files in the local directory."
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 Q:'Y
 ;Get list of files and delete
 S HDOS=$G(@HDROOT@("OS"))
 S HDDIR=$G(@HDROOT@("LOCAL DIR"))
 S HDFILE=$G(@HDROOT@("FILE NAME"))
 S:+HDOS=1 HDTEMP(HDFILE_"*.*;*")=""
 S:+HDOS=2 HDTEMP(HDFILE_"*.*")=""
 ;Get the list of files
 I $$LIST^%ZISH(HDDIR,"HDTEMP","HDFLIST") D
 . ;Delete files
 . I $$DEL^%ZISH(HDDIR,$NA(HDFLIST)) D
 . . ;Update tracking file
 . . S HDIDX=0
 . . F  S HDIDX=$O(^HDISF(7118.27,HDIDX)) Q:'HDIDX  D
 . . . S HDIENS=HDIDX_","
 . . . S HDFDA(7118.27,HDIENS,5)=0
 . . . D FILE^DIE("","HDFDA","HDEMSG")
 . . D CLEAN^DILF
 . . W !!,"HL7 files have been deleted."
 . E  D
 . . W !!,"WARNING: One or more files were not deleted.",!
 E  D
 . W !!,"WARNING: No files were found to delete.",!
 D CONT^ZZSTFDU
 Q
 ;
P3(HDROOT) ; Purge ftp Session Log Files
 ; Inputs: HDROOT - Configuration global root
 ; Output: none
 N HDOS,HDTMPDIR,HDLOGFIL,HDTEMP,HDFLIST
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 I $G(@HDROOT@("MODE"))="L" D  Q
 . W !,"Local File Mode - No ftp logs."
 . D CONT^ZZSTFDU
 S DIR(0)="Y"
 S DIR("A")="  Are you sure"
 S DIR("A",1)="  This will delete all ftp session log files."
 S DIR("B")="NO"
 S DIR("?")="  Answer YES to delete all ftp session log files."
 D ^DIR
 Q:($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 Q:'Y
 ;
 S HDOS=$G(@HDROOT@("OS"))
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDLOGFIL=$P($G(@HDROOT@("LOG FILE")),".",1)
 S:+HDOS=1 HDTEMP(HDLOGFIL_"*.*;*")=""
 S:+HDOS=2 HDTEMP(HDLOGFIL_"*.*")=""
 ;Get list of files and delete them
 I $$LIST^%ZISH(HDTMPDIR,"HDTEMP","HDFLIST") D
 . I $$DEL^%ZISH(HDTMPDIR,$NA(HDFLIST)) D
 . . W !!,"Log files have been deleted."
 . E  D
 . . W !!,"WARNING: One or more log files were not deleted.",!
 E  D
 . W !!,"WARNING: No log files were found to delete.",!
 D CONT^ZZSTFDU
 Q
 ;
