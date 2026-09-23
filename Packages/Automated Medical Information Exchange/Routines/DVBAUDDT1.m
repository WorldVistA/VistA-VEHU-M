DVBAUDDT1 ;ALB/CP - UTL DVBDATE subroutines & extrinsics #1 ; 10/10/18 2:07pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           ^%DT   ; IA #10003
 ;    ^DD("DD"      ; IA #10017
 ;    $$FMADD^XLFDT ; IA #10103
 ;   $$FMDIFF^XLFDT ; IA #10103
 ;     $$FMTE^XLFDT ; IA #10103
 ;     $$FMTH^XLFDT ; IA #10103
 Q
 ;
DATE(DVBDATE,DVBTIME,DVBSECS,DVBFORMAT) ; Returns the DVBDATE in external DVBFORMAT.
 ;
 N DVBVAL
 ;
 ;
 S DVBFORMAT=$G(DVBFORMAT,0) ; DVBDEFAULT DVBDATE DVBFORMAT of MMM DD YYYY HH:MM:SS
 S DVBTIME=$G(DVBTIME,0) ; Defaults to returning DVBDATE w/o DVBTIME
 S DVBSECS=$G(DVBSECS,0) ; DVBDEFAULT to no seconds returned
 ;
 ; Set the appropriate DVBDATE based upon the DVBFORMAT parameter
 ;
 I DVBFORMAT=0 D  ; DVBDEFAULT
 . S DVBDATE=$$FMTE^XLFDT(DVBDATE) ; yyymmdd.hhmmss to MMM dd, yyyy@hh:mm:ss
 I DVBFORMAT=1 D  ; Override DVBDEFAULT DVBFORMAT (with MM/DD/YY)
 . S DVBDATE=$$FMTE^XLFDT(DVBDATE,"2Z") ;yyymmdd.hhmmss to MM/DD/YY@hh:mm:ss
 ;
 ;
 S DVBDATE=$TR(DVBDATE,"@"," ") ;........................ See step 1 above
 S:DVBFORMAT=0&(DVBDATE[",") DVBDATE=$E(DVBDATE,1,6)_$E(DVBDATE,8,$L(DVBDATE)) ; step 2
 I DVBSECS=0 D  ; Optionally does not return seconds
 . S DVBDATE=$P(DVBDATE,":",1,2) ;............................ step 3 above
 ;
 S DVBVAL=DVBDATE
 I DVBTIME=0 D  ; Strip off DVBTIME from the DVBDATE based upon DVBFORMAT
 . I DVBFORMAT=0 SET DVBVAL=$E(DVBVAL,1,11) ; Strip off DVBTIME: MMM DD YYYY
 . I DVBFORMAT=1 SET DVBVAL=$E(DVBVAL,1,8) ;. Strip off DVBTIME: MM/DD/YY
 ;
 QUIT DVBVAL ; DVBDATE
 ;
DAYSAGO(DVBDATE) ; Returns: DVBDATE (in external mm/dd/yy DVBFORMAT) and the
 ;
 N DVBDAYS,DVBDATEX
 ; ZEXCEPT: DT
 ;
 S DVBDATE=$P(DVBDATE,".")
 S DVBDATEX=$$FMTE^XLFDT(DVBDATE,"2Z") ; External DVBFORMAT mm/dd/yy
 ;
 ; Account for a DVBDATE that is yesterday or today
 I DVBDATE=DT S DVBDATEX=DVBDATEX_" (today)" QUIT DVBDATEX
 I DVBDATE=$$FMADD^XLFDT(DT,-1) D  Q DVBDATEX ;
 . S DVBDATEX=DVBDATEX_" (yesterday)"
 ;
 ; Account for a DVBDATE that is in the future
 I DVBDATE=$$FMADD^XLFDT(DT,1) D  Q DVBDATEX ;
 . S DVBDATEX=DVBDATEX_" (tomorrow)"
 I DVBDATE>$$FMADD^XLFDT(DT,1) D  Q DVBDATEX ;
 . S DVBDAYS=$$FMDIFF^XLFDT(DT,DVBDATE)*-1 ;Change negative to positive
 . S DVBDATEX=DVBDATEX_" (in "_DVBDAYS_" DAYS)"
 ;
 ; Account for a DVBDATE that is in the past
 I DVBDATE D  Q DVBDATEX ; Concatenate number of DVBDAYS ago
 . S DVBDATEX=DVBDATEX_" ("_$$FMDIFF^XLFDT(DT,DVBDATE)_" DVBDAYS ago)"
 ;
 ; Account for a DVBDATE that is the null string
 I DVBDATE="" S DVBDATE="<Empty>"
 ;
 Q DVBDATE ; DAYSAGO
 ;
DTBEG(DVBDTBEG) ; Return: Beginning DVBDATE for DVBDATE range search loop.
 ;
 I DVBDTBEG="" QUIT ""
 I $P(DVBDTBEG,".",2) Q $$FMADD^XLFDT(DVBDTBEG,0,0,0,-1) ; 1 sec ago
 Q $$FMADD^XLFDT(DVBDTBEG,-1)_.24 ; Day before at midnight ; DVBDTBEG
 ;
DTEND(DVBDTEND) ; Return: Maximum ending DVBDATE for DVBDATE range search loop.
 ;
 I DVBDTEND="" Q ""
 I $P(DVBDTEND,".",2) Q DVBDTEND_"99"  ;-> End DVBDATE/DVBTIME = DTMAX
 ;
 QUIT DVBDTEND_.24 ; End DVBDATE at midnight ; DVBDTEND
 ;
DTSOK(DVBDTBEG,DVBDTEND) ; Extrinsic Return: 1 if end DVBDATE => begin DVBDATE.
 ;
 N DVBVAL
 ;
 S DVBVAL=1
 I DVBDTEND<DVBDTBEG D  ;
 . W $C(7)
 . D CENTER^DVBAUDPRT1("Error:  From DVBDATE > To DVBDATE",2,80,1)
 . S DVBVAL=""
 ;
 Q DVBVAL ; DTSOK
 ;
GETDT(DVBPROMPT,DVBTYPE,DVBDEFAULT,DVBRESTRICT) ; DVBPROMPT for DVBDATE, & return array
 ;
 N @($$%DT^DVBAUDNEW1())
 ; ZEXCEPT: %DT,DVB2DTBEG,DVB2DTEND,DVBQUIT,Y
 ;
 S DVBQUIT=0
 ; Quit, if system DVBDATE for today (DT) is not defined, return DVBQUIT=1
 I $L($G(DT))'=7 S DVBQUIT=1 Q
 ;
 ; Get the DVBDEFAULT DVBDATE for presentation in the DVBPROMPT
 S DVBDEFAULT=$G(DVBDEFAULT)
 I DVBDEFAULT="CB" S DVBDEFAULT=$E(DT,1,3)_"0101"
 I DVBDEFAULT="CE" S DVBDEFAULT=$E(DT,1,3)_"1231"
 I DVBDEFAULT="FB" S DVBDEFAULT=$E(DT,1,3)-$S($E(DT,4,5)<10:1,1:"")_"1001"
 I DVBDEFAULT="FE" S DVBDEFAULT=$E(DT,1,3)+$S($E(DT,4,5)>9:1,1:"")_"0930"
 I DVBDEFAULT="T" S DVBDEFAULT=DT
 ;
 ; Setup call to FM utility ^%DT to DVBPROMPT for DVBDATE
 ;
 S %DT("A")=$G(DVBPROMPT) ; Set DVBDATE prompting text
 S %DT="AE" ; (A)sk (E)cho
 I $G(DVBRESTRICT)["F" S %DT=%DT_"F" ; (F)uture dates are assumed
 I $G(DVBRESTRICT)["P" D  ; (P)ast dates are assumed
 . S %DT=%DT_"P" ;... (P)ast dates are assumed
 . S %DT(0)="-"_DT ;.  Up to and including today
 I $G(DVBRESTRICT)["R" S %DT=%DT_"R" ; (R)equires DVBTIME
 I %DT'["R" S %DT=%DT_"T" ;(T)ime allow but not required
 I %DT'["R",%DT'["S",%DT'["T" S %DT=%DT_"T" ;(T)ime allow but not required
 I $G(DVBRESTRICT)["S" S %DT=%DT_"S" ; (S)econds should be returned
 I DVBDEFAULT S Y=DVBDEFAULT X ^DD("DD") S %DT("B")=Y
 ;
 D ^%DT I Y<1 S DVBQUIT=1 Q
 ;
 ; Populate either DVB2DTBEG or DVB2DTEND output array, depends on DVBTYPE
 I $G(DVBTYPE)'="E" S DVBTYPE="B" ; Set DVBTYPE DVBDEFAULT
 ;
 I DVBTYPE="B" D  ; Begin DVBDATE
 . S DVB2DTBEG("I")=Y
 . S DVB2DTBEG("$H")=$$FMTH^XLFDT(DVB2DTBEG("I"))
 . S DVB2DTBEG("E")=$$DATE(DVB2DTBEG("I"),1,$S(%DT["S":1,1:0))
 . W "   ",DVB2DTBEG("E") ; Echo DVBDATE in external DVBFORMAT
 ;
 I DVBTYPE="E" D  ; End   DVBDATE
 . S DVB2DTEND("I")=Y
 . S DVB2DTEND("$H")=$$FMTH^XLFDT(DVB2DTEND("I"))
 . S DVB2DTEND("E")=$$DATE(DVB2DTEND("I"),1)
 . W "   ",DVB2DTEND("E") ; Echo DVBDATE in external DVBFORMAT
 ;
 Q  ; GETDT
 ;
GETDTS(DVBDATETXT) ; DVBPROMPT user for DVBDATE range
 ;
GETDTS1  ; Branch to this label upon errors found below
 ;
 ; Refresh output
 S DVBQUIT=0 ; End DVBDATE might set DVBQUIT=1; then repeat Begin DVBDATE
 K DVB2DTBEG,DVB2DTEND
 ;
 W !!,"Enter "_DVBDATETXT_" range"
 D GETDT("    Begin date: ","B") Q:DVBQUIT
 D GETDT("      End date: ","E") G:DVBQUIT GETDTS1
 I '$$DTSOK(DVB2DTBEG("I"),DVB2DTEND("I")) G GETDTS1
 ;
 S DVB2DTBEG=$$DTBEG(DVB2DTBEG("I"))
 S DVB2DTEND=$$DTEND(DVB2DTEND("I"))
 ;
 Q  ; GETDTS   
