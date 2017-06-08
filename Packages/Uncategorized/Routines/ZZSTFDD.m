ZZSTFDD ;HRN/ART ; STS Text File Deployment ; 19-NOV-2008
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
EN ; -- main entry point for HDISTFD FOF VIEW FTP LOGS
 I $$PROD^XUPROD() D  Q
 . W !!,"ERROR: This tool may not be used on a production system."
 . D CONT^ZZSTFDU
 N HDROOT
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 ;Load prarameters from HDIS Parameter
 D INIT^ZZSTFD1(HDROOT)
 ;Check parameters
 Q:'$$PARAMCK^ZZSTFDU(HDROOT)
 Q:$G(@HDROOT@("MODE"))=""
 I $G(@HDROOT@("MODE"))="L" D  Q
 . W !!,"Local File Mode - No ftp logs."
 . D CONT^ZZSTFDU
 ;
 D EN^VALM("ZZSTFD FOF VIEW FTP LOGS")
 Q
 ;
HDR ; -- header code
 N HDMODE
 S HDMODE=$G(^TMP("HDISTFD",$J,"PARAMS","MODE"))
 S VALMHDR(1)="View FTP Session Log Files"
 S VALMHDR(2)="Mode: "_$S(HDMODE="F":"File of",HDMODE="R":"Remote",1:"?")_" Files"
 Q
 ;
INIT ; -- init variables and list array
 N HDLCNT,HDLINE,HDROOT,HDOS,HDLOGFIL,HDFLIST,HDTMPDIR,HDTEMP,HDFILE,HDREC
 S HDLCNT=0
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 S HDOS=$G(@HDROOT@("OS"))
 Q:'$$PARAMCK^ZZSTFDU(HDROOT)
 S HDTMPDIR=$G(@HDROOT@("TEMP DIR"))
 S HDLOGFIL=$P($G(@HDROOT@("LOG FILE")),".",1)
 S:+HDOS=1 HDTEMP(HDLOGFIL_"*.*;*")=""
 S:+HDOS=2 HDTEMP(HDLOGFIL_"*.*")=""
 ;Get the list of files
 I $$LIST^%ZISH(HDTMPDIR,"HDTEMP","HDFLIST") D
 . S HDFILE=""
 . F  S HDFILE=$O(HDFLIST(HDFILE)) Q:HDFILE=""  D
 . . S HDLINE=HDTMPDIR_HDFILE
 . . S HDLCNT=HDLCNT+1
 . . D SET^VALM10(HDLCNT,HDLINE)
 . . ;Display records
 . . I $$OPEN^ZZSTFDU("FILE",HDTMPDIR,HDFILE,"R") D
 . . . F  Q:$$EOF^ZZSTFDU  U IO R HDREC:DTIME D
 . . . . S HDLCNT=HDLCNT+1
 . . . . S HDLINE="   "_HDREC
 . . . . D SET^VALM10(HDLCNT,HDLINE)
 . . . D CLOSE^ZZSTFDU("FILE")
 E  D
 . W !!,"WARNING: No log files were found.",!
 . D CONT^ZZSTFDU
 . S VALMQUIT=1
 S VALMCNT=HDLCNT
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
