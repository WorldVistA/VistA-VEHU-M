DVBAUDUU ;ALB/CP - Audited Option User Utilization Prompt ; 8/4/26 12:53pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;      $$NOW^XLFDT    ; #10103 ; API for current date & time:
 ;            ^DISV    ; IA #  510
 ;
 Q
 ;
ENTER ; From option: Audited Option User Utilization
 ;              [DVBA AUDITED OPTION USER UTIL]
 ;
 N DVBOPTION,DVBRPT
 S DVBOPTION="AUDITED OPTION USER UTILIZATION"
 ;
PROMPT ; Issue prompts for screening and sorted report output.
 N POP,DVBASKDT,DVBDTBEG,DVBDTEND,DVBFTBEG,DVBFTEND,DVBLEGEND
 N DVBOPT,DVBPKG,DVBQUIT,DVBSORT,DVBULIMIT
 ; ZEXCEPT: IO,IOF,DVBOPTION,DVBRPT
 ;
 W @IOF,!?1,"*** ",DVBOPTION," ***" S (DVBQUIT,DVBLEGEND)=0
 D KILLTMP
 D GETOPTS G:DVBQUIT EXIT ; Determine Options to include on the report
 I DVBRPT=1 D OPTSOUT^DVBAUDDIC("AEMQ",0,1) G:DVBQUIT PROMPT ; Select opts
 I DVBRPT=2 D FTVALS^DVBAUDASK2("OPTION") G:DVBQUIT PROMPT ; Free text opt. range
 I DVBRPT=3 D ASKPKG^DVBAUDASK1 G:DVBQUIT PROMPT ;All opts for a namespace
 ;
 D ASKDT($T(+0)) G:DVBQUIT PROMPT ;........... Limit report to a dt. range?
 I DVBASKDT="YES" D GETDTS^DVBAUDDT1("report LAST USED date") G:DVBQUIT PROMPT
 ;
 D USRLIMIT^DVBAUDASK1($T(+0)) G:DVBQUIT PROMPT ;Active/Inactive Users?
 D GETSORT($T(+0)) G:DVBQUIT PROMPT ;.........Prompt for sort criteria
 D DEVICE^DVBAUDDEV1($T(+0),"",132) G:$G(POP)!DVBQUIT PROMPT U IO
 D IOM132^DVBAUDDEV1($T(+0)) ;..................Change to 132 columns
 W @IOF
 ;
START ; Queued report will start here
 N DVBBEG,DVBEND
 S DVBBEG=$$NOW^XLFDT()
 D BUILD^DVBAUDUU1 ;..........................Build sorted ^TMP global
 S DVBEND=$$NOW^XLFDT()
 D PRINT^DVBAUDUU2 ;..........................Print the report
 D PROCTIME^DVBAUDPRT1(DVBBEG,DVBEND) ;...........Display processing time
 D CONTINUE^DVBAUDPRT1 ;........................Press <Enter> to continue
 ;
EXIT ; Close the Device and kill the ^TMP globals.
 ; From: PROMPT (above)
 ;
 D IOMRESET^DVBAUDDEV1($T(+0)) ;................ Reset screen to 80 cols
 D CLOSE^DVBAUDDEV1 ;........................... Close device, cleanup
 ;
KILLTMP ; Kill ^TMP global
 K ^TMP("AMIE",$J)
 ;
 Q  ; Quit routine DVBAUDUU
 ;
ASKDT(DVBRTN) ; Limit the report to a specific date range?
 ;
 N DVBDEF
 ; ZEXCEPT: DUZ,DVBASKDT,DVBQUIT
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBASKDT"),"NO")
 ;
 W !
 S DVBASKDT=$$ASKYESNO^DVBAUDASK1("LIMIT THE REPORT TO A SPECIFIC DATE RANGE",DVBDEF)
 I DVBASKDT="^" S DVBQUIT=1 Q
 S DVBASKDT=$S(DVBASKDT="Y":"YES",1:"NO")
 ;
 S ^DISV(DUZ,DVBRTN,"DVBASKDT")=DVBASKDT
 ;
 Q  ; Quit ASKDT
 ;
GETOPTS ; Determine how options will be selected for this report
 ;
 N DVBDEF,DVBMAXIMUM,DVBSUB
 ; ZEXCEPT: DUZ,DVBQUIT,DVBRPT
 ;
 S DVBDEF=$G(^DISV(DUZ,$T(+0),"DVBRPT"),1)
 I $G(DVBRPT) S DVBDEF="" ; No default when repeatedly executed
 ;
 S DVBMAXIMUM=3,DVBQUIT=0
 W !!,"Which report selection"
 S DVBRPT(1)="Select specific options"
 S DVBRPT(2)="Select a from-to free text range of options"
 S DVBRPT(3)="All the options for a selected package namespace"
 F DVBSUB=1:1:3 W !?5,DVBSUB,". ",DVBRPT(DVBSUB)
 ;
 S DVBRPT=$$ASKNUM^DVBAUDASK1(DVBMAXIMUM,DVBDEF)
 I "^"[DVBRPT S DVBQUIT=1 Q
 S ^DISV(DUZ,$T(+0),"DVBRPT")=DVBRPT
 ;
 Q  ; Quit GETOPTS
 ;
GETSORT(DVBRTN) ; Get sorting criteria
 ;
 N DVBDEF ; Default response
 ; ZEXCEPT: DUZ,DVBQUIT,DVBSORT
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBSORT"))
 ;
 S DVBSORT(1)="Option & User"
 S DVBSORT(2)="Option, Parent Service & User"
 S DVBSORT(3)="Option, Date Last Used & User"
 S DVBSORT(4)="Option, Usage Count & User"
 S DVBSORT(5)="Usage Count, Option & User"
 S DVBSORT(6)="Usage Count, Parent Service & User"
 S DVBSORT(7)="Parent Service, Option & User"
 S DVBSORT(8)="Parent Service, User & Option"
 S DVBSORT(9)="Parent Service, Date Last Used & User"
 S DVBSORT(10)="Parent Service, Date Last Used & Option"
 S DVBSORT(11)="Date Last Used, Option, & User"
 S DVBSORT(12)="Date Last Used, User & Option"
 ;
 D GETSORT^DVBAUDASK1($T(+0),.DVBSORT,DVBDEF) Q:DVBQUIT
 ;
 S DVBSORT=$G(^DISV(DUZ,DVBRTN,"DVBSORT"))
 ;
 Q  ; Quit GETSORT
