ZVHDATE  ; OIA/TJH - populate DATE RANGE FOR BCMA data ;3/4/15
 ;;0.1;NO PKG;**NO PATCHES**;Dec  1, 2013
 ;
 ; This routine will populate date range for BCMA meds
 ; administrations for selected patients
 ;
 ; called by ZVHBC, ZVHBC3, ZVHBCMN
 ;
 ;[3/3/15 ajc - reworking to add times to the start and end dates]
 ;-----------------------------------------------------------------------
 ;
 Do EN Quit  ; enter at label
 ;
 ; DO Date Range Select Label
EN(SDATE,EDATE,ZVHDTARY) ;ENTRY POINT
 KILL ^TMP("ZVHDTARY",$J)
 NEW SDATE,EDATE SET (SDATE,EDATE)=""  ; For start and end date
 DO GETDT(.SDATE,.EDATE,.ZVHDTARY)   ;  create a start and stop date
 IF 'SDATE,'EDATE DO  QUIT
 . WRITE !,?5,"Missing Date(s)",!! QUIT  ; exit
 ;
 ; DO Date ARRAY label using SDATE, EDATE
 NEW ZVHDTARY ; SET ZVHDTARY=""
 ;DO DTARRAY(.SDATE,.EDATE,.ZVHDTARY)
 Do DTRA2(.SDATE,.EDATE) ; [3/4/15 AJC]
 IF $DATA(ZVHDTARY)'>9 QUIT  ; exit routine
 ;
 ;debug
 ;ZWRITE SDATE,EDATE,ZVHDTARY,^TMP("PSJ",$J,1,0)
 ;N READY W !,"Ready to continue?  " R READY
 ;IF READY["NO" QUIT
 ;KILL READY
 ;debug
 ;
GETDT(SDATE,EDATE,ZVHDTARAY) ; Get date range from user - pass in SDATE, EDATE by
 ; reference, returns the start and end date
 ;
 ; get start date using DI Read
 NEW DIR,Y,DTOUT,DUOUT,DIRUT
 ;SET DIR(0)="D",DIR("A")="Enter start date for Medication Administrations" [3/3/15 AJC]
 Set DIR(0)="DOA^1:9999999.999999:EXT"
 Set DIR("A")="Enter start date for Medication Administrations: "
 DO ^DIR KILL DIR
 QUIT:$G(DTOUT)!$G(DUOUT)!$G(DIRUT) ; quit if the user times out, enters ^ or null
 SET:$DATA(Y) SDATE=+Y  ; if data returned, set SDATE & convert to $h
 KILL Y
 ;
 ; get end date using DI read
 NEW DIR,Y,DTOUT,DUOUT,DIRUT
 ; Set DIR(0)="D",DIR("A")="Enter the Ending date" [3/3/15 ajc]
 Set DIR(0)="DOA^1:9999999.999999:EXT"
 Set DIR("A")="Enter the Ending date: "
 DO ^DIR KILL DIR
 QUIT:$G(DTOUT)!$G(DUOUT)!$G(DIRUT) ; quit if the user times out, enters ^ or null
 SET:$DATA(Y) EDATE=+Y ; if data returned, set EDATE and convert date to $H
 KILL Y
 ;
 ; Switch the dates if needed
 NEW TEMP
 IF SDATE>EDATE SET TEMP=EDATE,EDATE=SDATE,SDATE=TEMP
 KILL TEMP
 ;
 ; Ask user to Verify the date range
 WRITE !,?5,"We will make entries from ",$$FMTE^XLFDT(SDATE)," to ",$$FMTE^XLFDT(EDATE),!
 NEW DIR,Y,DTOUT,DUOUT,DIRUT SET DIR(0)="Y",DIR("A")="Is this correct?"
 DO ^DIR KILL DIR
 QUIT:$G(DTOUT)!$G(DUOUT)!$G(DIRUT) ; quit if the user times out, enters ^ or null
 IF Y(0)="NO" SET (SDATE,EDATE)="" QUIT
 KILL Y
 WRITE !!
 ;
 ;convert to $h - moved to the end to fix midnight display error
 ;SET SDATE=$$FMTH^XLFDT(SDATE),EDATE=$$FMTH^XLFDT(EDATE)
 ;
 QUIT  ; label GETDT
 ;
DTARRAY(SDATE,EDATE,ZVHDTARY) ; Build the date array using start, end date
 ; pass start and end dates and array by reference.
 ; Return the Date Array in ZVHDTARY
 ;[3/3/15 AJC - ADDING TIMES]
 WRITE ?5,"Setting up the date range..."
 If '$Data(SDATE)!'$Data(EDATE) Write "Start and end dates are required!" Quit ; [3/3/15 ajc]
 ;
 ;[3/3/15 AJC] add the start and end date/time to the array first 
 Set ZVHDTARY($$HTFM^XLFDT(SDATE))=""
 Set ZVHDTARY($$HTFM^XLFDT(EDATE))=""
 Set SDATE=$Piece(SDATE,",")+1 ; change horolog date/time to date only
 Set EDATE=$Piece(EDATE,",")-1 ; change horolog date/time to date only
 If SDATE=EDATE Set ZVHDTARY($$HTFM^XLFDT(SDATE))="" ; only one day between them... add it to the array.
 If SDATE'<EDATE Merge ^TMP("ZVHDTARY",$J)=ZVHDTARY Quit ; there are no dates between start date and end date
 ; [end changes 3/3/15 ajc]
 ;
 ;now add all the dates in between without a time
 NEW I SET ^TMP("ZVHDTARY",$J)=""
 FOR I=SDATE:1:EDATE Do 
 . Quit:I=EDATE ;[3/4/15 AJC]
 . SET ZVHDTARY($$HTFM^XLFDT(I))="" ; ZVHDTARY compiled in $H then converted from to FM date.
 IF $DATA(ZVHDTARY)>9 WRITE "  DONE!",!!
 ELSE  WRITE " ERROR!!!",!!
 M ^TMP("ZVHDTARY",$J)=ZVHDTARY
 ;
 QUIT  ; label DTARRAY
 ;  GOAL TAKE A DATE RANGE ENTERED BY USER IN EXTERNAL FORMAT
 ; CONVERT IT TO A $H DATE RANGE
 ; THEN CONVERT THE FILEMAN DATES FOR USE IN ORDER ENTERING.
 ;
 ;
 ;IDEA FOR DATE/TIME CHANGES:
 ; DEV>N DIR,X,Y S DIR(0)="DA^3000000:9999999:EXR",DIR("A")="ENTER DATE: "
 ; DEV 1S1>D ^DIR
 ; ENTER DATE: T ??
 ; This response must be a date and time.
 ; ENTER DATE: N  (APR 10, 2014@13:42)
 ; DEV 1S1>ZW X,Y
 ; X="N"
 ; Y=3140410.1342
 ; Y(0)="APR 10,2014@13:42"
 ;
 ;
SINGLE(DATE)    ; select a single date [8/26/14 ajc]
 ; required: pass by reference DATE, will return a Fileman date in it.
 ;
 NEW DIR,DIRUT,DIROUT,X,Y,DTOUT,DUOUT,DA ; vars for DI Read
 SET DIR(0)="D"
 SET DIR("B")="TODAY"
 DO ^DIR
 ; 
 IF $DATA(DIRUT)!$DATA(DIROUT)!(+Y'>0)!(+Y'?.N) DO  QUIT
 . WRITE !,?2,"ERROR: No Date selected.",!!!
 . SET DATE=-1 ; return a -1 for errors
 ELSE  SET DATE=+Y
 ;
 QUIT  ; label SINGLE
 ;
 ;
SELDTRG()       ; select a date range  [10/28/14 ajc]
 ;EXT OUT: -1 for error, 0 for failed to select, otherwise: "start date ^ end date"
 ;
 WRITE #,"Select a date range...",!
 WRITE ?2,"(For a single date, just enter it as the start and end dates)",!
 NEW SDATE,EDATE,OUT ; start date, end date, output
 WRITE "   " SET SDATE=$$SELDATE("Start")
 WRITE "   " SET EDATE=$$SELDATE("End")
 ;
 IF ($GET(SDATE)="")!($GET(EDATE)="") QUIT 0
 IF SDATE>EDATE DO  ; switch 'em
 . NEW TEMP
 . SET TEMP=SDATE,SDATE=EDATE,EDATE=TEMP
 ;
 SET OUT=SDATE_"^"_EDATE
 ;
 QUIT $GET(OUT) ; label SELDTRG
 ;
 ;
SELDATE(DISPLAY)        ; select a date in the PAST (no future dates)  [10/28/14 ajc]
 ;EXT OUT: -1 for error, 0 for failed to select, otherwise a valid FM date
 ;OPTIONAL: pass a string in DISPLAY for the display name (EX: Start for start date)
 ;
 NEW X,Y,%DT,DTOUT,DUOUT,DIRUT,DIROUT
 SET %DT="AEPST",%DT(0)="-NOW"
 SET %DT("A")=$SELECT($DATA(DISPLAY):"Select "_DISPLAY_" Date: ",1:"Select Date: ")
 DO ^%DT
 IF $GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) WRITE !!,"ERROR: No date selected.",!! QUIT 0
 IF Y=-1 WRITE !!,"ERROR: Unknown date selection error.",!! QUIT -1
 ;
 QUIT $GET(Y) ; label SELDATE
 ;
 ;
DTRA2(SDATE,EDATE) ; Build the date array using start, end date
 ; v2 for fileman date/time, not horolog
 ;REQUIRED: pass by reference: start (SDATE) and end (EDATE) dates in valid
 ;   fileman date/time. New ZVHDTARY before calling.
 ;      
 ; Returns the Date Array in ZVHDTARY
 ;
 ;[3/3/15 AJC - ADDING TIMES]
 ;[3/4/15 ajc - switching from $h to fileman date/times
 WRITE ?5,"Setting up the date range..."
 If '$Data(SDATE)!'$Data(EDATE) Do  Quit ; [3/4/15 ajc check input vars]
 . Write "Start and end dates are required!" 
 . Set ZVHDTARY=-1
 If SDATE'?7N.1".".6N!(EDATE'?7N.1".".6N) Do  Quit
 . Write !!,"ERROR: Not valid fileman date times"
 . Set ZVHDTARY=-1
 ; [end changes 3/4/15 ajc]
 ;
 ;[3/3/15 AJC] add the start and end date/time to the array first 
 Set ZVHDTARY(SDATE)=""
 Set ZVHDTARY(EDATE)=""
 Set SDATE=$Piece(SDATE,".") ; change date/time to date only
 Set EDATE=$Piece(EDATE,".") ; change date/time to date only
 If SDATE=EDATE Set ZVHDTARY(SDATE)="" ; only one day between them... add it to the array.
 If SDATE'<EDATE Merge ^TMP("ZVHDTARY",$J)=ZVHDTARY Quit ; there are no dates between start date and end date
 ; [end changes 3/3/15 ajc]
 ;
 ;now add all the dates in between without a time using FMADD [3/4/15 ajc]
 NEW I Set I=SDATE
 SET ^TMP("ZVHDTARY",$J)=""
 For  Set I=$$FMADD^XLFDT(I,1) Quit:I'<EDATE  Set ZVHDTARY(I)="" 
 IF $DATA(ZVHDTARY)>9 M ^TMP("ZVHDTARY",$J)=ZVHDTARY WRITE "  DONE!",!!
 ELSE  Set ^TMP("ZVHDTARY",$J)=-1 WRITE " ERROR: Date array was not set up!!",!!
 ;[end changes 3/4/15 AJC]
 ;
 QUIT  ; label DTARRAY
 ;
 ;
