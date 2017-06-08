ZZSTFDB ;HRN/ART ; STS Text File Deployment ; 31-OCT-2008
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
 ;  choose files to process
 ;  download files
 ;  process files thru MFS
 ;  update status in tracking file
 ;
EN ; -- main entry point for VALM - HDISTFD FOF MAIN
 N X
 ;Screen IO housekeeping
 S X="IORESET"
 D ENDR^%ZISS
 ;List Manager Template
 D EN^VALM("ZZSTFD FOF MAIN")
 ;Screen IO housekeeping
 W IORESET
 D KILL^%ZISS
 Q
 ;
HDR ; -- header code
 N HDMODE
 S HDMODE=$G(^TMP("HDISTFD",$J,"PARAMS","MODE"))
 S VALMHDR(1)="Local Directory Name: "_$G(^TMP("HDISTFD",$J,"PARAMS","LOCAL DIR"))
 S VALMHDR(2)="Mode: "_$S(HDMODE="F":"File of",HDMODE="R":"Remote",HDMODE="L":"Local",1:"?")_" Files"
 Q
 ;
INIT ; -- init variables and list array
 N HDLCNT,HDRNBR,HDFNAME,HDIENS,HDLINE
 N HDFILE,HDDOM,HDPRECS,HDPSTCS,HDSTAT,HDLOAD,HDDATE
 S HDLCNT=0
 S HDFNAME=""
 F  S HDFNAME=$O(^HDISF(7118.27,"B",HDFNAME)) Q:HDFNAME=""  D
 . S HDRNBR=""
 . F  S HDRNBR=$O(^HDISF(7118.27,"B",HDFNAME,HDRNBR)) Q:HDRNBR=""  D
 . . S HDLCNT=HDLCNT+1
 . . S HDIENS=HDRNBR_","
 . . S HDFILE=$$GET1^DIQ(7118.27,HDIENS,.01,"I")
 . . S HDDOM=$$GET1^DIQ(7118.27,HDIENS,1,"I")
 . . S HDPRECS=$$GET1^DIQ(7118.27,HDIENS,2,"I")
 . . S HDPSTCS=$$GET1^DIQ(7118.27,HDIENS,3,"I")
 . . S HDSTAT=$$GET1^DIQ(7118.27,HDIENS,4,"I")
 . . S HDSTAT=$S(HDSTAT=0:"NOT LOADED",HDSTAT=1:"LOADED",HDSTAT=-1:"ERROR (-1)",HDSTAT=-2:"ERROR (-2)",HDSTAT=-3:"ERROR (-3)",1:"")
 . . S HDLOAD=$$GET1^DIQ(7118.27,HDIENS,5,"I")
 . . S HDLOAD=$S(HDLOAD=0:"NO",HDLOAD=1:"YES",1:"")
 . . S HDDATE=$$FMTE^XLFDT($$GET1^DIQ(7118.27,HDIENS,6,"I"),2)
 . . S HDLINE=""
 . . S HDLINE=$$SETFLD^VALM1(HDLCNT,HDLINE,"LINENBR")
 . . S HDLINE=$$SETFLD^VALM1(HDDOM,HDLINE,"DOMAIN")
 . . S HDLINE=$$SETFLD^VALM1(HDFILE,HDLINE,"FILENAME")
 . . S HDLINE=$$SETFLD^VALM1(HDSTAT,HDLINE,"STATUS")
 . . S HDLINE=$$SETFLD^VALM1(HDLOAD,HDLINE,"DL")
 . . S HDLINE=$$SETFLD^VALM1(HDDATE,HDLINE,"LDATE")
 . . S HDLINE=$$SETFLD^VALM1(HDPRECS,HDLINE,"PRE-CS")
 . . S HDLINE=$$SETFLD^VALM1(HDPSTCS,HDLINE,"POST-CS")
 . . D SET^VALM10(HDLCNT,HDLINE,HDRNBR)
 S VALMCNT=HDLCNT
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;K ^TMP("HDISTFD",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SELECT ; Select Files
 ; Inputs: none
 ; Output: none
 N HDLN,HDIDX,HDLNBR,HDIEN,HDFILE,HDSTAT,HDDL,HDSELECT
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S HDSELECT=$NA(^TMP("HDISTFD",$J,"SELECT"))
 ;Select line numbers
 S DIR(0)="L^"_VALMBG_":"_VALMLST
 S DIR("A")="Enter a Line Number or list of Line Numbers"
 S DIR("?",1)="Enter a single line number, list of numbers, or range of numbers,"
 S DIR("?",2)=" for example, 6 or 1,3,5 or 2-4,8."
 S DIR("?")="The line numbers must be between "_VALMBG_" and "_VALMLST_" (inclusive)."
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S VALMBCK="R" Q
 S HDLN=Y
 ;Parse response, highlight selected lines, and add to temp global
 S HDLNBR=1
 F HDIDX=1:1 Q:HDLNBR=""  D
 . S HDLNBR=$P(HDLN,",",HDIDX)
 . Q:HDLNBR=""
 . I '$D(@HDSELECT@(HDLNBR)) D
 . . S HDFILE=$TR($E($G(@VALMAR@(HDLNBR,0)),21,61)," ","")
 . . S HDIEN=$$FINDFILE^ZZSTFDU(HDFILE)
 . . S HDSTAT=+($$GET1^DIQ(7118.27,HDIEN_",",4,"I"))
 . . S HDDL=+($$GET1^DIQ(7118.27,HDIEN_",",5,"I"))
 . . S @HDSELECT@(HDLNBR)=HDIEN_U_HDFILE_U_HDSTAT_U_HDDL
 . . D HLON^ZZSTFDU(HDLNBR)
 S VALMBCK="R"
 Q
 ;
DESELECT ; De-select Files
 ; Inputs: none
 ; Output: none
 N HDLN,HDIDX,HDLNBR
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,HDSELECT
 S HDSELECT=$NA(^TMP("HDISTFD",$J,"SELECT"))
 I '$D(@HDSELECT) D  Q
 . W !,"WARNING: There are no selected files."
 . D CONT^ZZSTFDU
 . S VALMBCK="R"
 ;Select line numbers
 S DIR(0)="L^"_VALMBG_":"_VALMLST
 S DIR("A")="Enter a Line Number or list of Line Numbers"
 S DIR("?",1)="Enter a single line number, list of numbers, or range of numbers,"
 S DIR("?",2)=" for example, 6 or 1,3,5 or 2-4,8."
 S DIR("?")="The line numbers must be between "_VALMBG_" and "_VALMLST_" (inclusive)."
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S VALMBCK="R" Q
 S HDLN=Y
 ;Parse response, unhighlight selected lines, and remove from temp global
 S HDLNBR=1
 F HDIDX=1:1 Q:HDLNBR=""  D
 . S HDLNBR=$P(HDLN,",",HDIDX)
 . Q:HDLNBR=""
 . I $D(@HDSELECT@(HDLNBR)) D
 . . K @HDSELECT@(HDLNBR)
 . . D HLOFF^ZZSTFDU(HDLNBR)
 S VALMBCK="R"
 Q
 ;
LOAD ; Process Selected Files
 ; Inputs: none
 ; Output: none
 N HDLNBR,HDDIR,HDNODE,HDIENS,HDFILE,HDSTAT,HDDLSTAT,HDFDA,HDEMSG,HDHIT
 N HDLOAD,HDROOT,HDSELECT,HDRET,HDMODE
 N HL,HLQUIT,HLNODE,HLNEXT,HDIO
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 S HDMODE=$G(@HDROOT@("MODE"))
 S HDSELECT=$NA(^TMP("HDISTFD",$J,"SELECT"))
 ;Check for selected files
 I '$D(@HDSELECT) D  Q
 . W !,"WARNING: Please select at least one file to load."
 . D CONT^ZZSTFDU
 . S VALMBCK="R"
 S HDDIR=$G(@HDROOT@("LOCAL DIR"))
 ;Set HL7 variables for MFS
 S HL("FS")="^"
 S HL("ECH")="~|\&"
 S HL("MID")=0
 S HLQUIT=1 ;needs to be reset for each file
 S HLNODE=""
 S HLNEXT="D GETNEXT^ZZSTFDB"
 ;S INACT=0 ;<<<<<<<<<<<<<<<<<<<<<<<UNDEFINED>PCECODE+27^PXCAST<<<<<<<<<<<<
 ;Check if selected files were previously loaded
 S HDHIT=0
 S HDLNBR=""
 F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . S HDDLSTAT=$P(@HDSELECT@(HDLNBR),U,4)
 . S HDSTAT=$P(@HDSELECT@(HDLNBR),U,3)
 . I (HDDLSTAT'=1)!(HDSTAT<0) D
 . . S HDHIT=1
 ;Download selected files
 D FULL^VALM1
 S HDRET=1
 I HDHIT,HDMODE'="L" D
 . S HDRET=$$DOWNLOAD^ZZSTFDA(HDROOT,2,HDSELECT)
 . Q:'HDRET
 . ;Update download status on screen
 . S HDLNBR=""
 . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . S HDIENS=$P(@HDSELECT@(HDLNBR),U,1)_","
 . . S HDLOAD=$$GET1^DIQ(7118.27,HDIENS,5,"I")
 . . S HDLOAD=$S(HDLOAD=0:"NO",HDLOAD=1:"YES",1:"")
 . . D FLDTEXT^VALM10(HDLNBR,"DL",HDLOAD)
 . . ;D WRITE^VALM10(HDLNBR)
 I 'HDRET D  Q
 . ;W !,"WARNING: Error occurred while downloading file(s)."
 . ;D CONT^ZZSTFDU
 . D RE^VALM4
 . S VALMBCK="R"
 ;Load selected files
 S HDLNBR=""
 F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . S HDNODE=$G(@HDSELECT@(HDLNBR))
 . S HDIENS=$P(HDNODE,U,1)_","
 . S HDFILE=$P(HDNODE,U,2)
 . S HDSTAT=$P(HDNODE,U,3)
 . S HDDLSTAT=$P(HDNODE,U,4)
 . ;Check file load status
 . I HDSTAT'=1 D
 . . ;Check file download status
 . . I HDDLSTAT=1 D
 . . . ;;Perform pre-load checksum   <<< uncomment if implementing file of files processing
 . . . ;I '$$PRECKSUM(HDROOT,HDIENS) D  Q
 . . . ;. D CKSUMERR(HDDIR,HDFILE,HDIENS,HDLNBR,1)
 . . . W !,"Loading: ",HDDIR,HDFILE
 . . . ;Open HL7 file
 . . . I '$$OPEN^ZZSTFDU("FILE",HDDIR,HDFILE,"R") D  Q
 . . . . K @HDSELECT@(HDLNBR)
 . . . . D HLOFF^ZZSTFDU(HDLNBR)
 . . . . S VALMBCK="R"
 . . . S HDIO=IO
 . . . ;Call MFS processor  IRC 5506
 . . . S HLQUIT=1
 . . . D MAIN^XUMF1H
 . . . I $G(ERROR) D  Q  ;Pavel 20151117
 . . . . W !,*7,"Load Terminated "_ERROR H 2
 . . . . D CLOSE^ZZSTFDU("FILE")
 . . . . D HLOFF^ZZSTFDU(HDLNBR) S VALMBCK="R"
 . . . ;F  X HLNEXT Q:HLQUIT'>0  D
 . . . ;. ;U 0 W !,HLNODE
 . . . ;Close HL7 file
 . . . D CLOSE^ZZSTFDU("FILE")
 . . . ;;Perform post-load checksum   <<< uncomment if implementing file of files processing
 . . . ;I '$$PSTCKSUM(HDROOT,HDIENS) D  Q
 . . . ;. D CKSUMERR(HDDIR,HDFILE,HDIENS,HDLNBR,2)
 . . . ;Update file load status
 . . . S HDFDA(7118.27,HDIENS,4)=1
 . . . S HDFDA(7118.27,HDIENS,6)=$$NOW^XLFDT()
 . . . D FILE^DIE("","HDFDA","HDEMSG")
 . . . D CLEAN^DILF
 . . . ;Update screen
 . . . D HLOFF^ZZSTFDU(HDLNBR)
 . . . D FLDTEXT^VALM10(HDLNBR,"STATUS","LOADED")
 . . . D FLDTEXT^VALM10(HDLNBR,"LDATE",$$FMTE^XLFDT($$GET1^DIQ(7118.27,HDIENS,6,"I"),2))
 . . . ;D WRITE^VALM10(HDLNBR)
 . . E  D
 . . . W !,"WARNING: File ",HDDIR,HDFILE," has not been downloaded."
 . . . D CONT^ZZSTFDU
 . . . D HLOFF^ZZSTFDU(HDLNBR)
 . E  D
 . . W !,"WARNING: File ",HDDIR,HDFILE," has already been loaded."
 . . D CONT^ZZSTFDU
 . . D HLOFF^ZZSTFDU(HDLNBR)
 . K @HDSELECT@(HDLNBR)
 ;D CONT^ZZSTFDU
 D RE^VALM4
 S VALMBCK="R"
 Q
 ;
VIEW ; View HL7 Records
 ; Inputs: none
 ; Output: none
 ;Check for selected files
 N HDHIT,HDLNBR,HDROOT,HDSELECT,HDRET,HDLOAD,HDIENS,HDMODE,HDDLSTAT
 S HDROOT=$NA(^TMP("HDISTFD",$J,"PARAMS"))
 S HDMODE=$G(@HDROOT@("MODE"))
 S HDSELECT=$NA(^TMP("HDISTFD",$J,"SELECT"))
 I '$D(@HDSELECT) D  Q
 . W !,"WARNING: Please select at least one file to view."
 . D CONT^ZZSTFDU
 . S VALMBCK="R"
 ;Download selected files if not previously loaded
 S HDHIT=0
 S HDLNBR=""
 F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . S HDDLSTAT=$P(@HDSELECT@(HDLNBR),U,4)
 . I HDDLSTAT'=1 D
 . . S HDHIT=1
 I HDHIT,HDMODE'="L" D
 . S HDRET=$$DOWNLOAD^ZZSTFDA(HDROOT,2,HDSELECT)
 . Q:'HDRET
 . S HDLNBR=""
 . ;Update download status
 . F  S HDLNBR=$O(@HDSELECT@(HDLNBR)) Q:HDLNBR=""  D
 . . S HDIENS=$P(@HDSELECT@(HDLNBR),U,1)_","
 . . S HDLOAD=$$GET1^DIQ(7118.27,HDIENS,5,"I")
 . . S HDLOAD=$S(HDLOAD=0:"NO",HDLOAD=1:"YES",1:"")
 . . D FLDTEXT^VALM10(HDLNBR,"DL",HDLOAD)
 . . D WRITE^VALM10(HDLNBR)
 ;View records
 D EN^ZZSTFDC
 S VALMBCK="R"
 Q
 ;
GETNEXT ; Get Next Record
 ; This sub-routine is called by MFS to read the next HL7 message segment
 ; Input  - none
 ; Output - none
 ;          HLNODE - message segment
 ;          HLQUIT=0 when end of file is reached
 ; HDIO has been set to the device from which to read
 K HLNODE
 U HDIO
 I $$EOF^ZZSTFDU D  Q
 . S HLQUIT=0
 R HLNODE:DTIME
 Q
 ;
DISPERR ; Display Error Messages from MFS
 ; Inputs: none
 ; Output: none
 ;Error from EM^XUMF1H - ^TMP("XUMF ERROR",$J,ERRCNT_  - Killed when XUMF1H completes
 ;Error from EM^XUMFX - Sends Mail
 ;Error from EM^XUMF0 - Sends Mail
 N HDIDX
 S HDIDX=""
 F  S HDIDX=$O(^TMP("XUMF ERROR",$J,HDIDX)) Q:HDIDX=""  D
 . ;
 Q
 ;
PRECKSUM(HDROOT,HDIENS) ; Pre-Load Checksum Processing
 ;; Inputs: HDROOT - Configuration global root
 ;;         HDIENS - IEN string for FM API
 ;; Output: 1 = Processing was successful
 ;;         0 = Error occurred
 ;;
 ;; EN^XUMF5I(X0,MODE,IENCOUNT) calculates the MD5 checksum for a file
 ;; X0 = IEN or name of entry from 4.005 file
 ;;      >>>(the routine will abort if a valid value is not passed)<<<
 ;; MODE = 0 regular mode.. last HASH value returned in Apl. ACK.
 ;;        1 debugging mode.. all values + hash codess returned in Apl ACK
 ;;        1.1 debugging mode.. all values (no hash codes) returned in Apl ACK
 ;;        2 debugging mode.. all fields values, all hash values, all hash codes returned in Apl. ACK.
 ;; IENCOUNT  = maximum entries for MD5 hash.. if NULL.. all entries counted...
 ;; The checksum is returned in the second ";" piece of the variable: ERROR
 ;;
 ;Q:$G(@HDROOT@("MODE"))'="F" 1
 ;Q:'(+$G(@HDROOT@("CHECKSUMS"))) 1
 ;N HDPRECS,HDDOM,HDIDX,HDERRMSG,HDCKSUM
 ;S HDPRECS=$$GET1^DIQ(7118.27,HDIENS,2,"I")
 ;Q:HDPRECS="" 1
 ;S HDDOM=$$GET1^DIQ(7118.27,HDIENS,1,"I")
 ;  <<<<<<<< this next reference needs an IRC
 ;S HDIDX=$O(^DIC(4.005,"B",HDDOM,""))
 ;I HDIDX="" D  Q 0
 ;. W !,"WARNING: The domain name (",HDDOM,") was not found in file 4.005."
 ;K ERROR
 ; Calculate checksum call  IRC #5509
 ;D EN^XUMF5I(HDIDX,0)
 ;S HDERRMSG=$P(ERROR,";",1)
 ;I HDERRMSG'="^" D  Q 0
 ;. W !,"WARNING: An error occurred calculating the pre-load checksum."
 ;S HDCKSUM=$P($P(ERROR,";",2),":",2)
 ;I HDPRECS'=HDCKSUM D  Q 0
 ;. W !,"WARNING: The calculated checksum does not match the pre-load checksum."
 ;. W !,"         Pre-load:   ",HDPRECS
 ;. W !,"         Calculated: ",HDCKSUM
 Q 1
 ;
PSTCKSUM(HDROOT,HDIENS) ; Post-Load Checksum Processing
 ;; Inputs: HDROOT - Configuration global root
 ;;         HDIENS - IEN string for FM API
 ;; Output: 1 = Processing was successful
 ;;         0 = Error occurred
 ;Q:$G(@HDROOT@("MODE"))'="F" 1
 ;Q:'(+$G(@HDROOT@("CHECKSUMS"))) 1
 ;N HDPSTCS,HDDOM,HDIDX,HDERRMSG,HDCKSUM
 ;S HDPSTCS=$$GET1^DIQ(7118.27,HDIENS,3,"I")
 ;Q:HDPSTCS="" 1
 ;S HDDOM=$$GET1^DIQ(7118.27,HDIENS,1,"I")
 ;  <<<<<<<< this next reference needs an IRC
 ;S HDIDX=$O(^DIC(4.005,"B",HDDOM,""))
 ;I HDIDX="" D  Q 0
 ;. W !,"WARNING: The domain name (",HDDOM,") was not found in file 4.005."
 ;K ERROR
 ; Calculate checksum call  IRC #5509
 ;D EN^XUMF5I(HDIDX,0)
 ;S HDERRMSG=$P(ERROR,";",1)
 ;I HDERRMSG'="^" D  Q 0
 ;. W !,"WARNING: An error occurred calculating the post-load checksum."
 ;S HDCKSUM=$P($P(ERROR,";",2),":",2)
 ;I HDPSTCS'=HDCKSUM D  Q 0
 ;. W !,"WARNING: The calculated checksum does not match the post-load checksum."
 ;. W !,"         Post-load:  ",HDPSTCS
 ;. W !,"         Calculated: ",HDCKSUM
 Q 1
 ;
CKSUMERR(HDDIR,HDFILE,HDIENS,HDLNBR,HDTYPE) ;Checksum error
 ;; Inputs: HDDIR - Local Directory
 ;;         HDFILE - HL7 Text File Name
 ;;         HDIENS - Tracking file IEN string
 ;;         HDLNBR - VA list screen line number
 ;;         HDTYPE - type of error
 ;;                  1 = pre-load
 ;;                  2 = post-load
 ;; Output: none
 ;N HDFDA,HDEMSG,HDNBR,HDTEXT
 ;S HDNBR=$S(HDTYPE=1:-1,HDTYPE=2:-2,1:0)
 ;S HDTEXT=$S(HDTYPE=1:"Pre",HDTYPE=2:"Post",1:"")
 ;;Display message
 ;W !,"WARNING: A ",HDTEXT,"-load checksum error occurred for: ",HDDIR,HDFILE
 ;D CONT^ZZSTFDU
 ;;Update tracking file
 ;S HDFDA(7118.27,HDIENS,4)=HDNBR
 ;S HDFDA(7118.27,HDIENS,6)=$$NOW^XLFDT()
 ;D FILE^DIE("","HDFDA","HDEMSG")
 ;D CLEAN^DILF
 ;;Update screen
 ;D HLOFF^ZZSTFDU(HDLNBR)
 ;D FLDTEXT^VALM10(HDLNBR,"STATUS","ERROR ("_HDNBR_")")
 ;D FLDTEXT^VALM10(HDLNBR,"LDATE",$$FMTE^XLFDT($$GET1^DIQ(7118.27,HDIENS,6,"I"),2))
 ;;D WRITE^VALM10(HDLNBR)
 Q
 ;
