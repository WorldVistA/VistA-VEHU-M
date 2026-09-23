DVBAUDUI ;ALB/CP- User Audit Summary Inquiry Prompts ; 3/27/18 2:26pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;            ^%ZISC           ; IA #10089
 ;       $$NOW^XLFDT           ; IA #10103
 ;            ^DISV            ; IA #  510
 ;
 Q
 ;
ENTER ; From option: User Audit Summary Inquiry
 ;              [DVBA USER AUDIT SUMMARY INQ]
 ;
 N DVBASKDT,DVBDTBEG,DVBDTEND,DVBUSER,DVBOPTION,DVBQUIT,DVBSORT,POP,X
 ;
PROMPT ; User prompts
 ; ZEXCEPT: IO,IOF
 ;
 S DVBQUIT=0
 S DVBOPTION="USER AUDIT SUMMARY INQUIRY"
 W @IOF,!?1,"*** ",DVBOPTION," ***"
 D KILL ;.................................. Refresh the ^TMP("AMIE",$J)
 D USER^DVBAUDDIC("AEMQZ",0) G:DVBQUIT EXIT ; Prompt for USER(s)
 D ASKDT($T(+0)) G:DVBQUIT PROMPT ;......... Limit by date range?
 I DVBASKDT="YES" D  G:DVBQUIT PROMPT ;...... IF  Yes
 . D GETDTS^DVBAUDDT1("LAST AUDITED DATE") ;..     Get the data range
 D ASKSORT($T(+0)) G:DVBQUIT PROMPT ;....... Prompt for sort criteria
 D DEVICE^DVBAUDDEV1($T(+0),,80) G:DVBQUIT PROMPT U IO ; Device prompt
 W @IOF ; Clear the screen if the report is viewed immediately
START ; Start routine here when queued
 ;
 N DVBBEG,DVBEND
 S DVBBEG=$$NOW^XLFDT()
 D BUILD^DVBAUDUI1 ;..........................Build sorted ^TMP global
 S DVBEND=$$NOW^XLFDT() ;.....................Save end date/time
 D PRINT^DVBAUDUI2 ;..........................Print the report
 D PROCTIME^DVBAUDPRT1(DVBBEG,DVBEND) ;...........Display processing time
 D CONTINUE^DVBAUDPRT1 ;........................Press <Enter> to continue
EXIT ; Exit routine logic, close device & kill the ^TMP global
 ;
 N @($$%ZISC^DVBAUDNEW1())
 D ^%ZISC
KILL ; Kill ^TMP global
 K ^TMP("AMIE",$J)
 ;
 Q  ; Quit routine DVBAUDUI
 ;
ASKDT(DVBRTN) ; Limit the report to a specific date range?
 ;
 N DVBDEF
 ; ZEXCEPT: DUZ,DVBASKDT,DVBQUIT
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBASKDT"),"NO")
 ;
 W !
 S DVBASKDT=$$ASKYESNO^DVBAUDASK1("LIMIT THE REPORT TO A SPECIFIC LAST AUDIT DATE RANGE")
 I DVBASKDT="^" S DVBQUIT=1 Q
 S DVBASKDT=$S(DVBASKDT="Y":"YES",1:"NO")
 ;
 S ^DISV(DUZ,DVBRTN,"DVBASKDT")=DVBASKDT ; Save response for next default
 ;
 Q  ; Quit ASKDT
 ;
ASKSORT(DVBRTN) ; Get sorting criteria
 ;
 N DVBDEF ; Default response
 ; ZEXCEPT: DUZ,DVBQUIT,DVBSORT
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBSORT"))
 ;
 S DVBSORT(1)="User & Option Name"
 S DVBSORT(2)="User & Date Option Last Used (Chronological Order)"
 S DVBSORT(3)="User & Date Option Last Used (Reverse Chronological)"
 S DVBSORT(4)="User & Highest to Lowest Option Usage Count"
 ;
 D GETSORT^DVBAUDASK1($T(+0),.DVBSORT,DVBDEF) Q:DVBQUIT
 ;
 S DVBSORT=$G(^DISV(DUZ,DVBRTN,"DVBSORT"))
 ;
 Q  ; Quit ASKSORT
