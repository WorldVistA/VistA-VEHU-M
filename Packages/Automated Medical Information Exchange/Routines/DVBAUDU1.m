DVBAUDU1 ;ALB/CP - API Calls Routine #1 ; 6/11/18 12:41pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           ^%DT      ; IA #10003 
 ;       GETS^DIQ      ; IA # 2056
 ;   $$FMDIFF^XLFDT    ; IA #10103
 ;      $$NOW^XLFDT    ; IA #10103
 ;   ^DIC(19,"B",      ; IA # 2246 & # 2509
 ;   ^DIC(19,          ; IA # 2539 & #10156
 ;   ^DIC(19.2,        ; IA # 1064
 ;
 Q 
 ;
BUILDOOO(DVBRTN,DVBEDIT,DVBOPTYPE) ; Build DVBTARGET(array) of option candidate(s)
 ;
 N DVBCNT,DVBIEN19,DVBOPTNAME,DVBOPT
 ; ZEXCEPT: IOF,IOM,DVBQUIT,DVBTARGET
 ;
 K DVBTARGET ; Refresh output array of Options meeting the criteria
 S DVBQUIT=0
 ;
 ; If any of the required input variables are missing SET DVBQUIT=1
 I $G(DVBRTN)=""!($G(DVBEDIT)="")!($G(DVBOPTYPE)="") S DVBQUIT=1 Q
 ;
 Q:DVBEDIT'=4  ; Quit, if not deleting Options out of order
 Q:"^DVBAUDOAD^"'[("^"_DVBRTN_"^")  ; Quit if not appropriate DVBRTN
 ;
 W @IOF
 W !?4,"Searching for audited Options which are OUT OF ORDER that match your"
 W !?4,"selected Option TYPE criteria.  We will be present these one at a"
 W !?4,"time to determine if you would like to remove that Option Audit."
 W !
 S DVBCNT("OPT")=0 ; Num. of Option file entries processed.
 S DVBCNT("PRE")=0 ; Num. of candidates presented for audit removal.
 ;
 S DVBOPTNAME="" ; ICR #2246 & 2509
 F  S DVBOPTNAME=$O(^DIC(19,"B",DVBOPTNAME)) Q:DVBOPTNAME=""  S DVBIEN19=0 D  ;
 . F  S DVBIEN19=$O(^DIC(19,"B",DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19  D  ;
 . . S DVBCNT("OPT")=DVBCNT("OPT")+1
 . . D DOTS^DVBAUDPRT2(DVBCNT("OPT"),400) ; Display a dot every 400 records
 . . Q:'$$OPTIONOK^DVBAUDU2(DVBRTN,DVBOPTYPE,DVBIEN19)
 . . ; Add to (or accumulate) DVBTARGET array of output options
 . . S DVBTARGET(DVBOPTNAME,DVBIEN19)=$$GET1^DIQ(19,DVBIEN19,4) ; TYPE field #4
 . . S DVBCNT("PRE")=DVBCNT("PRE")+1
 ;
 I DVBCNT("PRE")>0 D  ; Display # of candidate options found
 . N DVBMSG
 . S DVBMSG=DVBCNT("PRE")
 . S DVBMSG=DVBMSG_" Option file candidate"
 . S DVBMSG=DVBMSG_$S(DVBCNT("PRE")>1:"s",1:"") ; Add 's' if plural
 . S DVBMSG=DVBMSG_" found."
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1) ;2 linefeeds w/IOM width & rev. video
 ;
 I $O(DVBTARGET(""))="" D  Q
 . N DVBMSG
 . S DVBMSG="No inactive Option(s) were found for your selected criteria"
 . I DVBCNT("PRE")=0 S DVBMSG=DVBMSG_"." ; If no options are found add a period
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . I DVBCNT("PRE") D  ;
 . . S DVBMSG="with an ENTRY ACTION containing 'AUDIT^DVBAUDOA'."
 . . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 Q  ; Quit BUILDOOO
 ;
MSGIGNOR(DVBRTN) ; Display a warning message that option(s) will be ignored
 ;
 N DVBMSG
 ; ZEXCEPT: IOM,DVBQUIT
 ;
 S DVBQUIT=0 I $G(DVBRTN)="" S DVBQUIT=1 Q
 ;
 S DVBMSG="Options "_$S(DVBRTN="DVBAUDOAD":"without ",1:"with ")
 S DVBMSG=DVBMSG_"'D AUDIT^DVBAUDOA' in the ENTRY ACTION "
 S DVBMSG=DVBMSG_"will be ignored."
 D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 ;
 Q  ; Quit MSGIGNOR
 ;
OPTSCH(DVBRTN,DVBEDIT,DVBOPTYPE) ; Build DVBTARGET(array) of option
 ;
 N DVBCNT,DVBIEN,DVBOPTSCH,DVBFOUND
 ; ZEXCEPT: IOM,DVBQUIT,DVBTARGET
 ;
 S DVBQUIT=0
 ;
 I $G(DVBRTN)=""!($G(DVBEDIT)="")!($G(DVBOPTYPE)="") S DVBQUIT=1 Q
 ;
 Q:DVBEDIT'=3
 Q:"^DVBAUDOA^"'[("^"_DVBRTN_"^")  ; Quit if not appropriate DVBRTN
 ;
 W !!,"Searching for OPTION SCHEDULING file Options to audit which match your cr"
 ;
 S DVBCNT("OPT")=0 ; Num. of OPTION SCHEDULING file entries processed.
 ; Num. of OPTION SCHEDULING entry candidates presented for auditing.
 S DVBCNT("PRE")=0
 ; DVBFOUND, set to 1 once one Option is found matching the criteria
 S DVBFOUND=0
 ;
 K DVBTARGET ; Refresh output array of wildcard selected options
 S DVBIEN=0
 F  S DVBIEN=$O(^DIC(19.2,DVBIEN)) Q:'DVBIEN  D  ;
 . S DVBCNT("OPT")=DVBCNT("OPT")+1
 . Q:'$D(^DIC(19.2,DVBIEN,0))  ; No zero node found for the DVBIEN
 . ;
 . N DVBOPT,DVBOPTSCH
 . ;
 . ; Retrieve DVBOPTSCH(array) of data fields from file 19.2
 . D OPTSCH^DVBAUDDIQ(DVBIEN) Q:DVBQUIT
 . ; Retrieve DVBOPT(array) of data fields from file 19
 . D OPTION^DVBAUDDIQ(DVBOPTSCH("DVBIEN19")) Q:DVBQUIT
 . ;
 . Q:'$$OPTIONOK^DVBAUDU2(DVBRTN,DVBOPTYPE,DVBOPTSCH("DVBIEN19"))
 . I DVBRTN="DVBAUDOA" Q:'$$OPTSCHOK(DVBRTN,.DVBOPTSCH)  ; Does not qualify
 . ;
 . Q:$D(DVBTARGET(DVBOPTSCH("OPTNAME"),DVBOPTSCH("DVBIEN19")))  ; Target exists
 . S DVBFOUND=1
 . ;
 . ; Add to (or accumulate) DVBTARGET array of output options
 . S DVBTARGET(DVBOPTSCH("OPTNAME"),DVBOPTSCH("DVBIEN19"))=DVBOPT("TYPE")
 . S DVBCNT("PRE")=DVBCNT("PRE")+1 ; Count Options presented for auditing
 ;
 I DVBCNT("PRE")>1 D  ; Display number of DVBTARGET options found
 . N DVBMSG
 . ; ZEXCEPT: IOM
 . S DVBMSG="I found "_DVBCNT("PRE")_" candidate Options matching your criteria and"
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . S DVBMSG="I will now present these one at a time for your approval!"
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 I $O(DVBTARGET(""))="",DVBRTN'="DVBAUDU1" D  Q  ;
 . N DVBMSG
 . S DVBMSG="No active Option(s) were found for your selected criteria"
 . I DVBFOUND=0 S DVBMSG=DVBMSG_"." ; When no options are found, add a period
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . I DVBFOUND D  ;
 . . I DVBRTN="DVBAUDOA" S DVBMSG="that are not already audited."
 . . I DVBRTN="DVBAUDOAD" S DVBMSG="with an ENTRY ACTION containing 'D AUDIT^DVBAUDOA'."
 . . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 Q  ; Quit OPTSCH
 ;
OPTSCHOK(DVBRTN,DVBOPTSCH) ; Extrinsic function
 ;
 N DVBVAL
 S DVBVAL=0
 ;
 ; If any of the required input variables are missing SET DVBQUIT=1
 S DVBQUIT=0
 I DVBRTN="" S DVBQUIT=1 Q  ; Missing required DVBRTN input variable
 I $O(DVBOPTSCH(""))="" S DVBQUIT=1 Q  ; Missing required input array
 ;
 Q:"^DVBAUDDIE^DVBAUDOA^DVBAUDOAS^DVBAUDU3S^"'[("^"_DVBRTN_"^")  ; **1**
 ;
 I DVBOPTSCH("TASKID")>0,DVBOPTSCH("QTORUNTIMEI")>$$NOW^XLFDT() D  ;
 . Q:DVBOPTSCH("FREQ")=""  ; RESCHEDULING FREQUENCY is null
 . ;
 . I "H"=$E(DVBOPTSCH("FREQ"),$L(DVBOPTSCH("FREQ"))),DVBOPTSCH("FREQ")<24 Q
 . ;
 . I "S"=$E(DVBOPTSCH("FREQ"),$L(DVBOPTSCH("FREQ"))) Q
 . S DVBVAL=1 ; Option qualifies; all criteria has been met
 ;
 Q DVBVAL ; Quit $$OPSCHOK extrinsic
 ;
PGMACCSS(DVBRTN,DUZ) ; Determine if user's DUZ(0) has programmer (@) access
 ;
 ; ZEXCEPT: DVBQUIT
 S DVBQUIT=0 ; Default the return quit variable to successful.
 ;
 Q:$G(DUZ(0))["@"  ; Quit if the user has programmer access
 ;
 W !
 ;
 I DVBRTN="DVBAUDOA" D  ;
 . W !?5
 . D REVVIDEO^DVBAUDPRT1("ON")
 . W "Access denied - Only users with programmer access may initiate"
 . D REVVIDEO^DVBAUDPRT1("OFF")
 . W !?5
 . D REVVIDEO^DVBAUDPRT1("ON")
 . W "the Option Audit process for various VistA package options."
 . D REVVIDEO^DVBAUDPRT1("OFF")
 ;
 I DVBRTN="DVBAUDOAD" D  ;
 . W !?5
 . D REVVIDEO^DVBAUDPRT1("ON")
 . W "Access denied - Only users with programmer access may delete"
 . D REVVIDEO^DVBAUDPRT1("OFF")
 . W !?5
 . D REVVIDEO^DVBAUDPRT1("ON")
 . W "existing Option Audit's from the OPTION file's ENTRY ACTION."
 . D REVVIDEO^DVBAUDPRT1("OFF")
 ;
 D CONTINUE^DVBAUDPRT1(2,"R")
 S DVBQUIT=1
 ;
 Q  ; Quit PGMACCSS
 ;
PROCTIME(DVBIEN19,DVBOCCURIEN) ; Returns the processing time for the
 ;
 N DVBOCCRMULT,DVBTIMEBEG,DVBTIMEEND,DVBVAL
 N %,DVBDAYS,DVBDIFF,DVBHRS,DVBMINS,DVBSECS
 N @($$%DT^DVBAUDNEW1())
 ; ZEXCEPT: %DT,X,Y
 ;
 S DVBVAL="" ; Initialize output from extrinsic function to null
 ;
 ; Validate input variables
 ;
 Q:'$G(DVBIEN19) DVBVAL
 Q:'$G(DVBOCCURIEN) DVBVAL
 Q:$$GET1^DIQ(396.9991,DVBIEN19,.01,"I")'=DVBIEN19 DVBVAL
 Q:'$D(^DVB(396.9991,DVBIEN19,"OCCUR","B",DVBOCCURIEN,DVBOCCURIEN)) DVBVAL
 D OCCRMULT^DVBAUDDIQ(DVBIEN19,DVBOCCURIEN)
 S DVBTIMEBEG=DVBOCCRMULT("TIMEBEG") ; Internal O-DATE/TIME TASKED AUDIT BEGAN
 S DVBTIMEEND=DVBOCCRMULT("TIMEEND") ; Internal O-DATE/TIME TASKED AUDIT ENDED
 ;
 S %DT="ST"
 S X=DVBTIMEBEG
 K Y D ^%DT I Y=-1!($P(DVBTIMEBEG,".")'?7N) Q ""
 S X=DVBTIMEEND
 K Y D ^%DT I Y=-1!($P(DVBTIMEEND,".")'?7N) Q ""
 ;
 S DVBDIFF=$$FMDIFF^XLFDT(DVBTIMEEND,DVBTIMEBEG,3) ; Returns: DD HH:MM:SS
 ;
 ; Convert processing time to external format and display results
 ;
 S DVBDAYS=+$P(DVBDIFF," ")
 S DVBHRS=+$P($P(DVBDIFF," ",2),":")
 S DVBMINS=+$P($P(DVBDIFF," ",2),":",2)
 S DVBSECS=+$P($P(DVBDIFF," ",2),":",3)
 S:DVBSECS="" DVBSECS=1
 S:DVBDAYS DVBVAL=DVBVAL_" DAYS: "_DVBDAYS
 S:DVBHRS DVBVAL=DVBVAL_"  HOURS: "_DVBHRS
 S:DVBMINS DVBVAL=DVBVAL_"  MINS: "_DVBMINS
 S:DVBSECS DVBVAL=DVBVAL_"  SECS: "_DVBSECS
 S DVBVAL=$E(DVBVAL,3,999)
 ;
 Q DVBVAL ; Quit $$PROCTIME extrinsic
 ;
SELWILD(DVBEDIT) ; Prompt "Select an Option NAMESPACE with wild card '*': "
 ;
 ; ZEXCEPT: DTIME,IOM,DVBNAMSPC,DVBQUIT,DVBTEXT
 ;
 S DVBNAMSPC="" ; Default the output namespace to null.
 S DVBQUIT=0 ;... Default the return quit variable to successful.
 I $G(DVBEDIT)="" S DVBQUIT=1 Q
 Q:DVBEDIT'=2  ; Quit, if not editing by wildcard character (*)
SELWILD1 ;
 W !!
 R "Select an Option NAMESPACE with wild card '*': ",DVBNAMSPC:DTIME
 I "^"[DVBNAMSPC S DVBQUIT=1 Q  ; User hit <Enter> or entered '^', exit
 I $E(DVBNAMSPC,$L(DVBNAMSPC),$L(DVBNAMSPC))'="*"!(DVBNAMSPC["?") D  G SELWILD1
 . N DVBTEXT
 . W:DVBNAMSPC'["?" " ??"
 . S DVBTEXT="For example, if the package namespace is 'DGZ' enter 'DGZ*'"
 . D CENTER^DVBAUDPRT1(DVBTEXT,2,IOM,1)
 Q  ; Quit SELWILD & SELWILD1
