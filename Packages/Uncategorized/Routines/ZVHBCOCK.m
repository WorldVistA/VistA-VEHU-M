ZVHBCOCK ; OIA/TJH,AJC CHECK BCMA administrations ; 5/21/14
 ;;0.1;NO PKG;**NO PATCHES**;JAN  13, 2014
 ;
 ;   Provides Order checking for medications
 ;
 ;   Called by ZVHBC and ZVHBC3
 ;----------------------------------------------------------
 ;
 WRITE "Not an entry point!  Use EN^ZVHBC",!! QUIT  ; labels in this routine are called by ZVHBC and ZVHBC3
 ;
EN(ZVHPT,ZVHON,ZVHDTM,ZVHGIVEN,SILENT) ; cont/sch meds - see if already given for the
 ;   date/time specified
 ; pass by ref: ZVHGIVEN (returns as 1=given, or 0=not given)
 ; pass by value: ZVHPT (patient DFN) ZVHON (Order Number for PSJ) and
 ;   ZVHDTM (date time to check)
 IF $GET(SILENT)="" SET SILENT=0
 SET ZVHGIVEN=1 ; default to true
 IF $DATA(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDTM)) DO  
 . SET ZVHGIVEN=1  ; ZVHGIVEN passed as a reference
 . ;IF 'SILENT WRITE "Order already given" 
 ELSE  SET ZVHGIVEN=0 ; med not given for this date/time
 Q  ; $D=1 if dose is given.
 ;
 ;
ONETM(ZVHPT,ZVHON,MED,ZVHGIVEN,ZVHFILE,SILENT) ; see if 1 time or on call med already given
 ; pass by ref: ZVHGIVEN (returns as 1=given, or 0=not given)
 ; pass by value: ZVHPT (patient DFN) ZVHON (Order Number for PSJ) 
 ;   MED medication number in ^TMP("PSJ",$J) ZVHFILE (1 to save)
 ; WARNING: only use for one time or on call meds!
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 SET ZVHGIVEN=1 ; Default to true, already given
 ;
 ;REQUIRED:
 QUIT:'ZVHPT!'ZVHON!'MED
 ;get the previous admins for this patient
 NEW DATE,DONE SET DATE="",DONE=0 ; var for date/time of previous med administrations
 FOR  SET DATE=$ORDER(^PSB(53.79,"AADT",ZVHPT,DATE),-1) QUIT:DONE!(DATE="")  DO
 . ;WRITE DATE,! ; debug
 . NEW PSBIEN SET PSBIEN="" ; for ien in the ^PSB(53.79 file
 . FOR  SET PSBIEN=$ORDER(^PSB(53.79,"AADT",ZVHPT,DATE,PSBIEN)) QUIT:DONE!(PSBIEN="")  DO
 . . ;WRITE "PSBIEN=",PSBIEN,! ; debug
 . . ; check to see if its the same PSJON
 . . IF $PIECE(^PSB(53.79,PSBIEN,.1),"^")=ZVHON DO  ; its already been given
 . . . SET (ZVHGIVEN,DONE)=1 ; stop searching
 . . . IF 'SILENT WRITE "  Already given, expire the order...",!
 . . . NEW ORDER SET ORDER=$PIECE(^TMP("PSJ",$J,MED,0),"^",9) ; get the order #
 . . . IF ORDER[";" SET ORDER=$PIECE(ORDER,";") ; drop the ; and version number
 . . . W "ORDER#:",ORDER,! ;debug
 . . . IF $GET(ORDER)'>0 DO  QUIT  
 . . . . SET ZVHERR=1,ZVHERR("ONETM","MISSING ORDER #",ZVHPT,ZVHON,MED)=""
 . . . . WRITE:'SILENT "ERROR: No order #",!
 . . . NEW ZVHERREXP SET ZVHERREXP=0
 . . . IF $G(ZVHFILE)=1 DO  ; save = true
 . . . NEW STOPDATE SET STOPDATE=$PIECE(^PSB(53.79,PSBIEN,0),"^",4)
 . . . ;W STOPDATE," " ; debug
 . . . IF $GET(STOPDATE)'>0 DO  QUIT
 . . . . SET (ZVHERR,ZVHERREXP)=1
 . . . . SET ZVHERR("ONETM","EXPIRE","MISSING STOPDATE",ZVHPT,ZVHON,MED,$G(PSBIEN),$GET(ORDER))=""
 . . . . WRITE:'SILENT " ERROR: Missing Stop Date - could not expire order.",!
 . . . IF $G(ZVHFILE)=1 DO EXPIRE^ZVHBC2(ORDER,STOPDATE,MED,.ZVHERREXP,SILENT) ;debug W "after expire:",STOPDATE,!
 . . . IF ZVHERREXP DO  QUIT
 . . . . SET (ZVHERR,ERROR1TM)=1
 . . . . SET ZVHERR("ONETM","EXPIRE",ZVHPT,ZVHON,MED,$GET(STOPDATE),$GET(PSBIEN),$GET(ORDER))=""
 . . . . IF 'SILENT WRITE "  ERROR! One time order was not expired.",!
 . . . ELSE  WRITE:'SILENT "Order # ",$GET(ORDER)," Expired on: ",$GET(STOPDATE),! ;debug
 . . . ;
 . . . ; DO WE NEED TO EXPIRE IT IN FILE 55
 . . . ;
 . . ELSE  SET ZVHGIVEN="" ; it has not been given
 QUIT  ; label ONETM 
 ;
 ;
FREQ(ZVHPT,ZVHMED,ZVHFREQ,ZVHERRFREQ,SILENT) ; compute the frequency in SECONDS!
 ; internal to ZVHBC routines - requires ^TMP("PSJ",$J) from EN^PSJBCMA
 ;pass by value: ZVHPT (patient) ZVHMED (med order number from ^TMP("PSJ"))
 ;pass by ref: ZVHERRFREQ (error/debug) ZVHFREQ (frequency) this will be set
 ;   to the frequency in hours (ex: Daily = 24)
 IF $GET(SILENT)="" SET SILENT=0
 ;
 SET ZVHFREQ=$PIECE(^TMP("PSJ",$J,ZVHMED,1),"^",3) ; get the frequency
 IF ZVHFREQ[" " SET ZVHFREQ=$PIECE(ZVHFREQ," ") ; drop the free text after the frequency
 ;debug - check error handling
 ;IF ZVHFREQ["Q5M" W "Test ERROR!  Skipping...",! SET ZVHERRFREQ=1,ZVHERR("TEST","Q5M")="" QUIT
 ;debug
 ;
 ; convert common abbreviations to hours
 IF ZVHFREQ="QDAY"!(ZVHFREQ="QD")!(ZVHFREQ["DAILY") SET ZVHFREQ=(24*60*60) QUIT  ; once per day 86400 seconds
 IF ZVHFREQ["QPM"!(ZVHFREQ["QAM")!(ZVHFREQ["QHS") SET ZVHFREQ=(24*60*60) QUIT  ; morning/evening/bed time (all daily)
 IF ZVHFREQ["BID" SET ZVHFREQ=(12*60*60) QUIT  ; twice a day (24 hours/2 times)
 IF ZVHFREQ["TID" SET ZVHFREQ=(8*60*60) QUIT  ; 3 times a day
 IF ZVHFREQ["QID" SET ZVHFREQ=(6*60*60) QUIT  ; 4 times a day
 IF ZVHFREQ["QOD" SET ZVHFREQ=(48*60*60) QUIT  ; every other day
 ;
 ; with meals frequency - try 4 hours
 IF (ZVHFREQ["QM")!(ZVHFREQ["QAC") SET ZVHFREQ=(4*60*60) QUIT ; this is is 3/day, but spaced close (like 08-12-18)
 ;
 ; common frequencies to translate
 IF ZVHFREQ?1"Q"1N1"H"1.E!(ZVHFREQ?1"Q"1N1"M".E) SET ZVHFREQ=$EXTRACT(ZVHFREQ,1,3) ; drop anything after the freq (ex Q8H* changed to Q8H)
 IF ZVHFREQ?1"Q"2N1"H"1.E!(ZVHFREQ?1"Q"2N1"M".E) SET ZVHFREQ=$EXTRACT(ZVHFREQ,1,4) ; drop anything after the freq (ex Q12H* changed to Q12H)
 ;
 ; translate format Q#H (hours)
 IF ZVHFREQ?1"Q"1.2N1"H" DO  ; if the frequency is Q#H or Q##H (EX: Q6H, Q12H)
 . SET ZVHFREQ=$PIECE(ZVHFREQ,"Q",2) ; remove the Q
 . SET ZVHFREQ=$PIECE(ZVHFREQ,"H") ; remove the H
 . SET ZVHFREQ=ZVHFREQ*60*60 ; convert the hours to seconds
 ;
 ; translate Format Q#M (minutes)
 IF ZVHFREQ?1"Q"1.2N1"M" DO  ; if the frequency is Q#M or Q##M (EX: Q5M, Q60M)
 . SET ZVHFREQ=$PIECE(ZVHFREQ,"Q",2) ; remove the Q
 . SET ZVHFREQ=$PIECE(ZVHFREQ,"H") ; remove the H
 . SET ZVHFREQ=ZVHFREQ*60 ; convert to seconds by mutliplying by 60
 ;
 ;quit if frequency is not a numeric value
 IF ZVHFREQ'=+ZVHFREQ DO  
 . SET (ZVHERR,ZVHERRFREQ)=1 
 . IF 'SILENT WRITE " ERROR!!",!
 ;
 ;next... deal with day of the week scheduled frequencies
 ;
 QUIT  ; label FREQ
 ;
 ;
SKIP(ZVHPT,ZVHMED,GVNDTTM,ZVHFREQ,ZVHSKIP) ; skip this med?
 ;pass by value: ZVHPT (patient) ZVHMED (medication order number from
 ;  ^TMP("PSJ")) ZVHDATE (date) and ZVHFREQ (frequency in SECONDS!)
 ;pass by ref: ZVHSKIP will return as a 1 if it should be skipped for this date
 ;
 SET ZVHSKIP=1 ; default to skip this med for this date/TIME
 IF GVNDTTM=""!(ZVHFREQ="") SET ZVHSKIP="ERROR^NULL VALUES PASSED" QUIT
 IF ZVHFREQ'=+ZVHFREQ SET ZVHSKIP="ERROR^ZVHFREQ IS NOT AN INTEGER" QUIT
 ;find the last admin date/time
 NEW ZVHMEDIEN SET ZVHMEDIEN=$PIECE(^TMP("PSJ",$J,ZVHMED,3),"^") ; get the med IEN
 NEW ZVHLASTGVN SET ZVHLASTGVN=$ORDER(^PSB(53.79,"AOIP",ZVHPT,ZVHMEDIEN,""),-1) ; get last given date/time
 ;convert it to horolog and add the freq
 IF ZVHLASTGVN="" SET ZVHSKIP="" QUIT  ; if last given does not exist, then ok to give, do not skip
 ELSE  SET ZVHLASTGVN=$$FMTH^XLFDT(ZVHLASTGVN) ; convert to horolog
 ;see if the date is > the horolog of ZVHDATE@0000 and < the horolog of ZVHDATE@2359
 ;
 NEW ZVHDATE1 SET ZVHDATE1=$$FMTH^XLFDT(GVNDTTM) ; get horolog for this date @ midnight
 NEW ZVHDATE SET ZVHDATE=$PIECE(GVNDTTM,".") ; just the date of given date/time
 NEW ZVHDATE2 SET ZVHDATE2=+(ZVHDATE_".235959") SET ZVHDATE2=$$FMTH^XLFDT(ZVHDATE2) ; horolog of this date at 23:59.59
 ;
 IF ZVHLASTGVN<ZVHDATE1!((ZVHLASTGVN>ZVHDATE1)&(ZVHLASTGVN<ZVHDATE2)) SET ZVHSKIP="" QUIT  ; next admin date is this date, don't skip
 ELSE  QUIT  ; keep default of ZVHSKIP=1
 ;
 QUIT  ; label SKIP
 ;
 ;
SKIP2(ZVHPT,ZVHMED,GVNDTTM,ZVHFREQ,ZVHSKIP,SILENT) ; skip this med?
 ;pass by value: ZVHPT (patient) ZVHMED (medication order number from
 ;  ^TMP("PSJ")) ZVHDATE (date) and ZVHFREQ (frequency in SECONDS!)
 ;pass by ref: ZVHSKIP will return as a 1 if it should be skipped for this date
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 SET ZVHSKIP=1 ; default to skip this med for this date/TIME
 IF GVNDTTM=""!(ZVHFREQ="") SET ZVHSKIP="1^ERROR^NULL VALUES PASSED" QUIT
 IF ZVHFREQ'=+ZVHFREQ SET ZVHSKIP="1^ERROR^ZVHFREQ IS NOT AN INTEGER" QUIT
 ;
 ;for daily frequencies, just use the date
 IF ZVHFREQ>86399 DO SKIPDAY(ZVHPT,ZVHMED,GVNDTTM,ZVHFREQ,.ZVHSKIP,SILENT) QUIT  ; daily = 24*60*60 = 86400
 ;new plan...
 NEW START,SDATE,STIME,END,HGVNDTTM
 SET HGVNDTTM=$$FMTH^XLFDT(GVNDTTM) ; change GVNDTTM to horolog
 ;
 ;set start=time of gvndttm - freq
 SET SDATE=$P(HGVNDTTM,",") ; horolog date for start date
 SET STIME=$P(HGVNDTTM,",",2) ; horolog time for start time
 SET STIME=STIME-FREQ
 IF STIME<0 DO  ; if time < 0 decriment date by 1 and add 86400 seconds to time
 . SET SDATE=SDATE-1
 . SET STIME=STIME+86400 ; 86400 seconds in a day (24*60*60)
 SET START=SDATE_","_STIME
 ;
 SET START=$$HTFM^XLFDT(START) ; convert horolog to Fileman
 ;
 SET END=$$FMADD^XLFDT(GVNDTTM,0,0,0,FREQ) ;set end=gvndttm+freq 
 ;
 ;plan: use the START and END to see if this hav been given in that time.
 ;
 NEW MEDICATION,GIVEN
 SET MEDICATION=$PIECE(^TMP("PSJ",$J,ZVHMED,3),"^") ; get the medication IEN
 SET GIVEN=$ORDER(^PSB(53.79,"AOIP",ZVHPT,MEDICATION,START)) ; get the next given date/time after the start
 IF GIVEN'=""&(GIVEN<END) SET ZVHSKIP=1 ; if there is a med given in the range then set ZVHSKIP to true
 ELSE  SET ZVHSKIP=0 ; ok to give
 ;
 ;
 QUIT  ; label SKIP2
 ;
 ;
SKIPDAY(ZVHPT,ZVHMED,GVNDTTM,ZVHFREQ,ZVHSKIP,SILENT) ; skip this med? - DAILY PRN meds
 ;pass by value: ZVHPT (patient) ZVHMED (medication order number from
 ;  ^TMP("PSJ")) ZVHDATE (date) and ZVHFREQ (frequency in SECONDS!)
 ;pass by ref: ZVHSKIP will return as a 1 if it should be skipped for this date
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 ;
 SET ZVHSKIP=1 ; default to skip this med for this date/TIME
 IF GVNDTTM=""!(ZVHFREQ="") SET ZVHSKIP="1^ERROR^NULL VALUES PASSED" QUIT
 IF ZVHFREQ'=+ZVHFREQ SET ZVHSKIP="1^ERROR^ZVHFREQ IS NOT AN INTEGER" QUIT
 ;find the last admin date/time
 NEW MEDICATION,GIVEN,START,STARTH,END,FREQDAY SET MEDICATION=$PIECE(^TMP("PSJ",$J,ZVHMED,3),"^") ; get the med IEN
 SET FREQDAY=ZVHFREQ\86400 ; frequency/seconds per day (modulo for whole number)
 IF FREQDAY=1 SET (START,END)=$PIECE(GVNDTTM,".") ; only check that date for daily meds
 ELSE  DO  
 . SET FREQDAY=FREQDAY-1 ; reduce days by 1
 . SET STARTH=$$FMTH^XLFDT(GVNDTTM) ; convert to horolog
 . NEW DAYS SET DAYS=$PIECE(STARTH,",") ; get days from horolog date/time
 . SET STARTH=(DAYS-FREQDAY)_","_0001 ; subtract the freq from the days
 . SET START=$$HTFM^XLFDT(STARTH) ; convert to fileman
 . SET END=$PIECE(GVNDTTM,".") ; get the date to be given
 . SET END=$$FMADD^XLFDT(END,FREQDAY,0,0,0) ; add the frequency days
 SET GIVEN=$ORDER(^PSB(53.79,"AOIP",ZVHPT,MEDICATION,START)) ; get the next given date/time
 IF GIVEN'=""&($PIECE(GIVEN,".")'>END) DO  ; if its on or before the end date
 . SET ZVHSKIP=1 ; already given this date
 . IF 'SILENT WRITE ?30,"Already given for this date.",!
 ELSE  SET ZVHSKIP=0 ; Not given in this date range, ok to file
 ;
 QUIT  ; label SKIPDAY
 ;
 ;
LASTGVN(PATIENT,MED,SDATE,EDATE,LASTGIVEN)      ; find last date/time given in a date range
 ; pass by value: PATIENT (IEN) and MED (number of med in the ^TMP("PSJ",$J) array)
 ;   SDATE (start date) and EDATE (end date) in fileman date/time format
 ; pass by ref: LASTGIVEN (will return date/time in this var in fileman format)
 ;get the Pharm IO 
 IF SDATE'=+SDATE!(SDATE'>0) SET LASTGIVEN="ERROR^BAD START DATE" QUIT
 IF EDATE'=+EDATE!(EDATE'>0) SET LASTGIVEN="ERROR^BAD END DATE" QUIT
 NEW MEDIEN,FIRSTGVN SET MEDIEN=$PIECE(^TMP("PSJ",$J,MED,3),"^")
 SET FIRSTGVN=$ORDER(^PSB(53.79,"AOIP",PATIENT,MEDIEN,SDATE)) ; first given on or after start date
 IF (FIRSTGVN="")!(FIRSTGVN>EDATE) SET LASTGIVEN=0 ; not given in the date range
 ELSE  SET LASTGIVEN=$ORDER(^PSB(53.79,"AOIP",PATIENT,MEDIEN,EDATE),-1) ;
 ;
 ;NEED: HOW TO RECOGNIZE ERRORS HERE?
 ;
 ;
 QUIT  ; label LASTGVN
 ;
 ;
