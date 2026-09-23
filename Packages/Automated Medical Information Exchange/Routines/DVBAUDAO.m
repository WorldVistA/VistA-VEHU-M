DVBAUDAO ;ALB/CP - List Audited Option Summary Prompts ; 3/26/18 4:28pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;        $$NOW^XLFDT   ; #10103 ; API for current date & time
 ;            ^DISV            ; IA #  510
 ;
 Q
ENTER ; From option: List Audited Option Summary
 ;              [AMIE LIST AUDITED OPTION SUM]
 N DVBDISYS,DVBOPTION,DVBRPT
 S DVBOPTION="LIST AUDITED OPTION SUMMARY"
 ;
PROMPT ; Issue prompts for screening and sorted report output.
 N POP,DVBASKDT,DVBDAYS,DVBDTBEG,DVBDTEND,DVBFTBEG,DVBFTEND,DVBNTIMES,DVBOPT
 N DVBPKG,DVBQUIT,DVBSORT,DVBULIMIT
 ; ZEXCEPT: IO,IOF,DVBOPTION.DVBRPT
 ;
 W @IOF,!?1,"*** ",DVBOPTION," ***" S DVBQUIT=0
 D KILLTMP
 D GETRPT G:DVBQUIT EXIT ;............ Determine which report to run
 D ASKLOW($T(+0)) G:DVBQUIT PROMPT ;.. Opts used less than 'x' times
 D ASKHIGH($T(+0)) G:DVBQUIT PROMPT ;. Opts used more than 'x' times
 D ASKNEW($T(+0)) G:DVBQUIT PROMPT ;.. New opts within 'X' no. of days
 D ASKNUSED($T(+0)) G:DVBQUIT PROMPT ; Audits not used in last 'X' days
 D ASKUSED($T(+0)) G:DVBQUIT PROMPT ;. Audits used in last 'X' days
 I DVBRPT=8 D FTVALS^DVBAUDASK2("OPTION") G:DVBQUIT PROMPT ; Free text opt. range
 I DVBRPT=9 D ASKPKG^DVBAUDASK1 G:DVBQUIT PROMPT ;All opts for a namespace
 D ASKOPTS G:DVBQUIT PROMPT ;......... Prompt for active & inactive opt
 D ASKSORT($T(+0)) G:DVBQUIT PROMPT ;. Prompt for sort criteria
 D ASKDT($T(+0)) G:DVBQUIT PROMPT
 I DVBSORT=3,DVBASKDT="YES" D  G:DVBQUIT PROMPT
 . D GETDTS^DVBAUDDT1("AUDIT START DATE")
 I DVBSORT'=3,DVBASKDT="YES" D  G:DVBQUIT PROMPT
 . D GETDTS^DVBAUDDT1("LAST AUDITED DATE")
 D DEVICE^DVBAUDDEV1($T(+0),"",132) G:$G(POP)!DVBQUIT PROMPT U IO
 D IOM132^DVBAUDDEV1($T(+0)) ; Change video display screen to 132 columns
 W @IOF
 ;
START ; Queued report will start here
 ;
 N DVBBEG,DVBEND
 S DVBBEG=$$NOW^XLFDT() ;............. Set begin of processing time
 D BUILD^DVBAUDAO1 ;.................. Build sorted ^TMP global
 S DVBEND=$$NOW^XLFDT() ;............. Set ending of processing time
 D PRINT^DVBAUDAO2 ;.................. Print the report
 D PROCTIME^DVBAUDPRT1(DVBBEG,DVBEND) ;... Display processing time
 D CONTINUE^DVBAUDPRT1 ;................ Press <Enter> to continue
 ;
EXIT ; Close the Device and kill the ^TMP globals.
 ; From: PROMPT (above)
 ;
 D IOMRESET^DVBAUDDEV1($T(+0)) ;........ Reset screen to 80 cols
 D CLOSE^DVBAUDDEV1 ;................... Close device, cleanup
 ;
KILLTMP ;
 K DVBDISYS ; To assure this value is left the way it is found
 K ^TMP("AMIE",$J)
 ;
 Q  ; Quit routine DVBAUDAO
 ;
ASKDT(DVBRTN) ; Limit the report to a specific date range?
 N DVBDEF
 ; ZEXCEPT: DUZ,DVBASKDT,DVBQUIT
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBASKDT"),"NO")
 ;
 W !
 S DVBASKDT=$$ASKYESNO^DVBAUDASK1("LIMIT THE REPORT TO A SPECIFIC LAST AUDIT DATE R")
 I DVBASKDT="^" S DVBQUIT=1 Q
 S DVBASKDT=$S(DVBASKDT="Y":"YES",1:"NO")
 ;
 S ^DISV(DUZ,DVBRTN,"DVBASKDT")=DVBASKDT
 ;
 Q  ; Quit ASKDT
 ;
ASKHIGH(DVBRTN) ; Prompt for options used more than 'X' number of times.
 N DVBDEFAULT,DVBLINEFEED
 ; ZEXCEPT: DUZ,DVBNTIMES,DVBQUIT
 ;
 Q:DVBRPT'=4  ; Quit if this is not the right report
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 ;
 S DVBDEFAULT=$G(^DISV(DUZ,DVBRTN,"DVBASKHGH"),199)
 S DVBLINEFEED=0 ; Bypass line feed
 ;
 W !!,"Include Options used more than 'X' number of times"
 S DVBNTIMES=$$ASKNUM^DVBAUDASK1("",DVBDEFAULT) ; No DVBMAXIMUM response
 I DVBNTIMES="^" S DVBQUIT=1 Q
 ;
 S ^DISV(DUZ,DVBRTN,"DVBASKHGH")=DVBNTIMES
 ;
 Q  ; Quit ASKHIGH
 ;
ASKLOW(DVBRTN) ; Prompt for options used less than 'X' number of times.
 N DVBDEFAULT,DVBLINEFEED
 ; ZEXCEPT: DUZ,DVBNTIMES,DVBQUIT
 ;
 Q:DVBRPT'=3  ; Quit if this is not the right report
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 ;
 S DVBDEFAULT=$G(^DISV(DUZ,DVBRTN,"DVBASKLOW"),6)
 S DVBLINEFEED=0 ; Bypass line feed
 ;
 W !!,"Include Options used less than 'X' number of times"
 S DVBNTIMES=$$ASKNUM^DVBAUDASK1("",DVBDEFAULT) ; No DVBMAXIMUM response
 I DVBNTIMES="^" S DVBQUIT=1 Q
 ;
 S ^DISV(DUZ,DVBRTN,"DVBASKLOW")=DVBNTIMES
 ;
 Q  ; Quit ASKLOW
 ;
ASKNEW(DVBRTN) ; Prompt for new option audited within 'X' number of days ago.
 N DVBDEFAULT,DVBLINEFEED
 ; ZEXCEPT: DUZ,DVBDAYS,DVBQUIT
 ;
 Q:DVBRPT'=5  ; Quit if this is not the right report
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 ;
 S DVBDEFAULT=$G(^DISV(DUZ,DVBRTN,"DVBASKNEW"),30)
 S DVBLINEFEED=0 ; Bypass line feed
 ;
 W !!,"Include Options added to the audit list within 'X' number of days ago"
 S DVBDAYS=$$ASKNUM^DVBAUDASK1(99,DVBDEFAULT)
 I DVBDAYS="^" S DVBQUIT=1 Q
 ;
 S ^DISV(DUZ,DVBRTN,"DVBASKNEW")=DVBDAYS
 ;
 Q  ; Quit ASKNEW
 ;
ASKNUSED(DVBRTN) ; Prompt for audited options not used  within 'X' days.
 N DVBDEFAULT,DVBLINEFEED
 ; ZEXCEPT: DUZ,DVBDAYS,DVBQUIT
 ;
 Q:DVBRPT'=6  ; Quit if this is not the right report
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 ;
 S DVBDEFAULT=$G(^DISV(DUZ,DVBRTN,"DVBNUSED"),366)
 S DVBLINEFEED=0 ; Bypass line feed
 ;
 W !!,"Audited options not used in the last 'X' number of days"
 S DVBDAYS=$$ASKNUM^DVBAUDASK1(999999999,DVBDEFAULT)
 I DVBDAYS="^" S DVBQUIT=1 Q
 ;
 S ^DISV(DUZ,DVBRTN,"DVBNUSED")=DVBDAYS
 ;
 Q  ; Quit ASKNUSER
 ;
ASKOPTS(DVBRTN) ; Determine which options to include
 N DVBDEF,DVBMAXIMUM
 ; ZEXCEPT: DUZ,DVBOPT,DVBQUIT
 ;
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 S DVBDEF=$G(^DISV(DUZ,$T(+0),"DVBOPT"),1)
 I $G(DVBOPT) S DVBDEF="" ; No DVBDEFAULT when repeatedly executed
 ;
 S DVBMAXIMUM=3,DVBQUIT=0
 W !!,"Which options will be included"
 W !?5,"1) Both active and inactive options"
 W !?5,"2) Only active options"
 W !?5,"3) Only inactive options"
 ;
 S DVBOPT=$$ASKNUM^DVBAUDASK1(DVBMAXIMUM,DVBDEF)
 I "^"[DVBOPT S DVBQUIT=1 Q
 S ^DISV(DUZ,$T(+0),"DVBOPT")=DVBOPT
 ;
 Q  ; Quit ASKOPTS
 ;
ASKSORT(DVBRTN) ; Get sorting criteria
 N DVBDEF ; DVBDEFAULT response
 ; ZEXCEPT: DUZ,DVBQUIT,DVBSORT
 ;
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBSORT"))
 ;
 S DVBSORT(1)="Option Name"
 S DVBSORT(2)="Option Type & Option Name"
 S DVBSORT(3)="Audit Start Date & Option Name"
 S DVBSORT(4)="Last Audited Date & Option Name"
 S DVBSORT(5)="Ascending Usage Count & Option Name"
 S DVBSORT(6)="Descending Usage Count & Option Name"
 ;
 D GETSORT^DVBAUDASK1($T(+0),.DVBSORT,DVBDEF) Q:DVBQUIT
 ;
 S DVBSORT=$G(^DISV(DUZ,DVBRTN,"DVBSORT"))
 ;
 Q  ; Quit ASKSORT
 ;
ASKUSED(DVBRTN) ; Prompt for audited options used  within 'X' days.
 ;
 N DVBDEFAULT,DVBLINEFEED
 ; ZEXCEPT: DUZ,DVBDAYS,DVBQUIT
 ;
 Q:DVBRPT'=7  ; Quit if this is not the right report
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 ;
 S DVBDEFAULT=$G(^DISV(DUZ,DVBRTN,"DVBUSED"),14)
 S DVBLINEFEED=0 ; Bypass line feed
 ;
 W !!,"Audited options used in the last 'X' number of days"
 S DVBDAYS=$$ASKNUM^DVBAUDASK1(366,DVBDEFAULT)
 I DVBDAYS="^" S DVBQUIT=1 Q
 ;
 S ^DISV(DUZ,DVBRTN,"DVBUSED")=DVBDAYS
 ;
 Q  ; Quit ASKUSED
 ;
GETRPT ; Determine which report to run
 ;
 N DVBDEF,DVBMAXIMUM
 ; ZEXCEPT: DUZ,DVBQUIT,DVBRPT
 ;
 S DVBQUIT=0 ;. Initialize output quit flag to NO (0)
 S DVBDEF=$G(^DISV(DUZ,$T(+0),"DVBRPT"),10)
 I $G(DVBRPT) S DVBDEF="" ; No DVBDEFAULT when repeatedly executed
 ;
 S DVBMAXIMUM=11,DVBQUIT=0
 W !!,"Which report selection"
 W !?5,"1) Include all options audited"
 W !?5,"2) Audited options never utilized"
 W !?5,"3) Options with low or no usage"
 W !?5,"4) Options with high usage"
 W !?5,"5) Options added to the audit list within 'X' number of days ago"
 W !?5,"6) Options not used within 'X' number of days"
 W !?5,"7) Options used within the last 'X' number of days"
 W !?5,"8) Select a from-to free text range of audited options"
 W !?5,"9) All the audited options for a selected package namespace"
 W !?4,"10) Audited options that are regularly recurring tasks"
 W !?4,"11) All audited options with recorded usage"
 ;
 S DVBRPT=$$ASKNUM^DVBAUDASK1(DVBMAXIMUM,DVBDEF)
 I "^"[DVBRPT S DVBQUIT=1 Q
 S ^DISV(DUZ,$T(+0),"DVBRPT")=DVBRPT
 ;
 Q  ; Quit GETRPT
