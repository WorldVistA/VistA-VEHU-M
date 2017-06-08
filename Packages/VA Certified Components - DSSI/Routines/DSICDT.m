DSICDT ;DSS/SGM - DATE FUNCTION RPCS ;03/18/2005 15:31
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#  Supported References
 ;-----  --------------------------------------
 ; 2054  DT^DILF
 ;10104  UP^XLFSTR
 ;10103  ^XLFDT: FMTE,FMTH,FMTHL7,HL7TFM,HTFM
 ;
 ;Take a date.time in any format, return date.time in another format
 ;  FUN - opt - if +$G(FUN) then extrinsic function, else RPC call
 ;INVAL - req - input value to be converted
 ; if inval contains an alpha character then always assume input is in
 ; external format.  See notes at end of routine for detailed
 ; explanation of acceptable external input values
 ;
 ;INTYPE - opt - ONLY IF INVAL contains an alpha char or contains /
 ; Else, required. Usually it is a single character.  If two chars,
 ; then it must consist of I and one of the 1st 6 below:
 ; plus "I".  If INVAL="I" then assume INVAL in external format.
 ; Following codes specific INVAL format:
 ;  D - Delphi format           F - FM format
 ;  E - Human readable format   M - M format ($H)
 ;  H - HL7 format              G - UCT format
 ;  I - Internationalized format, i.e., the day number precedes the
 ;      month number
 ;  S - Draeger-Saturn time format
 ;
 ;OUTYPE - opt - default value is FM format "F"
 ; A string of characters designating output format(s)
 ; If OUTYPE contains
 ;  F - return FM format         D - return Delphi format
 ;  E - return human readable    M - return M format ($H)
 ;  A - return all formats       H - return HL7 format
 ;  G - return UCT format
 ;
 ;OUTFMT - opt - this param controls the format of the returned
 ; value for external date value only.  OUTFMT can contain only a
 ; single digit plus optional alpha characters.
 ; OUTFMT = "" - mmm dd, yyyy@hh:mm:ss - default
 ; If OUTFMT contains
 ;  1 -  mmm dd, yyyy@hh:mm:ss - default
 ;  [2-7 have no leading zeros]
 ;   2 -  mm/dd/yy@hh:mm:ss    5 -  mm/dd/yyyy@hh:mm:ss
 ;   3 -  dd/mm/yy@hh:mm:ss    6 -  dd/mm/yyyy@hh:mm:ss
 ;   4 -  yy/mm/dd@hh:mm:ss    7 -  yyyy/mm/dd@hh:mm:ss
 ;   5 -  mm/dd/yyyy@hh:mm:ss
 ;  D -  return date only
 ;  F -  output with leading blanks
 ;  S -  force seconds in outputs
 ;  Z -  pad months and days with leading zeros
 ;  P -  output time in ' hh:mm:ss am/pm'
 ;
 ;TIMEFMT - opt - default to M - controls what portion of the time
 ; part of the date will be returned
 ; TIMEFMT = H - hrs only   M - hr:min   S - hr:min:sec
 ;
 ;RETURN DSIC
 ;if OUTYPE is a single character, not equal to A, then return a
 ; single date.time value in the specified format.
 ;If OUTYPE is equal to A or is more than one character, then return
 ; a string in the format p1^p2^p3^p4^p5^p6  where
 ; p1 = Delphi format       p4 = int M format ($H)
 ; p2 = FM format           p5 = HL7 format
 ; p3 = human readable      p6 = UCT format
 ;Only those pieces requested will be returned
 ; If problems encountered, return the word ERR
 ; NOTES: -1 is a valid return value for an internal Delphi date.time
 ; Thus any problems encountered, then "ERR^message" will be returned.
 ; Not every ERR return value will have a message as many of the Kernel
 ; and Fileman date utilities only return a value of -1 if any problems
 ; encountered with no further explanation
 ;
 ;Notes on INVAL param
 ;1. If a two-digit year is entered, a year less than 20 years in the
 ;   future and no more than 80 years in the past is assumed. For
 ;   example, in the year 2000, two-digit years are assumed to be
 ;   between 1920 through 2019. 
 ;2. For Internationalization, this assumes that in the input, the day
 ;   number precedes the month number. For example, input of 05/11/2000
 ;   is assumed to be November 5, 2000 (instead of May 11, 2000). Also,
 ;   with this flag, the month must be input as a number. For example,
 ;   November must be input as 11, not NOV.
 ;3. To simplify entering dates, you can use shortcuts such as T for
 ;   today, T-1 for yesterday, or T+1 for tomorrow. Or you can combine
 ;   T with D for day, W for week, M for month, or Y for year; T-2D
 ;   means two days ago, T+1W means today plus one week, T+4M means four 
 ;   months from today, and T-3Y means three years ago from today.
 ;4. For time input, to be totally unambiguous, time can be as military
 ;   time (four or six digits, no colon), hour AM/PM, hour:minute AM/PM,
 ;   or hour:minute:second AM/PM. If you do omit an AM/PM notation, the
 ;   following assumptions are made:
 ;   a. If you enter a single digit for the hour, a time between 6AM
 ;      and 6PM is used. Thus, T@330 (or T@3:30) means today at 3:30 PM
 ;      and T@945 (or T@9:45) means today at 9:45 AM.
 ;   b. If you enter two digits for the hour, the actual hour entered is
 ;      used (as if military time were being used). Thus, T@0330 (or
 ;      T@03:30) means today at 3:30 AM.
 ;   c. As with dates, there are supported abbreviations you can use
 ;      when entering times in DATE/TIME fields.
 ;      1) To enter the present moment, you can enter the word NOW
 ;      2) To enter an hour from the present moment, enter NOW+1H
 ;      3) To enter an hour ago from the present moment, enter NOW-1H
 ;      4) You can also combine NOW with D for day, M for month, and
 ;         ' (apostrophe) for minute (NOW+3' for present time plus 3
 ;         minutes.
 ;      5) And you can enter MID for 12 a.m. and NOON for 12 p.m.
 ;
CNVT(DSIC,INVAL,INTYPE,OUTYPE,OUTFMT,TIMEFMT,FUN) ;
 ; RPC: DSIC DATE CONVERT
 N %,%H,%I,%T,X,Y,Z,DATE,DTOUT,DUOUT,TIME,RET,VAL
 F Z="INVAL","INTYPE","OUTYPE","OUTFMT","TIMEFMT" D
 .S @Z=$G(@Z) S:@Z?.E1L.E @Z=$$UP^XLFSTR(@Z)
 .Q
 I INVAL="" D ERR(1) G OUT
 I INTYPE="S",INVAL'?4N1"-"2N1"-"2N1"T"2N1":"2N.E D ERR(9) G OUT
 I INTYPE'="S",INVAL?.E1U.E!(INVAL["/") S INTYPE="E"
 S:OUTYPE="" OUTYPE="F" S:OUTYPE["A" OUTYPE="DEFGHM"
 I INTYPE="" D ERR(2) G OUT
 S:INTYPE="I" INTYPE="EI"
 I INTYPE'?1.2U D ERR(3) G OUT
 I INTYPE?2U,$S(INTYPE'["I":1,1:"EGH"'[$TR(INTYPE,"I")) D ERR(3) G OUT
 S X=TIMEFMT,TIMEFMT=$S(X="H":10,X="M":12,X="S":14,1:12)
 I $TR(OUTYPE,"DEFGHM")'="" D ERR(4) G OUT
 I $TR(OUTFMT,"1234567DFPSZ")'="" D ERR(8) G OUT
 ;  now start conversion - first convert to Fileman format
 S (RET,VAL)=""
 I "EFS"[INTYPE D  G:$D(DSIC) OUT
 .I INTYPE="S" S INVAL=$$SATURN
 .S Y=$$ETFM(INVAL)
 .I Y=-1 S DSIC="ERR" Q
 .S VAL=$$TIMEFMT(+Y),$P(RET,U,2)=VAL
 .Q
 I INTYPE["M" D  G:$D(DSIC) OUT
 .I INVAL'?1.5N,INVAL'?1.5N1","1.5N D ERR(5) Q
 .S VAL=$$TIMEFMT($$HTFM^XLFDT(INVAL))
 .S $P(RET,U,2)=VAL,$P(RET,U,4)=INVAL
 .Q
 I INTYPE["H" D  G:$D(DSIC) OUT
 .I INVAL'?8N,INVAL'?8N1"-"1.4N,INVAL'?8N1"+"1.4N D ERR(6) Q
 .S VAL=$$TIMEFMT($$HL7TFM^XLFDT(INVAL,"L"))
 .S $P(RET,U,2)=VAL,$P(RET,U,5)=INVAL
 .Q
 I INTYPE["D" D  G:$D(DSIC) OUT
 .S X=$$DTH(INVAL) I X="" D ERR(7) Q
 .S $P(RET,U,4)=X,$P(RET,U)=INVAL
 .S VAL=$$TIMEFMT($$HTFM^XLFDT(X)),$P(RET,U,2)=VAL
 .Q
 ; return a single date.time value if OUTYPE is a single character
 I OUTYPE["D",$P(RET,U)="" S $P(RET,U)=$$FMTD(VAL)
 I OUTYPE["M",$P(RET,U,4)="" S $P(RET,U,4)=$$FMTH^XLFDT(VAL)
 I OUTYPE["H",$P(RET,U,5)="" S $P(RET,U,5)=$$FMTHL7^XLFDT(VAL)
 I OUTYPE["E",$P(RET,U,3)="" S $P(RET,U,3)=$$FMTE^XLFDT(VAL,OUTFMT)
 I $L(OUTYPE)>1 S DSIC=RET
 E  S X=$F("DFEMHG",OUTYPE)-1 S:X>0 DSIC=$P(RET,U,X)
 S:'$D(DSIC) DSIC="ERR"
OUT Q:+$G(FUN) DSIC
 Q
 ;
 ; --------------- Delphi Conversions ------------------
 ; day zero M - $H: 12/31/1840   $H = 0
 ; day zero Delphi: 12/30/1899   $H = 21548
DCK(X) ; check to see if X is in proper Delphi format
 ; return 1 if X in in proper format, else return 0
 S:X<0 X=-X
 Q $S(X?5N:1,X?5N1"."1.N:1,1:0)
 ;
DTFM(X) ; convert Delphi to FM
 ; return FM date.time   Return "" for any problems
 Q $S($$DCK(X):$$HTFM^XLFDT($$DTH(X)),1:"")
 ;
DTH(X) ; convert Delphi date to $H format
 ; return $H date.time or else return ""
 Q $S($$DCK(X):(X\1+21548)_","_(X#1*86400+.5\1),1:"")
 ;
ETFM(X,FLAGS,LIMIT) ; convert external format to FM
 ;     X - opt - external date.time value [default to NOW]
 ; FLAGS - opt - see FLAGS for DT^DILF [default to ET]
 ; LIMIT - opt - FM date.time - if positive, then X'<LIMIT
 ;               if negative then X'>LIMIT
 ; Return: if FLAGS["E" return FM date.time ^ external date.time
 ;         if FLAGS'["E return FM date.time
 ;         if invalid return -1
 N Y,Z,DIERR,DSI,DSIER
 I $G(X)="" S X="NOW"
 S Z=$G(FLAGS)
 I Z="" S Z="ET"_$E("S",TIMEFMT=14)
 I X[":" S:Z'["T" Z=Z_"T" I $L(X,":")>2,Z'["S" S Z=Z_"S"
 S FLAGS=Z,LIMIT=$G(LIMIT) I $L(LIMIT),LIMIT'?7N.1".".N S LIMIT=""
 D DT^DILF(Z,X,.DSI,LIMIT,"DSIER") S Y=DSI
 I Y<1!(FLAGS'["E")!'$D(DSI(0)) Q Y
 Q Y_U_$P(DSI(0),":",1,$S(TIMEFMT=10:1,TIMEFMT=12:2,1:3))
 ;
FMTD(X) ; convert FM to Delphi
 ; return delphi date.time, else return ""
 Q $$HTD($$FMTH^XLFDT(X))
 ;
HTD(X) ; convert $H date to internal Delphi format
 N Y S Y=$P(X,",",2) S:Y=0 Y=""
 I Y S Y=$E(Y/86400,1,7) I $L(Y)=7 S Y=$E(Y+.000005,1,6)
 Q (X-21548)_Y
 ;
ERR(L) ; S DSIC=Error type
 N X S L=+$G(L)
 I L=1 S X="^No input value received"
 I L=2 S X="^No input value format received"
 I L=3 S X="^Invalid input value format: "_INTYPE
 I L=4 S X="^Invalid output format received: "_OUTYPE
 I L=5 S X="^Invalid internal M date format received: "_INVAL
 I L=6 S X="^Invalid HL7 date received: "_INVAL
 I L=7 S X="^Invalid Delphi date received: "_INVAL
 I L=8 S X="^Invalid output format received: "_OUTFMT
 I L=9 S X="^Invalid Saturn date-time received: "_INVAL
 S DSIC="ERR^"_X
 Q
 ;
SATURN() ;  convert saturn date.time to external date.time format
 N X,Y S X=INVAL
 S X=$P(X,"-",2)_"/"_$P($P(X,"-",3),"T")_"/"_$P(X,"-")
 S Y=$P($P(INVAL,"T",2),".")
 I Y'="00:00:00" S X=X_"@"_Y
 Q X
 ;
TIMEFMT(X) ;  for a FM date.time fix time portion if needed
 Q $E(X,1,TIMEFMT)
