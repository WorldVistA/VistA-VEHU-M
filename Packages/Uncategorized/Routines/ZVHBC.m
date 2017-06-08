ZVHBC ; OIA/AJC,TJH - Auto populate BCMA data ; 3/4/2015
 ;;0.1;NO PKG;**NO PATCHES**;Dec  1, 2013
 ;
 ; This routine will populate all the BCMA medication 
 ; administrations for selected patients and date range
 ;
 ;  HOW TO USE THIS ROUTINE
 ;    After Log in (or D ^XUP) has set up the variables for 
 ;    your screen, then enter at the EN label.
 ; 
 ;    Example:  >DO EN^ZVHBC
 ;
 ;    If you want to automate this using TaskMan, see ZVHBC3
 ;
 ;-----------------------------------------------------------------------
 ;[2014aug20 AJC] improve error tracking
 ;[2015MAR3 AJC ] allow date/times for start and end date
 ;-----------------------------------------------------------------------
 Do EN Quit ; enter at a label
 ;
EN ; Entry point
 ; Check for Production environment, quit if true
 NEW ZVHCHECK SET ZVHCHECK=$$PROD^XUPROD(1)
 IF ZVHCHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ELSE  WRITE !!,"OK!  This is a TEST account, proceeding...",!!
 IF '$DATA(U)!('$DATA(DUZ))!('$DATA(DUZ(2)))!('$DATA(IOF)) WRITE "Need to log in or D ^XUP first!" QUIT  ;
 ;
 NEW %,DG,DIC,DICR,DIW,ERR,X,X1,X2,TYP ; variables used by routines called
 ;
 ; Error trapping and display
 KILL ZVHERR SET ZVHERR=0
 ;
 NEW ZVHFILE DO SAVE(.ZVHFILE) ; this var will be used to determine if we save or just view
 ;
 New SILENT Set SILENT=0 ; default to not silent
 ;
 DO GETPT ; get patients
 DO GETDATE ; get dates
 DO PAT(IOF,$GET(ZVHFILE)) ; loop through the patients
 DO CKGBL ; check the global for errors
 IF $GET(ZVHERR) DO CKERROR ; check for errors
 DO CLEAN ; clean up the globals
 ;
 WRITE ?15,"All done, Goodbye.",!
 QUIT  ; Routine ZVHBC
 ;
 ;
CKGBL	; Check the ^PSB(53.79 global for errors
 ; get the start and end date from the date array
 ;FUTURE: add error handling
 NEW START,END
 SET START=$ORDER(^TMP("ZVHDTARY",$J,""))
 SET END=$ORDER(^TMP("ZVHDTARY",$J,""),-1)
 DO CHECK^ZVHFIX(START,END,SILENT)
 ;
 QUIT  ; label CKGBL
 ;
 ;
SAVE(ZVHFILE) ; ask user if we will save or just view an example
 ;
 NEW DIR,Y
 WRITE "This routine can enter BCMA medication administrations for the Patient(s)",!
 WRITE "and date range that you choose.",!!
 WRITE "Do you want to save the data into the BCMA files, or just view",!
 WRITE "an example?",!
 S DIR(0)="SO^S:S. Save the data to the BCMA file;V:V. View an example"
 S DIR("L",1)="Please choose S or V:"
 S DIR("L",2)=""
 S DIR("L",3)="   S. Save the data to the BCMA file"
 S DIR("L")="   V. View an example"
 D ^DIR
 ;
 I Y="S" SET ZVHFILE=1 WRITE !,"WARNING: Preparing the Data to SAVE in the BCMA Files",!
 KILL DIR,Y
 ;
 QUIT  ;label SAVE
 ;
 ;
GETPT ; get patients
 DO EN^ZVHPAT ; call Tom's routine to set up patients in ^TMP global
 IF $DATA(^TMP("ZVHPAT",$J))'>9 WRITE !,?5,"No patients selected",!! QUIT  ;
 ;
 QUIT  ; label GETPT
 ;
 ;
GETDATE ; get dates
 DO EN^ZVHDATE ;USE TOM'S DATE SELECTION
 IF $DATA(^TMP("ZVHDTARY",$J))'>9 WRITE !,?5,"No dates selected",!! DO CLEAN QUIT  ; exit routine
 ;
 QUIT  ; label GETDATE
 ;
 ;
PAT(IOF,ZVHFILE,SILENT) ; get the data for entry
 WRITE @IOF ; set up the screen
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 ; start loop thru patient array
 NEW ZVHPT SET ZVHPT="" ; var for patient
 FOR  SET ZVHPT=$ORDER(^TMP("ZVHPAT",$J,(ZVHPT))) QUIT:'ZVHPT  DO
 . WRITE !,"Adding meds for patient ",$P($G(^DPT(ZVHPT,0)),"^"),!
 . NEW ZVHROOM,START,END
 . SET ZVHROOM=$$GET1^DIQ(2,ZVHPT,.1)_" "_$$GET1^DIQ(2,ZVHPT,.101) ; get ward location and room bed
 . SET START=$ORDER(^TMP("ZVHDTARY",$J,"")) ; start date
 . SET END=$ORDER(^TMP("ZVHDTARY",$J,""),-1) ; end date/time
 . ; [3/4/15 AJC - if no end date without time, use 24:00 of the LAST date in the array
 . IF $GET(END)'["." SET END=+(END_.24)  
 . ;
 . ; ----------- Continuous IV infusions -------------------------
 . NEW ZVHERRIV S ZVHERRIV=0 ; for errors
 . ;DO IV^ZVHBCIV(ZVHPT,ZVHROOM,$GET(ZVHFILE),SILENT,END,.ZVHERRIV)  ;
 . ;DO IVCONT^ZVHBCIV(ZVHPT,ZVHROOM,$GET(ZVHFILE),SILENT,START,END,.ZVHERRIV)
 . IF ZVHERRIV SET ZVHERR=1,ZVHERR("NOW","IV",$J,ZVHPT)=$$GET1^DIQ(2,ZVHPT,.01) ;[2014aug20 AJC]
 . ;IF ZVHERR DO CKERRORS ;debug
 . ;
 . ; ---------- PRN meds -----------------------------------------
 . NEW ZVHERRPRN SET ZVHERRPRN=0 ; for errors
 . DO PRN^ZVHBC1(ZVHPT,ZVHROOM,START,END,$GET(ZVHFILE),.ZVHERRPRN,SILENT) ; do the PRN meds
 . IF ZVHERRPRN SET ZVHERR=1,ZVHERR("PRN",$J,ZVHPT)=$P($G(^DPT(ZVHPT,0)),"^") ;[2014aug20 AJC]
 . ;IF ZVHERR DO CKERROR ;debug
 . ;
 . ; ---------- One time and On call meds ------------------------
 . NEW ERRONETM SET ERRONETM=0 ; var for errors
 . DO ONETM^ZVHBC2(ZVHPT,ZVHROOM,.ERRONETM,$GET(ZVHFILE),END,SILENT) ; do the one time meds
 . IF $GET(ERRONETM) SET ZVHERR=1,ZVHERR("1TIME",$J,ZVHPT)=$P($G(^DPT(ZVHPT,0)),"^") ;[2014aug20 AJC]
 . ;IF ZVHERR DO CKERROR ;debug
 .;
 . ; ---------- Continuous/scheduled meds ------------------------
 . NEW ZVHERRSCH SET ZVHERRSCH=0 ; for errors
 . DO CNSCH(ZVHPT,ZVHROOM,.ZVHERRSCH,$GET(ZVHFILE),END,SILENT)
 . IF ZVHERRSCH SET ZVHERR=1,ZVHERR("SCH",$J,ZVHPT)=$P($G(^DPT(ZVHPT,0)),"^") ;[2014aug20 AJC]
 . ;IF ZVHERR DO CKERROR ;debug
 . WRITE !,"Patient ",$P(^DPT(ZVHPT,0),"^")," is DONE!  DFN=",ZVHPT
 . ;DEBUG
 . ;ZWRITE
 . ;NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Ready for the next Patient? Y to continue or CTRL-C to exit "
 . ;DO ^DIR KILL DIR
 . ;IF Y(0)="NO" QUIT
 . ;KILL Y
 . ;DEBUG
 . WRITE !
 ;
 QUIT  ; label PAT
 ;
 ;
CNSCH(ZVHPT,ZVHROOM,ZVHERRSCH,ZVHFILE,END,SILENT) ; Continuous and scheduled meds only
 ;pass by ref: ZVHERRSCH (error debug) 
 ;
 ;pass by value: ZVHPT (Patient IEN) ZVHROOM (Patient room/bed location) 
 ;  ZVHFILE (1 for save) END (end date/time in Fileman format) SILENT (1 for reduced output)
 ;
 ;required: ZVHPT ZVHROOM ZVHERRSCH
 ;[3/4/15 AJC - allow times for start and end dates]
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 ;
 ;QUIT:ZVHPT=""!(ZVHROOM="")!'$DATA(ZVHERRSCH) ; handle bad inputs better [3/4/15 AJC]
 If '$Data(ZVHPT)!'$Data(ZVHROOM) Do  Quit
 . Write:'SILENT "ERROR: Need patient and room-bed",!
 . Set (ZVHERRSCH,ZVHERR)=1
 . Set ZVHERR("ZVHBC","CNSCH",$J)=$G(ZVHPT)_U_$G(ZVHROOM)_U_$G(ZVHFILE) ; [end 3/4/15 AJC]
 ;
 IF $GET(END)="" DO  ; if no end date is passed, use midnight of the last date in the array
 . NEW DATE SET DATE=$ORDER(^TMP("ZVHDTARY",$J,""),-1) ; get the last date in the array
 . If DATE'["." SET END=+(DATE_.24) ; append midnight if no time
 . Else  Set END=+DATE ; allow time [3/4/15 ajc]
 ;
 ;[3/4/15 AJC - get the start date/time]
 New SDATE Set SDATE=$Order(^TMP("ZVHDTARY",$J,""))
 ;
 ;b ;debug
 ;loop through the dates and then file the meds if ZVHFILE=1
 NEW ZVHDATE SET ZVHDATE="" ; ZVHDATE = Date
 ; start loop thru Date array
 IF 'SILENT WRITE ?1,"Scheduled Medications:",!
 FOR  SET ZVHDATE=$ORDER(^TMP("ZVHDTARY",$J,ZVHDATE)) QUIT:'ZVHDATE  DO
 . ;B ;debug
 .IF 'SILENT WRITE ?2,"Date: ",$$FMTE^XLFDT(ZVHDATE,1),"  "
 .; get nurses who are active on that date
 .NEW ZVHDUZ,ZVHUSARRAY,ZVHERRUS SET (ZVHDUZ,ZVHUSARRAY)="",ZVHERRUS=0 ; var for DUZ, active users, errors
 .DO SELRN($P(ZVHDATE,"."),.ZVHUSARRAY,.ZVHERRUS,SILENT) ; [3/4/15 ajc add $p to zvhdate)
 .IF ZVHERRUS!($DATA(ZVHUSARRAY)'>9) DO  QUIT  
 ..IF 'SILENT WRITE " Can't file without nurses, skipping this date.",! 
 ..SET (ZVHERR,ZVHERRSCH)=1
 ..SET ZVHERR("CNSCH","USER",$J,ZVHPT)=$GET(ZVHDATE) ;[2014aug20 AJC]
 .NEW PSBOLDUZ,PSBOLSTS,PSJON ; ^PSJBCMA (?) might be the source of these leaks?
 .NEW ZVHERRMED SET ZVHERRMED=0 ; var for errors
 .DO ACTMED(ZVHPT,$P(ZVHDATE,"."),.ZVHERRMED,SILENT) ; ; [3/4/15 ajc add $p to zvhdate)
 .IF ZVHERRMED DO  QUIT  ; error trap
 ..SET (ZVHERR,ZVHERRSCH)=1
 ..SET ZVHERR("CNSCH","ACTMED",$J,ZVHPT)=$GET(ZVHDATE) ;[2014aug20 AJC] 
 ..IF 'SILENT WRITE !,?5,"ERROR in Active Meds.",!
 .IF $GET(^TMP("PSJ",$J,1,0))=-1 DO  QUIT  
 ..IF 'SILENT WRITE !!,?5,"No active meds for this date!",!
 .; build the MED array for cont/sch meds
 .NEW MEDARRAY,MED SET (MEDARRAY,MED)="" ; var for meds array, medication
 .IF 'SILENT WRITE ?6,"Building Active Meds array..."
 .FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO  ; set up array of continuous, scheduled meds
 ..;BREAK ;debug
 ..; check for continuous, scheduled in PSJ
 ..QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",2)'="C"  ; not continuous
 ..QUIT:$PIECE($GET(^TMP("PSJ",$J,MED,1)),"^",6)=""  ; no schedule
 ..NEW ON ; Order number for ^OR(100
 ..SET ON=$PIECE(^TMP("PSJ",$J,MED,0),"^",9)
 ..IF ON[";" SET ON=$PIECE(ON,";") ; Strip the version numbers
 ..;check status, start and stop dates in OR
 ..QUIT:$PIECE(^OR(100,ON,3),"^",3)'=6 ; quit if not an active order
 ..; [3/4/15 ajc - adding time, next 2 lines]
 ..;QUIT:$PIECE(^OR(100,ON,0),"^",8)'<(ZVHDATE_.24) ; replaced
 ..Quit:(ZVHDATE'[".")&($PIECE(^OR(100,ON,0),"^",8)'<(ZVHDATE_.24))  ; future order start date
 ..Quit:(ZVHDATE[".")&($PIECE(^OR(100,ON,0),"^",8)'<(ZVHDATE))  ; future order start date
 ..QUIT:$PIECE(^OR(100,ON,0),"^",9)'>ZVHDATE  ; order stop date in the past
 ..SET MEDARRAY(MED)=""
 .IF 'SILENT WRITE " DONE!",!
 .;
 .; start loop thru the med array
 .NEW ZVHMED SET ZVHMED=0
 .FOR  SET ZVHMED=$ORDER(MEDARRAY(ZVHMED)) QUIT:'ZVHMED  DO
 ..IF 'SILENT WRITE ?3,$E($P(^TMP("PSJ",$J,ZVHMED,3),"^",2),1,20),?25,"(IEN ",ZVHMED,")",! ; Medication
 ..;IF 'SILENT WRITE ! ; formatting only
 ..;next lines - get the frequency and see if we should give the med on this date
 ..NEW ZVHFREQ,ZVHERRFREQ SET ZVHFREQ="",ZVHERRFREQ=0 ; var for frequency, errors
 ..DO FREQ^ZVHBCOCK(ZVHPT,ZVHMED,.ZVHFREQ,.ZVHERRFREQ,SILENT) ; get frequency
 ..IF ZVHERRFREQ DO  QUIT  
 ...SET (ZVHERR,ZVHERRSCH)=1
 ...SET ZVHERR("CNSCH","FREQ",$J,ZVHPT)=$GET(ZVHMED)_U_$GET(ZVHDATE)_U_$GET(ZVHFREQ) ;[2014aug20 AJC]
 ..IF +ZVHFREQ'>0 DO  QUIT  ; skip if unable to get a freq
 ...IF 'SILENT WRITE ?15," ERROR! Unable to compute frequency, skipping.",! 
 ...SET ZVHERR("CNSCH","FREQ",$J,ZVHPT)=$GET(ZVHMED)_U_$GET(ZVHDATE) ;[2014aug20 AJC]
 ..NEW ZVHSKIP SET ZVHSKIP=0
 ..IF ZVHFREQ>86400 DO SKIP2^ZVHBCOCK(ZVHPT,ZVHMED,$P(ZVHDATE,"."),ZVHFREQ,.ZVHSKIP,SILENT) ; meds given less often than daily, see if should be given this date
 ..IF ZVHSKIP["ERROR" DO  QUIT  
 ...SET (ZVHERR,ZVHERRSCH)=1
 ...SET ZVHERR("CNSCH","SKIP",$J,ZVHPT)=$GET(ZVHMED)_U_$GET(ZVHDATE)_U_$GET(ZVHFREQ) ;[2014aug20 AJC]
 ..IF ZVHSKIP DO  QUIT
 ...IF 'SILENT WRITE ?15," Skipping for this date/time.",! 
 ..;next lines - get the scheduled admin times, store them in the ZVHTIMES as an array
 ..NEW ZVHTIMES,ZVHERRSCH SET ZVHTIMES="",ZVHERRSCH=0
 ..DO SCHTM(.ZVHTIMES,ZVHMED,$P(ZVHDATE,"."),ZVHPT,.ZVHERRSCH,SILENT)
 ..IF ZVHERRSCH DO  QUIT  
 ...SET (ZVHERR,ZVHERRSCH)=1
 ...SET ZVHERR("CNSCH","TIMES",$J,ZVHPT)=$GET(ZVHMED)_U_$GET(ZVHDATE)_U_$GET(ZVHTIMES) ;[2014aug20 AJC]
 ...IF 'SILENT WRITE ?15," No schedule, skipping... ",!
 ..; start loop thru scheduled times
 ..NEW ZVHSCHTM SET ZVHSCHTM=""
 ..FOR  SET ZVHSCHTM=$ORDER(ZVHTIMES(ZVHSCHTM)) QUIT:'ZVHSCHTM  DO
 ...NEW ZVHGIVEN SET ZVHGIVEN=1 ; default to already given
 ...;next line - see if its been given. send Patient, PSJ Order number, Scheduled date/time, and var for given.
 ...DO EN^ZVHBCOCK(ZVHPT,$PIECE($GET(^TMP("PSJ",$J,ZVHMED,0)),"^",3),(+$P(ZVHDATE,".")_+ZVHSCHTM),.ZVHGIVEN,SILENT) ; if cont scheduled med, see if given already
 ...IF ZVHGIVEN DO  QUIT  ; skip this one, its already given
 ....IF 'SILENT WRITE ?35,ZVHSCHTM,"   Already given.",!
 ...;next line: the max # of active nurses is stored in the 2nd piece of ZVHUSARRY(0)
 ...NEW ZVHDUZ SET ZVHDUZ=$RANDOM($PIECE(ZVHUSARRAY(0),"^",2))+1 ; select a random nurse from the active nurses array
 ...SET ZVHDUZ=ZVHUSARRAY(ZVHDUZ)
 ...; choose a random time
 ...NEW ZVHGVNTM SET ZVHGVNTM="" ; var for time medication is given
 ...DO SELTM(ZVHSCHTM,.ZVHGVNTM,.ZVHERRTIME,SILENT) ; continuous scheduled meds only
 ...IF ZVHGVNTM="ERROR" DO  QUIT  ; quit this loop if error
 ....SET (ZVHERR,ZVHSCH)=1
 ....SET ZVHERR("CNSCH","TIMES",$J,ZVHPT)=$GET(ZVHMED)_U_$GET(ZVHDATE)_U_$GET(ZVHSCHTM) ;[2014aug20 AJC] 
 ....IF 'SILENT WRITE ?5," Scheduled Time ERROR, skipping... ",!  
 ...;[3/4/15 ajc - if zvhdate has a time (like start and end dates) drop the time] 
 ...;NEW ZVHGVNDTTM SET ZVHGVNDTTM=ZVHDATE_ZVHGVNTM
 ...NEW ZVHGVNDTTM SET ZVHGVNDTTM=$P(ZVHDATE,".")_ZVHGVNTM
 ...IF ZVHGVNDTTM>END DO  QUIT ; quit if it's after the end date/time
 ....WRITE:'SILENT ?25,$$FMTE^XLFDT(ZVHGVNDTTM)," is after end date/time.",! 
 ....;ELSE  WRITE ?55,$GET(ZVHSCHTM),!
 ...; PASS the entries to FILEMAN via UPDATE^DIE
 ...; [3/4/15 AJC - quit if before start date/time]
 ...If ZVHGVNDTTM<SDATE Do  Quit ; quit if it is before the start date/time
 ....Write:'SILENT ?25,$$FMTE^XLFDT(ZVHGVNDTTM)," is before the start date/time.",!
 ...; [3/4/15 ajc - end changes]
 ...NEW ZVHFDA,DIERR,ZVHERRUD SET ZVHERRUD=0 ; ZVHFDA = array for fileman, DIERR = error variable ZVHERRUD for errors
 ...IF $PIECE(^TMP("PSJ",$J,ZVHMED,0),"^",3)["U" DO  ; for unit dose meds
 ....DO UD^ZVHBC1(.ZVHFDA,ZVHMED,.ZVHERRUD) ; set up the Unit Dose only fields
 ...IF ZVHERRUD DO  QUIT  ; skip to next med, save for debug
 ....SET (ZVHERR,ZVHERRSCH)=1
 ....SET ZVHERR("CNSCH","UNIT DOSE",$J,ZVHPT)=$GET(ZVHDATE)_U_$GET(ZVHMED)_U_$GET(ZVHSCHTM) ;[2014aug20 AJC]
 ....IF 'SILENT WRITE ?30,"ERROR in Unit Dose, skipping... ",! 
 ...NEW ZVHERRMED SET ZVHERRMED=0 ; var for errors
 ...IF $PIECE(^TMP("PSJ",$J,ZVHMED,0),"^",3)["V" DO  ; for IV meds
 ....DO IVONE^ZVHBC1(.ZVHFDA,ZVHMED,ZVHPT,$P(ZVHDATE,"."),.ZVHERRIV,.ZVHERRMED,SILENT) ; setup the IV fields.
 ...IF ZVHERRMED DO  QUIT  ; error skip to next med
 ....SET (ZVHERR,ZVHERRSCH)=1
 ....SET ZVHERR("CNSCH","IVONE",$J,ZVHPT)=$GET(ZVHDATE)_U_$GET(ZVHMED)_U_$GET(ZVHSCHTM) ;[2014aug20 AJC] 
 ....IF 'SILENT WRITE ?30,"ERROR in IV, skipping... ",! 
 ...SET ZVHFDA(53.79,"+1,",.12)="C" ; Cont scheduled meds only, not PRN, one time, or on call ("C" for continuous)
 ...SET ZVHFDA(53.79,"+1,",.13)=(+$P(ZVHDATE,".")_+ZVHSCHTM) ; scheduled time integer NOT string!
 ...NEW ZVHERRFDA SET ZVHERRFDA=0
 ...DO SETFDA^ZVHBC2(ZVHPT,ZVHROOM,ZVHGVNDTTM,ZVHDUZ,.ZVHFDA,ZVHMED,.ZVHERRFDA)
 ...IF ZVHERRFDA DO  QUIT  
 ....SET (ZVHERR,ZVHERRSCH)=1
 ....SET ZVHERR("CNSCH","SETFDA",$J,ZVHPT)=$GET(ZVHROOM)_U_$GET(ZVHGVNDTTM)_U_$GET(ZVHDUZ) ;[2014aug20 AJC] 
 ...NEW ZVHERRUPDATE,IEN SET ZVHERRUPDATE=0,IEN=""
 ...;B ;debug
 ...IF $GET(ZVHFILE) DO UPDATE^ZVHBC2(ZVHFILE,.IEN,ZVHMED,.ZVHERRUPDATE,SILENT)
 ...IF ZVHERRUPDATE DO  QUIT  
 ....SET (ZVHERR,ZVHERRSCH)=1
 ....SET ZVHERR("CNSCH","UPDATE",$J,ZVHPT)=$GET(ZVHROOM)_U_$GET(ZVHGVNDTTM)_U_$GET(ZVHDUZ)_U_$GET(ZVHMED)_U_$G(ZVHFILE)_U_$G(IEN) QUIT  ;[2014aug20 AJC]
 ...IF SILENT DO  
 ....WRITE ?3,$E($P(^TMP("PSJ",$J,ZVHMED,3),"^",2),1,20)," (",ZVHMED,")" ; Medication
 ....WRITE ?35,"USER #: ",ZVHDUZ
 ....WRITE ?55,$G(ZVHSCHTM)," done at ",ZVHGVNTM,!
 ...ELSE  DO  
 ....WRITE ?6,"USER #: ",ZVHDUZ,"  ",$P(^VA(200,ZVHDUZ,0),"^"),"  "
 ....WRITE ?55,$G(ZVHSCHTM)," done at ",ZVHGVNTM,!
 ...;IF ZVHERR DO CKERROR ;debug
 ...DO CLEAN^DILF ; kills the ^TMP globals from ^DIE
 ..IF 'SILENT WRITE ?5,"Medication ",$P(^TMP("PSJ",$J,ZVHMED,3),"^",2)," DONE!",! ;
 ..;ELSE  WRITE !
 .IF 'SILENT WRITE ?2,"Date of ",$$FMTE^XLFDT(ZVHDATE,1)," DONE!",!
 ;
 QUIT  ; label SCH
 ;
 ;
CKERROR ; check for errors, display and save if wanted
 IF $GET(ZVHERR) DO
 . WRITE !,?5,"There are errors!",!
 . NEW DIR,Y SET DIR(0)="Y",DIR("A")="     Do you want to view the error logs?"
 . DO ^DIR
 . QUIT:Y(0)="NO"
 . ELSE  WRITE ! ZWRITE ZVHERR
 . KILL Y,DIR
 SET ZVHERR=0
 ;
 QUIT  ; label CKERROR
 ;
 ;
CLEAN ; clean up the globals used
 WRITE !,?5,"Clearing the TMP globals... "
 KILL ^TMP("ZVHPAT",$J) ; Remove the patient array global
 KILL ^TMP("PSJ",$J) ; Remove the meds array global
 KILL ^TMP("ZVHDTARY",$J) ; remove the date array global
 KILL ^TMP("ZVHERROR",$J) ; remove the error data
 DO CLEAN^DILF ; kills the ^TMP globals from ^DIE
 WRITE "DONE!!",!!
 ;
 IF $DATA(ZVHERR)>9 DO  
 . WRITE !!,?2,"NOTE: There is error data stored in ZVHERR",!!
 . WRITE ?2,"Be sure to kill it when you are done reviewing.",!!
 ELSE  KILL ZVHERR ; if there are no errors then OK to kill ZVHERR
 ;
 QUIT  ; label CLEAN
 ;
 ;
ACTMED(ZVHPATIENT,ZVHDATE,ZVHERRMED,SILENT) ; Generate a list of active meds using existing BCMA calls.
 ;REQUIRED:
 ; pass by value: ZVHPATIENT (patient),ZVHDATE (date)
 ; Pass by reference: ZVHERRMED (error)
 ;
 ; Medication Array is stored in ^TMP("PSJ",$J)
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; Defaults to not silent
 WRITE:'SILENT ?5," Getting meds..."
 ; next 3 lines are copied from EN1^PSBMLEN
 KILL ^TMP("PSJ",$J)
 DO EN^PSJBCMA(ZVHPATIENT,ZVHDATE,"")
 IF $GET(^TMP("PSJ",$J,1,0))=-1 DO  QUIT  ;
 . IF 'SILENT WRITE " No active medications! SKIPPING THIS DATE!!",!!
 . ;SET ZVHERRMED=1,ZVHERR("ACTMED",ZVHPATIENT,ZVHDATE,"No active meds")="" ; return error for debug
 ELSE  WRITE:'SILENT " DONE!",!
 ;
 QUIT  ; label ACTMED
 ;
 ;
SCHTM(ZVHTIMES,ZVHMED,ZVHDATE,ZVHPATIENT,ZVHERRSCH,SILENT) ; Get the Scheduled admin times from ^PSJBCMA
 ; Pass by reference: ZVHTIMES (times), ZVHERRSCH (errors)
 ; pass by value: ZVHMED (medication), ZVHDATE (date), ZVHPATIENT (patient)
 ; Return the Times array in variable ZVHTIMES
 IF $GET(SILENT)="" SET SILENT=0
 IF 'SILENT WRITE ?5,"Getting Scheduled Times..."
 ;
 NEW ZVHCOUNT,ZVHSCH,ZVHHOUR,ZVHNOW SET (ZVHCOUNT,ZVHHOUR,ZVHSCH)=""
 SET ZVHNOW=$$NOW^XLFDT ; get now to use for PRN, One times, on call
 SET ZVHNOW=$EXTRACT(ZVHNOW,8,12) ; just use the hour minutes returned
 ; ZVHSCH=array of scheduled time(s), ZVHHOUR=scheduled time
 ;
 IF $PIECE(^TMP("PSJ",$J,ZVHMED,1),"^",2)="C" DO  ; Continuous meds only
 . SET ZVHSCH=$PIECE($GET(^TMP("PSJ",$J,ZVHMED,1)),"^",6) ; this is the scheduled times
 . ; now loop thru the scheduled times, and add them to the TIMES array
 . FOR ZVHCOUNT=1:1:$LENGTH(ZVHSCH,"-") SET ZVHHOUR=$PIECE(ZVHSCH,"-",ZVHCOUNT) QUIT:ZVHHOUR=""  DO
 . . SET ZVHHOUR="."_ZVHHOUR ; add a . on the front of hour to force it to be a string
 . . IF $P(ZVHHOUR,".",2)?4N SET ZVHTIMES(ZVHHOUR)="" QUIT  ;       4 digit ok, add to array
 . . IF $P(ZVHHOUR,".",2)?3N SET ZVHTIMES(ZVHHOUR_"0")="" QUIT  ;   change 3 digit to 4
 . . IF $P(ZVHHOUR,".",2)?2N SET ZVHTIMES(ZVHHOUR_"00")="" QUIT  ;  change 2 digit to 4
 . . IF $P(ZVHHOUR,".",2)?1N SET ZVHTIMES(ZVHHOUR_"000")="" QUIT  ; change 1 to 4
 . . ELSE  DO  QUIT
 . . . SET ZVHERRSCH(ZVHCOUNT,ZVHHOUR,ZVHSCH,ZVHMED,ZVHDATE,ZVHPATIENT)="" ; for debug
 . . . IF 'SILENT WRITE "Schedule error... check log.",!
 ;
 ; next 2 lines: if data in the TIMES array, write DONE, else no time select
 IF 'SILENT DO  
 . IF $DATA(ZVHTIMES)>9 WRITE " DONE!",!
 . ELSE  WRITE "  No times selected.",!
 ;
 QUIT  ; label SCHTM
 ;
 ;
SELRN(ZVHDATE,ZVHUSARRAY,ZVHERRUS,SILENT) ; create an array of active nurses for the date
 ; pass by value: ZVHDATE (Date of med admin) SILENT
 ; pass by ref: ZVHUSARRAY (array of users), and ZVHERRUS (error tracking)
 ; start with ORELSE key holders, then check person class. If they have an
 ; active person class in the nursing service providers specialty, add them to array
 ;WRITE "  Getting list of Active Nurses... "
 IF $GET(SILENT)="" SET SILENT=0 ; Defaults to not silent
 NEW ZVHCOUNT,ZVHDUZ SET (ZVHDUZ,ZVHCOUNT)=""
 FOR ZVHDUZ=0:0 SET ZVHDUZ=$ORDER(^XUSEC("ORELSE",ZVHDUZ)) QUIT:'ZVHDUZ!(ZVHCOUNT>49)  DO
 . NEW ZVHPC SET ZVHPC=$$GET^XUA4A72(ZVHDUZ,ZVHDATE)
 . ; returns IEN^Occupation^specialty^sub-specialty^Effective date^expiration date^VA Code^specialty code
 . IF ZVHPC'>0 QUIT  ;inactive, skip this IEN
 . IF $PIECE(ZVHPC,"^",2)="Nursing Service Providers" DO  QUIT  ; these are active nurses
 . . SET ZVHCOUNT=ZVHCOUNT+1
 . . SET ZVHUSARRAY(ZVHCOUNT)=ZVHDUZ
 . . SET ZVHUSARRAY(0)="Active Nurses"_"^"_ZVHCOUNT ; use this for $random
 . ELSE  QUIT  ; not nursing, so skip
 ; check user array, pass error if empty
 IF $DATA(ZVHUSARRAY)'>9 DO
 . SET ZVHERRUS(ZVHDATE)=" No active Nurses!" 
 . IF 'SILENT WRITE ZVHERRUS(ZVHDATE)
 ;ELSE  WRITE "DONE!",!
 ;
 QUIT  ; label SELRN2
 ;
 ;
SELTM(ZVHSCHTM,ZVHGVNTM,ZVHERRTIME,SILENT) ;
 ; Select a random time within 59 minutes of scheduled time
 ; Pass by reference: ZVHGVNTM (given time), ZVHERRTIME (erros)
 ; pass by value: ZVHSCHTM it needs to be a 5 digit string, starting with
 ; a . followed by the military time as a 2 digit hour and 2 digit minutes
 ; check ZVHSCHTM, quit if it is the wrong format
 IF $GET(SILENT) SET SILENT=0 ; default to not silent
 IF ($EXTRACT(ZVHSCHTM,1)'=".")!($EXTRACT(ZVHSCHTM,2,5)'?4N) DO  QUIT  ;
 . SET ZVHERRTIME(ZVHSCHTM)="",ZVHGVNTM="ERROR" ; store error and input for debug
 . WRITE "ERROR in Scheduled time!",!
 ;
 ; Goal: Add the random variable if even, subtract if odd
 NEW ZVHRANDOM SET ZVHRANDOM=$RANDOM(60) ; variable for selecting minutes
 NEW ZVHHOUR,ZVHMIN SET (ZVHHOUR,ZVHMIN)="" ; var for hour, minutes
 ; next line: if the scheduled time is after 11:30pm set hours to midnight
 IF +($P(ZVHSCHTM,".",2))>2330 SET ZVHSCHTM=".2400" ; will fix 2359
 SET ZVHHOUR=$EXTRACT(ZVHSCHTM,2,3) ; get hours, next line: get minutes
 IF $LENGTH($EXTRACT(ZVHSCHTM,4,5))=2 SET ZVHMIN=$EXTRACT(ZVHSCHTM,4,5)
 ELSE  SET ZVHMIN="00"
 ;
 IF ZVHRANDOM#2=1 DO  ; if random # is an odd number then subtract
 . SET ZVHMIN=(ZVHMIN-ZVHRANDOM) ; this will be given before scheduled time
 . IF ZVHMIN<0 DO  ; if ZVHMIN ended up negative, decrement the hour and add 60 to minutes
 . . SET ZVHMIN=60+ZVHMIN ; keep minutes positive
 . . SET:ZVHHOUR'<1 ZVHHOUR=ZVHHOUR-1  ; keep hour a positive number
 ELSE  DO
 . SET ZVHMIN=(ZVHMIN+ZVHRANDOM)
 . IF ZVHMIN>60 SET ZVHHOUR=ZVHHOUR+1,ZVHMIN=ZVHMIN-60 ; if minutes is greater than 60, increment hours
 . IF ZVHHOUR>23 SET ZVHHOUR=23
 ;
 IF +ZVHHOUR="" SET ZVHHOUR="00" ; keep 2 digit string
 IF +ZVHMIN="" SET ZVHMIN="00" ; keep 2 digit string
 IF $LENGTH(ZVHMIN)=1 SET ZVHMIN="0"_ZVHMIN ; need 2 digits
 IF $LENGTH(ZVHHOUR)=1 SET ZVHHOUR="0"_ZVHHOUR ; need 2 digits
 ;
 SET ZVHGVNTM="."_ZVHHOUR_ZVHMIN ; put them together
 ;next line: if the length of given time is not 4 digits, return error
 IF ZVHGVNTM'?1".".4N DO  QUIT  ;
 . SET (ZVHERR,ZVHERRTIME)=1
 . SET ZVHERR("SELTM",ZVHPT,ZVHMED,ZVHGVNTM,ZVHHOUR,ZVHMIN,ZVHSCHTM)="" ;for debug
 . SET ZVHGVNTM="ERROR"
 . WRITE:'SILENT "ERROR in Selecting time!"
 ;
 QUIT  ; SELTM label
 ;
 ;
TEST ; set up the globals only - for debug
 D GETPT,GETDATE W !
 D EN^PSJBCMA($O(^TMP("ZVHPAT",$J,"")),$O(^TMP("ZVHDTARY",$J,"")),"")
 ZW ^TMP("ZVHPAT",$J) W ! ; the patient array global
 ZW ^TMP("PSJ",$J) W ! ; the meds array global
 ZW ^TMP("ZVHDTARY",$J) W ! ; the date array global
 W !,"Don't forget to run CLEAN^ZVHBC when you are done!!"
 Q  ; label TEST
 ;
