SDES2SEARCHSLOTS ;ALB/BLB - SDES2 SEARCH CLINIC SLOTS ;Jan 25, 2025
 ;;5.3;Scheduling;**897,899**;Jan 25, 2025@8:05pm 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
SEARCH(JSON,SDCONTEXT,SEARCH) ;
 N ERRORS,WEEKDAYS,NUMBEROFAPPTS,RECURRING,OCCURRING,MATCHINGSLOTS,FREQUENCY,SLOTS,CONSECUTIVEDAYS,STARTDATE
 ;
 D VALIDATE(.ERRORS,.SDCONTEXT,.SEARCH,.WEEKDAYS,.RECURRING,.OCCURRING,.NUMBEROFAPPTS,.FREQUENCY,.STARTDATE)
 I $D(ERRORS) S ERRORS("slotSearch",1)="" D BUILDJSON^SDESBUILDJSON(.JSON,.ERRORS) Q
 ;
 D GETSLOTS(.SLOTS,$G(SEARCH("AM OR PM")),$G(SEARCH("LENGTH")),.SEARCH)
 D CONSECUTIVEDAYS(.CONSECUTIVEDAYS,.FREQUENCY,.WEEKDAYS,.RECURRING,.OCCURRING,$O(SEARCH("WEEKDAY",""),-1),.STARTDATE,$$ISOTFM^SDAMUTDT($G(SEARCH("START DATE"))))
 D MATCHSLOTS(.MATCHINGSLOTS,.CONSECUTIVEDAYS,.SLOTS,.NUMBEROFAPPTS)
 ;
 I '$D(MATCHINGSLOTS) S MATCHINGSLOTS("slotSearch",1)=""
 D BUILDJSON^SDES2JSON(.JSON,.MATCHINGSLOTS)
 Q
 ;
MATCHSLOTS(MATCHINGSLOTS,CONSECUTIVEDAYS,SLOTS,NUMBEROFAPPTS) ;
 N SLOTSTART,CONSECUTIVEDAY,CLINICIEN,MATCHINGDATE,RESULTCOUNT,MATCHCOUNT,PARTIALMATCHES,MISS,DEAD
 ;
 S CLINICIEN=0
 F  S CLINICIEN=$O(SLOTS(CLINICIEN)) Q:'CLINICIEN  K RESULTCOUNT  D
 .;
 .S CONSECUTIVEDAY=0
 .F  S CONSECUTIVEDAY=$O(CONSECUTIVEDAYS(CONSECUTIVEDAY)) Q:'CONSECUTIVEDAY!($G(RESULTCOUNT)=10)  D
 ..;
 ..S SLOTSTART=CONSECUTIVEDAY K PARTIALMATCHES
 ..F  S SLOTSTART=$O(SLOTS(CLINICIEN,SLOTSTART)),MATCHCOUNT=0 Q:'SLOTSTART!($P(SLOTSTART,".")>CONSECUTIVEDAY)!($G(RESULTCOUNT)=10)  D
 ...;
 ...S MATCHINGDATE=$$FMADD^XLFDT(CONSECUTIVEDAY,-1),MISS=0,DEAD=0
 ...F  S MATCHINGDATE=$O(CONSECUTIVEDAYS(MATCHINGDATE))_"."_$P(SLOTSTART,".",2) Q:'MATCHINGDATE!($G(MATCHCOUNT)=NUMBEROFAPPTS)!(DEAD)  D
 ....;
 ....I $D(SLOTS(CLINICIEN,MATCHINGDATE)) D  Q
 .....S RESULTCOUNT=$O(MATCHINGSLOTS("slotSearch",CLINICIEN,"result",""),-1)+1
 .....D BUILDMATCHES(.MATCHINGSLOTS,.PARTIALMATCHES,.MATCHCOUNT,.RESULTCOUNT,MATCHINGDATE,NUMBEROFAPPTS,CLINICIEN)
 ....;
 ....I '$G(MISS) S MISS=1 Q
 ....S DEAD=1
 Q
 ;
CONSECUTIVEDAYS(CONSECUTIVEDAYS,FREQUENCY,WEEKDAYS,RECURRING,OCCURRING,WEEKDAYCOUNT,DATE,STARTDATE) ;
 N WEEKCOUNT,KEPTLASTDATE,SKIPPEDLASTDATE,FIRSTWEEKMATCHES,FIRSTMONTHMATCH,WEEKS,VARIABLELENGTH,WEEKDAYOFFSET,LASTDAYFIRSTWEEK
 ;
 S FIRSTWEEKMATCHES=0,FIRSTMONTHMATCH=0,SKIPPEDLASTDATE=0,KEPTLASTDATE=0,LASTDAYFIRSTWEEK=0
 S LASTDAYFIRSTWEEK=$$FMADD^XLFDT(STARTDATE,6-$$FMTH^XLFDT(STARTDATE)+3#7)
 S DATE=$E(DATE,1,5)_"01"
 S DATE=$S(FREQUENCY="DAILY":$$FMADD^XLFDT(STARTDATE,-RECURRING),FREQUENCY="WEEKS":$$FMADD^XLFDT(STARTDATE,-1),1:$$FMADD^XLFDT(DATE,-1))
 F  S DATE=$$FMADD^XLFDT(DATE,$S(FREQUENCY="DAILY":RECURRING,1:1)) Q:DATE>=$$FMADD^XLFDT(STARTDATE,390)  D
 .;
 .I FREQUENCY="DAILY" S CONSECUTIVEDAYS(DATE)="" Q
 .I '$D(WEEKDAYS($$FMTH^XLFDT(DATE)+4#7)) Q
 .;
 .S WEEKCOUNT=$O(WEEKS($E(DATE,2,3),$E(DATE,4,5),$$DOW^XLFDT(DATE),""),-1)+1
 .S WEEKS($E(DATE,2,3),$E(DATE,4,5),$$DOW^XLFDT(DATE),WEEKCOUNT)=DATE
 .;
 .I WEEKCOUNT'=$G(OCCURRING),FREQUENCY'="WEEKS" Q
 .;
 .I FREQUENCY="MONTHS",FIRSTMONTHMATCH<WEEKDAYCOUNT D  Q
 ..S CONSECUTIVEDAYS(DATE)=""
 ..S FIRSTMONTHMATCH=FIRSTMONTHMATCH+1
 .;
 .I FREQUENCY="WEEKS",DATE'>LASTDAYFIRSTWEEK D  Q
 ..S CONSECUTIVEDAYS(DATE)=""
 .;
 .I WEEKDAYCOUNT*(RECURRING-1)>SKIPPEDLASTDATE D  Q
 ..S SKIPPEDLASTDATE=SKIPPEDLASTDATE+1 Q
 .;
 .S KEPTLASTDATE=KEPTLASTDATE+1
 .I KEPTLASTDATE=WEEKDAYCOUNT D
 ..S KEPTLASTDATE=0,SKIPPEDLASTDATE=0
 .;
 .S CONSECUTIVEDAYS(DATE)=""
 Q
 ;
GETSLOTS(SLOTS,AMPM,LENGTH,SEARCH) ;
 N CLINCOUNT,CLINICIEN,SLOTCOUNT,SLOTSTART,CLINICLENGTH,VARIABLELENGTH
 ;
 S CLINCOUNT=0
 F  S CLINCOUNT=$O(SEARCH("CLINIC IEN",CLINCOUNT)) Q:'CLINCOUNT  D
 .;
 .S CLINICIEN=$G(SEARCH("CLINIC IEN",CLINCOUNT))
 .S CLINICLENGTH=$$GET1^DIQ(44,CLINICIEN,1912,"I")
 .S VARIABLELENGTH=$$GET1^DIQ(44,CLINICIEN,1913,"I")
 .;
 .I LENGTH'=CLINICLENGTH,VARIABLELENGTH'="V" Q
 .I LENGTH'=CLINICLENGTH,VARIABLELENGTH="V",LENGTH#CLINICLENGTH'=0 Q
 .;
 .K @$NA(^TMP($J,"SLOTSEARCH"))
 .D GETSLOTS^SDEC57($NA(^TMP($J,"SLOTSEARCH")),$$GETRES^SDES2UTIL1(CLINICIEN),SEARCH("START DATE"),$$FMADD^XLFDT($$ISOTFM^SDAMUTDT(SEARCH("START DATE"),CLINICIEN),390))
 .;
 .S SLOTCOUNT=0
 .F  S SLOTCOUNT=$O(^TMP($J,"SLOTSEARCH",SLOTCOUNT)) Q:'SLOTCOUNT  D
 ..;
 ..S SLOTSTART=+$P($G(^TMP($J,"SLOTSEARCH",SLOTCOUNT)),U,2)
 ..I $L(AMPM),AMPM'=$S($P(SLOTSTART,".")_.12>SLOTSTART:"AM",1:"PM")!($P($G(^TMP($J,"SLOTSEARCH",SLOTCOUNT)),U,4)'>0) Q
 ..;
 ..I '$P(SLOTSTART,".",2) D
 ...S SLOTSTART=SLOTSTART_".0001"
 ..;
 ..S SLOTS(CLINICIEN,SLOTSTART)=""
 Q
 ;
BUILDMATCHES(MATCHINGSLOTS,PARTIALMATCHES,MATCHCOUNT,RESULTCOUNT,MATCHINGDATE,NUMBEROFAPPTS,CLINICIEN) ;
 N MIDNIGHT,CLINICNAME
 ;
 S CLINICNAME=$$GET1^DIQ(44,CLINICIEN,.01)
 S MATCHCOUNT=$G(MATCHCOUNT)+1
 S PARTIALMATCHES("slotSearch",CLINICIEN,"result",RESULTCOUNT,"apptDateTime",MATCHCOUNT)=$$FMTISO^SDAMUTDT(MATCHINGDATE,CLINICIEN)
 ;
 I $P($P(PARTIALMATCHES("slotSearch",CLINICIEN,"result",RESULTCOUNT,"apptDateTime",MATCHCOUNT),":",2),"-")="01" D
 .S MIDNIGHT=$P(PARTIALMATCHES("slotSearch",CLINICIEN,"result",RESULTCOUNT,"apptDateTime",MATCHCOUNT),":")
 .S MIDNIGHT=MIDNIGHT_":00-"_$P(PARTIALMATCHES("slotSearch",CLINICIEN,"result",RESULTCOUNT,"apptDateTime",MATCHCOUNT),"-",4)
 .S PARTIALMATCHES("slotSearch",CLINICIEN,"result",RESULTCOUNT,"apptDateTime",MATCHCOUNT)=MIDNIGHT
 ;
 I MATCHCOUNT=NUMBEROFAPPTS D
 .M MATCHINGSLOTS=PARTIALMATCHES K PARTIALMATCHES
 .S MATCHINGSLOTS("slotSearch",CLINICIEN,"defaultProvider")=$$DEFAULTPROVIDER(CLINICIEN)
 .S MATCHINGSLOTS("slotSearch",CLINICIEN,"clinicName")=CLINICNAME
 .S MATCHINGSLOTS("slotSearch",CLINICIEN,"clinicIen")=CLINICIEN
 Q
 ;
DEFAULTPROVIDER(CLINICIEN) ;
 N PROVIDERIEN,DEFAULTPROVIEN
 ;
 S PROVIDERIEN=0,DEFAULTPROVIEN=""
 F  S PROVIDERIEN=$O(^SC(CLINICIEN,"PR",PROVIDERIEN)) Q:'PROVIDERIEN!($G(DEFAULTPROVIEN))  D
 .I $$GET1^DIQ(44.1,PROVIDERIEN_","_CLINICIEN_",",.02,"I") S DEFAULTPROVIEN=$$GET1^DIQ(44.1,PROVIDERIEN_","_CLINICIEN_",",.01,"I")
 Q $$GET1^DIQ(200,DEFAULTPROVIEN,.01,"E")
 ;
VALIDATE(ERRORS,SDCONTEXT,SEARCH,WEEKDAYS,RECURRING,OCCURRING,NUMBEROFAPPTS,FREQUENCY,STARTDATE) ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) Q
 ;
 D VALIDATECLINIC(.ERRORS,.SEARCH)
 D VALIDATELENGTH(.ERRORS,.SEARCH)
 D VALIDATENUMAPPTS(.ERRORS,.SEARCH,.NUMBEROFAPPTS)
 D VALIDATEFREQUENC(.ERRORS,.SEARCH,.FREQUENCY)
 D VALIDATEWEEKDAYS(.ERRORS,.SEARCH,.WEEKDAYS,.FREQUENCY)
 I $D(ERRORS) Q
 ;
 D VALIDATERECUR(.ERRORS,.SEARCH,.RECURRING,$G(SEARCH("RECURRING EVERY")),$G(SEARCH("FREQUENCY")))
 D VALIDATEOCCUR(.ERRORS,.SEARCH,.OCCURRING,$G(SEARCH("FREQUENCY")),$G(SEARCH("OCCURRING EVERY")))
 ;
 S STARTDATE=$$VALISODTTM^SDES2VALISODTTM(.ERRORS,$G(SEARCH("START DATE")),,1,572,299)
 I $D(ERRORS) Q
 ;
 I $L($P($$FMTISO^SDAMUTDT($G(SEARCH("START DATE"))),"T",2)) D ERRLOG^SDES2JSON(618,.ERRORS,)
 I $$ISOTFM^SDAMUTDT($G(SEARCH("START DATE")))<DT D ERRLOG^SDES2JSON(.ERRORS,71)
 I $L($G(SEARCH("AM OR PM"))),$G(SEARCH("AM OR PM"))'="AM",$G(SEARCH("AM OR PM"))'="PM" D ERRLOG^SDES2JSON(.ERRORS,607)
 Q
 ;
VALIDATEOCCUR(ERRORS,SEARCH,OCCURRING,FREQUENCY,OCCURRENCE) ;
 I FREQUENCY'="MONTHS" Q
 I '$L($G(OCCURRENCE)) D ERRLOG^SDES2JSON(.ERRORS,617) Q
 I OCCURRENCE<1!(OCCURRENCE>5) D ERRLOG^SDES2JSON(.ERRORS,618) Q
 S OCCURRING=$G(SEARCH("OCCURRING EVERY"))
 Q
 ;
VALIDATERECUR(ERRORS,SEARCH,RECURRING,RECURRENCE,FREQUENCY) ;
 I '$L($G(RECURRENCE)) D ERRLOG^SDES2JSON(.ERRORS,615) Q
 I '$G(RECURRENCE) D ERRLOG^SDES2JSON(.ERRORS,616) Q
 I RECURRENCE'>0 D ERRLOG^SDES2JSON(.ERRORS,616) Q
 ;
 I $G(FREQUENCY)="DAILY",RECURRENCE>390 D ERRLOG^SDES2JSON(.ERRORS,616) Q
 I $G(FREQUENCY)="WEEKS",RECURRENCE>55 D ERRLOG^SDES2JSON(.ERRORS,616) Q
 I $G(FREQUENCY)="MONTHS",RECURRENCE>12 D ERRLOG^SDES2JSON(.ERRORS,616) Q
 ;
 S RECURRING=$G(SEARCH("RECURRING EVERY"))
 Q
 ;
VALIDATEFREQUENC(ERRORS,SEARCH,FREQUENCY) ;
 S FREQUENCY=$G(SEARCH("FREQUENCY"))
 I '$L(FREQUENCY) D ERRLOG^SDES2JSON(.ERRORS,611) Q
 I FREQUENCY'="DAILY",FREQUENCY'="WEEKS",FREQUENCY'="MONTHS" D ERRLOG^SDES2JSON(.ERRORS,610) Q
 Q
 ;
WEEKDAYNUM(WEEKDAY) ;
 Q $S(WEEKDAY="SUNDAY":0,WEEKDAY="MONDAY":1,WEEKDAY="TUESDAY":2,WEEKDAY="WEDNESDAY":3,WEEKDAY="THURSDAY":4,WEEKDAY="FRIDAY":5,WEEKDAY="SATURDAY":6,1:"")
 ;
VALIDATEWEEKDAYS(ERRORS,SEARCH,WEEKDAYS,FREQUENCY) ;
 N COUNT,DAYOFTHEWEEK
 ;
 I FREQUENCY="DAILY" Q
 I '$L($G(SEARCH("WEEKDAY",1))) D ERRLOG^SDES2JSON(.ERRORS,609) Q
 ;
 S COUNT=0
 F  S COUNT=$O(SEARCH("WEEKDAY",COUNT)) Q:'COUNT!($D(ERRORS))  D
 .S DAYOFTHEWEEK=$G(SEARCH("WEEKDAY",COUNT))
 .I DAYOFTHEWEEK'="SUNDAY",DAYOFTHEWEEK'="MONDAY",DAYOFTHEWEEK'="TUESDAY",DAYOFTHEWEEK'="WEDNESDAY",DAYOFTHEWEEK'="THURSDAY",DAYOFTHEWEEK'="FRIDAY",DAYOFTHEWEEK'="SATURDAY" D ERRLOG^SDES2JSON(.ERRORS,608) Q
 .S WEEKDAYS($$WEEKDAYNUM(SEARCH("WEEKDAY",COUNT)))=SEARCH("WEEKDAY",COUNT)
 Q
 ;
VALIDATENUMAPPTS(ERRORS,SEARCH,NUMBEROFAPPTS) ;
 S NUMBEROFAPPTS=$G(SEARCH("NUMBER OF APPTS"))
 I '$L(NUMBEROFAPPTS) D ERRLOG^SDES2JSON(.ERRORS,606) Q
 I NUMBEROFAPPTS<2!(NUMBEROFAPPTS>60) D ERRLOG^SDES2JSON(.ERRORS,605) Q
 Q
 ;
VALIDATECLINIC(ERRORS,SEARCH) ;
 N COUNT
 ;
 I '$G(SEARCH("CLINIC IEN",1)) D ERRLOG^SDES2JSON(.ERRORS,18) Q
 S COUNT=0
 F  S COUNT=$O(SEARCH("CLINIC IEN",COUNT)) Q:'COUNT!($D(ERRORS))  D
 .I '$G(SEARCH("CLINIC IEN",COUNT)) D ERRLOG^SDES2JSON(.ERRORS,18) Q
 .I '$D(^SC($G(SEARCH("CLINIC IEN",COUNT)))) D ERRLOG^SDES2JSON(.ERRORS,19) Q
 .I $$INACTIVE^SDESUTIL($G(SEARCH("CLINIC IEN",COUNT))) D ERRLOG^SDES2JSON(.ERRORS,525)
 Q
 ;
VALIDATELENGTH(ERRORS,SEARCH) ;
 N LENGTH
 ;
 S LENGTH=$G(SEARCH("LENGTH"))
 I LENGTH="" D ERRLOG^SDES2JSON(.ERRORS,115) Q
 I LENGTH<10!(LENGTH>240) D ERRLOG^SDES2JSON(.ERRORS,116) Q
 I LENGTH#10'=0,LENGTH#15'=0 D ERRLOG^SDES2JSON(.ERRORS,116)
 Q
 ;
