DVBAUDDIC ;ALB/CP - FM DIC API Subroutine Calls ; 3/27/18 3:33pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           ^DIC   ; IA #10006
 ;     $$GET1^DIQ   ; IA # 2056
 ;
 Q
BUILD ; Prompt for "Select BUILD NAME: "
 ;
 N @($$DIC^DVBAUDNEW1())
 ; ZEXCEPT: DVBBUILD,DVBQUIT
 ;
 S DVBQUIT=0 ; Default to successful lookup
 S DIC="^XPD(9.6,",DIC(0)="AEMQ"
 D ^DIC I Y<0 S DVBQUIT=1
 S DVBBUILD=$P(Y,U,2)
 ;
 Q  ; Quit BUILD
 ;
ENTRIES(DVBCNT) ; Internal subroutine
 ;   Display number of unique entries when DVBCNT>1
 ; Input:
 ;   DVBCNT ; Required ; Number of unique entries selected via DIC call
 ;
 N DVBMSG Q:DVBCNT'>1
 ; ZEXCEPT: IOM
 ;
 S DVBMSG="Number of unique entries selected: "_DVBCNT
 D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1) ;Center message using reverse video
 ;
 Q  ; Quit ENTRIES
 ;
OPTSIN(DVBRTN,DVBEDIT,DVBOPTYPE) ; FM DIC API to select multiple OPTIONs
 ;
 N @($$DIC^DVBAUDNEW1())
 N DVBDST,DVBDIALLVAL,DVBPOS
 ; ZEXCEPT: DIC,DVBQUIT,DVBTARGET,X,Y
 ;
 S DVBQUIT=0 ; Initialize quit status variable to No (for successful).
 K DVBTARGET ; Refresh output array of selected options
 ;
 ; Verify that required input variables are passed.
 I $G(DVBRTN)="" S DVBQUIT=1 Q  ; Routine name missing
 I $G(DVBEDIT)'=1 S DVBQUIT=1 Q  ; Missing or invalid DVBEDIT (can only be one)
 I $L($G(DVBOPTYPE))'>0 S DVBQUIT=1 Q
 F DVBPOS=1:1:$L(DVBOPTYPE) I "AEIMPRXSC"'[$E(DVBOPTYPE,DVBPOS,DVBPOS) S DVBQUIT=1 Q
 ;
 ;
 S DIC("S")="N DVBTYPE S DVBTYPE=$$GET1^DIQ(19,+Y,4,""I"") I DVBTYPE]""""" ;Screen 1
 S DIC("S")=DIC("S")_",DVBOPTYPE[DVBTYPE" ; User selected Option TYPE ;..Screen 2
 S DIC("S")=DIC("S")_",'$D(DVBTARGET($$GET1^DIQ(19,+Y,.01)))" ;.......Screen 3
 I DVBRTN="DVBAUDOA" D  ; Routine to apply the AMIE audit
 . S DIC("S")=DIC("S")_",$$GET1^DIQ(19,+Y,2)=""""" ;.................Screen 4
 . S DIC("S")=DIC("S")_",$$GET1^DIQ(19,+Y,20)'[""AUDIT^DVBAUDOA""" ;..Screen 5
 I DVBRTN="DVBAUDOAD" D  ; Routine to delete AMIE audit
 . S DIC("S")=DIC("S")_",$$GET1^DIQ(19,+Y,20)[""AUDIT^DVBAUDOA""" ;...Screen 6
 ;
 S DIC="^DIC(19," ; OPTION file #19
 S DIC("A")=" Select OPTION NAME: "
 S DIC(0)="AEQM"
 S DVBTARGET("CNT")=0
 ;
 W !
 F  D  Q:DVBQUIT
 . D ^DIC
 . I Y<1 S DVBQUIT=1 Q  ; User entered a "^" to exit.
 . S DVBTARGET($P(Y,U,2),+Y)=$$GET1^DIQ(19,+Y,4) ; 4 = DVBTYPE (external)
 . S DVBTARGET("CNT")=DVBTARGET("CNT")+1
 . ; Modify prompt text after first Option entry is selected.
 . I DVBTARGET("CNT")=1 S DIC("A")="     Another OPTION: "
 I X="^" S DVBQUIT=1 K DVBTARGET Q
 I $O(DVBTARGET(""))']"" S DVBQUIT=1 K DVBTARGET Q
 ;
 D ENTRIES(DVBTARGET("CNT")) ; Display num. of unique entries selected
 S DVBQUIT=0
 ;
 Q  ; Quit OPTSIN
 ;
OPTSOUT(DVBDIC0,DVBLIMIT,DVBSCREEN,DVBPROMPT) ; Prompt for one to many entries
 ;   from the AMIE AUDIT SUMMARY BY OPTION file #396.9991
 ;
 ; From:
 ;  PROMPT^DVBAUDUU  ; Audited Option User Utilization
 ;
 N @($$DIC^DVBAUDNEW1())
 N DVBDST,DVBIEN19,DVBCNT,DVBNAME
 ; ZEXCEPT: DIC,DLAYGO,DVBOPT,DVBQUIT,X,Y
 ;
 S DVBCNT=0 ;.... Initialize number of selected records to zero
 S DVBQUIT=0 ;... Initialize quit status variable to No
 ;
 ; Verify that required input variables were passed
 I $G(DVBDIC0)']"" S DVBQUIT=1 Q
 I $A($E($G(DVBLIMIT)))'>47 S DVBQUIT=1 Q
 ;
 K DVBOPT ; Refresh output array
 S DVBOPT("CNT")=0 ; Initialize output count to zero
 ;
 S DIC(0)=DVBDIC0 ; Attributes are required on parameter passing input
 ;
 ; DVBLIMIT must be an integer, zero or greater than 0
 I '$$POSINT^DVBAUDSTR1(DVBLIMIT) S DVBQUIT=2 Q
 ;
 S DVBSCREEN=$G(DVBSCREEN,0)
 I DVBSCREEN=0 K DIC("S")
 I DVBSCREEN=1 S DIC("S")="I '$D(DVBOPT(Y))" ; OPTION not prev. selected
 ;
 S DIC="^DVB(396.9991,"
 I DIC(0)["L" S DLAYGO=396.9991 ; Set DLAYGO to add a record
 ;
 S DVBPROMPT=$G(DVBPROMPT,"Select Audited OPTION NAME: ")
 S DIC("A")=DVBPROMPT
 ;
 W !
 F  D  Q:DVBQUIT
 . N DIERR,DVBERRMSG ; FM database server call error indicator
 . D ^DIC I X["^" S DVBQUIT=2 Q  ; DVBQUIT=2 on user '^'
 . I Y<0 S DVBQUIT=1 Q  ; User is finished selecting records
 . S DVBIEN19=$P(Y,U) ; Entries are DINUMed to New Person file
 . S DVBNAME=$$GET1^DIQ(396.9991,DVBIEN19,.01,"E",,"DVBERRMSG")
 . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","OPTION^"_$T(+0)) Q:DVBQUIT
 . Q:$D(DVBOPT(DVBIEN19))  ; Entry already selected
 . S DVBOPT(DVBIEN19)=DVBNAME ; Selected record IEN list
 . S DVBOPT("B",DVBNAME,DVBIEN19)="" ; Alphabetic name 'B' x-ref
 . S DVBCNT=DVBCNT+1 ; Count of the number of unique entries selected
 . I DVBLIMIT>0,DVBCNT=DVBLIMIT S DVBQUIT=1
 . I $O(DVBOPT(0)) S DIC("A")="       Another OPTION NAME: "
 ;
 Q:DVBQUIT=2  ;. User entered "^" to quit
 I $O(DVBOPT(0)) S DVBQUIT=0 ; User's selection, no '^', don't quit
 S DVBOPT("CNT")=DVBCNT ; Count of uniques selected
 ;
 D ENTRIES(DVBCNT) ; Display number of unique entries selected
 ;
 Q  ; Quit OPTSOUT
 ;
USER(DVBDIC0,DVBLIMIT,DVBSCREEN,DVBPROMPT) ; Prompt for one to many entries
 ;   from the AMIE AUDIT SUMMARY BY USER file #396.9992
 ;
 ;  PROMPT^DVBAUDUI  ; User Audit Summary Inquiry
 ;
 N @($$DIC^DVBAUDNEW1())
 N DVBDST,DVBIEN200,DVBCNT,DVBNAME
 ; ZEXCEPT: DIC,DLAYGO,DVBUSER,DVBQUIT,X,Y
 ;
 S DVBCNT=0 ;.... Initialize number of selected records to zero
 S DVBQUIT=0 ;... Initialize quit status variable to No
 ;
 ; Verify that required input variables were passed
 I $G(DVBDIC0)']"" S DVBQUIT=1 Q
 I $A($E($G(DVBLIMIT)))'>47 S DVBQUIT=1 Q
 ;
 K DVBUSER ; Refresh output array
 S DVBUSER("CNT")=0 ; Initialize output count to zero
 ;
 S DIC(0)=DVBDIC0 ; Attributes are required on parameter passing input
 ;
 ; DVBLIMIT must be an integer, zero or greater than 0
 I '$$POSINT^DVBAUDSTR1(DVBLIMIT) S DVBQUIT=2 Q
 ;
 S DVBSCREEN=$G(DVBSCREEN,0)
 I DVBSCREEN=0 K DIC("S")
 I DVBSCREEN=1 S DIC("S")="I $$ACTIVE^XUSER(Y)" ; Only active users
 ;
 S DIC="^DVB(396.9992,"
 I DIC(0)["L" S DLAYGO=396.9992 ; Set DLAYGO when adding to the database.
 ;
 S DVBPROMPT=$G(DVBPROMPT,"Select USERNAME: ")
 S DIC("A")=DVBPROMPT
 ;
 W !
 F  D  Q:DVBQUIT
 . N DIERR,DVBERRMSG ; FM database server call error indicator
 . D ^DIC I X["^" S DVBQUIT=2 Q  ; DVBQUIT=2 on user '^'
 . I Y<0 S DVBQUIT=1 Q  ; User is finished selecting records
 . S DVBIEN200=$P(Y,U) ; Entries are DINUMed to New Person file
 . S DVBNAME=$$GET1^DIQ(200,DVBIEN200,.01,"E",,"DVBERRMSG")
 . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","USER^"_$T(+0)) Q:DVBQUIT
 . Q:$D(DVBUSER(DVBIEN200))  ; Entry already selected
 . S DVBUSER(DVBIEN200)=DVBNAME ; Selected record IEN list
 . S DVBUSER("B",DVBNAME,DVBIEN200)="" ; Alphabetic name 'B' x-ref
 . S DVBCNT=DVBCNT+1 ; Count of the number of unique entries selected
 . I DVBLIMIT>0,DVBCNT=DVBLIMIT S DVBQUIT=1
 . I $O(DVBUSER(0)) S DIC("A")="   Another USER: "
 ;
 Q:DVBQUIT=2  ;. User entered "^" to quit
 I $O(DVBUSER(0)) S DVBQUIT=0 ; User's selection, no '^', don't quit
 S DVBUSER("CNT")=DVBCNT ; Count of uniques selected
 ;
 D ENTRIES(DVBCNT) ; Display number of unique entries selected
 ;
 Q  ; Quit USER
