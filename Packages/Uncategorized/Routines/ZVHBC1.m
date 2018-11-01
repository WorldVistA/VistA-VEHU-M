ZVHBC1 ; OIA/AJC/TJH - generate BCMA data for test systems ; 5/21/2014
 ;;0.1;NO PACKAGE;NO PATCHES; JAN 15,2014
 ;
 ; called by ZVHBC and ZVHBC3
 ;----------------------------------------------------------
 ;
 WRITE "Not an entry point!  Use EN^ZVHBC",!! QUIT  ; labels in this routine are called by ZVHBC and ZVHBC3
 ;
GETBC(ZVHMED,ZVHBARCD,SILENT) ; get an iv bag bar code (requires ^TMP("PSJ",$J) from EN^PSJBCMA)
 ; pass ZVHBARCD by ref - will return value in ZVHBARCD
 ; pass by value: ZVHMED (medication) SILENT (1=true)
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 ;B ;
 NEW ZVHBCUSED,ZVHDONE1,ZVHPT,ZVHON,ZVHINC1 SET (ZVHBARCD,ZVHDONE1,ZVHINC1)=""
 SET ZVHBCUSED=1 ; default to true
 SET ZVHON=$PIECE(^TMP("PSJ",$J,ZVHMED,0),"^",3) ; pharm order number
 SET ZVHPT=$PIECE(^TMP("PSJ",$J,ZVHMED,0),"^") ; patient IEN
 ;
 IF '$DATA(^TMP("PSJ",$J,ZVHMED,900))&'$DATA(^TMP("PSJ",$J,ZVHMED,950)) DO  QUIT  ; just quit if no barcodes
 . SET ZVHBARCD="",ZVHERR=1,ZVHERR("GETBC",ZVHPT,ZVHMED)="No barcodes in the ^TMP("_$C(34)_"PSJ"_$C(34)_" global"
 . IF 'SILENT WRITE "ERROR: No barcodes",!
 ;
 ; loop through barcodes
 FOR  SET ZVHINC1=$ORDER(^TMP("PSJ",$J,ZVHMED,900,ZVHINC1),-1) Q:ZVHDONE1!'ZVHINC1  DO
 . DO BARCD(ZVHPT,ZVHON,.ZVHBARCD,ZVHINC1,.ZVHBCUSED) ; see if used yet
 . ;B ;
 . IF ZVHBCUSED="" SET ZVHBARCD=ZVHINC1,ZVHDONE1=1 QUIT  ; if not used, good barcode, quit the for loop
 . IF ZVHBCUSED["1" QUIT  ; if used, try next one
 IF ZVHBCUSED["1"&'ZVHDONE1 DO  QUIT  ; no barcode found to use, so lets make more
 . ;BREAK ; debug
 . IF SILENT DO  QUIT  ; silent task - can't make more. use ward stock, and create alert.
 . . SET ZVHALERT=1
 . . SET ZVHALERT(ZVHPT,ZVHMED)="Need Barcodes: "_ZVHPT_" "_$$GET1^DIQ(2,ZVHPT,.01)_" "_$PIECE(^TMP("PSJ",$J,ZVHMED,3),"^",2)
 . WRITE !,?3,"There are no Barcode labels left, sending you to Inpatient Pharmacy.",!
 . WRITE ?3,"REMEMBER: ",$$GET1^DIQ(2,ZVHPT,.01)," ",$PIECE(^TMP("PSJ",$J,ZVHMED,3),"^",2),! ; print patient name and medication
 . NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Ready? Y to continue or CTRL-C to exit "
 . DO ^DIR KILL DIR
 . IF Y(0)="NO" QUIT
 . ;B ; DO PSJI
 . KILL Y
 . DO PSJI ; future improvement: can we send patient and med?
 . SET ZVHBARCD="0^ADDED MORE"
 . ;B ;CHECK ZW
 QUIT  ; label GETBC
 ;
 ;
BARCD(ZVHPT,ZVHON,ZVHBARCD,ZVHINC1,ZVHBCUSED) ;ZVHMED,.ZVHBARCD,.ZVHINC1,SILEN
 ; returns a 1 if the barcode has been used already, "" if not
 ; pass ZVHBCUSED by reference
 ; Pass patient IEN (ZVHPT), Inpatient pharmacy Order number (ZVHON), and
 ;  barcode to be evaluated (ZVHBARCD) by value.
 NEW ZVHIN2,ZVHDONE2,ZVHPOS,ZVHSPIN SET (ZVHIN2,ZVHDONE2,ZVHBCUSED,ZVHPOS)="" SET ZVHSPIN=0
 FOR  SET ZVHIN2=$ORDER(^PSB(53.79,"AUID",ZVHPT,ZVHON,ZVHIN2),-1) QUIT:ZVHIN2=""!(ZVHDONE2=1)  DO
 . IF ZVHINC1=ZVHIN2 SET ZVHBCUSED=1_"^"_"Already given" S ZVHDONE2=1 QUIT  ; look at next one
 . S ZVHBARCD=ZVHINC1 QUIT  ; not this one, so quit and check the next one
 . B ;
 QUIT  ; label BARCD
 ;
 ;
PSJI ;copied from option PSJI LBLI
 NEW J,J2,N,P17,PS,PSGLMT,PSIVAC,PSIVBR,PSIVCT,PSIVNOL,PSIVNOW,PSIVUP,PSIVX,PSJIVORF,PSJORL,TN,UL80,XQUIT,ZQ7 ; variables used by option PSJI LBLI
 ;entry actions
 D ^PSIVXU IF $D(XQUIT) QUIT
 ELSE  S PSIVAC="PROL",PSIVBR="D ENLBLI^PSIVLBL1" D ENCHS^PSIV,ENIVKV^PSGSETU
 K J,N,J2,P17,PS,PSIVAC,PSIVBR,PSIVCT,PSIVNOL,PSIVNOW,TN,ZQ7
 ; exit actions
 K PSGLMT,PSIVUP,PSIVX,PSJIVORF,PSJORL,UL80
 ;
 ; NOTE: the ^TMP("PSJ",$J) global will have to be restored!!
 QUIT  ; label PSJI
 ;
 ;
PRN(PATIENT,ZVHROOM,SDATE,EDATE,ZVHFILE,ERROR,SILENT)   ; get admin date times for PRN meds
 ; pass by value: PATIENT, ZVHROOM (room/bed) MED,SDATE (Start date) EDATE (end date/time) ZVHFILE (0 to view, 1 to save)
 ; pass by ref: ERROR, ZVHFDA
 If '$Data(PATIENT)!'$Data(ZVHROOM) Do  Quit  ; [3/4/15 ajc - handle input errors]
 . Write:'SILENT "ERROR: Missing input data.  Unable to enter PRN meds.",!!
 . Set (ZVHERR,ERROR)=1
 . Set ZVHERR("ZVHBC1","PRN",$J)=$G(PATIENT)_U_$G(ZVHROOM)_U_$G(ZVHFILE)_U_$G(SILENT)
 IF $GET(SDATE)="" DO  ; if no start date is passed, use 00:00 of the FIRST date in the array
 . NEW DATE SET DATE=$ORDER(^TMP("ZVHDTARY",$J,"")) ; get the FIRST date in the array
 . ; SET SDATE=+(DATE_.000001) ; [3/4/15 AJC - adding time option]
 . If DATE["." Set SDATE=+DATE
 . Else  Set SDATE=+(DATE_.000001) ; 1 second AFTER midnight 
 ;
 IF $GET(EDATE)="" DO  ; if no end date is passed, use 24:00 of the LAST date in the array
 . NEW DATE SET DATE=$ORDER(^TMP("ZVHDTARY",$J,""),-1) ; get the LAST date in the array
 . ;SET EDATE=+(DATE_.235959) ; [3/4/15 AJC - adding time]
 . If DATE["." Set EDATE=+DATE
 . Else  Set EDATE=+(DATE_.000001) ; 1 second AFTER midnight
 ;check end date/time for missing time
 IF EDATE?7N&(EDATE'[".") SET EDATE=+(EDATE_.24) ; midnight
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to NOT silent
 ;
 IF 'SILENT WRITE ?1,"PRN Medications:",!
 NEW PSBOLDUZ,PSBOLSTS,PSJON ; ^PSJBCMA (?) might be the source of these leaks?
 NEW ZVHERRMED SET ZVHERRMED=0 ; var for errors
 DO ACTMED^ZVHBC(PATIENT,EDATE,.ZVHERRMED,SILENT) ; get the list of active meds
 IF ZVHERRMED DO  QUIT  
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRN","ACTMED",PATIENT,EDATE)=""  ; error trap
 . IF 'SILENT WRITE !,?5,"ERROR in Active Meds.",!
 IF $GET(^TMP("PSJ",$J,1,0))=-1 DO  QUIT  
 . IF 'SILENT WRITE !!,?5,"No active meds for this date!",!
 ;BREAK ; debug
 ;build an array of PRN meds
 IF 'SILENT WRITE ?6,"Building Meds Array for PRN meds..."
 NEW MED,PRNARRAY SET MED="",PRNARRAY="PRN MEDS ARRAY" ;  medications
 FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO  
 . ;BREAK
 . NEW ON ; Order number for ^OR(100
 . SET ON=$PIECE(^TMP("PSJ",$J,MED,0),"^",9)
 . IF ON[";" SET ON=$PIECE(ON,";") ; Strip the version numbers
 . ;check status, start and stop dates in OR
 . QUIT:$PIECE(^OR(100,ON,3),"^",3)'=6 ; quit if not an active order
 . QUIT:$PIECE(^OR(100,ON,0),"^",8)'<EDATE ; future order start date
 . QUIT:$PIECE(^OR(100,ON,0),"^",9)'>SDATE ; stop date in the past
 . ;NEW ORSTART,ORSTDATE,ORSTOP,ORSTOPDATE
 . ;SET ORSTART=$PIECE(^TMP("PSJ",$J,MED,1),"^",4) ;order start date/time
 . ;SET ORSTDATE=$PIECE(ORSTART,".") ; just the date piece
 . ;SET ORSTOP=$PIECE(^TMP("PSJ",$J,MED,1),"^",5) ;order stop date/time
 . ;SET ORSTOPDATE=$PIECE(ORSTOP,".") ; just the date piece
 . ;BREAK ; debug
 . QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",2)'="P" ; P = PRN
 . ;QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",7)'="A"  ; not active
 . ;QUIT:ORSTOPDATE<SDATE  ; order stop date is before Date array start
 . ;QUIT:ORSTDATE>EDATE  ; order start date is after end of date array
 . SET PRNARRAY(MED)=""
 IF 'SILENT WRITE " DONE!",!
 ;
 NEW MED SET MED=0
 FOR  SET MED=$ORDER(PRNARRAY(MED)) QUIT:MED=""  DO
 . IF 'SILENT WRITE ?3,$E($P(^TMP("PSJ",$J,MED,3),"^",2),1,20),?25,"(IEN ",MED,")" ; Medication
 . ;IF 'SILENT WRITE ! ; just formatting
 . ;BREAK ; debug
 . NEW FREQ,ERRORFREQ SET (FREQ,ERRORFREQ)=0
 . DO FREQ^ZVHBCOCK(PATIENT,MED,.FREQ,.ERRORFREQ,SILENT)
 . IF ERRORFREQ DO  QUIT  
 . . SET (ERROR,ZVHERR)=1
 . . ;SET ^TMP("ZVHERROR",$J,"PRN","FREQ",PATIENT,MED)=""
 . . SET ZVHERR("PRN","FREQ",PATIENT,MED)="" 
 . . IF 'SILENT WRITE "Frequency ERROR!!",! 
 . ; NEED: deal with the q5m issue
 . ; get last admin time if it exists. if it is in the date range, use it to the start date loop
 . ; do the ones that have an implied time (like QAM, QPM, QHS, QAC)
 . NEW ERRDAILY,SCHEDULE SET ERRDAILY=0
 . SET SCHEDULE=$PIECE(^TMP("PSJ",$J,MED,1),"^",3)
 . IF SCHEDULE["Q5M" DO  QUIT  ; FIX THIS LATER!
 . . IF 'SILENT WRITE "Skipping Q5M for now",! 
 . . ELSE  WRITE !
 . ;IF SCHEDULE["QAM"!(SCHEDULE["QD")!(SCHEDULE["QDAY")!(SCHEDULE["DAILY") DO QAM(PATIENT,MED,FREQ,ZVHFILE,.ERRDAILY,SILENT) QUIT
 . ;IF SCHEDULE["QPM"!($PIECE(^TMP("PSJ",$J,MED,1),"^",3)["QHS") DO QPM(PATIENT,MED,FREQ,ZVHFILE,.ERRDAILY,SILENT) QUIT
 . IF SCHEDULE["QAC"!(SCHEDULE["QM") DO  QUIT  
 . . ;IF 'SILENT WRITE "Before meals - SKIPPING FOR NOW ",FREQ,!
 . . DO QAC(PATIENT,MED,FREQ,ZVHFILE,.ERRDAILY,SILENT)
 . IF FREQ=86400!(SCHEDULE["QAM")!(SCHEDULE["QD")!(SCHEDULE["QDAY")!(SCHEDULE["DAILY")!(SCHEDULE["QPM")!($PIECE(^TMP("PSJ",$J,MED,1),"^",3)["QHS") DO QDAY(PATIENT,MED,FREQ,ZVHFILE,.ERRDAILY,SILENT) QUIT
 . IF ERRDAILY DO  QUIT  
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("PRN","DAILY",PATIENT,MED,FREQ)="" 
 . ;IF FREQ=86400 WRITE "DAILY",! SET ZVHERR=1,ZVHERR("NEW SCHEDULE TO FIX")=FREQ QUIT  ; catch any daily's that I missed
 . IF SCHEDULE["QAC"!(SCHEDULE["QM") DO  QUIT  
 . . IF 'SILENT WRITE "QAC IS NOT READY YET",!
 . ; find last given date/time
 . NEW LASTGIVEN SET LASTGIVEN=""
 . DO LASTGVN^ZVHBCOCK(PATIENT,MED,SDATE,EDATE,.LASTGIVEN)
 . IF LASTGIVEN["ERROR" DO  QUIT
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("PRN","LASTGVN",PATIENT,MED,SDATE,EDATE,$GET(LASTGIVEN))=""
 . . IF 'SILENT WRITE "ERROR!! Unable to determine last date/time given.",!
 . ; if lastgiven is not within the range of SDATE-FREQ to EDATE, need to give a starting dose within the date range
 . NEW ERRSTRT SET ERRSTRT=0
 . IF LASTGIVEN=0!($$FMADD^XLFDT(LASTGIVEN,0,0,0,FREQ)<SDATE) DO START(PATIENT,MED,.LASTGIVEN,SDATE,EDATE,ZVHFILE,.ERRSTRT,SILENT)
 . IF ERRSTRT DO  QUIT  
 . . IF 'SILENT WRITE "ERROR!! Unable to define start date",! 
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("PRN","START",PATIENT,MED,$G(FREQ),$G(GVNDTTM),$G(LASTGIVEN))=""
 . ;
 . ; start a loop thru date/times
 . ; use fileman add to add the freq (hours) to the last date/time given, and add random value 0=59 for minutes and seconds
 . NEW GVNDTTM SET GVNDTTM="" ; given date time 
 . ;BREAK ; debug
 . FOR  SET GVNDTTM=$$FMADD^XLFDT(LASTGIVEN,0,0,$RANDOM(60),FREQ) QUIT:GVNDTTM>EDATE  DO  
 . . ;W GVNDTTM," " ; debug
 . . ;BREAK ; debug
 . . NEW SKIP SET SKIP=1
 . . DO SKIP2^ZVHBCOCK(PATIENT,MED,GVNDTTM,FREQ,.SKIP,SILENT)
 . . IF SKIP["ERROR" DO  QUIT  
 . . . IF 'SILENT WRITE "ERROR!!  Was it already given?",! 
 . . . SET (ERROR,ZVHERR)=1
 . . . SET ZVHERR("PRN","SKIP",PATIENT,MED,FREQ)=""
 . . IF SKIP DO  QUIT  ; select a new value
 . . . IF 'SILENT WRITE " Already given too close to this date/time",! 
 . . . SET LASTGIVEN=GVNDTTM ; use the given date/time for the next last given
 . . ;
 . . NEW ZVHFDA,ERRORFDA SET ZVHFDA="",ERRORFDA=0
 . . IF GVNDTTM>0 DO PRNFDA(PATIENT,MED,GVNDTTM,.ZVHFDA,.ERRORFDA)
 . . IF ERRORFDA!(GVNDTTM<0) DO  QUIT  
 . . . IF 'SILENT WRITE "ERROR!!",!
 . . . SET (ERROR,ZVHERR)=1
 . . . SET ZVHERR("PRN","PRNFDA",PATIENT,MED,GVNDTTM)="" QUIT
 . . ;ZW ZVHFDA ; debug
 . . ;
 . . NEW NUM,ERRUPDATE SET NUM="",ERRUPDATE=0
 . . ;[3/4/15 ajc - check start and end dates]
 . . If GVNDTTM<SDATE Write:'SILENT $$FMTE^XLFDT(GVNDTTM)," is before the start date/time.",! Set SKIP=1
 . . If GVNDTTM>EDATE Write $$FMTE^XLFDT(GVNDTTM)," is after the end date/time.",! Set SKIP=1
 . . ;[end 3/4/15 edits - ajc]
 . . IF ZVHFILE=1&(SKIP'[1) DO UPDATE^ZVHBC2(ZVHFILE,.NUM,MED,.ERRUPDATE)
 . . IF ERRUPDATE DO  QUIT  
 . . . SET (ERROR,ZVHERR)=1
 . . . SET ZVHERR("PRN","UPDATE",PATIENT,MED,GVNDTTM,SDATE,EDATE)=""
 . . . IF 'SILENT WRITE " ERROR!! Unable to File the Data",!
 . . ;WRITE ?6,"USER #: ",ZVHDUZ,"  ",$P(^VA(200,ZVHDUZ,0),"^"),?50,GVNDTTM
 . . SET LASTGIVEN=GVNDTTM ; 
 . . ;BREAK ;debug
 . IF 'SILENT WRITE ?5,"Medication ",$P(^TMP("PSJ",$J,MED,3),"^",2)," DONE!",! ;
 ;
 QUIT  ; label PRN
 ;
 ;
START(PATIENT,MED,LASTGIVEN,SDATE,EDATE,ZVHFILE,ERROR,SILENT)   ; give a starting DATE/TIME
 ; pass by ref: LASTGIVEN (will return value of date/time given) ERROR (returns if error)
 ; pass by value: PATIENT,MED,SDATE,EDATE and ZVHFILE (save=1)
 NEW DATE
 IF LASTGIVEN'>0 DO  
 . IF $PIECE(^TMP("PSJ",$J,MED,1),"^",4)>SDATE SET DATE=$PIECE(^TMP("PSJ",$J,MED,1),"^",4) ; order start date is in the range
 . ELSE  SET DATE=SDATE
 IF LASTGIVEN>0&($$FMADD^XLFDT(LASTGIVEN,0,0,0,FREQ)<SDATE) SET DATE=SDATE
 NEW GVNDTTM,ZVHFDA,ERRORFDA SET ZVHFDA="",ERRORFDA=0
 SET GVNDTTM=$$FMADD^XLFDT(DATE,0,2,$RANDOM(60),$RANDOM(60)) ; order start date/time
 ;
 NEW SKIP SET SKIP=1
 DO SKIP2^ZVHBCOCK(PATIENT,MED,GVNDTTM,FREQ,.SKIP)
 IF SKIP["ERROR" DO  QUIT  
 . IF 'SILENT WRITE "ERROR!!  Was it already given?",! 
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRN","SKIP",PATIENT,MED,FREQ)=""
 IF SKIP DO  QUIT  
 . IF 'SILENT WRITE " Already given this date",! 
 . SET LASTGIVEN=GVNDTTM
 IF GVNDTTM>0 DO PRNFDA(PATIENT,MED,GVNDTTM,.ZVHFDA,.ERRORFDA)
 IF ERRORFDA!(GVNDTTM<0) DO  QUIT  
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRN","PRNFDA",PATIENT,MED,GVNDTTM)=""
 . IF 'SILENT WRITE "ERROR!! Fileman Data Array setup error.",!
 ;ZW ZVHFDA ; debug
 ;
 NEW NUM,ERRUPDATE SET NUM="",ERRUPDATE=0
 IF ZVHFILE=1&(SKIP'[1) DO UPDATE^ZVHBC2(ZVHFILE,.NUM,MED,.ERRUPDATE)
 IF ERRUPDATE DO  QUIT  
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("START","UPDATE",PATIENT,MED,GVNDTTM,SDATE,EDATE)=""
 . IF 'SILENT WRITE " ERROR!! Unable to File the Data",!
 SET LASTGIVEN=GVNDTTM
 ;
 QUIT  ; label start
 ;
 ;
PRNFDA(PATIENT,MED,GVNDTTM,ZVHFDA,ERROR)        ; set the fileman Data Array for PRN meds
 ; pass by value: PATIENT (IEN), MED (IEN from ^TMP("PSJ",$J,IEN)), GVNDTTM (given date/time) 
 ; pass by ref: ZVHFDA (fileman Data Array), ERROR
 ; get an active nurse for that date
 IF GVNDTTM<0 SET ERROR=1 WRITE "No given Date/Time!  skipping...",! QUIT
 NEW ZVHDUZ,ZVHUSARRAY,ZVHERRUS,ZVHDATE SET (ZVHDUZ,ZVHUSARRAY)="",ZVHERRUS=0 ; var for DUZ, active users, errors
 SET ZVHDATE=$PIECE(GVNDTTM,".")
 DO SELRN^ZVHBC(ZVHDATE,.ZVHUSARRAY,.ZVHERRUS)
 IF ZVHERRUS!($DATA(ZVHUSARRAY)'>9) DO  QUIT
 . IF 'SILENT WRITE " Can't file without nurses, skipping this date.",! 
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRNFDA","USER",PATIENT,GVNDTTM)=""
 SET ZVHDUZ=$RANDOM($PIECE(ZVHUSARRAY(0),"^",2))+1 ; select a random nurse from the active nurses array
 SET ZVHDUZ=ZVHUSARRAY(ZVHDUZ) ; Get the DUZ of Nurse
 ;W "DUZ:",ZVHDUZ ; debug
 ;
 ;BREAK ; debug
 IF $PIECE(^TMP("PSJ",$J,MED,0),"^",3)["U" DO  ; unit dose meds
 . ;W " UD " ; debug
 . NEW ERRORUD SET ERRORUD=0
 . DO UD(.ZVHFDA,MED,.ERRORUD)
 IF $GET(ERRORUD) DO  QUIT
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRNFDA","UD",PATIENT,MED,GVNDTTM,SDATE,EDATE)=""
 . IF 'SILENT WRITE " ERROR!! Unable to set up Unit Dose variables",!
 NEW ERRORIV,ZVHERRMED SET (ERRORIV,ZVHERRMED)=0
 IF $PIECE(^TMP("PSJ",$J,MED,1),"^")["IV" DO  ; for iv and IVPB
 . ;W " IV " ; debug
 . DO IVONE(.ZVHFDA,MED,PATIENT,ZVHDATE,.ERRORIV,.ZVHERRMED,SILENT)
 IF ZVHERRMED!ERRORIV DO  QUIT  ; error skip to next med
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRNFDA","IV",PATIENT,ZVHDATE,MED,GVNDTTM)="" 
 . IF 'SILENT WRITE ?30,"ERROR in IV variable set up, skipping... ",! 
 NEW ERRORFDA SET ERRORFDA=0
 DO SETFDA^ZVHBC2(PATIENT,ZVHROOM,GVNDTTM,ZVHDUZ,.ZVHFDA,MED,.ERRORFDA,SILENT)
 ;ZW ZVHFDA ; debug
 IF ERRORFDA DO  QUIT  
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("PRNFDA","SETFDA",PATIENT,MED,GVNDTTM,SDATE,EDATE)="" 
 . IF 'SILENT WRITE " ERROR!! Unable to set up Fileman Data Array variables",! QUIT  
 ; select a reason
 NEW REASON,RANDOM SET RANDOM=$RANDOM(5)+1 ; random # 1-5
 SET REASON=$PIECE($TEXT(REASON+RANDOM),";;",2)
 SET ZVHFDA(53.79,"+1,",.21)=REASON
 IF SILENT DO
 . WRITE ?3,$E($P(^TMP("PSJ",$J,MED,3),"^",2),1,20)," (",MED,")" ; Medication
 . WRITE ?35,"USER #: ",ZVHDUZ
 . WRITE ?55,$$FMTE^XLFDT(GVNDTTM),!
 ELSE  WRITE ?6,"USER #: ",ZVHDUZ,"  ",$P(^VA(200,ZVHDUZ,0),"^"),?45,$$FMTE^XLFDT(GVNDTTM),!
 ;
 QUIT  ; label PRNFDA
 ;
 ;
CKDATES(DATE,SDATE,EDATE,OK)    ; make sure a given date/time is between 2 other dates
 ; REQUIRED: all dates in fileman format
 ; pass by ref: DATE (date to check) SDATE (start of date range) EDATE (end of date range)
 ; pass by value: OK - will return 1 or 0 or error.  1 is true, it is in the range.  
 ;   0 is false, not in the range.
 ;
 ;check for required variables
 IF $GET(SDATE)=""!($GET(EDATE)="")!($GET(DATE)="") SET OK="ERROR" QUIT  
 ;
 IF EDATE?7N&(EDATE'[".") SET EDATE=+EDATE_".24" ; midnight
 ;
 IF DATE'<SDATE&(DATE'>EDATE) SET OK=1 QUIT  ; in the range
 ELSE  SET OK=0 QUIT  ; not in the range
 ;
 QUIT  ; label CKDATES
 ;
 ;
QDAY(PATIENT,MED,FREQ,ZVHFILE,ERROR,SILENT)     ; give the QAM, daily, and QDAY meds at a random morning time
 ; give QPM meds at a random evening time
 ; pass by ref PATIENT,MED,FREQ,ZVHFILE,SILENT
 ; pass by value: ERROR
 NEW DATE SET DATE=""
 FOR  SET DATE=$ORDER(^TMP("ZVHDTARY",$J,DATE)) QUIT:DATE=""  DO  
 . ;W DATE ;debug
 . NEW STARTDTTM,ENDDTTM ; var for start/end date/times of the order
 . SET STARTDTTM=$PIECE(^TMP("PSJ",$J,MED,1),"^",4)
 . IF DATE<STARTDTTM SET DATE=$PIECE(STARTDTTM,".")
 . SET ENDDTTM=$PIECE(^TMP("PSJ",$J,MED,1),"^",5)
 . IF DATE'<ENDDTTM DO  QUIT ; already expired or d/c'd
 . . IF 'SILENT WRITE "Passed the order end date/time.",! 
 ;
 . NEW GVNDTTM,ZVHFDA ; given date/time and Fileman Data Array
 . ;
 . IF SCHEDULE["QPM"!($PIECE(^TMP("PSJ",$J,MED,1),"^",3)["QHS") DO 
 . . SET GVNDTTM=$$FMADD^XLFDT(DATE,0,21,$R(120),$R(60)) ; evening meds - give between 2100 and 2359
 . ELSE  SET GVNDTTM=$$FMADD^XLFDT(DATE,0,6,$R(120),$R(60)) ; unknown or morning meds - give between 0600 and 0859
 . ;
 . ; see if its been given this date
 . NEW SKIP SET SKIP=1
 . DO SKIP2^ZVHBCOCK(PATIENT,MED,GVNDTTM,FREQ,.SKIP)
 . IF SKIP["ERROR" DO  QUIT  
 . . IF 'SILENT WRITE "ERROR!!  Was it already given?",! 
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("PRN","QDAY","SKIP",PATIENT,MED,FREQ)=""
 . IF SKIP&'SILENT WRITE " Already given this date",! QUIT
 . NEW ERRFDA SET ERRFDA=0
 . IF GVNDTTM>0 DO PRNFDA(PATIENT,MED,GVNDTTM,.ZVHFDA,.ERRFDA)
 . IF ERRFDA!(GVNDTTM<0) DO  QUIT  
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("PRN","QDAY","SETFDA",PATIENT,MED,GVNDTTM)="" 
 . . IF 'SILENT WRITE "FDA ERROR!!",!
 . ;
 . NEW NUM,ERRUPDATE SET NUM="",ERRUPDATE=0
 . ;ZW ZVHFDA ; debug
 . IF SKIP&'SILENT W "  Already given this date.",! QUIT
 . IF ZVHFILE=1&(SKIP'=1) DO UPDATE^ZVHBC2(ZVHFILE,.NUM,MED,.ERRUPDATE)
 . IF ERRUPDATE DO  QUIT  
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("PRN","QDAY","UPDATE",PATIENT,MED,GVNDTTM,SDATE,EDATE)=""
 . . IF 'SILENT WRITE " ERROR!! Unable to File the Data",!
 IF 'SILENT WRITE ?5,"Medication ",$P(^TMP("PSJ",$J,MED,3),"^",2)," DONE!",! 
 ;
 QUIT  ; label QDAY
 ;
 ;
QAC(PATIENT,MED,FREQ,ZVHFILE,ERROR,SILENT)      ; give QAC (QM) meds at slightly random meal times
 ; breakfast = 0701-0959 (times to give) 178 minute range
 ; lunch = 1101-1259
 ; dinner = 1701-1959
 IF 'SILENT WRITE "Before meals - SKIPPING FOR NOW ",FREQ,!
 SET ZVHERR=1,ZVHERR("QAC",PATIENT,MED,FREQ)=""
 ;
 ; get the last date/time given
 ; if "" need to choose a start date/time - can I use START^ZVHBC1?
 ; determine if it's in the date range
 ; determine if its a breakfast, lunch or dinner
 ; if last given date/time is 07-10 do lunch
 ; if last given date/time is 11-13 do dinner
 ; if last given date/time is >17 add 1 to date and do breakfast
 ; check if we need to skip this date/time
 NEW SKIP,ZVHFDA ; var for skipping this dose, fileman data array
 SET SKIP=1 ; default to true, skip this med
 ; ? for detecting previous dose, use 0-1100, 1101-1700, 1701-2359 
 ; may need to have SKIP3 for this?
 ; setfda
 ; update
 ; set given date/time to be the last given
 ; give the next one
 ; quit at end of date range
 ;
 QUIT  ; label QAC
 ;
 ;
REASON  ; list of PRN reasons
 ;;patient request;;
 ;;as directed;;
 ;;MD orders;;
 ;;discomfort;;
 ;;requested;;
 ;
 QUIT  ; label REASON
 ;
 ;
UD(ZVHFDA,ZVHMED,ZVHERRUD) ; enter fields unique to unit dose meds
 ; internal use only, pass ZVHFDA by ref, ZVHMED,ZVHSCHTM by value
 ;
 SET ZVHFDA(53.79,"+1,",.09)="G" ; status = given - will need to change for IVs
 SET ZVHFDA(53.795,"+2,+1,",.01)=$P(^TMP("PSJ",$J,ZVHMED,700,1,0),"^") ; dispense drug ien (file 50)
 SET ZVHFDA(53.795,"+2,+1,",.02)=$P(^TMP("PSJ",$J,ZVHMED,700,1,0),"^",3) ; doses ordered
 SET ZVHFDA(53.795,"+2,+1,",.03)=$P(^TMP("PSJ",$J,ZVHMED,700,1,0),"^",3) ; doses given (= doses ordered)
 SET ZVHFDA(53.795,"+2,+1,",.04)=$P(^TMP("PSJ",$J,ZVHMED,3),"^",3) ; unit of administration EX: "TAB,EC"
 ;
 IF $DATA(ZVHFDA(53.795))'>9 SET ZVHERRUD=1
 QUIT  ; label UD
 ;
 ;
IVONE(ZVHFDA,ZVHMED,ZVHPT,ZVHDATE,ZVHERRIV,ZVHERRMED,SILENT) ; enter fields unique to IV
 ; for IV, IVPB, One-time, On call, scheduled
 ;
 ; internal use only, pass ZVHFDA,ZVHERRIV,ZVHERRMED by ref, ZVHMED,ZVHPT by value
 ; data is returned in the ZVHFDA array
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to NOT silent
 ;
 NEW INFUSION,IVPB SET (INFUSION,IVPB)=0 ; if it has a solution, and is continuous, and has no schedule, its an infusion
 IF $D(^TMP("PSJ",$J,ZVHMED,950,0))&($P(^TMP("PSJ",$J,ZVHMED,1),"^",2)="C")&($P(^TMP("PSJ",$J,ZVHMED,1),"^",6)="") SET INFUSION=1
 IF $PIECE(^TMP("PSJ",$J,ZVHMED,1),"^")="IVPB" SET IVPB=1
 ;
 NEW ZVHBARCD SET ZVHBARCD=0
 IF INFUSION!IVPB DO
 . DO GETBC(ZVHMED,.ZVHBARCD,SILENT) ; get a barcode for this IV
 ;DO GETBC(ZVHMED,.ZVHBARCD,SILENT) ; get a barcode
 IF ZVHBARCD["ADDED MORE" SET ZVHBARCD="" DO  ; loop again to get one of the new barcodes
 . DO ACTMED^ZVHBC(ZVHPT,ZVHDATE,.ZVHERRMED,SILENT) ; restore the ^TMP("PSJ",$J) global
 . DO GETBC(ZVHMED,.ZVHBARCD,SILENT) ; loop again to get one of the new barcodes
 ;Check for barcode, quit if not present
 IF 'SILENT&(INFUSION!IVPB)&('$GET(ZVHBARCD)!(ZVHBARCD["ERROR")) DO  QUIT  
 . QUIT:SILENT
 . WRITE !!,"BARCODE ERROR!!  Skipping...",!! 
 . SET (ZVHERR,ZVHERRIV)=1
 . SET ZVHERR("IVONE","BARCODE",ZVHPT,ZVHMED,ZVHDATE,$GET(ZVHBARCD))=""
 ;
 ;if ivpb or one/time or oncall, set status to given.  if continuous, set to infusing.
 IF IVPB!($PIECE(^TMP("PSJ",$J,ZVHMED,1),"^",2)["O") SET ZVHFDA(53.79,"+1,",.09)="G" ; status = given
 ;IF INFUSION SET ZVHFDA(53.79,"+1,",.09)="I" ; status = INFUSING
 ;
 SET ZVHFDA(53.79,"+1,",.16)="IV" ; injection site = IV
 IF ZVHBARCD SET ZVHFDA(53.79,"+1,",.26)=ZVHBARCD ; bar code for IV
 SET ZVHFDA(53.79,"+1,",.35)=$P(^TMP("PSJ",$J,ZVHMED,2),"^",2) ; infusion rate
 ; Unit dose (need for IVP, or remove????)
 IF $DATA(^TMP("PSJ",$J,ZVHMED,700,0)) DO
 . SET ZVHFDA(53.795,"+2,+1,",.01)=+$P(^TMP("PSJ",$J,ZVHMED,700,1,0),"^") ; dispense drug ien (file 50)
 . SET ZVHFDA(53.795,"+2,+1,",.02)=$P(^TMP("PSJ",$J,ZVHMED,700,1,0),"^",3) ; doses ordered
 . SET ZVHFDA(53.795,"+2,+1,",.03)=$P(^TMP("PSJ",$J,ZVHMED,700,1,0),"^",3) ; doses given (= doses ordered)
 . SET ZVHFDA(53.795,"+2,+1,",.04)=$P(^TMP("PSJ",$J,ZVHMED,3),"^",3) ; unit of administration EX: "TAB,EC"
 ; additives
 IF $DATA(^TMP("PSJ",$J,ZVHMED,850,0)) DO  
 . SET ZVHFDA(53.796,"+3,+1,",.01)=+$P(^TMP("PSJ",$J,ZVHMED,850,1,0),"^") ; additives - ien of IV additives file
 . SET ZVHFDA(53.796,"+3,+1,",.02)=$P(^TMP("PSJ",$J,ZVHMED,850,1,0),"^",2) ; additives name stored in doses ordered 
 . SET ZVHFDA(53.796,"+3,+1,",.03)=$P(^TMP("PSJ",$J,ZVHMED,850,1,0),"^",3) ; doses given (= doses ordered)
 ; solutions
 IF $DATA(^TMP("PSJ",$J,ZVHMED,950,0)) DO 
 . SET ZVHFDA(53.797,"+4,+1,",.01)=+$P(^TMP("PSJ",$J,ZVHMED,950,1,0),"^") ; solutions - ien of IV solutions file
 . SET ZVHFDA(53.797,"+4,+1,",.02)=$P(^TMP("PSJ",$J,ZVHMED,950,1,0),"^",2) ; solutions name stored in doses ordered
 . SET ZVHFDA(53.797,"+4,+1,",.03)=$P(^TMP("PSJ",$J,ZVHMED,950,1,0),"^",3) ; doses given (= doses ordered)
 ;
 IF (INFUSION!IVPB)&(($DATA(ZVHFDA(53.797))'>9)!(ZVHBARCD["ERROR")) DO  QUIT  ; check if successful solutions
 . SET (ZVHERR,ZVHERRIV)=1
 . SET ZVHERR("IVONE","ZVHFDA","IV",ZVHPT,ZVHMED,ZVHDATE)="No solution"
 . IF 'SILENT WRITE "No solution in the Fileman Data Array ERROR!!",!
 IF $DATA(ZVHFDA(53.79))'>9 DO  QUIT  ; check if successful
 . SET (ZVHERR,ZVHERRIV)=1
 . SET ZVHERR("IVONE","ZVHFDA",ZVHPT,ZVHMED,ZVHDATE)=""
 ;IF ZVHBARCD&'SILENT WRITE ?49,ZVHBARCD
 ;
 QUIT  ; Label IVONE
 ;
 ;
 
