ZVHBC2 ;OIA/AJC+TJH - Auto populate BCMA data for demos ; 5/21/14
 ;;0.1;NO PACKAGE;**NO PATCHES**;Feb 12 2014
 ;
 ; called by ZVHBC and ZVHBC3 (IV and PRN meds for ZVHBC)
 ;----------------------------------------------------------
 ;
 WRITE "Not an entry point!  Use EN^ZVHBC",!! QUIT  ; labels in this routine are called by ZVHBC and ZVHBC3
 ;
ONETM(PATIENT,ROOMBED,ERROR1TM,ZVHFILE,END,SILENT) ; give one time and on call meds
 ; pass by ref: ERROR1TM (for errors)
 ; pass by value: PATIENT ROOMBED and ZVHFILE (save(1) or display (0))
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to NOT silent
 ;
 IF 'SILENT WRITE ?1,"One time and on call Meds: ",!
 NEW START SET START=$ORDER(^TMP("ZVHDTARY",$J,0)) ; get the first date in the
 ;   array to use as the Start date
 ;
 IF $GET(END)="" DO  
 . NEW DATE SET DATE=$ORDER(^TMP("ZVHDTARY",$J,""),-1) ; get the last date in the array to use as the end date.
 . SET END=+(DATE_.235959) ; one second before midnight
 IF 'SILENT WRITE $$FMTE^XLFDT(START)," to ",$$FMTE^XLFDT(END),!
 ;
 NEW ERRORMED SET ERRORMED=0
 DO ACTMED^ZVHBC(PATIENT,END,.ERRORMED,SILENT)
 IF ERRORMED DO  QUIT  ;
 . SET (ERROR1TM,ZVHERR)=1
 . SET ZVHERR("ONETM","ACTMED",PATIENT,START,END)=""
 . IF 'SILENT WRITE "ERROR!!  Unable to get active meds... Skipping!",!!
 IF $GET(^TMP("PSJ",$J,1,0))=-1 DO  QUIT  
 . IF 'SILENT WRITE "No active One-time meds for this date.",!
 ;BREAK
 ;build an array of one time and on call meds
 IF 'SILENT WRITE ?6,"Building Meds Array for one-time and on-call..."
 NEW MED,MEDARRAY SET (MED,MEDARRAY)="" ;  medications
 FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO  
 . ;BREAK
 . NEW ON ; Order number for ^OR(100
 . SET ON=$PIECE(^TMP("PSJ",$J,MED,0),"^",9)
 . IF ON[";" SET ON=$PIECE(ON,";") ; Strip the version numbers
 . ;check status, start and stop dates in OR
 . QUIT:$PIECE(^OR(100,ON,3),"^",3)'=6 ; quit if not an active order
 . QUIT:$PIECE(^OR(100,ON,0),"^",8)'<END ; future order start date
 . QUIT:$PIECE(^OR(100,ON,0),"^",9)'>START ; stop date in the past
 . ;NEW ORSTART,ORSTDATE
 . ;SET ORSTART=$PIECE(^TMP("PSJ",$J,MED,1),"^",4) ;order start date/time
 . ;SET ORSTDATE=$PIECE(ORSTART,".") ; just the date piece
 . ;BREAK ;debug
 . QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",2)'["O" ; O(1 time) or OC(on call)
 . ;QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",7)'="A"  ; not active
 . ;QUIT:ORSTDATE<START  ; order start date is before Date array start
 . ;QUIT:ORSTDATE>END  ; order start date is after end of date array
 . ;
 . ;check if already given
 . NEW GIVEN,PSJON SET GIVEN=0
 . SET PSJON=$PIECE(^TMP("PSJ",$J,MED,0),"^",3) ; PSJ order number
 . ; ZVHPT,ZVHON,MED,ZVHGIVEN,ZVHFILE,SILENT
 . DO ONETM^ZVHBCOCK(PATIENT,PSJON,MED,.GIVEN,$G(ZVHFILE),SILENT)
 . IF GIVEN["ERROR" DO  QUIT  ;
 . . SET (ERROR1TM,ZVHERR)=1
 . . SET ZVHERR("ONETM","ZVHBCOCK",PATIENT,PSJON,GIVEN)=""
 . . IF 'SILENT WRITE "ERROR!  Unable to determine if already given.  Skipping!",!!
 . IF 'GIVEN SET MEDARRAY(MED)=""
 . ;BREAK ;debug
 IF 'SILENT WRITE " DONE!",!
 ;
 ; start loop thru the med array
 NEW MED SET MED=""
 FOR  SET MED=$ORDER(MEDARRAY(MED))  QUIT:'MED  DO
 . IF 'SILENT WRITE ?3,$E($P(^TMP("PSJ",$J,MED,3),"^",2),1,18),?22,"(",MED,")" ;
 . ;IF 'SILENT WRITE ! ; formatting
 . ;BREAK
 . ; set given date time to be 2 hours after order start date/time
 . NEW ORSTART
 . SET ORSTART=$PIECE(^TMP("PSJ",$J,MED,1),"^",4) ;order st date/time
 . NEW GVNDTTM SET GVNDTTM=$$FMADD^XLFDT(ORSTART,0,1,$R(60),$R(60)) ; add 1-2 hours to start date/time
 . ;BREAK ; debug
 . IF GVNDTTM>END DO  QUIT  
 . . IF 'SILENT WRITE " ",GVNDTTM," is after end date/time.",!
 . . ELSE  WRITE !
 . NEW DATE SET DATE=$PIECE(GVNDTTM,".") ; get the date
 . ;
 . ; generate an array of active nurses for that date
 . ;next line - var for nurse array, DUZ of nurse, and errors
 . NEW RNRA,ZVHDUZ,ERRUSER SET (RNRA,ZVHDUZ)="",ERRUSER=0 ;
 . DO SELRN^ZVHBC(DATE,.RNRA,.ERRUSER,SILENT)
 . IF ERRUSER!($DATA(RNRA)'>9) DO  QUIT  ;
 . . IF 'SILENT WRITE " Can't file without nurses, skipping this date.",!
 . . SET (ERROR1TM,ZVHERR)=1
 . . SET ZVHERR("ONETM","USER",PATIENT,DATE)=""
 . SET ZVHDUZ=$RANDOM($PIECE(RNRA(0),"^",2))+1 ; select a random nurse
 . ;   from the active nurses array
 . SET ZVHDUZ=RNRA(ZVHDUZ)
 . IF 'SILENT WRITE ?6," USER #: ",ZVHDUZ,"  ",$P(^VA(200,ZVHDUZ,0),"^"),"  "
 . ;
 . NEW ZVHFDA,ERRORFDA SET ZVHFDA="",ERRORFDA=0 ; for Fileman Data
 . DO SETFDA^ZVHBC2(PATIENT,ROOMBED,GVNDTTM,ZVHDUZ,.ZVHFDA,MED,.ERRORFDA,SILENT)
 . IF ERRORFDA DO  QUIT  
 . . SET (ERROR1TM,ZVHERR)=1
 . . SET ZVHERR("ONETM","SETFDA",PATIENT,MED,ROOMBED,GVNDTTM,ZVHDUZ)=""
 . . IF 'SILENT WRITE "DATA ARRAY ERROR!",!
 . ;if IV infusion, set the unique FDA fields for IV infusion
 . IF $PIECE(^TMP("PSJ",$J,MED,0),"^",3)["V" DO  ; for IV meds
 . . NEW ERRORIV,ZVHERRMED SET (ERRORIV,ZVHERRMED)=0 ; var for errors
 . . DO IVONE^ZVHBC1(.ZVHFDA,PATIENT,MED,DATE,.ERRORIV,.ZVHERRMED,SILENT) 
 . . IF ERRORIV!ZVHERRMED DO  
 . . . SET (ERROR1TM,ZVHERR)=1
 . . . SET ZVHERR("ONETM","IVONE",MED,PATIENT,DATE,$G(ERRORIV),$G(ZVHERRMED))=""
 . . . IF 'SILENT WRITE "ONE TIME IV ERROR!",!
 . IF $PIECE(^TMP("PSJ",$J,MED,0),"^",3)["U" DO  ; for unit dose meds
 . . NEW ERRORUD SET ERRORUD=0
 . . DO UD^ZVHBC1(.ZVHFDA,MED,.ERRORUD) ; set fda for Unit Dose meds
 . . IF ERRORUD DO  
 . . . SET (ERROR1TM,ZVHERR)=1
 . . . SET ZVHERR("ONETM","UD",MED,PATIENT,DATE)=""
 . . . IF 'SILENT WRITE "ONE TIME UNIT DOSE ERROR!",!
 . IF $G(ERRORIV)!$G(ERRORFDA) QUIT  ; skip this med
 . IF $GET(ZVHFILE) DO 
 . . NEW ERRUPDATE,NUM SET ERRUPDATE=0,NUM=""
 . . DO UPDATE^ZVHBC2(ZVHFILE,.NUM,MED,.ERRUPDATE,SILENT)
 . . IF ERRUPDATE DO  QUIT  ; skip to next med if error
 . . . SET (ERROR1TM,ZVHERR)=1
 . . . SET ZVHERR("ONETM","UPDATE",PATIENT,MED,ROOMBED,GVNDTTM,ZVHDUZ,$G(ZVHFILE),$G(NUM))=""
 . . . IF 'SILENT WRITE "ERROR IN FILEMAN UPDATE!",! 
 . . ELSE  DO  ;expire the order - next line is copied from routine ^PSBMLEN:
 . . . IF ($P(^PSB(53.79,$G(NUM),.1),U,2)'="O")!($P(^PSB(53.79,NUM,0),U,9)'="G") QUIT ; make sure its given before we expire the order
 . . . ;get the order number
 . . . NEW ORDER SET ORDER=$PIECE(^TMP("PSJ",$J,MED,0),"^",9)
 . . . IF ORDER[";" SET ORDER=$PIECE(ORDER,";") ; drop the ; and version number
 . . . NEW ZVHERREXP SET ZVHERREXP=0
 . . . DO EXPIRE^ZVHBC2(ORDER,STOPDATE,MED,.ZVHERREXP,SILENT)
 . . . IF ZVHERREXP DO  
 . . . . SET (ZVHERR,ERROR1TM)=1
 . . . . SET ZVHERR("ONETM","EXPIRE",PATIENT,MED,GVNDTTM,ORDER,STOPDATE)=""
 . . . . IF 'SILENT WRITE "  ERROR! One time order was not expired.",!
 . . ;
 . IF SILENT DO
 . . WRITE ?3,$E($P(^TMP("PSJ",$J,MED,3),"^",2),1,20)," (",MED,")" ; Medication
 . . WRITE ?35,"USER #: ",ZVHDUZ
 . WRITE ?55,$$FMTE^XLFDT(GVNDTTM),!
 ;
 QUIT  ; label ONETM
 ;
 ;
EXPIRE(ORDER,STOPDATE,MED,ERROR,SILENT)	; expire an order
 ; internal use only - does not check if it's been given!
 ;pass by value:
 ;  ORDER (IEN of the order in the Order file 100), 
 ;  STOPDATE (date/time in fileman format to use for the stop date of the order)
 ;  MED the med # from ^TMP("PSJ",$J,MED
 ;pass by ref: ERROR
 ;
 ;REQUIRED:
 QUIT:'ORDER!'STOPDATE!'MED
 ;
 NEW ZVHFDAO
 SET ZVHFDAO(100,ORDER_",",5)=7 ; status
 SET ZVHFDAO(100,ORDER_",",22)=STOPDATE ; stop date
 ;update the order using file^die
 DO FILE^DIE("","ZVHFDAO","")
 IF $DATA(DIERR) DO  
 . SET (ERROR,ZVHERR)=1
 . MERGE ZVHERR("EXPIRE",$J,ORDER,STOPDATE)=^TMP("DIERR",$J)
 ELSE  WRITE:'SILENT "Order # ",ORDER," Expired on: ",STOPDATE,!
 ;
 ;next, expire it in 55
 ;status E=expired 55.06,28 ? x-ref to order! << need to find this.
 ;stop date/time 55.06,34 note "AU" and "AUS" x-ref
 ;   X-refs are in the form of: ^PS(55,DA(1),"AU",type,stop date/time,DA) ^PS(55,DA(1),"AUS",stop date/time,DA)
 ; get the PSJON, type, and patient
 ;NEW PSJON,TYPE,PATIENT 
 ;SET PSJON=$PIECE(^TMP("PSJ",$J,MED,0),"^",3)
 ;SET TYPE=$PIECE(^TMP("PSJ",$J,MED,1),"^",2)
 ;SET PATIENT=$PIECE(^TMP("PSJ",$J,1,0),"^")
 ;SET ^PS(55,PATIENT,"AU",TYPE,STOPDATE,$P(PSJON,"U"))=""
 ;SET ^PS(55,PATIENT,"AUS",STOPDATE,$P(PSJON,"U"))=""
 ;BCMA Expired flag 55.06,123
 ;? inactive date 55.07,.03
 ;
 QUIT  ; label EXPIRE
 ;
 ;
SETFDA(ZVHPT,ZVHROOM,ZVHGVNDTTM,ZVHDUZ,ZVHFDA,ZVHMED,ERROR,SILENT) ; For FDA data common to 
 ;   all BCMA meds
 ; pass by ref: ZVHFDA (Fileman Data Array) ERROR (debug)
 ; pass all other variables by value
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to NOT silent
 ; check variables
 IF +ZVHPT'>0 DO  QUIT
 . SET (ZVHERR,ERROR)=1,ZVHERR("SETFDA","No var ZVHPT")="" 
 . IF 'SILENT WRITE "No Patient?!?!",!
 IF +ZVHGVNDTTM'>0 DO  QUIT  
 . SET (ZVHERR,ERROR)=1,ZVHERR("SETFDA","No var ZVHGVNDTTM",ZVHPT)="" 
 . IF 'SILENT WRITE "No Given Date/Time",! QUIT
 IF +ZVHDUZ'>0 DO  QUIT  
 . SET (ZVHERR,ERROR)=1,ZVHERR("SETFDA","NURSE",ZVHPT)=""
 . IF 'SILENT WRITE "No nurse!",! QUIT
 ;
 SET ZVHFDA(53.79,"+1,",.01)=+ZVHPT ; patient IEN
 SET ZVHFDA(53.79,"+1,",.02)=ZVHROOM ; room-bed from file 2
 SET ZVHFDA(53.79,"+1,",.03)=DUZ(2) ; division ien of the user
 SET ZVHFDA(53.79,"+1,",.04)=+ZVHGVNDTTM ; date/time entered
 SET ZVHFDA(53.79,"+1,",.05)=+ZVHDUZ ; ien of nurse (entered)
 SET ZVHFDA(53.79,"+1,",.06)=+ZVHGVNDTTM ; date/time given
 SET ZVHFDA(53.79,"+1,",.07)=+ZVHDUZ ; ien of nurse (action)
 SET ZVHFDA(53.79,"+1,",.08)=$P(^TMP("PSJ",$J,ZVHMED,3),"^") ; pharm orderable item
 SET ZVHFDA(53.79,"+1,",.11)=$P(^TMP("PSJ",$J,ZVHMED,0),"^",3) ; med order in file 55 (ex 10U or 10V)
 ;
 QUIT  ; label SETFDA
 ;
 ;
UPDATE(ZVHFILE,NUM,ZVHMED,ERROR,SILENT) ; send the data array to fileman
 ; pass by ref: NUM (will return ien for new entry in 53.79), ERROR (debug)
 ; pass by value: ZVHFILE (save=1), ZVHMED - this is the med # from ^TMP("PSJ",$J,ZVHMED)
 ;   SILENT (true=1)
 ;
 ; REQUIRED: fileman data array to be set in ZVHFDA
 IF $GET(SILENT)="" SET SILENT=0 ; default to NOT silent
 IF $GET(ZVHFILE) DO
 . ;debug WRITE "  Saving... "
 . NEW ZZIEN SET ZZIEN=""
 . IF '$DATA(ZVHFDA(53.79,"+1,",.06)) DO  QUIT  
 . . SET (ERROR,ZVHERR)=1 
 . . IF 'SILENT WRITE "Action date/time is a required field.",!
 . IF '$DATA(ZVHFDA(53.79,"+1,",.09)) DO  QUIT  
 . . SET (ERROR,ZVHERR)=1 
 . . IF 'SILENT WRITE "Status is a required field.",!
 . NEW PATIENT SET PATIENT=ZVHFDA(53.79,"+1,",.01)
 . DO UPDATE^DIE("S","ZVHFDA","ZZIEN","ZVHERR(PATIENT,ZVHMED)") ; send array to file
 . ;
 . ; ZW ^TMP("DIMSG") ;debug
 . ; next line: kill DIMSG if its a successful one.  don't need to save it.
 . IF $GET(ZVHERR(PATIENT,ZVHMED,"DIMSG"))=1 KILL ZVHERR(PATIENT,ZVHMED,"DIMSG")
 . ;next lines, check for errors, if found store the DIERR global in ZVHERR("DIERR")
 . IF $GET(ZVHERR(PATIENT,ZVHMED,"DIERR"))!$GET(DIERR) DO
 . . IF 'SILENT WRITE "Error encountered! Data not filed or incomplete.",!
 . . ;MERGE ZVHERR("DIERR",$GET(ZVHFDA(53.79,"+1,",.01)),ZVHMED)=^TMP("DIERR",$J)
 . . SET (ERROR,ZVHERR)=1
 . . ;
 . . ZW ^TMP("DIERR",$J),DIERR,ZVHERR(PATIENT,ZVHMED) ;debug
 . . ;DO CKERROR^ZVHBC ;debug
 . ELSE  DO  ; set up the audit
 . . SET NUM=ZZIEN(1) ;debug WRITE "DONE!!",!
 . . NEW AADT,STATUS,ZVHDUZ
 . . SET ZVHDUZ=ZVHFDA(53.79,"+1,",.05)
 . . SET AADT=$PIECE(^PSB(53.79,NUM,0),"^",6) ; action date/time
 . . SET STATUS=$PIECE(^PSB(53.79,NUM,0),"^",9) ; status EX: I = Infusing
 . . DO AUDIT(NUM,53.79,.06,AADT,"S",AADT,ZVHDUZ) ; set the audit for action date/time
 . . DO AUDIT(NUM,53.79,.09,STATUS,"S",AADT,ZVHDUZ) ; set the audit for the status
 . . IF $PIECE(^PSB(53.79,NUM,.1),"^")["U" DO  
 . . . NEW DOSEGVN,UNIT 
 . . . SET DOSEGVN=$PIECE(^PSB(53.79,NUM,.5,1,0),"^",3) ; doses given
 . . . SET UNIT=$PIECE(^PSB(53.79,NUM,.5,1,0),"^",4) ; units EX: Tab, capsule, etc
 . . . DO AUDIT(NUM,53.795,.03,DOSEGVN,"S",AADT,ZVHDUZ)
 . . . DO AUDIT(NUM,53.795,.04,UNIT,"S",AADT,ZVHDUZ)
 . . IF $PIECE(^PSB(53.79,NUM,.1),"^")["V" DO
 . . . NEW IVSITE SET IVSITE=$PIECE(^PSB(53.79,NUM,.1),"^",6) ; injection site
 . . . DO AUDIT(NUM,53.79,.16,IVSITE,"S",AADT,ZVHDUZ)
 . . . ; 
 . . . ; ADDITIVES - WHAT DO WE NEED HERE?  
 . . . ;IF $DATA(^PSB(53.79,NUM,.6,0)) DO  
 . . . . ;NEW ADOSEGVN SET ADOSEGVN=$PIECE(^PSB(53.79,NUM,.6,1,0),"^",3) 
 . . . . ;DO AUDIT(NUM,53.796,.03,ADOSEGVN,"S",AADT)
 . . . ; 
 . . . ; SOLUTION - doses given  (IV bag volume)
 . . . IF $DATA(^PSB(53.79,NUM,.7,0)) DO  
 . . . . NEW SDOSEGVN SET SDOSEGVN=$PIECE(^PSB(53.79,NUM,.7,1,0),"^",3)
 . . . . DO AUDIT(NUM,53.797,.03,SDOSEGVN,"S",AADT,ZVHDUZ)
 . . . ;
 . . NEW ZVHERRPATCH SET ZVHERRPATCH=0
 . . IF $GET(ZVHFDA(53.795,"+2,+1,",.04))["PATCH" DO   
 . . . ; set the variables for the patch
 . . . NEW PATIENT SET PATIENT=ZVHFDA(53.79,"+1,",.01)
 . . . NEW GVNDTTM SET GVNDTTM=ZVHFDA(53.79,"+1,",.06)
 . . . DO PATCH(PATIENT,GVNDTTM,NUM,ZVHMED,.ZVHERRPATCH,ZVHDUZ,ZVHFILE,SILENT)
 . . IF ZVHERRPATCH DO  QUIT  
 . . . SET (ZVHERR,ZVHERRSCH)=1
 . . . SET ZVHERR("PATCH",ZVHPT,ZVHDATE,ZVHMED,ZVHSCHTM)=""
 . . ;
 . . D  ; VPR freshness hook
 . . . NEW PSBIEN SET PSBIEN=NUM ; next 2 lines copied from ^PSBML
 . . . N X,DIC
 . . . S X="PSB EVSEND VPR",DIC=101 D EN^XQOR ;should handle all BCMA Med Log events for VPR
 ;debug ELSE  WRITE "View only, not saved.",!
 ;
 DO CLEAN^DILF ; kills the ^TMP globals from ^DIE
 KILL ZVHFDA ; make sure we clear this too
 ;
 ;
 QUIT  ; label UPDATE
 ;
 ;
AUDIT(PSBREC,PSBDD,PSBFLD,PSBDATA,PSBSK,AADT,ZVHDUZ) ; Med Log Audit - AJC this was copied from ^PSBUTL
 ; used by cross references to 53.79 to track changes to fields in Med Log file
 ; xref AU05, AU06, AU09, AU16, AU21, AU22 pass the value 53.79 as PSBDD
 ; xref AU303, AU304 pass the value 53.795 as PSBDD
 ; xref AU603, AU604 pass the value 53.796 as PSBDD
 ; xref AU703, AU704 pass the value 53.797 as PSBDD
 ; 
 ; AJC added AADT (action date/time) using this to set historical data to look more realistic
 ; AJC added ZVHDUZ (IEN of user) to get the correct user and not the user who started the scheduled task
 ;
 ;REQUIRED - pass by value:
 QUIT:$G(AADT)=""!($G(ZVHDUZ)="")
 ;
 N PSBDT,PSBTMP
 I '$D(PSBOLSTS) S PSBOLSTS=$P(^PSB(53.79,PSBREC,0),U,9)
 I '$D(PSBOLDUZ) S PSBOLDUZ=$P(^PSB(53.79,PSBREC,0),U,5)
 ; AJC next line PSBDATA is the value being set (EX: "G" for Given for action status)
 Q:$G(PSBDATA)="" ; AJC removed: !('$G(PSBAUDIT)) ; not needed for our use
 ;D NOW^%DTC S PSBDT=% ; AJC need to pass in the given date time to make this look right
 SET PSBDT=AADT ; AJC replaced the line above
 S PSBDATA=$$EXTERNAL^DILFD(PSBDD,PSBFLD,"",PSBDATA)  ; PSBDD=53.79, 53.795, 53.796, or 53.797 see comment AUDIT
 D FIELD^DID(PSBDD,PSBFLD,"","LABEL","PSBTMP")  ; PSBDD=53.79, 53.795, 53.796, or 53.797 see comment AUDIT
 S:'$D(^PSB(53.79,PSBREC,.9,0)) ^(0)="^53.799^^"
 S Y=$O(^PSB(53.79,PSBREC,.9,""),-1)+1,X=""
 ; AJC next line PSBTMP("LABEL") is set 3 lines up
 I PSBTMP("LABEL")["ACTION STATUS" D  Q
 .I PSBSK["K" S XY=Y F  S XY=$O(^PSB(53.79,PSBREC,.9,XY),-1) Q:($D(PSBGOON))!(+XY'>0)  D
 ..I ^PSB(53.79,PSBREC,.9,XY,0)["ACTION STATUS Set to '" D  Q
 ...S PSBGOON=1,PSBOLDUZ=$P(^PSB(53.79,PSBREC,.9,XY,0),U,2),X=$P(^PSB(53.79,PSBREC,.9,XY,0),"'",2)
 .S:$L(X)'>2 X=PSBOLSTS,X=$S(X="G":"GIVEN",X="H":"HELD",X="R":"REFUSED",X="I":"INFUSING",X="C":"COMPLETED",X="S":"STOPPED",X="N":"NOT GIVEN",X="RM":"REMOVED",X="M":"MISSING DOSE",X="":PSBOLSTS)
 .I PSBSK["K" S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_ZVHDUZ_U_"Field: "_PSBTMP("LABEL")_" '"_PSBDATA_"' by '"_$$GET1^DIQ(200,PSBOLDUZ,"INITIAL")_"' deleted."
 .;PSB*3*45 Store Action status and last given fields.
 .E  S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_ZVHDUZ_U_"Field: "_PSBTMP("LABEL")_" Set to '"_PSBDATA_"' by '"_$$GET1^DIQ(200,ZVHDUZ,"INITIAL")_"'."_U_PSBDATA_U_$P(^PSB(53.79,PSBREC,0),"^",7)
 ; AJC next line - if data is deleted, set PSBSK="K" otherwise, set PSBSK="S"
 I PSBSK["K" S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_ZVHDUZ_U_"Field: "_PSBTMP("LABEL")_" '"_PSBDATA_"' deleted."
 E  S ^PSB(53.79,PSBREC,.9,Y,0)=PSBDT_U_ZVHDUZ_U_"Field: "_PSBTMP("LABEL")_$S(PSBTMP("LABEL")["DISPENSE DRUG":" Added '",1:" Set to '")_PSBDATA_"'."
 ;BREAK ;debug
 K XY,PSBGOON
 Q
 ;
 ;
PATCH(PATIENT,AADT,IEN,MED,ERROR,ZVHDUZ,ZVHFILE,SILENT)	; administer and remove patches
 ; pass by ref: ERROR, 
 ; pass by value: PATIENT (IEN), AADT (Action date/time in fileman format),
 ;  IEN (the IEN of the new entry in the BCMA MEd file) MED (medication # in ^TMP("PSJ",$J))
 ;  ZVHDUZ (ien of user) ZVHFILE (save - set to 1)
 ; requires ^TMP("PSJ",$J) to be set
 NEW SECONDS,DATE,RMDTTM
 SET RMDTTM=$$FMTH^XLFDT(AADT) ; convert action date/time to horolog
 SET DATE=$PIECE(RMDTTM,","),SECONDS=$PIECE(RMDTTM,",",2) ; date is first piece, secs since midnight is 2nd
 SET SECONDS=SECONDS-91 ; subtract 1.5 minutes
 IF SECONDS<1 SET SECONDS=1 ; keep as a positive number
 SET RMDTTM=+DATE_","_+SECONDS ; put back together
 SET RMDTTM=$$HTFM^XLFDT(RMDTTM) ; convert to fileman
 NEW DATE SET DATE=AADT ; var for date/time of previous patches
 FOR  SET DATE=$ORDER(^PSB(53.79,"APATCH",PATIENT,DATE),-1) QUIT:'DATE  DO
 . ;W DATE,! ;debug
 . NEW PATCH SET PATCH="" ; var for IEN of previous Patch administration
 . FOR  SET PATCH=$ORDER(^PSB(53.79,"APATCH",PATIENT,DATE,PATCH)) QUIT:ERROR!'PATCH  DO
 . . ;W PATCH,! ; debug
 . . ;check if its the same med
 . . NEW DRUG1 SET DRUG1=$PIECE(^PSB(53.79,PATCH,0),"^",8) ; med IEN of first drug
 . . NEW DRUG2 SET DRUG2=$PIECE(^TMP("PSJ",$J,MED,3),"^") ; med IEN of 2nd drug
 . . IF DRUG1=DRUG2 DO  ; its a patch and its for the same med, so lets remove it!
 . . . ;WRITE "MATCH!",! ; debug
 . . . NEW STATUS SET STATUS=$PIECE(^PSB(53.79,PATCH,0),"^",9) ; status of old patch
 . . . IF STATUS'="G" QUIT  ; its not on anymore
 . . . ELSE  DO
 . . . . WRITE:'SILENT " Old patch still on... " ; debug
 . . . . NEW OLDAADT ; var for status and action date time for patch that is being removed
 . . . . SET OLDAADT=$PIECE(^PSB(53.79,PATCH,0),"^",6) ; old action date/time
 . . . . NEW ZVHFDAP ; fileman data array for the patch we will remove
 . . . . SET ZVHFDAP(53.79,PATCH_",",.09)="RM" ; set to status=removed
 . . . . SET ZVHFDAP(53.79,PATCH_",",.06)=RMDTTM ; set action date/time to the removal date/time
 . . . . IF $GET(ZVHFILE) DO FILE^DIE("","ZVHFDAP","ZVHERR") ; save the data
 . . . . IF $D(DIERR) DO  QUIT  
 . . . . . SET (ERROR,ZVHERR)=1 
 . . . . . SET ZVHERR("PATCH","NOT REMOVED",PATIENT,AADT,IEN,MED,ZVHDUZ)=""
 . . . . . MERGE ZVHERR("PATCH","NOT REMOVED","DIERR",PATIENT,AADT,IEN,MED,ZVHDUZ)=^TMP("DIERR")
 . . . . . WRITE:'SILENT "ERROR!! Old patch was not removed!",! QUIT
 . . . . ; 2. set all the audits for the old patch
 . . . . ELSE  DO  
 . . . . . ;WRITE OLDAADT," " ;debug
 . . . . . ;BREAK ; debug
 . . . . . DO:ZVHFILE AUDIT(PATCH,53.79,.06,OLDAADT,"K",RMDTTM,ZVHDUZ) ; delete old action date/time
 . . . . . DO:ZVHFILE AUDIT(PATCH,53.79,.06,RMDTTM,"S",RMDTTM,ZVHDUZ) ; remove date time updated
 . . . . . DO:ZVHFILE AUDIT(PATCH,53.79,.09,STATUS,"K",RMDTTM,ZVHDUZ) ; delete old status
 . . . . . DO:ZVHFILE AUDIT(PATCH,53.79,.09,"RM","S",RMDTTM,ZVHDUZ) ; status=removed
 . . . . . WRITE " Old patch removed. ",!
 . . . . . ;IF $DATA(^PSB(53.79,"APATCH",PATIENT,OLDAADT,PATCH)) ZW ^PSB(53.79,"APATCH",PATIENT,OLDAADT,PATCH) ; debug
 . . . . . ;IF $DATA(^PSB(53.79,"APATCH",PATIENT,AADT,PATCH)) ZW ^PSB(53.79,"APATCH",PATIENT,AADT,PATCH) ; debug
 ;
 ;IF $DATA(^PSB(53.79,"APATCH",PATIENT,AADT,IEN)) ZW ^PSB(53.79,"APATCH",PATIENT,AADT,IEN) ; debug
 ;
 ;
 QUIT  ; Label PATCH
 ;
 ;
