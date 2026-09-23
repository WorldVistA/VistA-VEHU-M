DVBAUDOAS ;ALB/CP - Summarize Audit Records ; 5/30/18 9:40am
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;      $$FIND1^DIC    ; # 2051
 ;           YN^DICN   ; #10009
 ;         FILE^DIE    ; # 1282
 ;       $$GET1^DIQ    ; # 2056
 ;      $$FMADD^XLFDT  ; #10103
 ;        $$NOW^XLFDT  ; #10103
 ;        $$GET^XPAR   ; # 2263
 ;           EN^XPAR   ; # 2263
 ;
 ;
 Q  ; Quit documentation
 ;
AUTOTASK ; Scheduled taskMan entry point
 ;
 N DVBIENEVENT,DVBMAXHIST,DVBQUIT
 ; ZEXCEPT: DVBCNT ; Output to PACK entry point, no. of recs. summarized
 ; ZEXCEPT: DVBPACK ; Set to 1 in PACK, indicates manual summarization
 ;
 S DVBPACK=$G(DVBPACK,0) ; Set to 1 when manually summarized (in PACK)
 I DVBPACK=0 N DVBCNT
 ;
 S DVBCNT=0 ; Number of AMIE OPTION AUDIT EVENT records processed
 S DVBQUIT=0 ; Initialize quit flag to NO
 ;
 S DVBMAXHIST=$$GET^XPAR("PKG.DVBAB OPTION AUDIT","DVBAB MAX OCCURRENCES HISTORY",)
 I 'DVBMAXHIST D  ; If no PARAMETERS entry found, then set value to 100
 . D EN^XPAR("PKG","DVBAB MAX OCCURRENCES HISTORY",,100)
 ;
 S DVBIENEVENT=0 ; AMIE OPTION AUDIT EVENT record IEN
 F  S DVBIENEVENT=$O(^DVB(396.999,DVBIENEVENT)) Q:'DVBIENEVENT!DVBQUIT  D  S DVBQUIT=0 ;
 . N DVBEVENT
 . ; ZEXCEPT: IOST
 . D EVENT^DVBAUDDIQ(DVBIENEVENT) Q:DVBQUIT  ; Get EVENT file data fields
 . Q:DVBEVENT("PURGFLG")="YES"  ;........... Bypass, already summarized
 . ;
 . I DVBEVENT("OPTNAME")=""!(DVBEVENT("USERNAME")="") D  Q  ;
 . . D SETPFLAG^DVBAUDDIE(DVBIENEVENT) Q  ; Set E-PURGE FLAG? = 'YES'
 . ;
 . Q:$$TASKED  ; Quit if the tasked event is still running
 . ;
 . D SUMOPT^DVBAUDDIE(.DVBEVENT,DVBMAXHIST)
 . Q:DVBQUIT  ;................. Database server error experienced
 . ;
 . D SUMUSER^DVBAUDDIE(.DVBEVENT) ; Edit AMIE AUDIT SUMMARY BY USER
 . Q:DVBQUIT  ;................. Database server error experienced
 . ;
 . D SETPFLAG^DVBAUDDIE(DVBIENEVENT) ; Set the E-PURGE FLAG? = 'YES'
 . Q:DVBQUIT  ;................. Database server error experienced
 . S DVBCNT=DVBCNT+1
 ;
 Q:DVBQUIT
 ;
 D PURGEVNT ; Purge AMIE OPTION AUDIT EVENT records w/PURGE FLAG="Y"
 ;
 N DVBIEN19
 S DVBIEN19=0
 F  S DVBIEN19=$O(^DIC(19,DVBIEN19)) Q:'DVBIEN19  D  ;
 . Q:'$D(^DIC(19,DVBIEN19,0))
 . N DIERR,DVBOPT,DVBERRMSG
 . Q:$$GET1^DIQ(19,DVBIEN19,20)'["AUDIT^DVBAUDOA"  ; Not audited
 . D EXITACT(DVBIEN19) ; "**1** ; New subroutine for patch #1
 . Q:$D(^DVB(396.9991,"B",DVBIEN19,DVBIEN19))  ; Record already exists, not needed
 . D SUMSTUB^DVBAUDDIE(DVBIEN19) ; Create a SUMMARY stub rec.
 Q:DVBQUIT
 ;
 D PURGEOPT ; Purge AMIE AUDIT SUMMARY BY OPTION records w/OPTION=""
 ;
 D PURGEUSR ; Purge AMIE AUDIT SUMMARY BY USER   records w/USER=""
 ;
 K DVBPACK ; Manual summarization flag
 ;
 Q  ; Quit AUTOTASK
 ;
EXITACT(DVBIEN19) ; Update the EXIT ACTION of an audited OPTION that is an
 ;
 N DVBEXACTION,DVBIENOSF,DVBOPTSCH,DVBOPTNAME
 ; ZEXCEPT: DVBQUIT
 ;
 S DVBQUIT=0 ; Indicates a successful database update
 S DVBOPTNAME=$$GET1^DIQ(19,+DVBIEN19,.01) Q:DVBOPTNAME=""  ; Quit if no NAME
 S DVBIENOSF=$$FIND1^DIC(19.2,"","BO",DVBOPTNAME) Q:'DVBIENOSF  ;Quit if no IEN
 S DVBEXACTION("BEF")=$$GET1^DIQ(19,DVBIEN19,15)
 Q:DVBEXACTION("BEF")["PTIME^DVBAUDOA"  ; PTIME already exists, quit
 ;
 D OPTSCH^DVBAUDDIQ(DVBIENOSF) ; Place #19.2 data in DVBOPTSCH(array)
 Q:'$$OPTSCHOK^DVBAUDU1($T(+0),.DVBOPTSCH)  ; Option is screened
 ;
 S DVBEXACTION("AFT")="D PTIME^DVBAUDOA" I DVBEXACTION("BEF")'="" D  ;
 . S DVBEXACTION("AFT")="D PTIME^DVBAUDOA "_DVBEXACTION("BEF")
 ;
 N DIERR,DVBERRMSG,DVBFDA,DVBFILE,DVBIENS
 N %,DIC ; Variables left behind during testing
 N DG,DICR,DIW ; Covers editing of audited fields
 ;
 S DVBIENS=DVBIEN19_",",DVBFILE=19
 S DVBFDA(DVBFILE,DVBIENS,15)=DVBEXACTION("AFT") ; Option EXIT  ACTION
 ;
 D FILE^DIE("E","DVBFDA","DVBERRMSG") ; ICR #1282
 D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","ENTRYACT^"_$T(+0)) Q:DVBQUIT
 ;
 Q  ; Quit EXITACT
 ;
PACK ; Summarize individual audit EVENT records from file #396.999
 ;
 N DVBCNT,DVBBEG,DVBOPTION,DVBPACK,DVBQUIT
 ; ZEXCEPT: IOF,IOST
 ;
 S DVBOPTION="Summarize Audit Records"
 W @IOF,!?1,"*** ",DVBOPTION," ***",! S DVBQUIT=0
 S DVBPACK=1 ; Indicates summarization is performed manually
 ;
 D PACKMSG ; Display message on what is about to happen
 D PACKOK G:DVBQUIT PACKX ; Prompt: Ok to continue?
 ;
 S DVBBEG=$$NOW^XLFDT()
 S DVBCNT=0 ; Number of AMIE OPTION AUDIT EVENT records processed
 ;
 D AUTOTASK
 ;
 I IOST["C-" D  ;
 . W !!,"Process completed...",!
 . I DVBCNT D  ;
 . . W ?1,DVBCNT," Audit DETAIL Record",$S(DVBCNT>1:"s",1:"")
 . . W " Summarized!"
 . D PROCTIME^DVBAUDPRT1(DVBBEG) ; Display proceccing time
 . D CONTINUE^DVBAUDPRT1 ;....... Press <Enter> to continue
 ;
PACKX ; Exit PACK (for GO TO statement above)
 Q  ; Quit PACK
 ;
PACKMSG ; Display a message concerning the summary process to the user.
 ; ZEXCEPT: IOF,DVBOPTION
 ;
 W !,"This option will loop thru the AMIE OPTION AUDIT EVENT file"
 W !,"(#396.999).  Each audited event record will be summarized into"
 W !,"two separate files:"
 W !
 W !,"  1. AMIE AUDIT SUMMARY BY OPTION file #396.9991, and"
 W !,"  2. AMIE AUDIT SUMMARY BY USER   file #396.9992"
 W !
 W !,"After all audited event records are summarized, the summary"
 W !,"information will be reflected in the various output reports"
 W !,"associated with the package.  Any AMIE OPTION AUDIT EVENT"
 W !,"record which is summarized will automatically be purged."
 W !
 W !,"   Note: As new audit events are collected throughout a"
 W !,"         workday, these events will NOT be reflected in the"
 W !,"         output reports until after the next audit"
 W !,"         summarization has completed."
 ;
 D CONTINUE^DVBAUDPRT1(2,"R") W @IOF,!?1,"*** ",DVBOPTION," ***"
 ;
 W !
 W !,"Running this option is the best way to ensure that all the"
 W !,"latest audit events are included as part of the output reports."
 W !
 W !,"This package also includes a 'Summarize Audit Records (Auto"
 W !,"Tasked)' option, designed to run in the background as a scheduled"
 W !,"task on a regularly recurring basis.  Please refer to the package"
 W !,"documentation for an example of how this might be implemented at"
 W !,"your site."
 W !
 W !,"Caution:  If you plan to audit options which are regularly"
 W !,"          scheduled tasks, it is recommended that you avoid"
 W !,"          setting up audits for scheduled tasks that run"
 W !,"          multiple times within a single work day.  For"
 W !,"          example, if a regularly scheduled option has a"
 W !,"          'RESCHEDULING FREQUENCY: 120S' (every two minutes"
 W !,"          (or 120 seconds)), do not audit this task to avoid"
 W !,"          too much data collection in the AMIE AUDIT OPTION"
 W !,"          EVENT file (#396.999)."
 W !
 D CONTINUE^DVBAUDPRT1(2,"R")
 W @IOF,!?1,"*** ",DVBOPTION," ***",!
 ;
 Q  ; Quit PACKMSG
 ;
PACKOK ; Prompt user with 'OK to continue? NO// '
 ;
 N @($$DICN^DVBAUDNEW1())
 ; ZEXCEPT: %,IOF,IOM,DVBOPTION,DVBQUIT
PACKOK1 ; Return here after user enters a question mark
 W !
 W "  Ok to continue"
 S %=2 D YN^DICN ; Set default response to NO and prompt user
 ;
 ; Output of variable % from YN^DICN:
 ;    %.......-1   User entered ^
 ;             0   User entered ?
 ;             1   User entered YES
 ;             2   User entered NO
 ;
 ; User entered a '?'
 I %=0 D  G PACKOK1
 . D CENTER^DVBAUDPRT1("You must respond by entering YES or NO",2,IOM,1)
 . D CONTINUE^DVBAUDPRT1(2,"R") ; Press <Enter> to continue
 . W @IOF,!?1,"*** ",DVBOPTION," ***",! S DVBQUIT=0
 ;
 ; User entered an '^' or 'NO' response, set quit flag & quit
 I %=-1!(%=2) S DVBQUIT=1 Q
 ;
 ; User entered a 'YES' response
 S DVBQUIT=0 ; Response was YES, do not quit.
 ;
 Q  ; Quit PACKOK & PACKOK1
 ;
PURGEVNT ; 3. Purge AMIE OPTION AUDIT EVENT recs w/E-PURGE FLAG?="YES"                           could not be determined.
 N DVBIENEVENT
 ;
 S DVBIENEVENT=0
 F  S DVBIENEVENT=$O(^DVB(396.999,"APURGE",1,DVBIENEVENT)) Q:'DVBIENEVENT  D  ;
 . D DELEVENT^DVBAUDDIK(DVBIENEVENT) ; Delete the DETAIL record
 ;
 Q  ; Quit PURGEVNT
 ;
PURGEOPT ; 
 ;
 N DVBIEN19
 ;
 ;
 S DVBIEN19="" ; DVBIEN19 = IEN pointer to the OPTION file #19
 F  S DVBIEN19=$O(^DVB(396.9991,"B",DVBIEN19)) Q:DVBIEN19=""  D  ;
 . N DIERR,DVBOPTNAME,DVBOPTTYPEI,DVBERRMSG
 . ;
 . S DVBOPTNAME=$$GET1^DIQ(19,+DVBIEN19,.01,"E") ; Option NAME
 . S DVBOPTTYPEI=$$GET1^DIQ(19,+DVBIEN19,4,"I") ;Option TYPE internal format
 . ;
 . I DVBOPTTYPEI]"","AEIMPRXSC"[DVBOPTTYPEI,DVBOPTNAME'="" Q  ; Do not purge
 . ;
 . D USEROPT^DVBAUDDIK(DVBIEN19) ; AMIE AUDIT SUMMARY BY USER
 . D OPTSUM^DVBAUDDIK(DVBIEN19) ;. AMIE AUDIT SUMMARY BY OPTION
 ;
 Q  ; Quit PURGEOPT
 ;
PURGEUSR ; 
 ;
 N DVBIEN200
 ;
 S DVBIEN200=0
 F  S DVBIEN200=$O(^DVB(396.9992,DVBIEN200)) Q:'DVBIEN200  D  ;
 . N DIERR,DVBERRMSG,DVBUSERNAME
 . S DVBUSERNAME=$$GET1^DIQ(200,DVBIEN200,.01,"E")
 . Q:DVBUSERNAME'=""  ;........... Quit, USER NAME identified
 . D USERSUM^DVBAUDDIK(DVBIEN200) ; Delete AMIE AUDIT SUMMARY BY USER rec
 ;
 Q  ; Quit PURGEUSR
 ;
TASKED() ; Extrinsic function, Output VALUE (0 or 1)
 N DVBMAXLIMIT
 ; ZEXCEPT: DVBEVENT
 ;
 I DVBEVENT("TASKEDI")'=1!DVBEVENT("DTENDEDI") Q 0
 ;
 S DVBMAXLIMIT=$$FMADD^XLFDT($$NOW^XLFDT(),-2) ; 2 days ago (48 hours)
 ;
 ; IF the tasked EVENT has been running for 2 days, allow it to summarize
 I DVBEVENT("TASKEDI")=1,DVBEVENT("DTEVENTI")<DVBMAXLIMIT Q 0
 ;
 Q 1 ; Quit TASKED extrinsic function
