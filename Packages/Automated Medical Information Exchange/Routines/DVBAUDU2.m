DVBAUDU2 ;ALB/CP - API Calls Routine #2;02/26/18  13:11 ; 4/12/18 6:06pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;         GETS^DIQ      ; # 2056
 ;   ^DIC(19,    ; IA # 2246
 ;   ^DIC(19.2,  ; IA # 1064
 Q
 ;
BUILDOS(DVBRTN,DVBEDIT,DVBOPTYPE) ; Build DVBTARGET(OptionName,OptionIEN)=""
 ;
 N DVBCNT,DVBIEN,DVBFOUND,DVBQUIT
 ; ZEXCEPT: IOF,IOM,DVBTARGET
 ;
 S DVBQUIT=0 ; Default to a successful search and build
 ;
 Q:DVBEDIT'=3  ;Quit if not deleting Options out of order from DVBAUDOAD
 Q:"^DVBAUDOAD^"'[("^"_DVBRTN_"^")  ; Quit if not appropriate DVBRTN
 ;
 S DVBCNT("OPT")=0 ; Num. of OPTION SCHEDULING file entries processed.
 ; Num. of OPTION SCHEDULING entry candidates presented for auditing.
 S DVBCNT("PRE")=0
 ; DVBFOUND, set to 1 once one Option is found matching the criteria
 S DVBFOUND=0
 ;
 K DVBTARGET ; Refresh output array of Options meeting the criteria
 ;
 W @IOF
 W !?2,"Searching for OPTION SCHEDULING file audits which match your criteria"
 W !
 S DVBIEN=0
 F  S DVBIEN=$O(^DIC(19.2,DVBIEN)) Q:'DVBIEN!DVBQUIT  D  ;
 . S DVBCNT("OPT")=DVBCNT("OPT")+1
 . D DOTS^DVBAUDPRT2(DVBCNT("OPT"),25) ; Displays a '.' every 50 records
 . Q:'$D(^DIC(19.2,DVBIEN,0))  ; No zero node found for the DVBIEN
 . ;
 . ; Retreive OPTION SCHEDULING file #19.2 and OPTION file #19 data
 . N DVBOPT,DVBOPTSCH
 . ;
 . ; Retrieve DVBOPTSCH(array) of data fields from file 19.2
 . D OPTSCH^DVBAUDDIQ(DVBIEN) Q:DVBQUIT
 . ; Retrieve DVBOPT(array) of data fields from file 19
 . D OPTION^DVBAUDDIQ(DVBOPTSCH("DVBIEN19")) Q:DVBQUIT
 . ;
 . Q:DVBOPT("ENTRYACTION")'["D AUDIT^DVBAUDOA"
 . Q:'DVBOPTSCH("TASKID")
 . ;
 . ; IF  scheduled every 'X' number of seconds, do not allow auditing
 . I "S"=$E(DVBOPTSCH("FREQ"),$L(DVBOPTSCH("FREQ"))) Q
 . ;
 . ; IF  hourly and less than 24H quit, do not allow auditing
 . I "H"=$E(DVBOPTSCH("FREQ"),$L(DVBOPTSCH("FREQ"))),DVBOPTSCH("FREQ")<24 Q
 . ;
 . S DVBFOUND=1
 . ; Add to (or accumulate) DVBTARGET array of output options
 . S DVBTARGET(DVBOPTSCH("OPTNAME"),DVBOPTSCH("DVBIEN19"))=DVBOPT("TYPE")
 . S DVBCNT("PRE")=DVBCNT("PRE")+1 ; Count Options presented for auditing
 Q:DVBQUIT
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
 . S DVBMSG="No regularly scheduled options were found for your selected criteria"
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . S DVBMSG="with an ENTRY ACTION containing 'D AUDIT^DVBAUDOA'."
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 Q  ; Quit BUILDOS
 ;
OPTBUILD(DVBRTN,DVBEDIT,DVBOPTYPE,DVBNAMSPC) ; Build DVBTARGET(array) of option
 ;
 N DVBCNT,DVBOPTNAME,DVBFOUND,DVBOPT
 ; ZEXCEPT: DVBACTION,IOM,DVBTARGET
 ;
 Q:DVBEDIT'=2  ;Quit, if not editing by prefix w/wildcard (*)/namespace
 ; Quit if not appropriate DVBRTN
 Q:"^DVBAUDOA^DVBAUDOAD^DVBAUDU3^"'[("^"_DVBRTN_"^")
 ;
 ; DVBFOUND, set to 1 once one Option is found matching DVBNAMSPC
 S DVBFOUND=0
 ;
 W !
 I DVBRTN="DVBAUDOA" D  ;
 . W !,"Searching for Options to audit which match your criteria..."
 I DVBRTN="DVBAUDOAD" D  ;
 . W !,"Searching for audited Options which match your criteria..."
 ;
 ; DVBEDIT=2 Options for a selected NAMESPACE (used with wildcard '*')
 ;
 K DVBTARGET ; Refresh output array
 S DVBCNT=0 ; Number of target options for editing ENTRY DVBACTION.
 S DVBOPT=$P(DVBNAMSPC,"*",1) ; PREFIX selected in SELWILD1^DVBAUDU1
 S DVBOPTNAME=$E(DVBOPT,1,$L(DVBOPT)-1)_$C($A($E(DVBOPT,$L(DVBOPT)))-1)
 F  S DVBOPTNAME=$O(^DIC(19,"B",DVBOPTNAME)) Q:DVBOPTNAME=""!($E(DVBOPTNAME,1,$L(DVBOPT))]"DVBA")  D
 . N DVBIEN19
 . ; Needed for AMIE to avoid R1 options
 . Q:$E(DVBOPTNAME,1,$L(DVBOPT))'=DVBOPT
 . ; Option file #19 internal entry number
 . S DVBIEN19=$O(^DIC(19,"B",DVBOPTNAME,0))
 . S DVBFOUND=1 ; Indicates that an Option was found for the selected DVBNAMSPC
 . Q:'$$OPTIONOK(DVBRTN,DVBOPTYPE,DVBIEN19)
 . ;
 . ; Add the Option to the list of DVBTARGET array of output options
 . S DVBTARGET(DVBOPTNAME,DVBIEN19)=$$GET1^DIQ(19,DVBIEN19,4) ; TYPE field #4
 . S DVBCNT=DVBCNT+1
 ;
 I DVBCNT>1 D  ; Display number of DVBTARGET options found
 . N DVBMSG
 . ; ZEXCEPT: IOM
 . S DVBMSG="I found "_DVBCNT_" candidate Options matching your criteria"
 . S DVBMSG=DVBMSG_$S(DVBRTN="DVBAUDU3":".",1:"")
 . Q:DVBRTN="DVBAUDU3"
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . S DVBMSG="and I will now present these one at a time"
 . S DVBMSG=DVBMSG_" for your approval!"
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 I $O(DVBTARGET(""))="",DVBRTN="DVBAUDOA" D  ;
 . N DVBMSG
 . S DVBMSG="No active Option(s) were found for the namespace of '"
 . S DVBMSG=DVBMSG_DVBNAMSPC_"'"
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . S DVBMSG="that match your selection criteria"
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . S DVBMSG="that are not already audited."
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 I $O(DVBTARGET(""))="",DVBRTN="DVBAUDOAD" D  Q  ; If no target opts found
 . N DVBMSG
 . S DVBMSG="No active Option(s) were found for the namespace of "
 . S DVBMSG=DVBMSG_"'"_$S($D(DVBNAMSPC):DVBNAMSPC,1:DVBNAMESPC)_"'"
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . S DVBMSG="for your selected criteria"
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . S DVBMSG="with an ENTRY ACTION containing 'D AUDIT^DVBAUDOA'."
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 Q  ; Quit OPTBUILD
 ;
OPTIONOK(DVBRTN,DVBOPTYPE,DVBIEN19) ; Extrinsic function to screen OPTION
 ; 
 N DIERR,DVBOPT,DVBQUIT,DVBRETURN
 ; ZEXCEPT: DVBACTION ; ACTION = 'BUILD' or 'DELETE'
 ; ZEXCEPT: DVBEDIT ; Value of 1 thru 4, depends on calling routine
 ;
 S DVBRETURN=0 ; Default to bypass the Option
 Q:'DVBIEN19 DVBRETURN ; Option DVBIEN not defined
 ;
 S DVBQUIT=0 D OPTION^DVBAUDDIQ(DVBIEN19) Q:DVBQUIT DVBRETURN
 Q:DVBOPT("TYPEI")="" DVBRETURN
 ; Option not target TYPE selected by user
 Q:DVBOPTYPE'[DVBOPT("TYPEI") DVBRETURN
 ;
 I $G(DVBACTION)'="DELETE","^DVBAUDOA^DVBAUDU3^"[("^"_DVBRTN_"^") D  Q DVBRETURN ;
 . Q:DVBOPT("OOOMSG")]""  ;.................. Option OUT OF ORDER MESSAGE exists
 . Q:DVBOPT("ENTRYACTION")["AUDIT^R2IVVOA"  ; ENTRY ACTION already shows an audit
 . S DVBRETURN=1 ; All screens pass for editing this DVBIEN19
 ;
 I DVBRTN="DVBAUDOAD"!($G(DVBACTION)="DELETE") D  Q DVBRETURN
 . ; DVBIEN19 not audited, nothing to delete
 . Q:DVBOPT("ENTRYACTION")'["AUDIT^DVBAUDOA"
 . I DVBEDIT=4 Q:DVBOPT("OOOMSG")=""  ; Looking only for inactive Options
 . S DVBRETURN=1 ; All screens for deleting D AUDIT^DVBAUDOA pass 4 this DVBIEN19
 ;
 Q DVBRETURN ; Quit $$OPTIONOK extrinsic
 ;
STRIPAUD(DVBACTION) ; Extrinsic function
 ;
 N DVBPOS,DVBRETURN
 ;
 I DVBACTION["D AUDIT^DVBAUDOA"!(DVBACTION["D PTIME^DVBAUDOA") D  ;
 . S:DVBACTION["D AUDIT^DVBAUDOA" DVBPOS=$F(DVBACTION,"D AUDIT^DVBAUDOA")
 . S:DVBACTION["D PTIME^DVBAUDOA" DVBPOS=$F(DVBACTION,"D PTIME^DVBAUDOA")
 . S DVBRETURN=$E(DVBACTION,1,DVBPOS-17)
 . S DVBRETURN=DVBRETURN_$P($E(DVBACTION,DVBPOS,$L(DVBACTION))," ",2,999)
 . S DVBRETURN=$$STRIPSPL^DVBAUDSTR1(DVBRETURN) ; Strip leading spaces
 ;
 I DVBACTION'["D AUDIT^DVBAUDOA",DVBACTION'["D PTIME^DVBAUDOA" S DVBRETURN=DVBACTION
 ;
 Q DVBRETURN ; Quit $$STRIPAUD extrinsic
