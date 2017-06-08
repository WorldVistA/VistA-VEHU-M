ZVHBCMN	 ; OIA/AJC - Menu of options for BCMA data ; 10/17/2014
 ;;0.1;NO PKG;**NO PATCHES**;JULY 22, 2014
 ;
 ; Menu for ZVHBC routines - Medication management for TEST accounts
 ;---------------------------------------------------------------------
 ;
 DO EN QUIT ; just go to entry point if entered directly
 ;
EN	; ENTRY POINT
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ELSE  WRITE !!,"OK!  This is a TEST account, proceeding...",!!
 IF '$DATA(U)!('$DATA(DUZ))!('$DATA(DUZ(2)))!('$DATA(IOF))!('$DATA(IOM)) WRITE "Need to log in or D ^XUP first!" QUIT  ;
 ;
 DO MAIN
 ;
 QUIT  ; routine ZVHBCMN
 ;
 ;
MAIN	; menu - Main:
 ;
 WRITE @IOF,!!,$$CJ^XLFSTR("BCMA Data for TEST Accounts",IOM),!!
 NEW DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S DIR(0)="SX^T:T. Give meds for Today;t:T. Give meds for Today;R:R. Give meds for a date Range;r:R. Give meds for a date Range;P:P. View the PSJ global for BCMA;p:P. View the PSJ global for BCMA;B:B. View bar codes for a patient;b:B. View bar codes for a patient;D:D. Delete meds for a patient;d:D. Delete meds for a patient;Q:Q. Quit;q:Q. Quit"
 S DIR("L",1)="Please Select one:"
 S DIR("L",2)=""
 S DIR("L",3)="   T. Give meds for Today"
 S DIR("L",4)="   R. Give meds for a date Range"
 S DIR("L",5)="   P. View the PSJ global for BCMA"
 S DIR("L",6)="   B. View bar codes for a patient (useful in BCMA)"
 S DIR("L",8)="   D. Delete meds for a patient"
 S DIR("L",9)=""
 S DIR("L",10)="   Q. Quit"
 S DIR("L")=""
 D ^DIR
 ;
 IF "Tt"[Y HANG 1 DO TODAY
 IF "Rr"[Y HANG 1 DO RANGE
 IF "Pp"[Y HANG 1 DO TEST^ZVHBC,CLEAN^ZVHBC,GOMAIN ; better to do a patient selection, date selection, then run it... someday...
 IF "Dd"[Y HANG 1 DO DELETE
 IF "Bb"[Y HANG 1 DO SHOWBC
 IF $DATA(DIRUT)!("Qq"[Y) WRITE !!!,"Goodbye.",!!!  QUIT
 ;
 QUIT  ; Label MAIN
 ;
 ;
TODAY	; Menu - today's meds:
 WRITE @IOF,!!,$$CJ^XLFSTR("Give meds for Today",IOM),!!
 ;define the option
 WRITE "This option will give the meds for today up to the date/time of NOW.",!
 WRITE "It will not give medications that have already been given.",!
 WRITE "For PRN medications it will given them after the ordered time period",!
 WRITE "has passed.",!!
 WRITE "The patients currently selected for this option are:",!!
 NEW PATIENTS,ERROR SET ERROR=0 DO SELDFN^ZVHBC3(.ERROR)
 IF ERROR SET ZVHERR=1,ZVHERR("MENU","SELDFN")="" WRITE ?2,"Error getting the Patient List!"
 ELSE  DO
 . NEW I SET I=""
 . FOR  SET I=$ORDER(PATIENTS(I)) DO  QUIT:I=""
 . . IF $GET(I)>0 WRITE ?2,"(DFN:",I,")",?30,$PIECE(^DPT(I,0),"^"),!
 WRITE !,"Adding and/or Removing patients from this list is done by editing ^ZVHBC3.",!!
 WRITE "Type ?? for more information.",!!
 ;
 NEW DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT ; DI Read variables
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Ready to give all of Today's meds for the patients listed above?"
 SET DIR("?")="Enter N or No to quit.  Enter Y or Yes to give the medications."
 SET DIR("?",1)=" * This option only works for Inpatients."
 SET DIR("?",2)=" * This will only give ACTIVE inpatient medications."
 SET DIR("?",3)=" * Every 5 minute meds PRN are NOT given."
 SET DIR("?",4)=" * This option DOES trigger the HMP freshness update."
 SET DIR("?",5)=" * This option does NOT add a cosigner for the High Risk Medications."
 SET DIR("?",6)=" * This option does NOT add the PRN effectiveness."
 SET DIR("?",7)=" * If no meds are given, have they have been given already?"
 SET DIR("?",8)=" * IV Meds are not included yet..."
 SET DIR("?",10)=""
 DO ^DIR
 QUIT:$DATA(DIRUT)
 IF Y=1 DO EN^ZVHBC3(1,1) HANG 5 ; save=true, silent=true
 ELSE  WRITE !!,"No meds given",!! HANG 1
 ;
 DO GOMAIN ; return the user to the main menu
 ;
 ;future - these would be cool:
 ;	Give meds for a specific patient
 ;	Give meds for a range of BCMA patients
 ;	Give meds for a range of VeHU patients
 ;	Give meds for all inpatients (use the ^DPT cross ref)
 ;
 QUIT  ; lable TODAY
 ;
 ;
GOMAIN(NAME,LABEL)	; repeat,return to main, or quit
 ;
 IF $DATA(NAME)&$DATA(LABEL) DO
 . NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT ; DI Read variables
 . SET DIR(0)="Y^A" ; DI read yes/no prompt
 . SET DIR("A")=NAME
 . SET DIR("B")="NO"
 . SET DIR("?")="Enter No to quit"
 . DO ^DIR
 . IF Y=1 DO @LABEL
 ;
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT ; DI Read variables
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Return to main menu"
 SET DIR("B")="YES"
 SET DIR("?")="Enter No to quit"
 DO ^DIR
 QUIT:$DATA(DIRUT)
 IF Y=1 DO MAIN QUIT
 ELSE  WRITE !!,"Goodbye",!! QUIT
 ;
 QUIT  ; label GOMAIN
 ;
 ;
RANGE	;Menu - meds for a date range:
 WRITE @IOF,!!,$$CJ^XLFSTR("Give meds for specific date range",IOM),!!
 ;	(define the option)
 WRITE "This option will allow you to give medications for a date range.",!
 WRITE "In order for the routine to find orders in the past, they must have:",!
 WRITE "  1. An active status in the order file (100)",!
 WRITE "  2. A start date that is older than or equal to the start date of your",!
 WRITE "     selected date range.",!
 WRITE "  3. Be completed in inpatient pharmacy.",!!
 WRITE "Additionally, you can give meds to a single patient, multiple patients, or to a",!
 WRITE "range of VeHU patients.",!!
 WRITE "Type ?? for more information.",!!
 ;
 NEW DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT ; DI Read variables
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Ready to enter Medications for a date range"
 SET DIR("?")="Enter N or No to quit.  Enter Y or Yes to give the medications."
 SET DIR("?",1)=" * This option only works for Inpatients."
 SET DIR("?",2)=" * This will only give ACTIVE inpatient medications."
 SET DIR("?",3)=" * Every 5 minute meds PRN are NOT given."
 SET DIR("?",4)=" * This option DOES trigger the HMP freshness update."
 SET DIR("?",5)=" * This option does NOT add a cosigner for the High Risk Medications."
 SET DIR("?",6)=" * This option does NOT add the PRN effectiveness."
 SET DIR("?",7)=" * If no meds are given, have they have been given already?"
 SET DIR("?",8)=" * IV Meds are not included yet..."
 SET DIR("?",10)=""
 DO ^DIR
 QUIT:$DATA(DIRUT)
 IF Y=0 WRITE !!,"No meds given",!! HANG 1
 IF Y=1 DO EN^ZVHBC HANG 5 ; save=true, silent=true
 ;
 ;future ideas:
 ;	Give meds for a range of BCMA patients
 ;	Give meds for all inpatients (use the ^DPT cross ref)
 ;
 ; Menu - Delete meds for a patient:
 ;	(define the option)
 ;
 DO GOMAIN ; return the user to the main menu
 ;
 QUIT  ; label RANGE
 ;
 ;
DELETE	; Call the delete option
 ;
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ;
 ;single patient selection
 NEW PATIENT,DFN SET (PATIENT,DFN)=""
 DO SINGLE^ZVHPAT(.PATIENT)
 IF $GET(PATIENT)=""!($GET(PATIENT)=-1) WRITE "No patient... quitting!",!!! QUIT
 ELSE  SET DFN=+PATIENT
 ;
 DO GETDATE^ZVHBC ; get date range
 IF $DATA(^TMP("ZVHDTARY",$J))'>9 WRITE !,?5,"No dates selected",!! DO CLEAN^ZVHBC QUIT  ; exit routine
 ;
 ;use the start and end dates to loop thru ^psb(53.79) and delete
 NEW START,END,DATE SET (START,END,DATE)=""
 SET START=$ORDER(^TMP("ZVHDTARY",$J,START))
 SET END=$ORDER(^TMP("ZVHDTARY",$J,END),-1)
 SET END=END_".24"
 ;
 NEW PSBARRAY ; list of IEN's to kill
 ;
 ;use the start and end dates to loop thru ^psb(53.79)
 SET DATE=START
 FOR  SET DATE=$ORDER(^PSB(53.79,"AADT",DFN,DATE)) QUIT:DATE>END!'DATE  DO
 . ;W DATE," " ;debug
 . NEW PSBIEN SET PSBIEN="" ; IEN from the ^PSB(53.79,IEN,0)
 . FOR  SET PSBIEN=$ORDER(^PSB(53.79,"AADT",DFN,DATE,PSBIEN)) QUIT:'PSBIEN  DO
 . . SET PSBARRAY(PSBIEN)=^PSB(53.79,PSBIEN,0)
 . . ;WRITE ?15,PSBIEN,!,?2,PSBARRAY(PSBIEN),! ;debug
 ZW PSBARRAY ;debug
 NEW DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT ; DI Read variables
 SET DIR(0)="Y^A" ; DI read yes/no prompt
 SET DIR("A")="Delete all these administrations?"
 SET DIR("B")="NO"
 SET DIR("?")="Enter No to quit, Yes to Delete them"
 DO ^DIR
 QUIT:$DATA(DIRUT)
 IF Y=1 DO DELPSB,GOMAIN
 ELSE  WRITE !!,"Goodbye",!!!
 ;
 ;B ;debug
 ;
 DO GOMAIN ; return the user to the main menu
 ;
 QUIT  ; label DELETE
 ;
 ;
DELPSB	;	delete the entries
 ;
 ;
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ;
 NEW PSBIEN SET PSBIEN="" ;LOOP THRU THE PSBARRAY
 FOR  SET PSBIEN=$ORDER(PSBARRAY(PSBIEN)) QUIT:'PSBIEN  DO 
 . DO KILLPSB(PSBIEN)
 . WRITE PSBIEN,!
 . ;
 . ;Check for any pointers in the 53.78 file
 . NEW IEN SET IEN=0 ; this is for the IEN of the 53.78 file
 . FOR  SET IEN=$ORDER(^PSB(53.78,IEN)) QUIT:'IEN  DO
 . . ;W IEN," ",$P(^PSB(53.78,IEN,0),U,8)," ",PSBIEN,! ;debug
 . . NEW IENPSB SET IENPSB=$PIECE(^PSB(53.78,IEN,0),"^",8) ; this is the PSBIEN pointer
 . . ; check the psbien to see if we should remove it
 . . IF PSBIEN=IENPSB DO
 . . . W ?2,IEN,"  MATCH: ",PSBIEN," = ",IENPSB,! ;debug
 . . . NEW DIK,DA
 . . . SET DIK="^PSB(53.78,",DA=IEN
 . . . D ^DIK
 . . . WRITE ?2,"Pointer removed from file 53.78.",!
 ;
 ;
 ;
 QUIT  ; label DELPSB
 ;
 ;
KILLPSB(PSBIEN)	; delete a BCMA entry by PSBIEN
 ; REQUIRED: pass by value PSBIEN as an integer
 ;
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ;
 QUIT:$GET(PSBIEN)=""!(+PSBIEN'=PSBIEN)
 NEW DONE,DIK,DA SET DONE=0
 SET DIK="^PSB(53.79,",DA=PSBIEN
 ;KILL THE AADT X-REF
 NEW PATIENT,ACTION
 SET PATIENT=$PIECE(^PSB(53.79,DA,0),"^") ; patient IEN
 SET ACTION=$PIECE(^PSB(53.79,DA,0),"^",6) ; action date/time
 KILL ^PSB(53.79,"AADT",PATIENT,ACTION,DA) ; removes the x-ref
 ;
 DO ^DIK
 ;
 QUIT DONE ; label KILLPSB
 ;
 ;
SHOWBC	; show the active barcodes for a patient, date [8/26/14 10/17/14 ajc]
 ;
 ; choose a patient
 NEW PATIENT,DATE
 DO SINGLE^ZVHPAT(.PATIENT)
 QUIT:PATIENT=-1
 ;
 ; choose a date
 DO SINGLE^ZVHDATE(.DATE)
 QUIT:DATE=-1
 ;
 ; get a list of active meds
 NEW ERROR SET ERROR=0 
 DO ACTMED^ZVHBC(PATIENT,DATE,.ERROR,1)
 IF ERROR!(^TMP("PSJ",$J,1,0)=-1) DO
 . WRITE !!,?2,"No active medications for ",$P(^DPT(PATIENT,0),U)," on "
 . NEW Y SET Y=DATE DO DD^%DT WRITE Y,!!!
 ELSE  DO  
 . WRITE @IOF,!!,$$CJ^XLFSTR("Active Bar Codes for "_$P(^DPT(PATIENT,0),U),IOM)
 . ; check for unit dose meds $D in 700 subs
 . NEW MED,UD SET MED="" SET UD=0
 . FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO
 . . ;W !,MED,?2,^TMP("PSJ",$J,MED,3) ;debug
 . . IF $DATA(^TMP("PSJ",$J,MED,700)) SET UD=1 ;debug W ?70," UD"
 . . ;E  W ?70,"Not UD" ;debug
 . ;
 . ; check for IV meds ($d in 850 or 950)
 . NEW MED,IV SET MED="" SET IV=0
 . FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO
 . . ;W !,MED,?2,^TMP("PSJ",$J,MED,3) ; debug
 . . IF ($DATA(^TMP("PSJ",$J,MED,850))!($DATA(^TMP("PSJ",$J,MED,950)))) SET IV=1 ; W ?70," IV" ;debug
 . . ;E  W ?70,"Not IV" ;debug
 . ;
 . IF UD DO ; show the BCs for the Unit Dose meds
 . . DO SHOWUD
 . . WRITE !
 . . NEW X FOR X=1:1:80 WRITE "-"
 . . WRITE !
 . ELSE  WRITE !,?2,"(No active Unit Dose Medications)",!
 . ;
 . IF IV DO ; show the iv meds
 . . DO SHOWIV
 . . WRITE !
 . . NEW X FOR X=1:1:80 WRITE "-"
 . . WRITE !
 . ELSE  WRITE !,?2,"(No active IV Medications)",!
 ;
 DO GOMAIN
 ;DO GOMAIN("Want to display another patient?","SHOWBC") ; start again or go back to main menu
 QUIT  ; label SHOWBC
 ;
 ;
SHOWUD	; show the unit dose meds
 ;
 WRITE !!,?2,"Unit Dose Medications (active only)",!
 NEW MED SET MED=""
 FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO
 . ;W !,MED,?2,$P(^TMP("PSJ",$J,MED,3),U,2)
 . NEW UDIEN SET UDIEN=0 ; for the 700 subs
 . FOR  SET UDIEN=$O(^TMP("PSJ",$J,MED,700,UDIEN)) QUIT:'UDIEN  DO
 . . WRITE $$RJ^XLFSTR(($P(^TMP("PSJ",$J,MED,700,UDIEN,0),U)),19) ; bar code
 . . WRITE ?20,$E($P(^TMP("PSJ",$J,MED,700,UDIEN,0),U,2),1,60),! ; med name
 ;
 QUIT  ; label SHOWUD
 ;
 ;
SHOWIV	; show the IV meds
 ;
 WRITE !!,?2,"IV Medications (active only)",!
 NEW MED SET MED=""
 FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO
 . QUIT:'$DATA(^TMP("PSJ",$J,MED,950))
 . WRITE !,?2,$PIECE(^TMP("PSJ",$J,MED,3),U,2),":",!
 . WRITE ?4,"Available Bags:",!
 . NEW BCARRAY SET BCARRAY(0)="Available Bar Codes" ; array of barcodes for this med.
 . ;loop through the 800 subs, check each one to see if it has been used
 . IF $DATA(^TMP("PSJ",$J,MED,800)) DO
 . . NEW BARC SET BARC="" ; BARC is the barcode from the 800 sub var
 . . FOR  SET BARC=$ORDER(^TMP("PSJ",$J,MED,800,BARC),-1) Q:'BARC  DO
 . . . DO BARCHK(PATIENT,MED)
 . . ;
 . ;loop through the 900 subs, check each one to see if it has been used
 . IF $DATA(^TMP("PSJ",$J,MED,900)) DO
 . . NEW BARC SET BARC="" ; BARC is the barcode from the 900 sub var
 . . FOR  SET BARC=$ORDER(^TMP("PSJ",$J,MED,900,BARC),-1) Q:'BARC  DO
 . . . DO BARCHK(PATIENT,MED)
 . . ;
 . ; display the unused barcodes
 . NEW BARCODE,COLUMN SET (BARCODE,COLUMN)=0 ; loop thru the barcode array and print them
 . FOR  SET BARCODE=$ORDER(BCARRAY(BARCODE)) QUIT:'BARCODE  DO  
 . . IF COLUMN>3 SET COLUMN=0 ; 4 column display
 . . SET COLUMN=COLUMN+1 ; increment the column each loop
 . . WRITE $$RJ^XLFSTR(BARCODE,20)
 . . WRITE:COLUMN=4 !  ; enter after 4th column
 . ;
 . ; display the bar codes for a ward stock bag
 . WRITE !,?4,"Ward stock bar codes:",!
 . NEW ADDIEN SET ADDIEN=0 ; for the 850 subs (additives)
 . FOR  SET ADDIEN=$O(^TMP("PSJ",$J,MED,850,ADDIEN)) QUIT:'ADDIEN  DO
 . . WRITE $$RJ^XLFSTR(($P(^PS(52.6,ADDIEN,0),U,2)),19)
 . . WRITE ?20,$E($P(^TMP("PSJ",$J,MED,850,ADDIEN,0),U,2),1,60),!
 . ;
 . NEW SOLIEN SET SOLIEN=0 ; for the 950 subs (solutions)
 . FOR  SET SOLIEN=$O(^TMP("PSJ",$J,MED,950,SOLIEN)) QUIT:'SOLIEN  DO
 . . WRITE $$RJ^XLFSTR($P(^PS(52.7,SOLIEN,0),U,2),19) ; pointer to drug file
 . . WRITE ?20,$E($P(^TMP("PSJ",$J,MED,950,SOLIEN,0),U,2),1,60),!
 ;
 QUIT  ; label SHOWIV
 ;
 ;
BARCHK(PATIENT,MED)	; check the bar code, so if it is used
 ; requires ^tmp("psj", med ien, patient IEN and new BCARRAY before calling
 NEW PSJON,BARCODE,USED ; psj order number, barcode for return, used=1 if true
 SET PSJON=$PIECE(^TMP("PSJ",$J,MED,0),"^",3) ; pharm order number
 DO BARCD^ZVHBC1(PATIENT,PSJON,.BARCODE,BARC,.USED) ; see if used yet
 IF USED="" SET BCARRAY(BARC)="" QUIT  
 IF USED["1" QUIT  ; if used, try next one ;
 QUIT  ; label BARCHK
 ;
 ;
