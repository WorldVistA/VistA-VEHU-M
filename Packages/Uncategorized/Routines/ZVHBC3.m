ZVHBC3 ; OIA/AJC,TJH - Auto populate BCMA data ; 12/3/15 5:36pm
 ;;0.1;NO PKG;**NO PATCHES**; Apr  3, 2014
 ; AUTO POPULATE BCMA DATA - Silent options
 ;--------------------------------------------------------------------
 ;
 ;  HOW TO USE THIS ROUTINE
 ;   1. Add/remove patients in the DFN label below as needed
 ;
 ;   2. When testing, you can set the SAVE variable to zero or "" to
 ;      just view the output
 ;
 ;   3. For a less verbose output, you can set the SILENT variable to 1
 ;
 ;      Examples:  
 ;       >DO EN^ZVHBC3       <--<< This sets SAVE to "" and SILENT to ""
 ;       >DO EN^ZVHBC3(0,1)  <--<< This sets SAVE to zero and SILENT to 1
 ;       >DO EN^ZVHBC3(1,0)  <--<< This sets SAVE to 1 and SILENT to zero
 ;       >DO EN^ZVHBC3(1,1)  <--<< This sets SAVE to 1 and SILENT to 1 
 ;
 ;       The last example is the way it is run by >DO TASK^ZVHBC3
 ;
 ;  SETTING IT UP TO RUN AS A TASK
 ;   1. Add/Remove patients in the DFN label below as needed
 ;
 ;   2. Errors will be sent as alerts, and saved in an error log.  To get
 ;      the alerts, add your DUZ as a subvariable of XQA in ALERT+4.  
 ;         Example: for DUZ of 100 add SET XQA(100)=""
 ;      a. The error log will be saved in the default HFS, and its 
 ;         location will be in the alert.  
 ;      b. The name of the error log will be ZVHBC_error_log.txt
 ;      c. This error log should be deleted periodically
 ;
 ;   3. If a patient needs more barcodes for IVPB's or Infusions then 
 ;      alerts will be sent to the same users who will recieve the error
 ;      alerts.  
 ;      a. The alert will include the patient name, DFN and medication.
 ;      b. You can add barcodes by running the option PSJI LBLI
 ;
 ;   4. This routine will save a copy of the output as last_ZVHBC.txt.
 ;      a. It will be stored in the default HFS device.
 ;      b. It will be overwritten each time.
 ;      c. If you want it to append instead, see TASK+9.  Change "W" to 
 ;      "A"
 ;
 ;   5. Create a new option (EVE > MENU MANAGEMENT > EDIT OPTION)
 ;      a. Suggested Name: ZVHBC TASK
 ;      b. Suggested Menu Text: Auto generate BCMA data
 ;      c. Type: run routine
 ;      d. Routine: TASK^ZVHBC3
 ;      e. Creator will default to your name.
 ;      f. All other fields can be blank
 ;
 ;   6. Add the new task using the TaskMan "Schedule/Unschedule" option
 ;      (EVE > TASKMAN MANAGEMENT)
 ;      a. Option name: <enter the name you chose in step 5a>
 ;      b. Queued to run at what time: Select a future time
 ;      c. Rescheduling frequency: use 1D for daily, 1H for hourly, 2H 
 ;         for every 2 hours, etc.
 ;      d. Save
 ;      e. Exit
 ; 
 ;  [3/26/15 Set up DUZs and DFNs for Amazon Orion VistA instance]
 ;=======================================================================
 ;
 W "entry points are EN and TASK",!
 QUIT  ; 
 ;
 ;
DFN ; list of patients DFN's to use for tasked routine ADD PATIENTS BELOW THIS LINE! 
 ;;100848;; EHMP,FIVE
 ;;100085;; BCMA,SEVENTY-PATIENT
 ;;100086;; BCMA,SEVENTYONE-PATIENT
 ;;100087;; BCMA,SEVENTYTWO-PATIENT
 ;;100088;; BCMA,SEVENTYTHREE-PATIENT
 ;;100089;; BCMA,SEVENTYFOUR-PATIENT
 ;;100886;; MEDICATIONS,REVIEW
 ;;!!!;; THIS IS THE END SIGNAL, ADD PATIENTS ABOVE THIS LINE! ---------------
 ;
 QUIT  ; label DFN
 ;
 ;
ALERT(TEXT) ; generate alerts for errors or for out of barcodes
 ;variables for XQAlert API:
 NEW SENT,XQA,XQAARCH,XQADATA,XQAFLG,XQAGUID,XQAID,XQAMSG,XQAOPT,XQAROU,XQASUPV,XQASURO,XQATEXT,XQALERR
 ;-------- add your DUZ like the next line to get alerts -------
 ;SET XQA(DUZ)="" ; send alerts to you
 SET XQA(119)="" ; send alerts to Tony
 SET XQA(121)="" ; send alerts to Johnny
 ;------------------------------------------------------------
 SET XQAID="ZVHBC" ; package ID
 SET XQAMSG=TEXT
 SET:TEXT["Need Barcodes" XQAOPT="PSJI LBLI"
 ;
 ; send alerts for errors
 IF $GET(ZVHERR) DO  ; setup XQATEXT to display the errors
 . ;MERGE XQATEXT=ZVHERR
 . SET XQATEXT=$$LJ^XLFSTR("The errors are saved in the error log:",80)_$$LJ^XLFSTR("  "_$$DEFDIR^%ZISH()_"ZVHBC_error_log.txt",80)
 . IF $DATA(ZVHERR("NOW")) DO  
 . . NEW TYPE SET TYPE=""
 . . FOR  SET TYPE=$ORDER(ZVHERR("NOW",TYPE)) QUIT:TYPE=""  DO
 . . . NEW PATIENT SET PATIENT=""
 . . . FOR  SET PATIENT=$ORDER(ZVHERR("NOW",TYPE,PATIENT)) QUIT:PATIENT=""  DO  
 . . . . NEW STRING SET STRING=$$LJ^XLFSTR("    "_TYPE_"|"_PATIENT_"|"_ZVHERR("NOW",TYPE,PATIENT),80)
 . . . . IF $LENGTH(STRING)>80 SET STRING=$EXTRACT(STRING,1,80) ; truncate to prevent wrap
 . . . . SET XQATEXT=XQATEXT_STRING
 . . . . ;
 ;
 SET SENT=$$SETUP1^XQALERT
 IF +SENT'=1!$GET(XQALERR) WRITE !,"ALERT ERROR ",$GET(XQALERR)
 ;
 QUIT  ;label ALERT
 ;
 ;
EN(SAVE,SILENT) ; Entry for non-tasked 
 ; pass by ref: SAVE (1= true, 0=false, null=false) SILENT (1= true, 0=false, null=false)
 ;
 ; Check for Production environment, quit if true
 NEW ZVHCHECK SET ZVHCHECK=$$PROD^XUPROD(1)
 IF ZVHCHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ELSE  WRITE:'$GET(SILENT) !!,"OK!  This is a TEST account, proceeding...",!!
 IF '$DATA(U)!('$DATA(DUZ))!('$DATA(DUZ(2)))!('$DATA(IOF)) WRITE "Need to log in or D ^XUP first!" QUIT  ;
 ;
 NEW %,DG,DIC,DICR,DIW,ERR,X,X1,X2,TYP ; variables used by routines called
 ;
 IF $GET(SAVE)="" SET SAVE=0 ; default to not save
 IF SAVE'=+SAVE!(SAVE>1) WRITE "SAVE?" QUIT  ; REQUIRED to be null, 0 or 1
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent.
 IF SILENT'=+SILENT!(SILENT>1) WRITE "SILENT?" QUIT  ; REQUIRED to be null, 0 or 1
 ;
 SET ZVHERR=0 ; NOT newed - for errors
 DO NOW(SAVE,SILENT)
 IF 'SILENT ZW START,END,ERRORDATE,ZVHERR,ERRORDFN,PATIENTS ; debug
 ;
 ;
 IF SILENT 
 . IF $GET(ZVHERR) DO CKERRORS  ; if errors silent check
 . DO CLEANS ; silently clean globals
 ELSE  DO
 . IF $GET(ZVHERR) DO CKERROR^ZVHBC  ; if errors  not silent
 . DO CLEAN^ZVHBC ; not silent
 . ELSE  WRITE !,?2,"No errors.  Check CPRS, VistA, or HMP for the medication data!",!! KILL ZVHERR
 ;
 QUIT  ; label EN
 ;
 ;
TASK ; task designed to be scheduled in taskman.  hourly to daily.
 ; Check for Production environment, quit if true
 NEW ZVHCHECK SET ZVHCHECK=$$PROD^XUPROD(1)
 QUIT:ZVHCHECK
 ;
 KILL ZVHERR SET ZVHERR=0 ; for errors, NOT new'd!
 NEW SILENT,DEVICE,POP,IO,ZVHALERT 
 SET SILENT=1 ; minimize output
 SET ZVHALERT=0 ; for alerts
 ;
 ;check assumed variables
 IF $GET(DUZ)="" SET DUZ=119 ; default to programmer 5
 ;IF $GET(DUZ(2))="" SET DUZ(2)=21788 ; default to location of 500D ; HMP
 IF $GET(DUZ(2))="" SET DUZ(2)=500 ; default to location of 500 ; eHMP
 IF $GET(U)="" SET U="^"
 ;If $Get(IOF)="" Set IOF="#,$C(27,91,50,74,27,91,72)" ; not needed
 ;
 ;new variables used by routines called
 NEW %,DG,DIC,DICR,DIW,ERR,X,X1,X2,TYP ;
 ;
 ;using HFS device for now.  P-M would be much better though
 SET DEVICE=$$DEFDIR^%ZISH()
 IF '$DATA(DEVICE) SET ZVHERR=1,ZVHERR("DEVICE",1)="No default HFS set in 8989.3!" QUIT
 ;Open the default HFS device
 DO OPEN^%ZISH("ZVHBC",,"last_ZVHBC.txt","W") ; change to "A" for append
 IF POP SET ZVHERR=1,ZVHERR("DEVICE",2)="Unable to open default HFS device!" QUIT
 USE IO
 WRITE $$NOW^XLFDT,! ; save date/time in log
 ;
 DO NOW(1,SILENT) ; 1=SAVE  SILENT=1
 ;
 IF ZVHERR DO CKERRORS ; check for errors (output on last_ZVHBC.txt
 ;
 ;CLOSE DEVICE
 DO CLOSE^%ZISH("ZVHBC")
 ;
 ;store errors in the error log
 IF $GET(ZVHERR("DIMSG"))=1 KILL ZVHERR("DIMSG") ; no need to see successful DI message
 IF $GET(ZVHERR) DO  
 . ;store in the error log
 . NEW POP,IO
 . DO OPEN^%ZISH("ZVHERROR",,"ZVHBC_error_log.txt","A")
 . IF POP SET ZVHERR=1,ZVHERR("DEVICE","ERROR LOG")="Unable to open default HFS device!" QUIT
 . USE IO
 . WRITE $$NOW^XLFDT,! ; save date/time in error log
 . ZW ZVHERR
 . DO CLOSE^%ZISH("ZVHERROR")
 . ;
 . ;Generate an alert for errors
 . NEW TEXT SET TEXT="ERROR: There was an error generated by one of the ZVHBC routines"
 . DO ALERT(TEXT)
 ;
 ;Generate alert(s) for running out of barcodes 
 IF $DATA(ZVHALERT) DO
 . NEW PATIENT SET PATIENT="" FOR  SET PATIENT=$ORDER(ZVHALERT(PATIENT)) QUIT:PATIENT=""  DO  
 . . NEW MED SET MED="" FOR  SET MED=$ORDER(ZVHALERT(PATIENT,MED)) QUIT:MED=""  DO
 . . . NEW TEXT SET TEXT=ZVHALERT(PATIENT,MED) DO ALERT(TEXT)
 ;
 DO CLEANS ; silent clean
 ;
 QUIT  ; label TASK
 ;
 ;
NOW(ZVHFILE,SILENT) ; Give all meds for today up to now
 ; NOT FOR EXTERNAL USE -  called by labels EN and TASK
 ; Pass by ref: ZVHFILE (Save if true (1))
 ;
 ; This needs to be a "silent" routine - no output or user interaction
 ;
 KILL ^TMP("ZVHDTARY",$J) ; clear the temp global for date array
 NEW TODAY,END ; ERRORDATE SET ERRORDATE=0
 SET TODAY=$$DT^XLFDT ;get todays date
 SET END=$$NOW^XLFDT ; use now for end date/time
 ;
 SET ^TMP("ZVHDTARY",$J,TODAY)="" ; single date in the array, will make the start date/time = TODAY @ 00:00
 ;
 NEW PATIENTS,ERRORDFN SET ERRORDFN=0
 DO SELDFN(.ERRORDFN)
 IF ERRORDFN DO  QUIT
 . SET ZVHERR=1,ZVHERR("NOW","DFN",$J)=$GET(START)_U_$GET(END)_U_$GET(TODAY)_U_$GET(NOW) ; [8/21/2014 ajc]
 . IF $DATA(PATIENTS)>9 MERGE ZVHERR("NOW","DFN","PATIENTS")=PATIENTS
 ;
 IF 'SILENT ZW TODAY,END,ZVHERR,ERRORDFN,PATIENTS ; debug
 IF ZVHFILE=""!(ZVHFILE=0) DO  
 . DO PAT("",TODAY,END,SILENT) ;debug (does not save)
 . IF 'SILENT WRITE !,"NOTE: Above data is display only - it was NOT saved!",!!!
 IF ZVHFILE=1 DO  
 . DO PAT(1,TODAY,END,SILENT) ; *** DANGER - THIS SAVES THE DATA! ***
 . IF 'SILENT WRITE !,"The Data above was SAVED!!!",!!!
 ;
 ;
 QUIT  ; label NOW
 ;
 ;
DATE(START,END,ERROR) ; Select start date/time (auto select Now for end date/time)
 ; pass by reference: START, END, ERROR.  
 ; results returned as fileman date/time in START and END
 ; 
 SET START=$$DT^XLFDT_".000001" ; todays date, 1 second past midnight
 SET END=$$NOW^XLFDT
 ;
 IF 'START!'END SET ERROR=1
 ;
 QUIT  ; label DATE
 ;
 ;
SELDFN(ERROR) ; select patient DFN's
 ; before calling this label, new the variable PATIENTS
 ; array of DFN's will be returned in PATIENTS
 ; pass by ref: ERROR
 ;
 NEW INC,NUM
 FOR INC=1:1 SET NUM=($P($TEXT(DFN+INC),";;",2)) QUIT:NUM="!!!"  DO
 . IF NUM'=""&(+NUM=NUM) SET PATIENTS(NUM)="",PATIENTS=INC
 ;
 IF $DATA(PATIENTS)'>9 SET ERROR=1
 ;
 QUIT  ; label SELDFN
 ;
 ;
PAT(ZVHFILE,START,END,SILENT) ; loop thru patient array and get the data for entry
 ; pass by value: ZVHFILE, START and END in fileman date/times
 ;
 ; REQUIRED: array of patients stored in PATIENTS
 IF $DATA(PATIENTS)'>9 QUIT
 IF $GET(SILENT)="" SET SILENT=0
 ;
 IF $Get(START)="" DO  ; if no start date is passed, use 00:00 of the FIRST date in the array
 . SET START=$ORDER(^TMP("ZVHDTARY",$J,"")) ; get the FIRST date in the array
 . ;SET START=+(DATE_.000001) ; 1 second AFTER midnight [3/26/15 removed ajc]
 ;
 IF $Get(END)="" DO  ; if no end date is passed, use 24:00 of the LAST date in the array
 . SET END=$ORDER(^TMP("ZVHDTARY",$J,""),-1) ; get the LAST date in the array
 . SET END=+(DATE_.24) ; 1 second BEFORE midnight ; changed to .24 [3/26/15 ajc]
 ;
 ; start loop thru PATIENTS array
 NEW ZVHPT SET ZVHPT="" ; var for patient dfn
 FOR  SET ZVHPT=$ORDER(PATIENTS(ZVHPT)) QUIT:'ZVHPT  DO
 . NEW ZVHROOM SET ZVHROOM=$$GET1^DIQ(2,ZVHPT,.1)_" "_$$GET1^DIQ(2,ZVHPT,.101) ; get ward location and room bed
 . WRITE "PATIENT: ",$$GET1^DIQ(2,ZVHPT,.01),! ; write patient name
 . ;
 . ; Continuous IV infusions
 . NEW ZVHERRIV S ZVHERRIV=0 ; for errors
 . ;DO IV^ZVHBCIV(ZVHPT,ZVHROOM,$GET(ZVHFILE),SILENT,END,.ZVHERRIV)  ;
 . ;DO IVCONT^ZVHBCIV(ZVHPT,ZVHROOM,$GET(ZVHFILE),SILENT,START,END,.ZVHERRIV)
 . IF ZVHERRIV SET ZVHERR=1,ZVHERR("NOW","IV",ZVHPT)=$$GET1^DIQ(2,ZVHPT,.01)
 . ;IF ZVHERR DO CKERRORS ;debug
 . ;
 . ; PRN meds
 . NEW ZVHERRPRN SET ZVHERRPRN=0 ; for errors
 . DO PRN^ZVHBC1(ZVHPT,ZVHROOM,START,END,$GET(ZVHFILE),.ZVHERRPRN,SILENT) ; do the PRN meds
 . IF ZVHERRPRN SET ZVHERR=1,ZVHERR("NOW","PRN",ZVHPT)=$$GET1^DIQ(2,ZVHPT,.01)
 . ;IF ZVHERR DO CKERROR ;debug
 . ;
 . ; Continuous/scheduled meds
 . NEW ZVHERRSCH SET ZVHERRSCH=0 ; for errors
 . DO CNSCH^ZVHBC(ZVHPT,ZVHROOM,.ZVHERRSCH,$GET(ZVHFILE),END,SILENT)
 . IF ZVHERRSCH SET ZVHERR=1,ZVHERR("NOW","SCH",ZVHPT)=$$GET1^DIQ(2,ZVHPT,.01)
 . ;IF ZVHERR DO CKERROR ;debug
 . ;
 . ; One time and On call meds
 . NEW ERRONETM SET ERRONETM=0 ; var for errors
 . DO ONETM^ZVHBC2(ZVHPT,ZVHROOM,.ERRONETM,$GET(ZVHFILE),END,SILENT) ; do the one time meds
 . IF $GET(ERRONETM) SET ZVHERR=1,ZVHERR("NOW","1TIME",ZVHPT)=$$GET1^DIQ(2,ZVHPT,.01)
 . ;IF ZVHERR DO CKERROR ;debug
 . ;
 . ;debug
 . ;ZWRITE 
 . ;NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Ready for the next Patient? Y to continue or CTRL-C to exit "
 . ;DO ^DIR KILL DIR
 . ;IF Y(0)="NO" QUIT
 . ;KILL Y
 . ;debug
 . IF 'SILENT WRITE ?10,$$GET1^DIQ(2,ZVHPT,.01)," DONE.",!
 ;
 QUIT  ; label PAT
 ;
 ;
CKERRORS ; check for errors, kind of silent.
 IF $GET(ZVHERR) WRITE !,?5,"There are errors stored in ZVHERR",!
 ;
 QUIT  ; label CKERRORS
 ;
 ;
CLEANS ; silent - clean up the globals used
 ; WRITE !,?5,"Clearing the TMP globals... "
 KILL ^TMP("ZVHPAT",$J) ; Remove the patient array global
 KILL ^TMP("PSJ",$J) ; Remove the meds array global
 KILL ^TMP("ZVHDTARY",$J) ; remove the date array global
 KILL ^TMP("ZVHERROR",$J) ; remove the error data
 KILL PATIENTS ; remove the patient array
 IF $GET(ZVHERR)=0 KILL ZVHERR ; 
 ;
 QUIT  ; label CLEAN
 ;
 ;
