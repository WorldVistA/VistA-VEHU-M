ZVHOPM ; OIA/AJC - modify Outpatient Meds ;3/12/15
 ;;0.1;NO PKG;**NO PATCHES**;Sep 19, 2014; no build
 ;
 ; test accounts only!
 ;
 ; External References
 ; ^%DT
 ; ^DIC
 ; FILE^DIE
 ; $$GET1^DIQ
 ; ^DIR
 ; $$FMADD^XLFDT
 ; $$FMTE^XLFDT
 ; $$PROD^XUPROD
 ; CHORDT^ZVHOPM2
 ; REFILLS^ZVHOPM2
 ; REFSHOW^ZVHOPM2
 ; $$GETPAT3^ZVHPAT
 ;
 ; [1/8/15] making a few small changes
 ; [1/12/15] adding functionality to change order dates
 ; [1/16/15] change patient selection
 ; [3/12/15] add exp date and order date/time multiples
 ; [4/10/15] add these dates for file 52: Issue, Login, Dispense
 ;           moved orders and refills to routine ZVHOPM2
 ;
 ; Future upgrades: Add some better default date/times
 ;---------------------------------------------------------------------------
 ;
 DO EN  ; redirect if called directly
 QUIT  ; routine ZVHOPM
 ;
EN      ; enter here!
 ; this will be a menu of options
 ;
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ELSE  WRITE !!,"OK!  This is a TEST account, proceeding...",!!
 IF '$DATA(U)!('$DATA(DUZ))!('$DATA(DUZ(2)))!('$DATA(IOF)) WRITE "Need to log in or D ^XUP first!" QUIT  ;
 ;
 ;[need to add a loop here so you can choose another patient] 
 ;select a patient
 NEW DFN SET DFN=$$GETPT QUIT:+DFN'>0  ; [1/16/2015]
 ;ZW ^DPT(DFN),Y ;debug
 ;
 New RXARRAY Do SETRXRA ; set up array of Rx's
 ;
 If $Data(RXARRAY) DO RELEASE(DFN)
 ;
 QUIT  ; label EN
 ;
 ;
GETPT() ; select a patient
 ;Ext Ouput: -1 for error, 0 for failure, patient DFN if successful
 ;
 NEW OUT SET OUT=$$GETPAT3^ZVHPAT
 QUIT $GET(OUT)
 ;
 ;use dic to select a patient from ^DPT(
 NEW DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,OUT
 SET OUT=0
 SET DIC="^DPT("
 SET DIC(0)="QEATMN"
 DO ^DIC
 IF Y=-1!$GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) DO  QUIT
 . WRITE !,"ERROR: No Patient Selected.",!!
 . SET OUT=0
 IF $DATA(Y) SET OUT=+Y ; patient's IEN in file 2
 ;
 QUIT $GET(OUT) ; label GETPT
 ;
 ;
SETRXRA ; set up the Rx array
 ;REQUIRED: new RXARRAY before calling
 ;EXT OUTPUT: -1 error, 0 fail, 1 successful
 ;use dic to select prescription(s) from ^psrx(
 ;
 NEW DONE,COUNT,OUT
 SET (DONE,COUNT,OUT)=0
 ;SET RXARRAY="Prescription IENs"
 FOR  SET COUNT=COUNT+1 QUIT:DONE  DO
 . NEW DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . IF COUNT=1 SET DIC("A")="Select a Prescription: "
 . IF COUNT>1 Set DIC("A")="Select another Prescription: "
 . SET DIC="^PSRX("
 . SET DIC(0)="QEA"
 . ; only show Rxs for this patient (field 2 points to file 2)
 . SET DIC("PTRIX",52,2,2)=DFN
 . SET DIC("S")="I $P(^(0),U,2)=DFN" ; only allow selection if DFN matches
 . DO ^DIC
 . IF $GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) SET DONE=1 QUIT
 . IF Y=-1 SET DONE=1 QUIT
 . ;ZW ^PSRX(+Y),Y ;debug
 . IF $DATA(Y) SET RXARRAY(+Y)="" ; 
 If $Data(RXARRAY)>9 Set OUT=1
 ;
 Quit $Get(OUT) ; label SETRXRA
 ;
 ;
RELEASE(DFN)    ; Release medication Rx by Patient and Rx #
 ;
 WRITE @IOF,!
 ; loop thru the RXARRAY
 NEW IEN52,ERROR SET IEN52=""
 FOR  SET IEN52=$ORDER(RXARRAY(IEN52)) QUIT:'IEN52  DO
 . DO SHOWRX(IEN52)
 . ; check finish date/time
 . NEW FINISHED,FINDATE,DONE 
 . SET DONE=0 ; var used to end loop
 . SET FINISHED=$$CKFINDT(IEN52,.FINDATE)
 . If FINISHED'>0 Write !,"Cannot release this Rx - you must finish it first.",!! Quit
 . ;
 . ;edit Issue and Login Date [4/10/15 AJC]
 . New ISSUE Set ISSUE=$$ISSUEDT(IEN52,FINDATE) ; default to finish date/time
 . New LOGIN Set LOGIN=$$LOGINDT(IEN52,ISSUE) ; default to issue date/time
 . ;
 . ;edit dispense date, use date of finish date as default [4/10/15 ajc]
 . New DISPENSE Set DISPENSE=$$DISPENSE(IEN52,FINDATE)
 . ;
 . ;ask if edit fill date [1/8/15 AJC]
 . NEW FILLDATE,FILLDATE2,CHANGED
 . SET FILLDATE=$$GET1^DIQ(52,IEN52,22,"I") 
 . WRITE !,?2,"FILL DATE: ",$$FMTE^XLFDT(FILLDATE),!
 . SET CHANGED=$$CHRELDT1(.FILLDATE2,DISPENSE,"FILL") ;[default to dispense 4/10/15 ajc]
 . ; if fileman date/time, then file it.
 . IF $GET(CHANGED)&($GET(FILLDATE2)?7N.1".".6N) Do 
 . . ;SET CHANGED=$$FILLCHG(IEN52,FILLDATE2,0) ; [4/10/15 AJC]
 . . Set CHANGED=$$CHGDATE(IEN52,FILLDATE2,22,"FILL",0)
 . . If CHANGED Set FILLDATE=FILLDATE2 ; 3/12/15 use for default expiration date/time
 . ; 
 . IF FINISHED=1&$DATA(FINDATE) DO
 . . WRITE !,?2,"FINISHED DATE: ",$$FMTE^XLFDT(FINDATE),!
 . . NEW RELEASED,RELDATE ; is it released? release date/time
 . . SET RELEASED=$$CKRELRX(IEN52,.RELDATE)
 . . WRITE ?2," RELEASE DATE: ",$$FMTE^XLFDT(RELDATE),!
 . . ;
 . . ;ask if edit finish date?
 . . NEW FINDATE2,CHANGED
 . . ; if the fill date was changed, use that as the default
 . . IF $GET(FILLDATE2) SET CHANGED=$$CHFINDT1(.FINDATE2,FILLDATE2)
 . . ELSE  SET CHANGED=$$CHFINDT1(.FINDATE2,FINDATE)
 . . ;B ;debug
 . . IF $GET(CHANGED)&($GET(FINDATE2)?7N.1".".6N) DO 
 . . . SET CHANGED=$$FILEFIN(IEN52,FINDATE2,0)  ; if fileman date/time, then file it.
 . . . SET FINDATE=FINDATE2 ; used as default for release date [1/8/15]
 . . ;B ;debug
 . . ;if released, then ask release date time, default to finish date/time
 . . IF RELEASED=1 NEW DATE SET DATE=$$CHRELDT1(.RELDATE,FINDATE,"RELEASE")
 . . IF 'RELEASED NEW DATE SET DATE=$$CHRELDT2(.RELDATE,FINDATE,"RELEASE") ; choose a release date/time
 . . ;IF $GET(DATE)=0!($GET(DATE)=-1) SET DONE=1 WRITE !!,"Nothing changed.",!! QUIT
 . . IF $Get(DATE)&(RELDATE?7N.1".".6N) DO  ; if fileman date/time, then release it
 . . . NEW ERROR SET ERROR=0
 . . . DO RELMED(IEN52,RELDATE,0,.ERROR)
 . . . IF ERROR ZW ERROR("EDITPSO",$J)
 . . . ELSE  WRITE !,"Rx released on ",$$GET1^DIQ(52,IEN52_",",31),!
 . . If ($Get(DATE)<1)&($Get(CHANGED)<1) WRITE !,"OK, Finish/Release are unchanged.",! QUIT
 . . ;
 . ELSE  WRITE !,"Cannot release this Rx - you must finish it first.",!! QUIT
 . ;FUTURE: it would be cool to link to patient presciption processing if the 
 . ; Rx is not finished.
 . ;
 . Do CHEXPDT(IEN52,FILLDATE) ; change the expiration date 
 . DO CHORDT^ZVHOPM2(IEN52) ; change order dates
 . DO REFILLS^ZVHOPM2(IEN52) ;release all the refills
 . ;
 . WRITE !!
 . DO SHOWRX(IEN52),REFSHOW^ZVHOPM2(IEN52) HANG 2 WRITE !!
 ;
 QUIT  ; label RELEASE
 ;
 ;
SHOWRX(IEN52)   ; show info for the Rx
 ;REQUIRED: pass by value IEN52 (ien in file 52)
 QUIT:'$DATA(IEN52)
 ;
 NEW ORDER SET ORDER=$$GET1^DIQ(52,IEN52,39.3) ; order #
 ;
 WRITE @IOF
 WRITE ?2,$E($$GET1^DIQ(52,IEN52,2),1,36),?42,$E($$GET1^DIQ(52,IEN52,6),1,37),! ; patient and med
 WRITE ?4,"Rx #: ",$$GET1^DIQ(52,IEN52,.01) WRITE:$L($$GET1^DIQ(52,IEN52,.01))>28 !
 WRITE ?34,"IEN: ",IEN52  WRITE ?64,"ORDER #: ",ORDER,!
 WRITE ?4,"# of REFILLS: ",$$GET1^DIQ(52,IEN52,9),?44,"DAYS SUPPLY: ",$$GET1^DIQ(52,IEN52,8),!
 ; [4/10/15 adding issue, login and dispense dates AJC]
 ; [6/15/2015 adding sign, release, when ordered, date of last activity]
 Write ?4,"   ISSUE DATE: ",$$GET1^DIQ(52,IEN52,1),?44,"ORDER DATE: ",$$GET1^DIQ(100.008,"1,"_ORDER_",",.01),!
 Write ?4,"   LOGIN DATE: ",$$GET1^DIQ(52,IEN52,21),?44,"    SIGNED: ",$$GET1^DIQ(100.008,"1,"_ORDER_",",6),!
 Write ?4,"DISPENSE DATE: ",$$GET1^DIQ(52,IEN52,25),?44,"  RELEASED: ",$$GET1^DIQ(100.008,"1,"_ORDER_",",16),!
 WRITE ?4,"    FILL DATE: ",$$GET1^DIQ(52,IEN52,22),?42,"WHEN ORDERED: ",$$GET1^DIQ(100,ORDER,4),!
 WRITE ?4,"  FINISH DATE: ",$$GET1^DIQ(52,IEN52,38.3),?44,"START DATE: ",$$GET1^DIQ(100,ORDER,21),!
 WRITE ?4," RELEASE DATE: ",$$GET1^DIQ(52,IEN52,31),?41,"LAST ACTIVITY: ",$$GET1^DIQ(100,ORDER,31),!
 ; added expire date 2015mar12 ajc
 Write ?4,"  EXPIRE DATE: ",$$GET1^DIQ(52,IEN52,26),?44," STOP DATE: ",$$GET1^DIQ(100,ORDER,22),! 
 ;
 QUIT  ; label SHOWRX
 ;
 ;
CKFINDT(IEN,FINISH)     ; check the finish date/time for an Rx
 ;REQUIRED: pass IEN by value the IEN in Rx file 52
 ;OPTIONAL: pass by reference FINISH to return the finish date/time
 ;OUTPUT: 0 if not finished, 1 if finished, -1 if error
 IF '$DATA(IEN) QUIT -1
 NEW DIERR
 SET FINISH="" ; finish date/time
 SET FINISH=$$GET1^DIQ(52,IEN_",",38.3,"I")
 IF $GET(DIERR) ZW ^TMP("DIERR",$J) QUIT -1
 IF FINISH="" QUIT 0
 IF FINISH?7N.1".".N QUIT 1
 ELSE  QUIT -1
 ;
 QUIT  ; label CKFINDT
 ;
 ;
ISSUEDT(IEN52,FINDATE)  ; edit Issue Date/time?
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52)
 ;OPTIONAL: pass by value FINDATE.  will default to finish date if not passed
 ;Extrinsic Output: -1 for error, 0 for fail, fileman date time for success
 ;
 Quit:'$Data(IEN52) -1
 New OUT Set OUT=0 ; ext output
 If '$Get(FINDATE) Set FINDATE=$$GET1^DIQ(52,IEN52,38.3)
 New ISSUE2,CHANGED
 Write ?2,"ISSUE DATE: ",$$GET1^DIQ(52,IEN52,1,"E"),!
 Set CHANGED=$$CHRELDT1(.ISSUE2,FINDATE,"ISSUE") ; ask if want to change it
 ;
 If $Get(CHANGED)&($Get(ISSUE2)?7N.1".".6N) Do 
 . ;Set CHANGED=$$ISSUCHG(IEN52,ISSUE2,0)
 . Set CHANGED=$$CHGDATE(IEN52,ISSUE2,1,"ISSUE",0)
 . If CHANGED Set OUT=$$GET1^DIQ(52,IEN52,1) ; date/time for ext output
 ;
 Quit $Get(OUT) ; label ISSUEDT
 ;
 ;
LOGINDT(IEN52,DEFAULT)  ; edit the login date/time?
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52)
 ;OPTIONAL: pass by value DEFAULT.  will default to issue date if not passed
 ;Extrinsic Output: -1 for error, 0 for fail, fileman date time for success
 ;
 Quit:'$Data(IEN52) -1
 New OUT Set OUT=0 ; ext output
 If '$Get(DEFAULT) Set DEFAULT=$$GET1^DIQ(52,IEN52,1)
 New LOGIN2,CHANGED
 Write ?2,"LOGIN DATE: ",$$GET1^DIQ(52,IEN52,21,"E"),!
 Set CHANGED=$$CHRELDT1(.LOGIN2,DEFAULT,"LOGIN") ; ask if want to change it
 ;
 If $Get(CHANGED)&($Get(LOGIN2)?7N.1".".6N) Do 
 . Set CHANGED=$$CHGDATE(IEN52,LOGIN2,21,"LOGIN",0)
 . If CHANGED Set OUT=$$GET1^DIQ(52,IEN52,21) ; date/time for ext output
 ;
 Quit $Get(OUT) ; label LOGINDT
 ;
 ;
DISPENSE(IEN52,DEFAULT) ; edit the dispense date? 25
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52)
 ;OPTIONAL: pass by value DEFAULT.  will default to finish date if not passed
 ;Extrinsic Output: -1 for error, 0 for fail, fileman date time for success
 ;
 Quit:'$Data(IEN52) -1
 New OUT Set OUT=0 ; ext output
 If '$Get(FINDATE) Set FINDATE=$$GET1^DIQ(52,IEN52,38.3)
 Set FINDATE=$Piece(FINDATE,".") ; date only
 New DISPENSE2,CHANGED
 Write ?2,"DISPENSE DATE: ",$$GET1^DIQ(52,IEN52,25,"E"),!
 Set CHANGED=$$CHRELDT1(.DISPENSE2,FINDATE,"DISPENSE") ; ask if want to change it
 ;
 If $Get(CHANGED)&($Get(DISPENSE2)?7N.1".".6N) Do 
 . Set CHANGED=$$CHGDATE(IEN52,DISPENSE2,25,"DISPENSE",0)
 . If CHANGED Set OUT=$$GET1^DIQ(52,IEN52,25) ; date/time for ext output
 ;
 Quit $Get(OUT) ; label DISPENSE
 ;
 ;
CHRELDT1(RELDATE,DEFDATE,DISPLAY)       ; change the release date/time
 ;REQUIRED: pass the Default date by value DEFDATE, pass the release date/time 
 ;   by ref (RELDATE)
 ;OUTPUT: 0 for failed, 1 for success
 ;OPTIONAL: pass a string in DISPLAY to use as the display text (EX: refill or release)
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,OUT ; vars for DI Read, OUT=output of extrinsic
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Want to change the "_$GET(DISPLAY)_" date/time"
 SET DIR("B")="NO"
 SET DIR("?",1)="This Prescription or Refill has an "_$Get(DISPLAY)_" date.  Answer"
 SET DIR("?",2)="yes to change the "_$Get(DISPLAY)_" date/time"
 DO ^DIR
 QUIT:$GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) 0
 IF Y=1 DO 
 . NEW DATE SET DATE=$$CHRELDT2(.RELDATE,DEFDATE,$GET(DISPLAY)) ; choose a new release date/time
 . IF DATE=0!(DATE=-1) SET OUT=0 QUIT  ; not successful in selecting a date
 . IF DATE=1 SET OUT=1
 ELSE  SET OUT=0
 ;
 QUIT OUT ; label CHRELDT1
 ;
 ;
CHRELDT2(RELDATE,DEFDATE,DISPLAY)       ; choose the date/time for release, refill 
 ;   or finish
 ;REQUIRED: All dates in FM format?
 ;   pass RELDATE by REFERENCE for return of the Release, refill or finish 
 ;   date/time
 ;OPTIONAL: Pass a string via DISPLAY to use as the display name.  (like 
 ;    release, refill or finish)
 ;    DEFDATE by value (default date/time) can use release date/time or refill 
 ;    date/time or any default date/time
 ;OUTPUT: 0 for failed, 1 for success, -1 for error
 ;
 IF $GET(DEFDATE)="" SET DEFDATE=0
 ;
 NEW X,Y,%DT,DTOUT,DUOUT,DIRUT,DIROUT
 SET %DT="AEST"
 IF DEFDATE>0 SET %DT("B")=DEFDATE
 SET %DT("A")=$SELECT($DATA(DISPLAY):DISPLAY_" Date: ",1:"New Date: ")
 DO ^%DT
 IF $GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT)!(Y=-1) QUIT 0
 IF Y SET RELDATE=+Y QUIT 1
 ;
 ;
 QUIT  ; label CHRELDT2
 ;
 ;
CHGDATE(IEN52,DATE,FIELD,TEXT,SILENT) ; edit a date of the Rx [4/10/15 ajc]
 ;REQUIRED: pass by value: IEN52 (ien of the Rx in file 52), new value DATE,
 ;    FIELD number, display TEXT to identify the field  
 ;  new ERROR before calling to save error trap
 ;
 ;OUTPUT: 1 successful, 0 not successful, -1 error
 QUIT:'$DATA(IEN52)!'$DATA(DATE)!'$Data(FIELD)!'$Data(TEXT) -1
 ;
 IF $GET(SILENT)="" SET SILENT=0
 NEW OUT SET OUT=0
 ;
 IF DATE?7N.1".".6N DO 
 . NEW DIERR,ZVHFDA KILL ^TMP("DIERR",$J) ; set up for DI Edit
 . SET ZVHFDA(52,IEN52_",",FIELD)=+DATE
 . ;B ;debug
 . DO FILE^DIE("K","ZVHFDA","")
 . ;check for errors
 . IF $DATA(DIERR) DO  QUIT
 . . SET ERROR=1,OUT=-1
 . . MERGE ERROR("EDITPSO","DATE",$G(TEXT),$J,IEN52,$Get(DATE))=^TMP("DIERR",$J)
 . . WRITE:'SILENT " ERROR: Unable to save the Edit, check ERROR variable array.",!!
 . ELSE  WRITE:'SILENT !!,?2,TEXT," date changed to ",$$GET1^DIQ(52,IEN52,FIELD),!! SET OUT=1
 Else  Set ERROR("EDITPSO","DATE",$J,IEN52,"BAD DATE")=$Get(DATE),OUT=-1
 ;
 QUIT $GET(OUT) ; label CHGDATE
 ;
 ;
CKRELRX(IEN,RELEASE)    ; check if the rx has already been released
 ;REQUIRED: Pass by value the IEN in file 52.  not the RX #!
 ;OPTIONAL: pass by ref the var RELEASE to get back the release date/time in
 ;  standard fileman format
 ;OUTPUT: 1 is released, 0 is not released, -1 is error
 QUIT:'$DATA(IEN) -1
 ; 
 NEW DIERR  ; for errors
 SET RELEASE="" ; release date/time
 SET RELEASE=$$GET1^DIQ(52,IEN_",",31,"I")
 IF $GET(DIERR) ZW ^TMP("DIERR",$J) QUIT -1
 IF RELEASE="" QUIT 0
 IF RELEASE?7N.1".".N QUIT 1
 ELSE  QUIT -1
 ;
 ;B ;debug
 QUIT  ; label CKRELRX
 ;
 ;
CHFINDT1(FINDATE,DEFDATE)       ; change the FINISH date/time
 ;REQUIRED: pass the Default date by value DEFDATE, pass the release date/time 
 ;   by ref (RELDATE)
 ;OUTPUT: 0 for failed, 1 for success
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,OUT ; vars for DI Read, OUT=output of extrinsic
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Want to change the FINISH date/time"
 SET DIR("B")="NO"
 SET DIR("?",1)="This Prescription or Refill has been FINISHED already, answer"
 SET DIR("?",2)="yes to change the FINISH date/time"
 DO ^DIR
 QUIT:$GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) 0
 IF Y=1 DO 
 . NEW DATE SET DATE=$$CHRELDT2(.FINDATE,DEFDATE,"FINISH") ; choose a new finish date/time
 . IF DATE=0!(DATE=-1) SET OUT=0 QUIT  ; not successful in selecting a date
 . IF DATE=1 SET OUT=1
 ELSE  SET OUT=0
 ;
 QUIT OUT ; label CHFINDT1
 ;
 ;
FILEFIN(IEN52,FINDATE,SILENT)   ; edit the finish date/time
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52)
 ;  pass by value FINDATE the new finish date/time in fileman format
 ;  new ERROR before calling to save error trap
 ;OUTPUT: 1 successful, 0 not successful, -1 error
 ;
 QUIT:'$DATA(IEN52)!'$DATA(FINDATE) -1
 ;
 IF $GET(SILENT)="" SET SILENT=0
 NEW OUT SET OUT=0
 IF FINDATE?7N.1".".6N DO 
 . NEW DIERR,ZVHFDA KILL ^TMP("DIERR",$J) ; set up for DI Edit
 . SET ZVHFDA(52,IEN52_",",38.3)=FINDATE
 . ;B ;debug
 . DO FILE^DIE("K","ZVHFDA","")
 . ;check for errors
 . IF $DATA(DIERR) DO  QUIT
 . . SET ERROR=1,OUT=-1
 . . MERGE ERROR("EDITPSO",$J,IEN)=^TMP("DIERR",$J)
 . . WRITE:'SILENT " ERROR: Unable to save the Edit, check ERROR variable array.",!!
 . ELSE  WRITE:'SILENT !!,?2,"Finish date changed to ",$$GET1^DIQ(52,IEN52,38.3),!! SET OUT=1
 ;
 QUIT $GET(OUT) ; label EDITFIN
 ;
 ;
RELMED(IEN,DATE,SILENT,ERROR)   ; release a medication
 ;REQUIRED: pass by value IEN - the prescription IEN from file 52.  NOT THE 
 ;  PRESCRIPTION NUMBER!  new ERROR before calling - will return the array of
 ;  error data
 ;OPTIONAL: pass a specific date to use as the release date.
 ;  if no date is passed, the finish date will be used
 ;  Silent=1 for silent output or silent=0 for verbose
 ;
 ;CHECK: existing reference date before calling.  check with user BEFORE calling this tagline
 ;
 ; returns a 1 if successful, a 0 if unsuccessful, and a -1 if an error occured
 ;---
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK QUIT -1
 ;
 IF 'IEN SET ERROR="NO IEN PASSED" QUIT -1
 ;
 IF $GET(SILENT)="" SET SILENT=0
 ;
 ;check the date input if given
 IF $GET(DATE)'=""&($GET(DATE)'?7N.1".".6N) WRITE:'SILENT "ERROR: Bad date input.",!! QUIT -1 ; 
 ;
 ;check that the med has a finish date (completed in op pharmacy)
 NEW FINISHED,FINDATE,SUCCESS
 SET SUCCESS=0
 SET FINISHED=$$CKFINDT(IEN,.FINDATE)
 IF FINISHED=1 DO 
 . NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; set up for DI Edit
 . SET ZVHFDA("52",IEN_",",31)=$S(DATE:DATE,1:FINDATE)
 . ;B ;debug
 . DO FILE^DIE("K","ZVHFDA","")
 . ;check for errors
 . IF $DATA(DIERR) DO  QUIT
 . . SET ERROR=1,OUT=-1
 . . MERGE ERROR("EDITPSO",$J,IEN)=^TMP("DIERR",$J)
 . . WRITE:'SILENT " ERROR:Unable to save the Edit, check ERROR variable array.",!!
 . ELSE  SET SUCCESS=1
 ;
 QUIT SUCCESS ; label RELMED
 ;
 ;
CHEXPDT(IEN52,FILLDATE) ; change the expiration date , 2015mar12 ajc
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52) 
 ;
 ;EXT OUTPUT: -1 error, 0 not changed, 1 changed
 ;
 Quit:'$Get(IEN52) -1  
 New OUT Set OUT=0 ; default ext output
 ;
 If $Get(FILLDATE)'?7N.1".".6N Set FILLDATE=$$GET1^DIQ(52,IEN52,22,"I")
 New DAYS,FILLS,DURATION,DEFAULT
 Set DAYS=$$GET1^DIQ(52,IEN52,8) ; days supply
 Set FILLS=$$GET1^DIQ(52,IEN52,9)+1 ; initial fill + all potential refills
 If DAYS=90&(FILLS=4) Set DURATION=365 ; change to 1 year
 Else  Set DURATION=DAYS*FILLS
 Set DEFAULT=$$FMADD^XLFDT(FILLDATE,DURATION)
 ;
 New EXPIRE,EXPIRE2,CHANGED,FILED
 Set EXPIRE=$$GET1^DIQ(52,IEN52,26) ; get the expiration date
 Write ?2,"EXPIRATION DATE: ",EXPIRE,!
 If DEFAULT>0 Set DEFAULT=$Piece(DEFAULT,".") ; date without time
 Set CHANGED=$$CHRELDT1(.EXPIRE2,DEFAULT,"EXPIRATION")
 ; if fileman date/time, then file it
 If $Get(CHANGED)&($Get(EXPIRE2)?7N.1".".6N) Do 
 . Set CHANGED=$$CHGDATE(IEN52,EXPIRE2,26,"EXPIRATION",0)
 . If CHANGED Set OUT=$$GET1^DIQ(52,IEN52,26) ; date/time for ext output
 ;
 Quit $Get(OUT) ; label CHEXPDT
 ;
 ;
