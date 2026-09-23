DVBAUDAO1 ;ALB/CP - List Audited Option Summary Build ; 4/12/18 5:57pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;      $$FIND1^DIC    ; IA # 2051
 ;       $$GET1^DIQ    ; IA # 2056
 ;     $$FMDIFF^XLFDT  ; IA #10103
 ;         $$UP^XLFSTR ; IA #10104
 ;     ^DIC(19,        ; IA # 2246
 ;
 ;
 Q
 ;
BUILD ; Build sorted ^TMP global for report output.
 ; ZEXCEPT: DVBRPT
 ;
 ; From option: List Audited option Summary
 ;              [AMIE LIST AUDITED OPTION SUM]
 ;
 ; This driver will execute the most efficient loop based upon DVBRPT.
 ;
 I DVBRPT=1 D BUILDOPT Q  ;. Include all currently audited options
 I DVBRPT=2 D BUILDOPT Q  ;. Audited options never utilized
 I DVBRPT=3 D BUILDOPT Q  ;. Options with low or no usage
 I DVBRPT=4 D BUILDSUM Q  ;. Options with high usage
 I DVBRPT=5 D BUILDSUM Q  ;. Options added to the audit list within 'X' number oo
 I DVBRPT=6 D BUILDSUM Q  ;. Options not used within 'X' number of days
 I DVBRPT=7 D BUILDSUM Q  ;. Options used within the last 'X' number of days
 I DVBRPT=8 D BUILDFT Q  ;.. User selected free text range of Options
 I DVBRPT=9 D BUILDPKG Q  ;. User selected package namespace
 I DVBRPT=10 D BUILDSUM Q  ; Audited options that are regularly recurring tasks
 I DVBRPT=11 D BUILDSUM Q  ; All audits option with recorded usage
 ;
EXIT ; Exit BUILD^DVBAUDOA1
 ;
 Q  ; Quit routine BUILD^DVBAUDOA1
 ;
BUILDFT ; User selected specific free text range found in DVBFTBEG & DVBFTEND
 ;
 N DVBCNT,DVBOPTNAME
 ; ZEXCEPT: DVBFTBEG,DVBFTEND
 ;
 S DVBCNT=0
 S DVBOPTNAME=DVBFTBEG ; Loop thru options names using free text from-to range
 F  S DVBOPTNAME=$O(^DIC(19,"B",DVBOPTNAME)) Q:DVBOPTNAME=""!(DVBOPTNAME]DVBFTEND)  D  ;
 . S DVBCNT=DVBCNT+1 ;........ Count the number of records processed
 . D DOTS^DVBAUDPRT2(DVBCNT) ; Display a dot every 100 records
 . N DVBIEN19
 . S DVBIEN19=0
 . F  S DVBIEN19=$O(^DIC(19,"B",DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19  D
 .. Q:'$D(^DVB(396.9991,"B",DVBIEN19,DVBIEN19))  ; Quit if no SUMMARY BY OPTION stub rd
 .. ;
 .. D COMMON(DVBIEN19,DVBOPTNAME)
 ;
 Q  ; Quit BUILDFT
 ;
BUILDOPT ; Loop through the entire AMIE AUDIT SUMMARY BY OPTION
 ; file #396.9991
 N DVBCNT,DVBIEN19,DVBQUIT
 ;
 S (DVBQUIT,DVBCNT,DVBIEN19)=0
 F  S DVBIEN19=$O(^DVB(396.9991,DVBIEN19)) Q:'DVBIEN19!DVBQUIT  D  ;
 . N DIERR,DVBOPTNAME,DVBERRMSG
 . S DVBCNT=DVBCNT+1 ;........ Count the number of records processed
 . D DOTS^DVBAUDPRT2(DVBCNT) ; Display a dot every 100 records
 . S DVBOPTNAME=$$GET1^DIQ(19,DVBIEN19,.01,"E",,"DVBERRMSG")
 . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","BUILDDVBOPT^"_$T(+0)) Q:DVBQUIT
 . Q:DVBOPTNAME=""
 . ;
 . D COMMON(DVBIEN19,DVBOPTNAME)
 ;
 Q  ; Quit BUILDOPT
 ;
BUILDPKG ; User selected package namespace found in DVBPKG
 ;
 N DVBCNT,DVBOPTNAME
 ; ZEXCEPT: DVBPKG
 ;
 S DVBCNT=0
 S DVBOPTNAME=DVBPKG ; Loop thru option names using the package namespace
 F  S DVBOPTNAME=$O(^DIC(19,"B",DVBOPTNAME)) Q:DVBOPTNAME=""!($E(DVBOPTNAME,1,$L(DVBPKG))'=DVBPKG)  D
 . S DVBCNT=DVBCNT+1 ;........ Count the number of records processed
 . D DOTS^DVBAUDPRT2(DVBCNT) ; Display a dot every 100 records
 . N DVBIEN19
 . S DVBIEN19=0
 . F  S DVBIEN19=$O(^DIC(19,"B",DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19  D  ;
 .. Q:'$D(^DVB(396.9991,"B",DVBIEN19,DVBIEN19))  ; Quit if no SUMMARY BY OPTION stub rd
 .. N DIERR,DVBERRMSG
 .. S DVBOPTNAME=$$GET1^DIQ(19,DVBIEN19,.01,"E",,"DVBERRMSG")
 .. D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","BUILDPKG^"_$T(+0)) Q:DVBQUIT
 .. ;
 .. D COMMON(DVBIEN19,DVBOPTNAME)
 ;
 Q  ; Quit BUILDPKG
 ;
BUILDSUM ; Loop through AMIE AUDIT SUMMARY BY OPTION file #396.9991
 ;
 N DVBCNT,DVBIEN19
 ;
 S (DVBCNT,DVBIEN19)=0
 F  S DVBIEN19=$O(^DVB(396.9991,DVBIEN19)) Q:'DVBIEN19  D  ;
 . N DIERR,DVBOPTNAME,DVBERRMSG
 . S DVBCNT=DVBCNT+1 ;........ Count the number of records processed
 . D DOTS^DVBAUDPRT2(DVBCNT) ; Display a dot every 100 records
 . S DVBOPTNAME=$$GET1^DIQ(19,DVBIEN19,.01,"E",,"DVBERRMSG")
 . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","BUILDSUM^"_$T(+0)) Q:DVBQUIT
 . D COMMON(DVBIEN19,DVBOPTNAME)
 ;
 Q  ; Quit BUILDSUM
 ;
COMMON(DVBIEN19,DVBOPTNAME) ; Code used by all BUILD loops above
 N DVBSUMOPT,DVBSAVEOPT
 S DVBSAVEOPT=$G(DVBOPT)
 N DVBOPT
 ;
 ; Get OPTION file #19 report data
 ;
 D OPTION^DVBAUDDIQ(DVBIEN19) Q:DVBQUIT
 ;
 D SUMOPT^DVBAUDDIQ(DVBIEN19) ; Get AMIE AUDIT SUMMARY BY OPTION data
 ;
 ; Screen the record and skip over any record that does not pass
 ; all of the various screens.
 ;
 S DVBOPT=$G(DVBSAVEOPT)
 N DVBSKIP
 ;
 S DVBSKIP=0 D SCREEN(.DVBSUMOPT) Q:DVBSKIP
 ;
 D SETTMP(DVBIEN19)
 ;
 Q  ; Quit COMMON
 ;
SCREEN(DVBSUMOPT) ; Screen record and set DVBSKIP=1 if any screen is not passed.
 ; Input:
 ;   DVBSUMOPT(array) ; Required ; See output of SUMOPT^DVBAUDDIQ
 ;
 N DVBDAYSAGO
 ; ZEXCEPT: DT,DVBDAYS,DVBASKDT,DVBDTBEG,DVBDTEND
 ; ZEXCEPT: DVBNTIMES,DVBOPT,DVBRPT,DVBSKIP,DVBSORT
 ;
 ; Applies to all the reporting options
 ;I DVBRPT>1,DVBSUMOPT("AUDITED?")="NO" S DVBSKIP=1 Q  ; Audit currently turned off.
 ;
 ; Screens applied to specific reports are below.
 ;
 I DVBRPT=2,DVBSUMOPT("USAGE")>0 S DVBSKIP=1 Q  ; Audited options never utilized
 I DVBRPT=3,DVBSUMOPT("USAGE")'<DVBNTIMES S DVBSKIP=1 Q  ; options with low or no usae
 I DVBRPT=4,DVBSUMOPT("USAGE")'>DVBNTIMES S DVBSKIP=1 Q  ; options with high usage
 ;
 ; Options added to the audit list within 'X' number of days ago (DVBRPT=5)
 I DVBRPT=5,DVBSUMOPT("AUDDAYS")>(DVBDAYS+1) S DVBSKIP=1 Q
 ;
 ; Options NOT used within 'X' number of days (DVBRPT=6)
 S DVBDAYSAGO=0 ; Determine how many days ago the option was used?
 I DVBSUMOPT("DTLASTI") S DVBDAYSAGO=$$FMDIFF^XLFDT(DT,DVBSUMOPT("DTLASTI"))
 I DVBRPT=6,DVBDAYSAGO>0,DVBDAYSAGO'>DVBDAYS S DVBSKIP=1 Q
 I DVBRPT=6,$P(DVBSUMOPT("DTLASTI"),".")=DT S DVBSKIP=1 Q  ; Skip TODAY
 ;
 ; Options used within the last 'X' number of days (DVBRPT=7)
 I DVBRPT=7,DVBSUMOPT("DTLASTI"),$$FMDIFF^XLFDT(DT,DVBSUMOPT("DTLASTI"))>DVBDAYS,DVBSUMOPT("USAGE")>0 S DVBSKIP=1 Q
 I DVBRPT=7,DVBSUMOPT("USAGE")=0 S DVBSKIP=1 Q
 ;
 ; Audited options scheduled as regular recurring tasks
 I DVBRPT=10 D  ;
 . N DVBIENOSF,DVBOPTSCH
 . S DVBIENOSF=$$FIND1^DIC(19.2,"","BO",DVBSUMOPT("OPTNAME"))
 . I 'DVBIENOSF S DVBSKIP=1 Q
 . D OPTSCH^DVBAUDDIQ(DVBIENOSF) ; Get OPTION SCHEDULING data
 . I DVBOPTSCH("TASKID")="" S DVBSKIP=1 Q  ;.... No TASK ID
 . I DVBOPTSCH("FREQ")="" S DVBSKIP=1 Q  ;...... No RESCHEDULING FREQUENCY
 . I DVBOPTSCH("QTORUNTIME")="" S DVBSKIP=1 Q  ; No QUEUED TO RUN AT WHAT TIME
 ;
 ; All audited options with recorded usage (DVBRPT=11)
 I DVBRPT=11,'DVBSUMOPT("DTLASTI") S DVBSKIP=1 Q
 ;
 I DVBOPT=2,DVBSUMOPT("ACTIVE?")="NO" S DVBSKIP=1 Q  ; Only 'active'   options are ad
 I DVBOPT=3,DVBSUMOPT("ACTIVE?")="YES" S DVBSKIP=1 Q  ;Only 'inactive' options are ad
 ;
 ; Limit the report to a specific date range (DVBASKDT="YES")
 I DVBASKDT="YES" D  Q:DVBSKIP
 . I DVBSORT=3 D  Q  ; If sorting by AUDIT START DATE
 . . I $P(DVBSUMOPT("DTSTARTI"),".")<DVB2DTBEG("I") S DVBSKIP=1 Q
 . . I $P(DVBSUMOPT("DTSTARTI"),".")>DVB2DTEND("I") S DVBSKIP=1 Q
 . ; If not sorting by AUDIT START DATE use LAST AUDITED DATE
 . I $P(DVBSUMOPT("DTLASTI"),".")<DVB2DTBEG("I") S DVBSKIP=1 Q
 . I $P(DVBSUMOPT("DTLASTI"),".")>DVB2DTEND("I") S DVBSKIP=1 Q
 ;
 Q  ; Quit SCREEN
 ;
SETTMP(DVBIEN19) ; Set DVBRPTDATA field pieces, set DVBSORTBY fields, set ^TMP global
 ; Input:
 ;   DVBIEN19 ; IEN of a AMIE AUDIT SUMMARY BY OPTION entry
 ;
 N DVBRPTDATA,DVBSORT1,DVBSORT2,DVBSORTBY
 ; ZEXCEPT: DVBOPTION,DVBSORT,DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBRPTDATA=DVBSUMOPT("OPTNAME")_"^"
 S DVBRPTDATA=DVBRPTDATA_DVBIEN19_"^"
 S DVBRPTDATA=DVBRPTDATA_DVBSUMOPT("OPTTYPE")_"^"
 S DVBRPTDATA=DVBRPTDATA_DVBSUMOPT("ACTIVE?")_"^"
 I DVBSUMOPT("DTSTARTI") S DVBRPTDATA=DVBRPTDATA_$$DATE^DVBAUDDT1(DVBSUMOPT("DTSTARTI"),0,1,1)
 E  S DVBRPTDATA=DVBRPTDATA_DVBSUMOPT("DTSTART")_"^" ; AUDIT START DATE might be '<Emptyl
 S DVBRPTDATA=DVBRPTDATA_DVBSUMOPT("AUDDAYS")_"^"
 I DVBSUMOPT("DT1STI") S DVBRPTDATA=DVBRPTDATA_$$DATE^DVBAUDDT1(DVBSUMOPT("DT1STI"),0,1,1)_"^"
 E  S DVBRPTDATA=DVBRPTDATA_"<Empty>^" ;LATEST AUDIT DATE might be '<Empty>' or null
 I DVBSUMOPT("DTLASTI") S DVBRPTDATA=DVBRPTDATA_$$DAYSAGO^DVBAUDDT1(DVBSUMOPT("DTLASTI"))_"^"
 E  S DVBRPTDATA=DVBRPTDATA_"<Empty>^" ;LATEST AUDIT DATE might be '<Empty>' or null
 S DVBRPTDATA=DVBRPTDATA_DVBSUMOPT("USAGE")
 ;
 S DVBSORTBY="SORT"_DVBSORT ; DVBSORT1, DVBSORT2, etc.
 D @DVBSORTBY
 ;
 S ^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2,DVBIEN19)=DVBRPTDATA
 ;
 Q  ; Quit SETTMP
 ;
SORT1 ; Sort by OPTION
 ; ZEXCEPT: DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBSORT1=DVBSUMOPT("OPTNAME")
 S DVBSORT2="<SORT2>"
 ;
 Q  ; Quit SORT1
 ;
SORT2 ; Sort by OPTION TYPE & OPTION
 ; ZEXCEPT: DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBSORT1=$$UP^XLFSTR(DVBSUMOPT("OPTTYPE"))
 S DVBSORT2=DVBSUMOPT("OPTNAME")
 ;
 Q  ; Quit SORT2
 ;------------------------------------------------------------------
SORT3 ; Sort by AUDIT START DATE & OPTION
 ; ZEXCEPT: DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBSORT1=$P(DVBSUMOPT("DTSTARTI"),".",1) ; Drop the time, most recent 1st
 S DVBSORT2=DVBSUMOPT("OPTNAME")
 ;
 Q  ; Quit SORT3
 ;
SORT4 ; Sort by LAST AUDITED DATE & OPTION
 ; ZEXCEPT: DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBSORT1=-+$P(DVBSUMOPT("DTLASTI"),".",1) ; Drop the time, most recent 1st
 S DVBSORT2=DVBSUMOPT("OPTNAME")
 ;
 Q  ; Quit SORT3
 ;
SORT5 ; Sort by ASCENDING USAGE COUNT & OPTION
 ; ZEXCEPT: DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBSORT1=DVBSUMOPT("USAGE")
 S DVBSORT2=DVBSUMOPT("OPTNAME")
 ;
 Q  ; Quit SORT5
 ;
SORT6 ; Sort by DECENDING USAGE COUNT & OPTION
 ; ZEXCEPT: DVBSORT1,DVBSORT2,DVBSUMOPT
 ;
 S DVBSORT1=-DVBSUMOPT("USAGE")
 S DVBSORT2=DVBSUMOPT("OPTNAME")
 ;
 Q  ; Quit SORT6
 ;
