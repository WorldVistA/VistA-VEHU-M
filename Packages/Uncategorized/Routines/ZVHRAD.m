ZVHRAD	; OIA/AJC - EDIT RADIOLOGY REPORTS ;2/5/15
 ;;0.1;NO PKG;**NO PATCHES**;Feb  5, 2015; no build
 ;
 ; class 1 calls: PROD^XUPROD, FMTE^XLFDT; GET1^DIQ; ^DIC, ^DIR, FILE^DIE
 ; class 3 calls: none 
 ;
 ; Remaining issues to fix and/test:
 ;   Order file - multiple order dates (ex: changed orders.) Currently, this
 ;     will only fix the first order date (the 'new' date)
 ;   Order File - Items sub file - Start... displays as Desired Date in the
 ;     order inquire.
 ;   Need to test on a set of images (70.03 IEN >1)
 ;
 ;---------------------------------------------------------------------------
 Do FIXRAD ; enter at a label
 Quit  ; routine ZVHRAD
 ;
 ;
FIXRAD	; Edit the dates of radiology reports and orders
 ;
 ; Check for Production environment, quit if true
 New CHECK Set CHECK=$$CHECK(1)
 Quit:CHECK 
 ;
 ;Check for IO variables
 IF '$Data(U)!('$Data(DUZ))!('$Data(DUZ(2)))!('$Data(IOF)) Write "Need to log in or D ^XUP first!" Quit 
 ;
 Write @IOF
 ; Select a patient
 New DFN Set DFN=$$GETRADPT
 If $Get(DFN)'>0 Write !!,"ERROR: No patient selected...  quitting.",!! Quit
 ;
 ; Set up array of completed orders
 New READY,ARRAY Set READY=$$SETRA(DFN)
 If 'READY Write !,"ERROR: Unable to set up the order array... are the Rad orders completed?",!!,?20,"Quitting.",!! Quit
 ;
 ; select an order from ARRAY
 New RADIEN,ORIEN,INVDATE,IEN7003,REPORT
 Set RADIEN=$$GET1RAD(DFN)
 If 'RADIEN!(RADIEN'["^") Write !,"ERROR: No order selected... quitting.",!! Quit
 Set ORIEN=$Piece(RADIEN,U,2) ; 2nd piece of output - order file 100 IEN
 Set RADIEN=$Piece(RADIEN,U) ; 1st piece of output - Rad order file 75.1 IEN 
 Set INVDATE=$Order(ARRAY(RADIEN,ORIEN,"")) ; inverse date/time used as DA in 75.1
 If $Get(INVDATE) Set IEN7003=$Order(ARRAY(RADIEN,ORIEN,INVDATE,"")) ; ien in 70.03 
 If $Get(IEN7003) Set REPORT=$Piece($Get(^RADPT(DFN,"DT",INVDATE,"P",IEN7003,0)),U,17) ; ien of the report in file 74
 ; quit if no report IEN
 If $Get(REPORT)'>0 Do AOXREFER(DFN,INVDATE,IEN7003,RADIEN) Quit
 ;
 Write !,?5,"Selected Radiology order: ",RADIEN," Order IEN: ",ORIEN,!!
 ;
 Do SHOWDATE(DFN,RADIEN)
 ;B ;DEBUG
 New DATEOROLD,DATEORNEW,DATEEXAM,DATEREPORT
 ; get the old date (original order date/time) from ^rao(75.1
 Set DATEOROLD=$$GET1^DIQ(100.008,1_","_ORIEN_",",.01)
 ;B ;DEBUG
 If ORIEN&RADIEN&REPORT Do
 . ;Write ?5,"Current order date/time: ",DATEOROLD,!
 . Write "OPTIONAL: Enter new date/times (or just hit enter to keep the existing ones)",!
 . ;  ask start date
 . Set DATEORNEW=$$GETDATE("Enter NEW start date for the Radiology order")
 . ;  ask date procedure completed
 . SET DATEEXAM=$$GETDATE("Enter NEW Examination date for this Rad order")
 . ;  ask date report completed (stop date)
 . Set DATEREPORT=$$GETDATE("Enter NEW Report/Verify date for this Rad order")
 . ;ZW DATEOROLD,DATEORNEW,DATEEXAM,DATEREPORT ; debug
 . Write !
 . If DATEORNEW Do  ;  fix the order dates in files 100 and 75.1
 . . New FIELD,FILE,SUCCESS Set SUCCESS=0
 . . Set FILE=100
 . . Set FIELD=4 Set SUCCESS=$$CHNGDATE(ORIEN,DATEORNEW,FIELD,FILE) ; when entered - 100
 . . Write:SUCCESS "Order, When entered Date updated.",!
 . . Set FIELD=21 Set SUCCESS=$$CHNGDATE(ORIEN,$P(DATEORNEW,"."),FIELD,FILE) ; start date - 100
 . . Write:SUCCESS "Order, Start Date updated.",!
 . . ;For FIELD=.01,6,16 Do CHNGDATE(ORIEN,DATEORNEW,FIELD,FILE,100.008) ; order, signed, and release dates - 100
 . . Set FIELD=.01 Set SUCCESS=$$CHNGDATE(ORIEN,DATEORNEW,FIELD,FILE,100.008) ; order date - 100
 . . Write:SUCCESS "Order, Start Date updated.",!
 . . Set FIELD=6 Set SUCCESS=$$CHNGDATE(ORIEN,DATEORNEW,FIELD,FILE,100.008) ; signed date - 100
 . . Write:SUCCESS "Order, Signed Date updated.",!
 . . Set FIELD=16 Set SUCCESS=$$CHNGDATE(ORIEN,DATEORNEW,FIELD,FILE,100.008) ; release date - 100
 . . Write:SUCCESS "Order, Released Date updated.",!
 . . Set FILE=75.1
 . . Set FIELD=16 Do CHNGDATE(RADIEN,DATEORNEW,FIELD,FILE) ; rad order date/time - 75.1
 . . Set FIELD=21 Do CHNGDATE(RADIEN,$P(DATEORNEW,"."),FIELD,FILE) ; date desired - 75.1
 . If DATEEXAM Do
 . . New FIELD,FILE
 . . Set FILE=74
 . . For FIELD=3,6 Do CHNGDATE(REPORT,DATEEXAM,FIELD,FILE) ; exam, report entered - 74
 . . ;Set FILE=70,FIELD=.01
 . . ;Do CHNGDATE(DFN,DATEEXAM,FIELD,FILE,70.02) ; exam date/time - 70
 . . ; just ignore this SAC violation of directly setting the global :)
 . . Set $Piece(^RADPT(DFN,"DT",INVDATE,0),U)=DATEEXAM
 . If DATEREPORT Do 
 . . New FIELD,FILE
 . . Set FIELD=22,FILE=100 Do CHNGDATE(ORIEN,DATEREPORT,FIELD,FILE) ; stop date - 100
 . . Set FIELD=18,FILE=75.1 Do CHNGDATE(RADIEN,DATEREPORT,FIELD,FILE) ; last activity date - 75.1
 . . For FIELD=7,8 Set FILE=74 Do CHNGDATE(REPORT,DATEREPORT,FIELD,FILE) ; verified, report dates - 74
 . ; 
 . If DATEEXAM Do  Quit
 . . New DONE Set DONE=1 ; default to done, so it will quit
 . . Do SHOWDATE(DFN,RADIEN) ; Show the dates in the files
 . . Set DONE=$$PAUSE("Time to edit the ^RADPT global, are you ready???")
 . . If DONE=0 Write !,"OK, Global is NOT set... quitting!",!!
 . . ;b ;debug
 . . IF DONE Do 
 . . . New ERROR,SUCCESS  Set SUCCESS=$$EDRADPT(DFN,INVDATE,IEN7003,DATEEXAM,.ERROR)
 . . . If SUCCESS Write "Global moved to the new date/time",!!
 . Else  Do SHOWDATE(DFN,RADIEN) ; show the dates again
 Else  Write !,"ERROR: unable to fix order dates.  Better check them in fileman.",!! Quit
 ; report success before exiting
 ;
 Quit  ; Label FIXRAD
 ;
 ;
AOXREFER(DFN,INVDATE,IEN7003,RADIEN)	; If AO x-ref is wrong
 ;REQUIRED: DFN,INVDATE,IEN7003,RADIEN
 ;
 Do
 . Write !!,?37,"OOPS!!!",!
 . Write "This routine uses the AO cross reference of the Radiology Patient File.",!
 . Write "Unfortunately, for the exam you selected, the AO x-ref is pointing to a",!
 . Write "radiology exam that does not exist.",!!
 . Write "Here are some data to help you fix that:",!
 . Write ?2,"AO Inverse Date Time: ",INVDATE,?45,"File 70.03 IEN: ",IEN7003,?65,"Rad IEN: ",RADIEN,!
 . Write ?2,"AR x-ref List of dates and inverse dates:",!
 . New DATE Set DATE=0
 . For  Set DATE=$Order(^RADPT("AR",DATE)) Quit:'DATE  Do
 . . New PATIENT
 . . Set PATIENT=0
 . . For  Set PATIENT=$Order(^RADPT("AR",DATE,PATIENT)) Quit:'PATIENT  Do
 . . . If PATIENT=DFN Do
 . . . . New DATEI Set DATEI=0
 . . . . For  Set DATEI=$Order(^RADPT("AR",DATE,PATIENT,DATEI)) Quit:'DATEI  Do
 . . . . . Write ?5,DATE,?20,DATEI,!
 . Write ?2,"DT x-ref List of inverse dates",!
 . New DATE Set DATE=0
 . For  Set DATE=$Order(^RADPT(DFN,"DT",DATE)) Quit:'DATE  Write ?5,DATE,!
 . Write !,"Quitting...",!!!
 ;
 Quit  ; label AOXREFER
 ;
 ;
GETAPXRF(DFN,INVDATE)	; check AP x-reference, return procedure and number if found.
 ;REQUIRED: pass by value DFN (patient IEN) and INVDATE the inverse date used 
 ;          by 75.1 as DA
 ;EXT OUTPUT: -1 error, 0 fail, if successful - IEN of procedure from file# 71
 ;            and the num from the x-ref. 
 Quit:'$Data(DFN)!'$Data(INVDATE) -1
 ;
 New OUT Set OUT=0 ; extrinsic output
 ;
 If INVDATE?7N.1".".6N Do
 . New PROCEDURE,APDATE,NUM Set (PROCEDURE,APDATE,NUM)=""
 . For  Set PROCEDURE=$Order(^RADPT(DFN,"DT","AP",PROCEDURE)) Quit:'PROCEDURE  Do
 . . For  Set APDATE=$Order(^RADPT(DFN,"DT","AP",PROCEDURE,APDATE)) Quit:'APDATE  Do
 . . . IF INVDATE=APDATE Do
 . . . . Set NUM=$ORDER(^RADPT(DFN,"DT","AP",PROCEDURE,APDATE,""))
 . . . . Set OUT=PROCEDURE_U_NUM
 Else  Set OUT=0
 ;
 Quit $Get(OUT)
 ;
 ;
SHOWDATE(DFN,RADIEN)	; show the dates for a radiology order
 ;REQUIRED: pass by value DFN and RADIEN as the order ien in ^RAO(75.1
 ;   also uses ARRAY as set up in SETRA
 Quit:'$Data(ARRAY)>9
 Quit:'$Data(RADIEN)!'$Data(DFN)
 ;
 New ORIEN,ORDATE,ORREL,ORSIGN,ORSTART,ORSTOP,EXAMDATE,INVDATE,IEN7003,REPORTIEN,REPEXAM,REPENTER,REPORTDATE,VERIFYDATE,RAODATE,RAOACT,DESIREDATE
 Set ORIEN=$$GET1^DIQ(75.1,RADIEN,7) ; order IEN
 Set ORDATE=$$GET1^DIQ(100.008,1_","_ORIEN_",",.01) ; order entered date/time
 Set ORREL=$$GET1^DIQ(100.008,1_","_ORIEN_",",16) ; order release date/time
 Set ORSIGN=$$GET1^DIQ(100.008,1_","_ORIEN_",",6) ; order signed date/time
 Set ORSTART=$$GET1^DIQ(100,ORIEN,21) ; start date of order
 Set ORSTOP=$$GET1^DIQ(100,ORIEN,22) ; stop date of order
 Set RAODATE=$$GET1^DIQ(75.1,RADIEN,16) ; rad order date/time - 75.1, 16 
 Set RAOACT=$$GET1^DIQ(75.1,RADIEN,18) ; last activity - 75.1, 18 
 Set DESIREDATE=$$GET1^DIQ(75.1,RADIEN,21) ; radiology exam date desired
 Set INVDATE=$Order(ARRAY(RADIEN,ORIEN,"")) ; inverse date time of image order
 If INVDATE Do 
 . Set EXAMDATE=$Piece(^RADPT(DFN,"DT",INVDATE,0),U)
 . Set EXAMDATE=$$FMTE^XLFDT(EXAMDATE) ; external format
 . Set IEN7003=$Order(ARRAY(RADIEN,ORIEN,INVDATE,"")) ; ien in 70.03
 . If IEN7003 Do 
 . . Set REPORTIEN=$Piece(^RADPT(DFN,"DT",INVDATE,"P",IEN7003,0),U,17)
 . . Set REPEXAM=$$GET1^DIQ(74,REPORTIEN,3) ; exam date in the report file
 . . Set REPENTER=$$GET1^DIQ(74,REPORTIEN,6) ; date report entered
 . . Set REPORTDATE=$$GET1^DIQ(74,REPORTIEN,8) ; reported date
 . . Set VERIFYDATE=$$GET1^DIQ(74,REPORTIEN,7) ; verified date
 ;
 Write !,"Patient - ",$$GET1^DIQ(2,DFN,2),!
 Write "Date/times for this Radiology order: ",RADIEN," Order IEN: ",ORIEN,!
 Write "------------------------------------------------------------------------------",!
 Write "Order Dates:",!
 Write ?2,"  Order: ",?11,$Get(ORDATE),?40," Start: ",?51,$Get(ORSTART),!
 Write ?2,"Release: ",?11,$Get(ORREL),?40," Signed: ",?51,$Get(ORSIGN),!
 Write ?2,"   Stop: ",?11,$Get(ORSTOP),!!
 Write "Radiology Order dates:",! ;RAODATE,RAOACT     "
 Write ?2,"  Order: ",?11,$Get(RAODATE),?40,"LastAct: ",?51,$Get(RAOACT),!
 Write ?2," Desire: ",?11,$Get(DESIREDATE),!!
 Write "Radiology Patient File Exam date:",?51,$Get(EXAMDATE),!!
 Write "Radiology Report Dates:",!
 Write ?2,"Entered: ",?11,$Get(REPENTER),?40,"   Exam: ",?51,$Get(REPEXAM),!
 Write ?2," Report: ",?11,$Get(REPORTDATE),!
 Write ?2," Verify: ",?11,$Get(VERIFYDATE),!
 Write "------------------------------------------------------------------------------",!!
 ;
 Quit  ; label SHOWDATE
 ;
 ;
CHNGDATE(DA,DATE,FIELD,FILE,SUB) ; change a date in a file
 ;REQUIRED: pass by value DA as the ien from file, DATE that you want, the
 ;          FIELD you want it in, and the FILE # of the file
 ;EXTR OUT: -1 for error,0 for fail, 1 for success
 ;OPTIONAL: pass by value SUB if the date is in a sub file (ex 100.008)
 ; 
 New CHECK Set CHECK=$$CHECK(1) Quit:CHECK  ; Silent Check for Production environment, quit if true
 ;
 Quit:'$Data(DA)!'$Data(DATE)!'$Data(FIELD)!'$Data(FILE) -1
 If DA'?.N Write "IEN must be a number",!! Quit -1 ; must be a number
 IF DATE'?7N.1".".6N Write "Date must be in valid fileman format",!! Quit -1 ; must be fileman date/time
 If FIELD'?1.N&(FIELD'?1"."1.N) Write "Field number must be a number!",!! Quit -1 ; must be a number
 If $Get(SUB)>0&($Piece($GET(SUB),".")'=$Piece(FILE,".")) Write "Sub file must be a number starting with ",$Piece(FILE,"."),!! Quit -1
 ;
 If FILE=70 Write "Can't set file 70 (Radiology Patient) through FileMan.  Use Direct global set.",!! Quit
 ;
 New OUT Set OUT=0 ; for extr output
 ;
 New ZVHFDA ; for fileman data array
 If '$Get(SUB) Set ZVHFDA(FILE,DA_",",FIELD)=+DATE
 Else  Set ZVHFDA(SUB,1_","_DA_",",FIELD)=+DATE ; currently, this only fixes the first entry...
 ;
 If $Data(ZVHFDA)>9 Do
 . Do FILE^DIE("S","ZVHFDA","")
 . If $Data(DIERR) Do PAUSE("Error saving data:") Kill DIERR
 . Else  Set OUT=1
 ;
 Quit $Get(OUT) ; label CHNGDATE
 ;
 ;
PAUSE(STRING)	; show fileman error data, prompt for user to continue
 ; REQUIRED: pass by value STRING to display for the user
 ; EXT OUTPUT: -1 for error, 0 for quit, 1 for continue
 ;
 Quit:'$Length(STRING) -1
 New OUT Set OUT=0 ; extrinsic output
 ;
 Write !!,STRING,!
 ZW DIERR,^TMP("DIERR",$J)
 New DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Set DIR(0)="YA"
 Set DIR("A")="ENTER if you want to Continue, N or Ctrl-C to quit.  Ready?  "
 Set DIR("B")="YES"
 Do ^DIR
 If $Get(DTOUT)!$Get(DUOUT)!$Get(DIRUT)!$Get(DIROUT) Quit 0
 If $Get(Y) Set OUT=+Y
 ;
 Quit $Get(OUT) ; label ERROR
 ;
 ;
CHECK(SILENT) ; Check for Production environment, quit if true
 ; EXTR OUTPUT: 1 if production envirnment. 0 if not
 If '$Get(SILENT) Set SILENT=0 ; default to not silent
 ;
 New CHECK Set CHECK=$$PROD^XUPROD(1)
 If CHECK Write:'SILENT "This routine is for TEST systems only!!!",!!,"Goodbye!",!! Quit CHECK
 Else  Write:'SILENT "OK!  This is a TEST account, proceeding..."
 ;
 QUIT CHECK ; label CHECK
 ;
 ;
GETRADPT() ; select a radiology patient and report by ^radpt
 ;REQUIRED: ?
 ;Extrinsic Output: -1 for errors, 0 for none selected, radien^dfn if selected
 Quit:'$Data(U)!'$Data(IOF) -1
 New OUT Set OUT=0 ; extr output
 ;
 New DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Set DIC("A")="Select a Radiology Patient: "
 Set DIC="^RADPT("
 Set DIC(0)="QEA"
 Do ^DIC
 If $Get(DTOUT)!$Get(DUOUT)!$Get(DIRUT)!$Get(DIROUT) Quit 0
 If Y=-1 Set OUT=-1
 If $Get(Y)>0 Set OUT=+Y
 ;B ;debug
 ;
 Quit $Get(OUT) ; Label GETRADPT
 ;
 ;
GETDATE(STRING)	; Select a date using DI Read
 ; REQUIRED: pass by value STRING with the prompt for DIR("A")
 ; EXT OUTPUT: -1 error, 0 none selected, date/time in fileman format if 
 ;    successful
 Quit:'$Data(STRING) -1
 Quit:$Length(STRING)'>0 -1
 New OUT Set OUT=0 ; extrinsic ouput
 ;
 New DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT ; ,NOW
 ;Set NOW=$$NOW^XLFDT
 Set DIR(0)="DOA^1:NOW:EXR"
 Set DIR("A")=STRING_": "
 Set DIR("?")="Please enter a date/time.  Time is REQUIRED!"
 Do ^DIR
 Quit:$Get(DTOUT)!$Get(DUOUT)!$Get(DIRUT)!$Get(DIROUT) OUT ; quit if the user times out, enters ^ or null
 Set:$Data(Y) OUT=+Y  ; if data returned, set as new exam date/time
 ;
 Quit $Get(OUT) ; label GETDATE
 ;
 ;
GET1RAD(DFN)	; Select an order from the ARRAY
 ;REQUIRED: pass DFN by value (patient IEN in file 2)
 ;   must have ARRAY set by SETRA^ZVHRAD before calling
 ;Extrinsic Output: -1 for error, 0 for none selected, IEN of selected 
 ;   Radiology Order if successful
 Quit:'$Data(DFN)!($Get(DFN)'>0)!'$Data(U)!'$Data(IOF) -1
 Quit:'$Data(ARRAY) 0
 ;
 New OUT Set OUT=0 ; extrinsic ouput
 ;
 ; set up the string for the ^DIR list
 New COUNT,RADIEN,STRING,MAX
 Set (COUNT,RADIEN)=0
 Set STRING="SO^"
 Set MAX=$Order(ARRAY("COUNT",""),-1) ; get the highest number
 For  Set COUNT=$Order(ARRAY("COUNT",COUNT)) Quit:'COUNT  Do
 . Set RADIEN=$Piece(ARRAY("COUNT",COUNT),U) ; Radiology ien
 . Set STRING=STRING_COUNT_":"_$Piece($$GET1^DIQ(75.1,RADIEN,16),"@")_" "_$$GET1^DIQ(75.1,RADIEN,2) ; removed: COUNT_". "_
 . If COUNT'>MAX Set STRING=STRING_";" ; delimiter required for all except the last one
 ;
 New DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Set DIR(0)=STRING
 Set DIR("L",1)="Please select a Radiology Report:"
 Set DIR("L",2)=""
 Do ^DIR
 If $Get(DTOUT)!$Get(DUOUT)!$Get(DIRUT)!$Get(DIROUT) Quit 0
 If Y<1!(Y>MAX) Quit -1
 If Y>0&(Y'>MAX) Set OUT=ARRAY("COUNT",Y) ; put rad ien and order ien into the SELECTION array
 ;B ;debug
 ;
 Quit $Get(OUT) ; label GET1RAD
 ;
 ;
SETRA(DFN)	; set the array of completed lab orders
 ;REQUIRED: pass DFN by value (patient IEN in file 2)
 ;  new ARRAY before calling
 ;Ouput: List of Radiology Orders IEN in variable ARRAY
 ;Extrinsic Output: 1 for success, 0 for fail, -1 for error
 Quit:'$Data(DFN)!($Get(DFN)'>0)!'$Data(U)!'$Data(IOF) -1
 ;
 New OUT Set OUT=0 ; for extr output
 ;
 ; use  ^rao(75.1,"b",dfn,ien x-ref to set up an array of completed Rad orders
 New RADIEN Set RADIEN="" ; for the IEN of the order in file 75.1
 For  Set RADIEN=$Order(^RAO(75.1,"B",DFN,RADIEN)) Quit:'RADIEN  Do
 . New STATUS Set STATUS=$$GET1^DIQ(75.1,RADIEN,5) ;only complete exams
 . If STATUS="COMPLETE" Do 
 . . New ORIEN Set ORIEN=$$GET1^DIQ(75.1,RADIEN,7)
 . . ;If $Get(ORIEN)>0 Set ARRAY(RADIEN,ORIEN)=""
 . . ; use ^radpt("ao",radien,dfn,inv req date.time,ien)
 . . New DATEINV,IEN7003 Set DATEINV=$Order(^RADPT("AO",RADIEN,DFN,"")) ; inv date  of request
 . . Quit:'$Get(DATEINV)>0  ; don't add if it's missing the AO x-ref
 . . Set IEN7003="" ; for the order ien in 70.03 sub 
 . . For  Set IEN7003=$Order(^RADPT("AO",RADIEN,DFN,DATEINV,IEN7003)) Quit:'IEN7003  Do
 . . . Set ARRAY(RADIEN,ORIEN,DATEINV,IEN7003)=""
 ;
 ; add counter to the ARRAY
 New COUNT,RADIEN,ORDERIEN,DATEINV
 Set COUNT=0 ; use as a counter
 Set RADIEN=0
 For  Set RADIEN=$Order(ARRAY(RADIEN)) Quit:'RADIEN  Do
 . Set COUNT=COUNT+1 ; increment the counter
 . Set ORDERIEN=$Order(ARRAY(RADIEN,"")) ; get the order ien
 . Set DATEINV=$Order(ARRAY(RADIEN,ORDERIEN,"")) ; get the inv date/time of request
 . Set ARRAY("COUNT",COUNT)=RADIEN_U_ORDERIEN_U_DATEINV ; Add counter to the ARRAY
 ;ZW ARRAY ;debug 
 ;B ;debug
 ;
 If $Data(ARRAY)'>9 Set OUT=0
 Else  Set OUT=1
 ;
 Quit $Get(OUT) ; label SETRA
 ;
 ;
EDRADPT(DFN,INVDATE,IEN7003,DATEEXAM,ERROR)	; Edit the ^RADPT global
 ; just ignore this major SAC violation of directly setting the globals :)
 ;
 ;REQUIRED: Pass the following variables by value - 
 ;    DFN - patient's IEN in file 2
 ;    INVDATE - inverse date/time of the exam, used as DA in ^RADPT(DFN,"DT",DA)
 ;    IEN7003 - the IEN of the exam multiple in file 70.03
 ;    DATEEXAM - the new exam date/time
 ;  Pass by reference ERROR for return of any errors
 ;
 ;EXT OUTPUT: -1 error, 0 fail, 1 success
 ;
 ; Silent Check for Production environment, quit if true
 New CHECK Set CHECK=$$CHECK(1) Quit:CHECK 
 ;
 Quit:'$Data(DFN)!'$Data(INVDATE)!'$Data(IEN7003)!'$Data(DATEEXAM) -1
 IF DATEEXAM'?7N.1".".6N Write "Date must be in valid fileman format",!! Quit -1 ; must be fileman date/time
 ;
 New OUT Set OUT=0 ; extrinsic output
 ;
 Write @IOF
 ZW ^RADPT(DFN,"DT",INVDATE)
 New READY
 Set READY=$$PAUSE("Original ^RADPT Global listed above.  Ready to copy to the new one?")
 Quit:'READY
 ;
 New DATEEXAMI Set DATEEXAMI=9999999.9999-DATEEXAM ; [6/4/2014 ajc - 4 digit time per Scott Borst]
 Merge ^RADPT(DFN,"DT",DATEEXAMI)=^RADPT(DFN,"DT",INVDATE)
 ;
 Write !
 ZW ^RADPT(DFN,"DT",DATEEXAMI)
 New READY
 Set READY=$$PAUSE("NEW ^RADPT Global listed above.  Are you ready to DELETE to the old one???")
 If 'READY Do  Quit 0 ; not ready, so back out changes
 . Write !!,"OK, Removing new global..."
 . Kill ^RADPT(DFN,"DT",DATEEXAMI)
 . If '$Data(^RADPT(DFN,"DT",DATEEXAMI)) Write "done.",!!,"Quitting...",!!
 ;
 ; it would be really cool to back up the global somewhere...
 ;
 If READY&$Data(^RADPT(DFN,"DT",DATEEXAMI)) Do  ; if the user is ready, and the new global has data
 . ; fix the "DT","AP" x-ref 
 . New OLDDATE Set OLDDATE=9999999.9999-INVDATE
 . New APXREF Set APXREF=$$GETAPXRF(DFN,INVDATE) ; check to see if it is there
 . If APXREF>0 Do
 . . Set ^RADPT(DFN,"DT","AP",$Piece(APXREF,U),DATEEXAMI,INVDATE,$Piece(APXREF,U,2))="" ; set new
 . . Kill ^RADPT(DFN,"DT","AP",$Piece(APXREF,U),INVDATE,$Piece(APXREF,U,2)) ; kill old
 . ;
 . ; fix the "DT","B" x-ref
 . If $Data(^RADPT(DFN,"DT","B",OLDDATE,INVDATE)) Do
 . . Set ^RADPT(DFN,"DT","B",DATEEXAM,DATEEXAMI)="" ; set the new
 . . Kill ^RADPT(DFN,"DT","B",OLDDATE,INVDATE) ; kill the old
 . ;
 . ; fix the "AR" x-ref
 . If $Data(^RADPT("AR",OLDDATE,DFN,INVDATE)) Do
 . . Set ^RADPT("AR",DATEEXAM,DFN,DATEEXAMI)="" ; set the new
 . . Kill ^RADPT("AR",OLDDATE,DFN,INVDATE) ; kill the old
 . ;
 . ; fix the "AO" x-ref
 . If $Data(^RADPT("AO",RADIEN,DFN,INVDATE,IEN7003)) Do
 . . Set ^RADPT("AO",RADIEN,DFN,DATEEXAMI,IEN7003)="" ; set the new
 . . Kill ^RADPT("AO",RADIEN,DFN,INVDATE,IEN7003) ; kill the old
 . ;
 . Kill ^RADPT(DFN,"DT",INVDATE) ; kill the old global
 ;
 If $Data(^RADPT(DFN,"DT",DATEEXAMI))&'$Data(^RADPT(DFN,"DT",INVDATE)) Set OUT=1
 ;
 Quit $Get(OUT) ; label EDRADPT
 ;
 ;
