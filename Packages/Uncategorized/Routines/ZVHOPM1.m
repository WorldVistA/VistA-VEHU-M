ZVHOPM1 ; OIA/AJC - modify Outpatient Meds #2 ;1/13/15
 ;;0.1;NO PKG;**NO PATCHES**;Jan 12, 2015; no build
 ;
 ; This will release all the medications for a selected patient
 ;
 ; class 3 APIs: CKRELRX^ZVHOPM; GETPAT3^ZVHPAT
 ; class 1 APIs: PROD^XUPROD; GET1^DIQ; ^DIC
 ;
 ; Future upgrades:
 ;  Add a menu of options
 ;---------------------------------------------------------------------------
 ;
 DO EN
 QUIT  ; enter at a label
 ;
 ;
EN      ; Entry point
 ; Check for Production environment, quit if true
 NEW CHECK SET CHECK=$$PROD^XUPROD(1)
 IF CHECK WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!",!! QUIT
 ELSE  WRITE !!,"OK!  This is a TEST account, proceeding...",!!
 IF '$DATA(U)!('$DATA(DUZ))!('$DATA(DUZ(2)))!('$DATA(IOF)) WRITE "Need to log in or D ^XUP first!" QUIT  ;
 ;
 ;select a patient
 NEW DFN SET DFN=$$GETPT^ZVHOPM QUIT:+DFN'>0
 ;
 ;build an array of all rx ien numbers
 NEW MEDS SET MEDS="Outpatient Meds Arrray for "_$$GET1^DIQ(2,100847,.01)_"^"_DFN
 DO SETMEDRA(DFN)
 ;
 ;b ;debug
 ;loop thru array
 IF $DATA(MEDS)>9 DO
 . NEW IEN52 SET IEN52="" ; this is the Rx ien in file 52
 . FOR  SET IEN52=$ORDER(MEDS(IEN52)) QUIT:'IEN52  DO
 . . WRITE "PRESCIPTION #: ",$$GET1^DIQ(52,IEN52,.01)," IEN #: ",IEN52,!
 . . WRITE ?2,"(RE)FILL DATES:",?22,"RELEASE DATES:",!
 . . WRITE ?2,$$GET1^DIQ(52,IEN52,22) ; Fill date/time
 . . ; check the release date of fill - release if not done
 . . NEW RELEASED,RELDATE ; is it released? release date/time
 . . SET RELEASED=$$CKRELRX^ZVHOPM(IEN52,.RELDATE)
 . . IF RELEASED WRITE ?22,RELDATE
 . . ELSE  WRITE ?22,"THIS WILL BE THE DO RELEASE SPOT"
 . . ;
 . . ; get # of refills and bulid an array of refill dates
 . . NEW REFILLS,REFILLRA SET REFILLRA=$$GETREF(IEN52),REFILLS=+REFILLRA
 . . IF $GET(REFILLS)>0 DO
 . . . W "   ",REFILLS," REFILL(S)",! ; # of refills
 . . . NEW I
 . . . FOR I=0:1:REFILLS SET REFILLRA(I)=$P(REFILLRA,U,(I+1)) ; set the refill array
 . . . ;B ;debug
 . . . ; for each refill check release date and release if not done
 . . . NEW REFILL SET REFILL=0
 . . . FOR  SET REFILL=$ORDER(REFILLRA(REFILL)) QUIT:'REFILL  DO
 . . . . NEW REFDATE,RELDATE SET REFDATE=$P(REFILLRA(REFILL),";",2) ; Refill date
 . . . . W ?2,REFILL,". ",REFDATE ; refill dates
 . . . . SET RELDATE=$$GET1^DIQ(52.1,REFILL_","_IEN52,17)
 . . . . IF $GET(RELDATE)]"" W ?22,RELDATE ; release date
 . . . . ELSE  WRITE ?22,"THIS WILL BE THE DO RELEASE REFILL SPOT"
 . . . . W !
 . . . . ;b ;debug
 . . . W !
 . . ELSE  W "  NO REFILLS",!!
 ;
 QUIT  ; label EN
 ;
 ;
GETREF(IEN52)   ; get the refills for a specific Rx
 ;REQUIRED: pass by value IEN52 the ien of the Rx in file 52
 ;Ext Out: ^ delimited string: # of refills ^ refill date ^ refill date ^ refill date
 ;   EX: 5^1;3110127^2;3110428.1^3;3110730.123456^4;3110815.1432^5;3110930.235959
 ; DIQ DISPENSE DATE 52.1,10.1  0;19
 ;     RELEASED DATE 52.1,17    0;18
 QUIT:'$DATA(IEN52) -1
 NEW OUT SET OUT=0 ; ext output
 ;
 ;get the number of refills
 NEW NUM,ORDER SET NUM=$PIECE($GET(^PSRX(IEN52,1,0)),U,3)
 IF NUM>0 DO 
 . SET OUT=NUM
 . ; get the date of each
 . NEW REFILL,REFDATE SET REFILL=0 ; refill # and refill date
 . FOR  SET REFILL=$ORDER(^PSRX(IEN52,1,REFILL)) QUIT:'REFILL  DO
 . . SET REFDATE=$$GET1^DIQ(52.1,REFILL_","_IEN52,.01,"I")
 . . IF $GET(REFDATE)?7N.1".".6N SET OUT=OUT_"^"_REFILL_";"_REFDATE ; add date to output
 ;
 QUIT $GET(OUT) ; label GETREF
 ;
 ;
SETMEDRA(DFN)   ;  build an array of all the Rx ien's for a specified patient
 ;REQUIRED: new MEDS var array before calling - this will return the Rx list
 ;    pass by value DFN - the patient's IEN from file 2
 QUIT:'$DATA(DFN)
 ;
 ;use the ^psrxindex(52, to match the dfn
 NEW DRUG,STARTDT,STOPDT,STRING,OUT
 SET (DRUG,STARTDT,STOPDT,STRING,OUT)=0
 ;
 FOR  SET DRUG=$ORDER(^PXRMINDX(52,"PI",DFN,DRUG)) QUIT:'DRUG  DO
 . ;W DRUG,! ;debug
 . ; loop thru the start dates
 . FOR  SET STARTDT=$ORDER(^PXRMINDX(52,"PI",DFN,DRUG,STARTDT)) QUIT:'STARTDT  DO
 . . ;W ?2,STARTDT ;debug
 . . ; loop thru the stop dates
 . . FOR  SET STOPDT=$ORDER(^PXRMINDX(52,"PI",DFN,DRUG,STARTDT,STOPDT)) QUIT:'STOPDT  DO
 . . . ;W ?18,STOPDT ;debug
 . . . ; loop thru string with Rx #
 . . . FOR  SET STRING=$ORDER(^PXRMINDX(52,"PI",DFN,DRUG,STARTDT,STOPDT,STRING)) QUIT:'STRING  DO
 . . . . ;W ?40,STRING,! ;debug
 . . . . ;B ;debug
 . . . . IF $DATA(STRING) SET MEDS(+STRING,STARTDT,STOPDT,DRUG)="",OUT=1
 ;
 QUIT $GET(OUT) ; label MEDRA
 ;
 ;
