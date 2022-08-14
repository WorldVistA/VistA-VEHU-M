SDESUTIL ;ALB/MGD/TAW,KML,LAB - SDES Utilities ;April 22, 2022
 ;;5.3;Scheduling;**801,804,805,814,816,818**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to INSTITUTION in #2251
 ; Reference to KERNEL SYSTEM PARAMETERS in #1518
 Q
 ;
PADCLTIME(TIME) ;
 ; TIME - Time to Pad
 S TIME=$S($G(TIME)'="":TIME,1:8)
 I TIME'?1.2N Q -1
 S TIME=TIME_"00"
 Q TIME
 ;
PADFMTIME(TIME) ;
 ; TIME - Time to Pad
 I TIME'?1.4N Q -1
 S TIME=$E(TIME_"0000",1,4)
 Q TIME
 ;
PADLENGTH(STRING,CHAR,LENGTH,WHERE) ;
 N PAD,PADST
 I $L(STRING)'<LENGTH Q STRING
 S PADST=LENGTH-$L(STRING)
 S $P(PAD,CHAR,PADST)=CHAR
 I WHERE="F" S STRING=PAD_STRING
 I WHERE="E" S STRING=STRING_PAD
 Q STRING
 ;
EASVALIDATE(SDEAS) ;
 I SDEAS="" S SDEAS=-1 Q SDEAS
 S SDEAS=$$STRIP^SDEC07(SDEAS)
 I $L(SDEAS)>40 S SDEAS=-1
 Q SDEAS
 ;
ISDATEDST(DATE,DSTSUM) ;Does this date use Daylight Savings
 ; DATE -    FM format
 ; DSTSUM - "DST" or "SUM"
 ; Return 1 = DATE is considered DST or SUM.
 ;        0 = DATE is not DST and not SUM
 ;       -1 = DATE is not FM format
 N YR
 S DATE=$G(DATE),DSTSUM=$G(DSTSUM)
 I '$$VALIDFMFORMAT^SDECDATE(DATE) Q -1
 S YR=$E(DATE,2,3)
 I DATE<$$DSTSTART(YR,DSTSUM) Q 0
 I DATE>$$DSTEND(YR,DSTSUM) Q 0
 Q 1
DSTSTART(YR,DSTSUM) ;Daylight Savings or Summer start date
 ; countries that observe DST or Summer ST (e.g., USA observes DST and Europe observes SUM ST)
 ; YR - 2 digit year
 ; DSTSUM - "DST" or "SUM"
 ; Return is the FM date for the FIRST day of DST or SUM
 N DSTMONTH,DOW,DSTDT,SUNDAY
 S DSTMONTH="0301",DSTSUM=$G(DSTSUM)
 ; SUNDAY will be 2nd Sunday in March OR Last Sunday in March
 S SUNDAY=$S(DSTSUM="DST":2,DSTSUM="SUM":"4,5",1:2) ;if not DST or SUM, treat as DST
 S YR=$G(YR)
 I YR="" S DSTDT=$E(DT,1,3)_DSTMONTH
 E  S DSTDT=$E(DT)_YR_DSTMONTH
 S DOW=$$DOW^XLFDT(DSTDT,1)
 I DOW D
 .I DSTSUM="DST" S DSTDT=DSTDT+(SUNDAY*7)-DOW
 .E  S DSTDT=$$SUMMER(DSTDT,DOW,SUNDAY)
 Q DSTDT
DSTEND(YR,DSTSUM) ;Daylight Savings END date
 ; YR - 2 digit year
 ; DSTSUM - "DST" or "SUM"
 ; Return is the FM date for the LAST day of DST or SUM
 N DSTMONTH,DOW,DSTDT,SUNDAY
 S DSTSUM=$G(DSTSUM)
 S DSTMONTH=$S(DSTSUM="DST":"1101",DSTSUM="SUM":"1001",1:"1101")
 ; SUNDAY will be first Sunday in November or last Sunday in October
 S SUNDAY=$S(DSTSUM="DST":1,DSTSUM="SUM":"4,5",1:1)  ; if not DST or SUM treat as DST
 S YR=$G(YR)
 I YR="" S DSTDT=$E(DT,1,3)_DSTMONTH
 E  S DSTDT=$E(DT)_YR_DSTMONTH
 S DOW=$$DOW^XLFDT(DSTDT,1)
 I DOW D
 .I DSTSUM="DST" S DSTDT=DSTDT+(SUNDAY*7)-DOW
 .E  S DSTDT=$$SUMMER(DSTDT,DOW,SUNDAY)
 Q $$FMADD^XLFDT(DSTDT,-1)
 ;
SUMMER(DSTDT,DOW,SUNDAY) ; determine last Sunday of MARCH or OCTOBER
 ; DSTDT - March or October (e.g, CYY0301 or CYY1001)
 ; DOW - 1, 2, 3, 4, 5, or 6
 ; SUNDAY - "4,5" representing 4th or 5th Sunday of March or October
 ; Returns the date when SUMMER offset begins or ends (e.g., eastern europe uses Summer offset)
 N X,VALIDSUNDAY,LASTSUNDAY
 S DSTDT=$G(DSTDT),DOW=$G(DOW),SUNDAY=$G(SUNDAY)
 S LASTSUNDAY=0
 F X=1,2 S VALIDSUNDAY=DSTDT+($P(SUNDAY,",",X)*7)-DOW I $$VALIDFMFORMAT^SDECDATE(VALIDSUNDAY) S LASTSUNDAY=VALIDSUNDAY
 Q LASTSUNDAY
 ;
TIMEZONEDATA(CLINICIEN) ;Get timezone and offsets
 ; CLINIC - IEN from Hospital Location #44
 ;    If clinic is not passed, use default Facility/Institution
 ; Output:
 ;   Returns TimeZone Name ^ TimeZone IEN ^ TimeZone Exception ^ Offset for Standard Time ^ Offset for DST or SUMMER ^
 N SDINST,SDDIV,SDTIMEZONEE,SDTIMEZONEI,TIMEZONEEXECPT,X,POP,TIMEFRAMEARY,OFFSET,OFFSETDSTSUM,DSTSUM,RETURN,TIMEFRAMEIEN,SDMSG
 N EXECPTFLG
 S (POP,SDINST,DSTSUM,EXECPTFLG)="",(OFFSET,OFFSETDSTSUM)=-9999
 I $G(CLINICIEN) D
 .S SDDIV=$$GET1^DIQ(44,CLINICIEN_",",3.5,"I")
 .S:SDDIV SDINST=$$GET1^DIQ(40.8,SDDIV_",",.07,"I")
 I SDINST="" S SDINST=$$GET1^DIQ(8989.3,1,217,"I")
 S SDTIMEZONEE=$$GET1^DIQ(4,SDINST,800,"E")
 S SDTIMEZONEI=$$GET1^DIQ(4,SDINST,800,"I")
 S EXECPTFLG=$$GET1^DIQ(4,SDINST,802,"I")
 S TIMEZONEEXECPT=$S(EXECPTFLG=0:1,1:0) ;if except value = 0 then exception is present
 ;
 F X=1:1:3 D  Q:POP
 .S TIMEFRAMEIEN=X_","_SDTIMEZONEI_","
 .D GETS^DIQ(1.711,TIMEFRAMEIEN,".01;.02","IE","TIMEFRAMEARY","SDMSG") ;Data from WORLD TIMEZONE file
 .I '$D(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.01)) S POP=1 Q
 .I $G(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.01,"I"))="SST" S OFFSET=$G(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.02,"E"))
 .I $G(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.01,"I"))="DST" S DSTSUM="DST",OFFSETDSTSUM=$G(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.02,"E")) ;vse-2705
 .I $G(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.01,"I"))="SUM" S DSTSUM="SUM",OFFSETDSTSUM=$G(TIMEFRAMEARY(1.711,TIMEFRAMEIEN,.02,"E")) ;vse-2705
 ;
 Q SDTIMEZONEE_"^"_SDTIMEZONEI_"^"_TIMEZONEEXECPT_"^"_OFFSET_"^"_OFFSETDSTSUM_"^"_DSTSUM  ;vse-2705
 ;
GETTZOFFSET(SDDATE,SDCLINIC) ;Get Time Zone offset based on clinic and daylight savings
 ; SDCLINIC - OPT - IEN from Hospital Location #44
 ; SDDATE   - REQ - FM fomatted date
 ; Return
 ;   If clinic is passed in get Division then Instution
 ;   Otherwise get Instution from Kernel System Parameters
 ;   Get the Time Zone and Time Zone Exception from the Instution
 N OFFSET,TZINFO
 S SDDATE=$G(SDDATE)
 I '$$VALIDFMFORMAT^SDECDATE(SDDATE) Q ""
 S SDCLINIC=$G(SDCLINIC)
 S TZINFO=$$TIMEZONEDATA(SDCLINIC)
 S OFFSET=$P(TZINFO,"^",4)   ;assume non DST
 ; If the Institution uses DST or SUMMER & SDDATE is in the daylight savings period, then send the DST/SUMMER Offset
 I $P(TZINFO,"^",3)=0 S OFFSET=$S($$ISDATEDST(SDDATE,$P(TZINFO,"^",6)):$P(TZINFO,"^",5),1:OFFSET)
 Q OFFSET
