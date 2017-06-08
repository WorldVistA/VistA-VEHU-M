ZVHOPM2	;OIA/AJC - modify Outpatient Med orders & refills ;4/10/15
 ;;0.1;NO PKG;**NO PATCHES**;Apr 10, 2015; no build
 ;
 ; test accounts only!
 ;
 ; class 3 APIs: SHOWRX^ZVHOPM; CHRELDT1^ZVHOPM; CHRELDT2^ZVHOPM
 ; class 1 APIs: PROD^XUPROD; GET1^DIQ; ^DIC; FIND1^DIC; FILE^DIE; ^DIR; ^%DT
 ;
 ; [6/3/15 ajc - adding signature date/time, release date/time, and date of 
 ;   last activity]
 ;---------------------------------------------------------------------------
 ;
 ;
 Write !!,"Enter at a label!",!! Quit
 ;
 ;
REFILLS(IEN52,SILENT)	; release the existing refills
 ;REQUIRED: pass IEN52 by value - the Rx IEN in file 52
 ;OUTPUT: 1 successful, 0 not successful, -1 error
 ;
 QUIT:'$D(IEN52) -1
 IF $GET(SILENT)="" SET SILENT=0
 ;get the number of refills
 NEW NUM SET NUM=$$REFSHOW2(IEN52) ;OK
 ; check the order - should it have refills?
 NEW REFORD SET REFORD=$$GET1^DIQ(52,IEN52,9) ;OK
 IF REFORD'>0 DO  QUIT 0
 . DO:'SILENT SHOWRX^ZVHOPM(IEN52) ;OK
 . WRITE:'SILENT !!,?2,"No refills ordered.",!!
 . ;
 ELSE  IF 'SILENT NEW CHANGED SET CHANGED=$$REFADD(IEN52) ; prompt to make changes [1/8/15] ;OK
 ;
 ; display current refills and releases
 DO:'SILENT SHOWRX^ZVHOPM(IEN52) ; OK
 SET NUM=$$REFSHOW(IEN52) ; display refills again, get NUM number of refills ;OK
 ;
 NEW ERROR ; for errors in loop
 IF NUM>0 NEW I SET I=0 FOR  SET I=$ORDER(^PSRX(IEN52,1,I)) QUIT:'I!(I'?1N)  DO   ;loop thru the refills
 . ;B ;debug
 . WRITE !!,"Now, you may release the Refill(s):"
 . NEW REFILLDT,IENS,RELEASED,RELDATE,DATE
 . ; get the refill date
 . SET IENS=I_","_IEN52_"," SET REFILLDT=$$GET1^DIQ(52.1,IENS,.01,"I") ;OK
 . ; get the release date
 . SET RELEASED=$$CKRELRF(IEN52,I,.RELDATE) ; RELDATE=$$GET1^DIQ(52.1,IENS,17) ;OK
 . ; select the release date/time, default to refill date time
 . IF RELEASED=1 DO  ; already released, want a new release date/time?
 . . WRITE !!,?2,"Editing #",I,". ","REFILL DATE/TIME: ",REFILLDT,!
 . . WRITE ?6,"RELEASE DATE/TIME: ",RELDATE,!
 . . SET DATE=$$CHRELDT1^ZVHOPM(.RELDATE,REFILLDT,"RELEASE the refill")  ; OK
 . ELSE  DO  ; not released, so just ask for the release date/time
 . . WRITE !,?2,"Editing #",I,".",?6,"REFILL DATE/TIME: ",REFILLDT,!
 . . SET DATE=$$CHRELDT2^ZVHOPM(.RELDATE,REFILLDT,"RELEASE the refill") ; OK
 . IF $GET(DATE)=0!($GET(DATE)=-1) WRITE !!,"Nothing changed.",!! QUIT
 . IF $GET(DATE)=1 DO  ; relese the refill
 . . NEW RELEASED SET RELEASED=$$RELREF(IEN52,I,RELDATE,0,.ERROR) ;OK
 . . ;debug ;ZW I,REFILLDT,IENS,RELEASED,RELDATE,DATE,ERROR
 . . IF $GET(RELEASED)=-1!($GET(RELEASED)=0) WRITE !,"NOTHING CHANGED!",!! QUIT
 . . IF $GET(RELEASED)=1 WRITE !,"Refill Released on ",$$GET1^DIQ(52.1,IENS,17) ;OK
 ; 
 QUIT  ; label REFILLS
 ;
REFSHOW(IEN52)	; show refills and their release dates
 ;REQUIRED: pass IEN52 by value
 ;OUTPUT: -1 if error, number of refills if not an error
 QUIT:'$DATA(IEN52) -1
 WRITE !
 ;get the number of refills
 NEW NUM,ORDER SET NUM=$PIECE($GET(^PSRX(IEN52,1,0)),U,3)
 SET ORDER=$$GET1^DIQ(52,IEN52,9) ;OK
 ;
 IF ORDER'>0 WRITE !,"There are no refills ORDERED for this Rx.",!
 IF NUM>0 DO
 . NEW I SET I=0
 . FOR  SET I=$ORDER(^PSRX(IEN52,1,I)) QUIT:I=""!(I>NUM)!(I'=+I)  DO  ;
 . . WRITE ?2,I,"."
 . . WRITE ?6,"REFILL DATE: ",$$GET1^DIQ(52.1,I_","_IEN52_",",.01) ;OK
 . . WRITE ?44,"RELEASE DATE: ",$$GET1^DIQ(52.1,I_","_IEN52_",",17),! ;OK
 ELSE  WRITE ?2,"There are no refills for this Rx.",!! SET NUM=0
 ;
 QUIT NUM ; label REFSHOW
 ;
 ;
REFSHOW2(IEN52)	; show refills WITHOUT their release dates
 ;REQUIRED: pass IEN52 by value
 ;OUTPUT: -1 if error, number of refills if not an error
 QUIT:'$DATA(IEN52) -1
 WRITE !
 ;get the number of refills
 NEW NUM SET NUM=$PIECE($GET(^PSRX(IEN52,1,0)),U,3)
 IF NUM>0 DO
 . NEW I SET I=0
 . FOR  SET I=$ORDER(^PSRX(IEN52,1,I)) QUIT:I=""!(I>NUM)!(I'=+I)  DO  ;
 . . WRITE ?2,I,"."
 . . WRITE ?6,"REFILL DATE: ",$$GET1^DIQ(52.1,I_","_IEN52_",",.01),! ;OK
 ELSE  WRITE ?2,"There are no refills for this Rx.",!! SET NUM=0
 ;
 QUIT NUM ; label REFSHOW2
 ;
 ;
REFADD(IEN52)	; add/edit the refills [change display text 1/8/15]
 ;REQUIRED: pass by value IEN52 (ien in file 52)
 ;EXTRINSIC OUTPUT: -1 for error, 0 for no change, 1 for successful change
 QUIT:'$DATA(IEN52) -1
 ;
 DO SHOWRX^ZVHOPM(IEN52) ;OK
 ; check the order - should it have refills?
 NEW REFORD SET REFORD=$$GET1^DIQ(52,IEN52,9) ; # of refills ORDERED ;OK
 IF REFORD'>0 WRITE !!,?2,"No refills ordered.  Quitting...",!! QUIT 0
 ;
 WRITE !,"Now editing REFILL date/times...",!
 NEW OUT,DONE SET (DONE,OUT)=0 ; OUT = output Done=1 when done editing
 DO  ; prompt to make changes
 . DO REFSHOW2(IEN52) ;OK
 . FOR  QUIT:DONE  DO 
 . . NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT ; vars for DI Read
 . . SET DIR(0)="Y^A" ; DI read yes/no prompt
 . . NEW NUM SET NUM=$PIECE($GET(^PSRX(IEN52,1,0)),U,3) ; get the number of refills ENTERED [1/8/15]
 . . ;B ;debug
 . . IF NUM'<REFORD SET DONE=1 WRITE !!,REFORD_" refills ordered!",!! QUIT  ; #entered must be less than or equal to # ordered
 . . SET:NUM'>0 DIR("A")="Want to add REFILL date/time(s)" ; [1/8/15]
 . . SET:NUM>0 DIR("A")="Want to add new REFILLS or edit the existing REFILL date/time(s)" ; [1/8/15]
 . . SET DIR("B")="NO"
 . . DO ^DIR
 . . QUIT:$GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT)
 . . ;B ;debug
 . . IF Y=1 SET OUT=$$REFADD2(IEN52) ; edit/add refills ;OK
 . . IF Y=0!(Y=-1) SET DONE=1,OUT=0
 ;
 QUIT $GET(OUT) ; label REFADD
 ;
 ;
REFADD2(IEN52)	; add/edit refill date/time
 ;REQUIRED: pass by value IEN52 (ien in file 52) and I (refill #)
 ;  pass by ref: DONE and OUT to return signal for finished and output
 ;EXT OUTPUT: 0 for fail, 1 for success, -1 for error
 QUIT:'$DATA(IEN52) -1
 ;
 NEW OUT SET OUT=0 ; for output
 NEW DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DA
 SET DIC("A")="Select a refill: "
 SET DIC="^PSRX("_IEN52_",1,"
 SET DIC(0)="ACELMNQT" ; L = LAYGO
 SET DA=1,DA(1)=IEN52
 DO ^DIC
 IF $GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) SET OUT=-1 QUIT
 IF Y=-1 SET OUT=-1 QUIT
 IF +Y DO
 . ;B ;debug
 . NEW IENREFILL,REFILLDT,NEW
 . SET IENREFILL=+Y ; ien of the refill in 52.1
 . SET REFILLDT=$PIECE(Y,U,2) ; date/time of the refill
 . SET NEW=$PIECE(Y,"^",3)
 . IF $GET(NEW)=1 SET OUT=$$REFADD3(IEN52,IENREFILL,REFILLDT,0) QUIT  ; ADDED a new entry ;OK
 . IF $GET(NEW)="" SET OUT=$$EDITREF(IEN52,IENREFILL,0) QUIT  ; EDIT an existing entry ;OK
 . ELSE  WRITE !!,"OK, nothing added.",!! SET OUT=0
 ;
 QUIT $GET(OUT) ; label REFADD2
 ;
 ;
REFADD3(IEN52,IEN521,REFILLDT,SILENT)	; add a new refill
 ;REQUIRED: IEN52 by value (ien from file52) and IEN521 by value (ien of the 
 ;   refill from 52.1)
 ;OUTPUT: 1 for success, 0 for fail, -1 for error
 QUIT:'$DATA(IEN52)!'$DATA(IEN521)!'$DATA(REFILLDT) -1
 IF $GET(SILENT)="" SET SILENT=0
 ;
 ;select a date for the new refill
 NEW OUT SET OUT=0 ; OUT for output, default to 0
 IF REFILLDT'?7N.1".".6N WRITE:'SILENT "ERROR: Bad date input.",!! QUIT 0
 ELSE  DO  ; got a good refill date, file it
 . NEW DIERR,ZVHFDA ; variables for DI Edit/File
 . KILL ^TMP("DIERR",$J) ; for error trapping
 . ; copy the required fields from the Rx
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",.01)=+REFILLDT               ; refill date
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",1)=+$$GET1^DIQ(52,IEN52,7)   ; QTY ;OK
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",1.1)=+$$GET1^DIQ(52,IEN52,8) ; DAYS SUPPLY ;OK
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",4)=+$$GET1^DIQ(52,IEN52,23)  ; PHARM DUZ ;OK
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",7)=+REFILLDT                 ; LOGIN DATE
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",10.1)=+REFILLDT              ; DISPENSED DATE
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",2)=$S(IEN52#2>0:"M",1:"W")   ; MAIL/WINDOW [1/8/15]
 . SET ZVHFDA(52.1,IEN521_","_IEN52_",",11)=$$GET1^DIQ(52,IEN52,27)  ; NDC ;OK
 . ; don't set the release date/time yet
 . DO FILE^DIE("K","ZVHFDA","") ; file it ;OK
 . IF $DATA(DIERR) DO  QUIT  ;
 . . ZW ^TMP("DIERR",$J)
 . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out. Ready to continue?",DIR("B")="YES"
 . . DO ^DIR
 . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") QUIT
 . ELSE  DO 
 . . SET OUT=1
 . . WRITE !!,"SUCCESSFULLY FILED.  New REFILL Date: ",$$GET1^DIQ(52.1,IEN521_","_IEN52_",",.01),! ;OK
 ;
 QUIT $GET(OUT) ; label REFADD3
 ;
 ;
CKRELRF(IEN52,REFIEN,DATE)	; check if the refill has been released
 ;REQUIRED: Pass by value IEN52 (the ien in file 52)
 ;          Pass by value REFIEN (the ien of the refill sub of file 52.1)
 ;OPTIONAL: Pass by reference DATE to return the date/time
 ;OUTPUT: 1 is released, 0 is not released, -1 is error
 ;
 NEW DIERR
 QUIT:'$DATA(IEN52)!'$DATA(REFIEN) -1 ; required inputs
 SET DATE=$$GET1^DIQ(52.1,REFIEN_","_IEN52_",",17,"I") ;OK
 IF $GET(DIERR) ZWRITE ^TMP("DIERR",$J) QUIT -1
 IF DATE="" QUIT 0
 IF DATE?7N.1".".N QUIT 1
 ELSE  QUIT -1
 ;
 QUIT  ; label CKRELRF
 ;
 ;
RELREF(IEN52,IENREFILL,DATE,SILENT,ERROR)	; release a refill
 ;REQUIRED: pass by value: IEN52 (ien of the Rx in file 52); IENREFILL (refill
 ;  IEN from 52.1); DATE release date/time
 ;  New ERROR before calling to allow return of ERROR array
 ;OPTIONAL: SILENT (1 for less verbose)
 ;output 0 for failed 1 for success -1 for error
 ;
 IF 'IEN52!'IENREFILL!'DATE SET ERROR=1,ERROR($J)="MISSING REQUIRED INPUTS" QUIT -1
 ;
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1) ;OK
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT -1
 ;
 IF $GET(SILENT)="" SET SILENT=0
 ;
 NEW DIERR,ZVHFDA ; for DI Edit
 KILL ^TMP("DIERR",$J) ; for errors
 ;
 ; if no date passed, use the refill date/time
 IF $GET(DATE)="" SET DATE=$$GET1^DIQ(52.1,IENREFILL_","_IEN52_",",.01) ;OK
 ; check the date
 IF DATE'?7N.1".".6N WRITE:'SILENT "ERROR: Bad date input.",!! QUIT -1
 ;
 SET ZVHFDA(52.1,IENREFILL_","_IEN52_",",17)=DATE ; set the release date/time
 DO FILE^DIE("K","ZVHFDA","") ; file the Release date/time ;OK
 ; check for errors
 IF $DATA(DIERR) DO  QUIT 0
 . IF 'SILENT DO 
 . . ZW ^TMP("DIERR",$J)
 . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out.  Ready to continue?",DIR("B")="YES"
 . . DO ^DIR
 . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") QUIT
 ELSE  QUIT 1 ; successful
 ;
 QUIT -1 ; label RELREF
 ;
 ;
EDITREF(IEN52,IENREFILL,SILENT)	; edit existing refill
 ;REQUIRED: pass by ref: IEN52 (ien of the Rx in file 52) and IENREFILL (ien 
 ;    of the refill in file 52.1) 
 ;OUTPUT: 1 for successful, 0 for fail, -1 for error
 ;OPTIONAL: SILENT=1 for less verbose output
 QUIT:'$DATA(IEN52)!'$DATA(IENREFILL) -1
 IF $GET(SILENT)="" SET SILENT=0
 ;
 NEW OUT,ERROR
 SET OUT=0 ; default to not filed.
 ;
 DO  ; set up the refill to be edited
 . ; get the refill date
 . NEW REFILLDT,IENS SET IENS=IENREFILL_","_IEN52_"," SET REFILLDT=$$GET1^DIQ(52.1,IENS,.01)
 . ; get the release date
 . NEW RELEASED,RELDATE SET RELEASED=$$CKRELRF(IEN52,IENREFILL,.RELDATE) ; RELDATE=$$GET1^DIQ(52.1,IENS,17) ;OK
 . ; select the default date/time
 . ;   if already released, default to the release date/time
 . ;   otherwise, default to refill date time
 . NEW DATE,DEFDATE SET DEFDATE=$SELECT(RELDATE>0:RELDATE,1:REFILLDT)
 . IF RELEASED=1 DO  ; already released, choose a new release date/time
 . . WRITE !!,?2,"Editing #",IENREFILL,". ","REFILL DATE/TIME: ",REFILLDT,!
 . . WRITE ?6,"RELEASE DATE/TIME: ",RELDATE,!
 . . SET DATE=$$CHRELDT1^ZVHOPM(.REFILLDT,DEFDATE,"REFILL") ;OK
 . ELSE  DO  ; not released, so just ask for the release date/time
 . . WRITE !,?2,"Editing #",IENREFILL,".",?6,"REFILL DATE/TIME: ",REFILLDT,!
 . . SET DATE=$$CHRELDT2^ZVHOPM(.REFILLDT,DEFDATE,"REFILL") ;OK
 . IF $GET(DATE)=0!($GET(DATE)=-1) WRITE !!,"Nothing changed.",!! QUIT
 . IF $GET(DATE)=1 DO  ; FILE THE REFILL DATE/TIME
 . . NEW DIERR,ZVHFDA KILL ^TMP("DIERR",$J)
 . . SET ZVHFDA(52.1,IENREFILL_","_IEN52_",",.01)=REFILLDT
 . . ;B ;debug
 . . DO FILE^DIE("K","ZVHFDA","") ;OK
 . . IF $DATA(DIERR) DO  QUIT
 . . . SET OUT=0
 . . . IF 'SILENT DO 
 . . . . ZW ^TMP("DIERR",$J)
 . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out.  Ready to continue?",DIR("B")="YES"
 . . . . DO ^DIR
 . . . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") QUIT
 . . . ELSE  MERGE ERROR("PSOEDIT",$J)=^TMP("DIERR",$J)
 . . ELSE  SET OUT=1 QUIT  ; successful
 ;
 QUIT $GET(OUT) ; label EDITREF
 ;
 ;
 ;==================================ORDERS===================================
 ;
CHORDT(IEN52)	; Charge order dates? [1/8/15]
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52)
 ;
 QUIT:'$DATA(IEN52) -1
 ;
 DO SHOWOR(IEN52) ;OK
 ;
 NEW OUT,ORDER,ACTIVITY 
 SET OUT=0,ORDER=$$GET1^DIQ(52,IEN52,39.3) ; output and order # ;OK
 Set ACTIVITY(0)="Array of activity date/times" ; [6/3/15]
 ;want to change the order dates?
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT ; vars for DI Read
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Want to change any of the ORDER date/times"
 SET DIR("B")="NO"
 DO ^DIR
 QUIT:$GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT)
 ;B ;debug
 IF Y=0!(Y=-1) SET OUT=0
 IF Y=1 DO  ; edit the order dates
 . WRITE !
 . NEW CHANGED1 SET CHANGED1=$$CHORDT1(ORDER) ; order date/time ;OK
 . NEW CHANGED2 SET CHANGED2=$$CHORDT2(ORDER) ; start date/time ;OK
 . NEW CHANGED3 SET CHANGED3=$$CHORDT3(ORDER) ; stop date/time ;OK
 . ; use the ACTIVITY array to set the date of last activity
 . New LAST Set LAST=$Order(ACTIVITY(""),-1)
 . If $Get(LAST) Do
 . . If LAST?7N.1".".6N Set LAST=$$FILEOR2(ORDER,LAST,"LAST ACTIVITY",31,0)
 . ;B ;debug
 . Set OUT=CHANGED1_"^"_CHANGED2_"^"_CHANGED3_"^"_LAST ; [6/3/15]
 ;
 QUIT $GET(OUT) ; label CHORDT
 ;
 ;
SHOWOR(IEN52)	; show the order dates
 ;REQUIRED: pass by value IEN52 (ien of the Rx in file 52)
 ;OUTPUT: start date, end date, when entered, order date
 ;  ext out: 1 successful, 0 fail, -1 error
 QUIT:'$DATA(IEN52) -1
 ;
 NEW OUT,ORDER,NUM SET OUT=0
 SET ORDER=$$GET1^DIQ(52,IEN52,39.3) ;OK
 Set NUM=0 ; will be IEN for file 100.008
 QUIT:+$GET(ORDER)'>0 -1
 ;
 Write !,?2,"ORDER #: ",ORDER
 For  Set NUM=$Order(^OR(100,ORDER,8,NUM)) Quit:'NUM  Do  ; 2015mar12 ajc
 . Write ?25,$$GET1^DIQ(100.008,NUM_","_ORDER_",",2) ; action type ;OK
 . Write ?42,"ORDER DATE: ",$$GET1^DIQ(100.008,NUM_","_ORDER_",",.01),! ; action date/time ;OK
 ;WRITE !,?2,"ORDER #: ",ORDER,?42,"ORDER DATE: ",$$GET1^DIQ(100.008,"1,"_ORDER_",",.01) ; date/time ordered
 WRITE ?42,"START DATE: ",$$GET1^DIQ(100,ORDER,21),! ;OK
 WRITE ?43,"STOP DATE: ",$$GET1^DIQ(100,ORDER,22),! ;OK
 ;
 QUIT $GET(OUT) ; label SHOWOR
 ;
 ;
CHORDT1(IEN100)	; change the order date(s)
 ;REQUIRED: pass by value IEN100 (ien of the order in file 100)
 ;OUTPUT: start date, end date, when entered, order date
 ;  ext out: 1 successful, 0 fail, -1 error
 ;rewritten to show all subfile date/times 3/12/15 ajc
 ;
 Quit:'$Data(IEN100) -1
 New OUT,NUM Set OUT=0 ; ext output
 Set NUM=0 ; use for the IEN of the subfile entry
 ;for loop through them
 For  Set NUM=$ORDER(^OR(100,IEN100,8,NUM)) Quit:'NUM  Do 
 . Write !
 . New LABEL,ORDATE,ORDATE2,CHANGED
 . ; use the order action as a label.  present each one to the user for editing
 . Set ORDATE=$$GET1^DIQ(100.008,NUM_","_IEN100_",",.01) ; date/time ordered ;OK
 . Set LABEL=$$GET1^DIQ(100.008,NUM_","_IEN100_",",2) ; new, dc, hold, etc ;OK
 . ;Write !,$Select(LABEL="NW":"New",LABEL="DC":"Discontinue",LABEL="HD":"Hold",LABEL="RL":"Release Hold",LABEL="XX":"Change")
 . Write LABEL," Order: ",ORDATE,!
 . Set OUT=$$CHORDT11(IEN100,NUM,LABEL) ;OK
 ;
 QUIT $GET(OUT) ; label CHORDT1
 ;
 ;
CHORDT11(IEN100,NUM,LABEL)	; prompt to change the date
 ;REQUIRED: pass by value IEN100 (ien of the order in file 100), NUM is the ien
 ;  of the date in 100.008, LABEL is the ACTION field from 100.008
 ;OUTPUT: dates to the screen
 ;  ext out: 1 successful, 0 fail, -1 error
 ;
 QUIT:'$DATA(IEN100)!'$Data(NUM) -1
 NEW OUT,ORDATE,ORDATE2,CHANGED SET OUT=0
 SET ORDATE=$$GET1^DIQ(100.008,NUM_","_IEN100_",",.01) ; date/time ordered ;OK
 ;
 SET CHANGED=$$CHRELDT1^ZVHOPM(.ORDATE2,ORDATE,LABEL_" Order") ;OK
 IF $GET(CHANGED)&($GET(ORDATE2)?7N.1".".6N) DO 
 . Do KIL^ORDD100(IEN100,NUM) ; kill the existing AC x-ref [6/15/2015 ajc]
 . Do ACT2^ORDD100A(IEN100,NUM) ; kill the existing ACT x-ref [6/15/2015 ajc]
 . ; 6/15/2015 added .01 to next line
 . SET CHANGED=$$FILEOR1(IEN100,ORDATE2,NUM,.01,LABEL,0) ; if fileman date/time, then file it. ;OK
 . ;SET OUT=CHANGED
 . If $Get(CHANGED) Set ACTIVITY(ORDATE2)=LABEL ; add date to activity array [6/3/15]
 . ; set signature date/time (if present) [6/15/2015]
 . New SIGN ; signature date/time
 . Set SIGN=$$GET1^DIQ(100.008,NUM_","_IEN100_",",6) ; check if signed (EX: service corrections are not)
 . If $Data(SIGN) Do  ; if it's signed, change the signature date/time
 . . Set SIGN=$$FILEOR1(IEN100,ORDATE2,NUM,6,LABEL_" SIGNATURE",0) ; 6 = field #
 . . If $Get(SIGN)>0 Set ACTIVITY(ORDATE2)=LABEL_" Signature" ; add to activity log
 . ; set release date/time 6/15/2015
 . New RELEASE ; release date/time 
 . Set RELEASE=$$FILEOR1(IEN100,ORDATE2,NUM,16,LABEL_" RELEASE",0) ; 16 = field #
 . If $Get(RELEASE)>0 Set ACTIVITY(ORDATE2)=LABEL_" Release"
 . ; need to change output to include all 3
 . Set OUT=CHANGED_"^"_SIGN_"^"_RELEASE
 ;
 QUIT $GET(OUT) ; label CHORDT11
 ;
 ;
CHORDT2(IEN100)	; change the order START date
 ;REQUIRED: pass by value IEN100 (ien of the order in file 100)
 ;OUTPUT: start date, end date, when entered, order date
 ;  ext out: 1 successful, 0 fail, -1 error
 QUIT:'$DATA(IEN100) -1
 NEW OUT,ORSTART,ORSTART2,CHANGED SET OUT=0
 SET ORSTART=$$GET1^DIQ(100,ORDER,21) ; start date/time ;OK
 ; want to change it?
 SET CHANGED=$$CHRELDT1^ZVHOPM(.ORSTART2,ORSTART,"Order START") ;OK
 ; if fileman date/time, then file it
 IF $GET(CHANGED)&($GET(ORSTART2)?7N.1".".6N) SET OUT=$$FILEOR2(IEN100,ORSTART2,"START",21,0) ;OK
 If $Get(OUT)>0 Set ACTIVITY(ORSTART2)="Start"
 ;
 QUIT $GET(OUT) ; label CHORDT2
 ;
 ;
CHORDT3(IEN100)	; change the order STOP date
 ;REQUIRED: pass by value IEN100 (ien of the order in file 100)
 ;OUTPUT: start date, end date, when entered, order date
 ;  ext out: 1 successful, 0 fail, -1 error
 QUIT:'$DATA(IEN100) -1
 NEW OUT,DEFAULT,ORSTOP2,CHANGED SET OUT=0
 ;SET ORSTOP=$$GET1^DIQ(100,ORDER,22) ; stop date/time
 Set DEFAULT=$$GET1^DIQ(52,IEN52,26,"I") ; default to expiration date/time ;OK
 ;want to change it?
 SET CHANGED=$$CHRELDT1^ZVHOPM(.ORSTOP2,DEFAULT,"Order STOP") ;OK
 ; if fileman date/time, then file it.
 ;IF $GET(CHANGED)&($GET(ORSTOP2)?7N.1".".6N) SET OUT=$$FILEOR3(IEN100,ORSTOP2,0) ;OK 6/15/2015
 IF $GET(CHANGED)&($GET(ORSTOP2)?7N.1".".6N) SET OUT=$$FILEOR2(IEN100,ORSTOP2,"STOP",22,0)
 ;
 QUIT $GET(OUT) ; label CHORDT3
 ;
 ;
FILEOR1(IEN100,ORDATE,NUM,FIELD,LABEL,SILENT)	; file the new order date/time
 ; 6/15/2015 AJC - adding field to make this useful for multiple date/times
 ;REQUIRED: pass by value IEN100 (order number) NUM is the ien from 100.008
 ;  FIELD is the field # in the fileman Data Dictionary
 ;Ext Output: 1 = successful, 0 failed, -1 error
 NEW CHECK SET CHECK=$$PROD^XUPROD(1) ;OK
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ;
 QUIT:'$DATA(IEN100)!'$Data(NUM)!'$Data(FIELD)!'$Data(LABEL)
 NEW OUT SET OUT=0
 IF $GET(SILENT)="" SET SILENT=0
 ;
 NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; set up for DI Edit
 IF +$GET(ORDATE)>0&(ORDATE?7N.1".".6N) DO 
 . ;SET ZVHFDA(100.008,NUM_","_IEN100_",",.01)=+ORDATE ; 6/15/2015
 . SET ZVHFDA(100.008,NUM_","_IEN100_",",FIELD)=+ORDATE ; new order date
 . ;If NUM=1 SET ZVHFDA(100,IEN100_",",4)=+ORDATE ; 6/15/2015
 . If NUM=1&(FIELD=.01) SET ZVHFDA(100,IEN100_",",4)=+ORDATE ; when entered should match new order
 . ;B ;debug
 . DO FILE^DIE("","ZVHFDA","") ;OK
 . ;check for errors
 . IF $DATA(DIERR) DO  QUIT
 . . SET ERROR=1,OUT=-1
 . . MERGE ERROR("FILE_ORDER_SUBFILE_DATE",$J,IEN100)=^TMP("DIERR",$J)
 . . WRITE:'SILENT " ERROR: Unable to save the Edit, check ERROR variable array.",!!
 . ELSE  DO 
 . . WRITE:'SILENT !!,?2,"Order "_LABEL_" date changed to " ; 6/15/2015 added LABEL
 . . WRITE:'SILENT $$GET1^DIQ(100.008,NUM_","_IEN100_",",FIELD),! ;OK
 . . If NUM=1&(FIELD=.01) WRITE:'SILENT ?2,"When Entered date changed to ",$$GET1^DIQ(100,IEN100,4),!! ;OK
 . . SET OUT=1
 ;
 QUIT $GET(OUT) ; label FILEOR1
 ;
 ;
FILEOR2(IEN100,DATE,LABEL,FIELD,SILENT)	; file the new START date/time
 ; make generic to any field in the file (not subfiles)
 ;REQUIRED: pass these by value - IEN100 (order number); DATE in fileman 
 ;  date/time; LABEL is the name of the field and FIELD is the field # from 
 ;  the data dictionary
 ;  new ERROR before calling this
 ;Ext Output: 1 = successful, 0 failed, -1 error
 NEW CHECK SET CHECK=$$PROD^XUPROD(1) ;OK
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ;
 QUIT:'$DATA(IEN100)!'$DATA(DATE)!'$Data(LABEL)!'$Data(FIELD)
 NEW OUT SET OUT=0
 IF $GET(SILENT)="" SET SILENT=0
 ;
 NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; set up for DI Edit
 IF +$GET(DATE)>0&(DATE?7N.1".".6N) DO 
 .  SET ZVHFDA(100,IEN100_",",FIELD)=+DATE
 . ;B ;debug
 . DO FILE^DIE("K","ZVHFDA","") ;OK
 . ;check for errors
 . IF $DATA(DIERR) DO  QUIT
 . . SET ERROR=1,OUT=-1
 . . MERGE ERROR("FILE_OR_DATE",$J,IEN100)=^TMP("DIERR",$J)
 . . WRITE:'SILENT " ERROR: Unable to save the Edit, check ERROR variable array.",!!
 . ELSE  WRITE:'SILENT !!,?2,LABEL_" date changed to ",$$GET1^DIQ(100,IEN100,FIELD),!! SET OUT=1 ;OK
 ;
 QUIT $GET(OUT) ; label FILEOR2
 ;
 ;
 ;===========================NOT CALLED========================
 ;
CKREFDT(IEN52,REFIEN)	; get the refill date/time
 ;REQUIRED: Pass by value IEN52 (the ien in file 52)
 ;          Pass by value REFIEN (the ien of the refill sub of file 52.1)
 ;OUTPUT: -1 for error or date/time in fileman format if successful
 ;
 NEW DIERR
 QUIT:'$DATA(IEN52)!'$DATA(REFIEN) -1 ; required inputs
 NEW DATE
 SET DATE=$$GET1^DIQ(52.1,REFIEN_","_IEN52_",",.01,"I") ;OK
 IF $GET(DIERR) ZWRITE ^TMP("DIERR",$J) QUIT -1
 IF DATE="" QUIT -1
 IF DATE?7N.1".".N QUIT DATE
 ELSE  QUIT -1
 ;
 ;
 QUIT  ; label CKREFDT
 ;
 ;
GETIEN(RXNUM)	; get the IEN from the RX number
 ;REQUIRED: pass by value the Prescription number
 ;OUTPUT: The IEN in file 52, or -1 for error
 ;
 QUIT:'$DATA(RXNUM) -1
 ;
 NEW DIERR,RXIEN ; for errors, for Rx IEN
 SET RXIEN=""
 SET RXIEN=$$FIND1^DIC(52,,"B",RXNUM) ;OK
 IF RXIEN=0!(RXIEN="") QUIT -1 ; not found
 IF RXIEN QUIT RXIEN
 ELSE  QUIT -1
 ;
 QUIT  ; label GETIEN
 ;
 ;
FILEOR3(IEN100,STOPDATE,SILENT)	; file the new STOP date/time
 ;REQUIRED: pass by value IEN100 (order number)
 ;Ext Output: 1 = successful, 0 failed, -1 error
 Q
 NEW CHECK SET CHECK=$$PROD^XUPROD(1) ;OK
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ;
 QUIT:'$DATA(IEN100)!'$DATA(STOPDATE)
 NEW OUT SET OUT=0
 IF $GET(SILENT)="" SET SILENT=0
 ;
 NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; set up for DI Edit
 IF +$GET(STOPDATE)>0&($GET(STOPDATE)?7N.1".".6N) DO 
 . SET ZVHFDA(100,IEN100_",",22)=+STOPDATE
 . ;check for DC date/time, if populated, make it match stop date.
 . New DCDATE Set DCDATE=$$GET1^DIQ(100,IEN100,63,"I") ;OK
 . If $Get(DCDATE)>0 Set ZVHFDA(100,IEN100_",",63)=+STOPDATE_"."_$Piece(DCDATE,".",2)
 . ;B ;debug
 . DO FILE^DIE("K","ZVHFDA","") ;OK
 . ;check for errors
 . IF $DATA(DIERR) DO  QUIT
 . . SET ERROR=1,OUT=-1
 . . MERGE ERROR("FILE_OR_STOPDATE",$J,IEN100)=^TMP("DIERR",$J)
 . . WRITE:'SILENT " ERROR: Unable to save the Edit, check ERROR variable array.",!!
 . ELSE  Do 
 . . WRITE:'SILENT !!,?2,"Stop date changed to ",$$GET1^DIQ(52,IEN52,22) ;OK
 . . If $Get(DCDATE)>0 Write:'SILENT ?2,"DC Date changed to ",$$GET1^DIQ(100,IEN100,63) ;OK
 . . Write:'SILENT !!
 . . SET OUT=1
 ;
 ;
 QUIT $GET(OUT) ; label FILEOR3
 ;
 ;
