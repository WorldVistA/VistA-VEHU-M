DVBAUDU3S ;ALB/CP - Support calls for API routine DVBAUDU3 ; 10/15/18 1:43pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;      $$FIND1^DIC      ; IA # 2051
 ;       $$GET1^DIQ      ; IA # 2056
 Q
 ;
BUILD(DVBENTRYPT,DVBTARGET,DVBOPTYPES) ; Loop thru DVBTARGET, and
 ;
 N DVBCNT,DVBIENOSF,DVBMAXLEN,DVBOPTNAME,DVBFLAG1,DVBQUIT
 ; ZEXCEPT: DVBFLAGMP,DVBXPDNM
 ;
 S DVBOPTYPES=$G(DVBOPTYPES,"AEIPRXSC")
 ;
 S DVBCNT("SEL")=0 ; Number of DVBTARGET options selected for auditing.
 S DVBQUIT=0 ;.... Quit/terminate flag, initialized to off (0)
 S DVBMAXLEN=229 ;.. Maximum DVBLENGTH of ENTRY ACTION and EXIT ACTION
 S DVBFLAG1=1 ; 1st time flag
 ;
 S DVBOPTNAME=0
 F  S DVBOPTNAME=$O(DVBTARGET(DVBOPTNAME)) Q:(DVBOPTNAME="")!DVBQUIT  D  ;
 . N DVBIEN19
 . S DVBIEN19=0 ; DVBIEN19 is the IEN of the OPTION file #19
 . F  S DVBIEN19=$O(DVBTARGET(DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19  D  ;
 . . N DIERR,DVBENACTION,DVBEXACTION,DVBOPT,DVBERRMSG
 . . ; Quit if Option NAME no longer exists
 . . Q:$$GET1^DIQ(19,DVBIEN19,.01)=""
 . . ;
 . . ; Return DVBOPT(array) of Option file fields
 . . ;
 . . D OPTION^DVBAUDDIQ(DVBIEN19) Q:DVBQUIT
 . . Q:DVBOPT("ENTRYACTION")["D AUDIT^DVBAUDOA"  ; Only allowed one time
 . . ;
 . . Q:DVBOPTYPES'[DVBOPT("TYPEI")  ; Bypass non applicable DVBOPT. types
 . . ;
 . . S DVBENACTION("BEF")=DVBOPT("ENTRYACTION") ; ENTRY ACTION before
 . . I $L(DVBENACTION("BEF"))>DVBMAXLEN Q
 . . S DVBEXACTION("BEF")=DVBOPT("EXITACTION") ; EXIT ACTION before
 . . I $L(DVBEXACTION("BEF"))>DVBMAXLEN Q
 . . ;
 . . S DVBENACTION("AFT")="D AUDIT^DVBAUDOA"
 . . I DVBENACTION("BEF")'="" D  ;
 . . . S DVBENACTION("AFT")="D AUDIT^DVBAUDOA "_DVBENACTION("BEF")
 . . ;
 . . D EXITACT ; Format EXIT ACTION in DVBEXACTION("AFT")
 . . ;
 . . I DVBFLAG1=1 D MESSAGE(DVBENTRYPT)
 . . ;
 . . ; Update ENTRY ACTION of the OPTION DVBIEN19 entry
 . . ;
 . . D ENTRYACT^DVBAUDDIE(DVBIEN19,.DVBENACTION,.DVBEXACTION) Q:DVBQUIT
 . . S DVBCNT("SEL")=DVBCNT("SEL")+1 ; Number of options selected for audit
 . . W !?2,$J(DVBCNT("SEL"),3),". ",?6,DVBOPTNAME
 . . W ?38,$$GET1^DIQ(19,DVBIEN19,4,"E",,"DVBERRMSG"),?55,"[Option Audit Added]"
 . . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","BUILD^"_$T(+0)) Q:DVBQUIT
 . . D SUMSTUB^DVBAUDDIE(DVBIEN19) ; Create the SUMMARY record stub
 . . Q:DVBQUIT
 ;
 W !
 ;
 ; If more than 1 eligible option was presented, display statistics
 I DVBCNT("SEL")>0 D  ;
 . W !,"Number of options selected for auditing: ",DVBCNT("SEL")
 . W !
 . ;
 . W !,"Editing process complete for KIDS Build ",DVBXPDNM,"."
 . D:$G(DVBFLAGMP) CONTINUE^DVBAUDPRT1(2,"R") ; Only if a mult-package
 ;
 I DVBCNT("SEL")=0 D  ; Display number of DVBTARGET options found
 . N DVBMSG
 . ; ZEXCEPT: IOM
 . S DVBMSG="I could not find any active Options for the KIDS Build"
 . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . D CENTER^DVBAUDPRT1(DVBXPDNM,1,IOM,1)
 . S DVBMSG="that are not already audited."
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 ;
 Q  ; Quit BUILD^DVBAUDU3S
 ;
DELETE(DVBENTRYPT,DVBTARGET,DVBOPTYPES) ; Cleanup Option ENTRY & EXIT actions
 ;
 N DVBCNT,DVBDASHES,DVBENACTION,DVBLENGTH,DVBMSG
 N DVBOPTNAME,DVBFLAG1,DVBQUIT,DVBRESPONSE,DVBSPACES,DVBSUB
 ; ZEXCEPT: DVBIEN19,IOM,DVBEDIT,DVBNAMSPC,DVBTARGET,DVBXPDNM
 ;
 S DVBCNT("DEL")=0
 S $P(DVBDASHES,".",IOM+1)="" ; Line of DVBDASHES ('-')
 S $P(DVBSPACES," ",IOM+1)="" ; Line of DVBSPACES (' ')
 S DVBFLAG1=1
 ;
 S (DVBOPTNAME,DVBQUIT)=0
 F  S DVBOPTNAME=$O(DVBTARGET(DVBOPTNAME)) Q:(DVBOPTNAME="")!DVBQUIT  D  ;
 . N DVBIEN19
 . S DVBIEN19=0
 . F  S DVBIEN19=$O(DVBTARGET(DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19!DVBQUIT  D  ;
 . . N DIERR,DVBENACTION,DVBEXACTION,DVBMSG,DVBOPT,DVBERRMSG
 . . ;
 . . D OPTION^DVBAUDDIQ(DVBIEN19) Q:DVBQUIT
 . . ;
 . . Q:DVBOPT("ENTRYACTION")'["D AUDIT^DVBAUDOA"  ; No audit to delete
 . . Q:DVBOPTYPES'[DVBOPT("TYPEI")  ; Bypass non-applicable option types
 . . ;
 . . S DVBENACTION("BEF")=DVBOPT("ENTRYACTION") ; Capture ENTRY ACTION
 . . S DVBENACTION("AFT")=$$STRIPAUD^DVBAUDU2(DVBENACTION("BEF"))
 . . S DVBEXACTION("BEF")=DVBOPT("EXITACTION") ;. Capture EXIT  ACTION
 . . ;
 . . ; If first time, display informational message to the user
 . . ;
 . . I DVBFLAG1=1,DVBENTRYPT="AUDITBLD" D MESSAGE("DELBLD")
 . . I DVBFLAG1=1,DVBENTRYPT="AUDITSPC" D MESSAGE("DELSPC")
 . . ;
 . . ; **2** Begin 10/15/2018
 . . S DVBEXACTION("AFT")=DVBEXACTION("BEF") ; Initialized to prevent error
 . . ; **2** End   10/15/2018
 . . I DVBEXACTION("BEF")]"",DVBEXACTION("BEF")["D PTIME^DVBAUDOA" D  ;
 . . . S DVBEXACTION("AFT")=$$STRIPAUD^DVBAUDU2(DVBEXACTION("BEF"))
 . . ;
 . . I DVBENACTION("BEF")=DVBENACTION("AFT") D  Q  ;
 . . . W !
 . . . D REVVIDEO^DVBAUDPRT1("ON")
 . . . W !,"Note: The ENTRY ACTION is not compatible with this Delete AMIE Audit "
 . . . W !,"      utility, but is displayed in case you want to make note of th"
 . . . W !,"      for cleaning it up manually later."
 . . . D REVVIDEO^DVBAUDPRT1("OFF")
 . . . D CONTINUE^DVBAUDPRT1(2,"R")
 . . ;
 . . N DVBIENEVENT,DVBASK,DVBEDITOK
 . . S DVBASK="Y" ; Stuff, do not prompt
 . . S DVBCNT("DEL")=DVBCNT("DEL")+1
 . . D ENTRYACT^DVBAUDDIE(DVBIEN19,.DVBENACTION,.DVBEXACTION) Q:DVBQUIT
 . . ;
 . . ; Delete the OPTION DVBSUB-file entry from #396.9992 (User summaary)
 . . D USEROPT^DVBAUDDIK(DVBIEN19)
 . . ;
 . . ; Delete the SUMMARY record from #396.9991
 . . D OPTSUM^DVBAUDDIK(DVBIEN19)
 . . ;
 . . ; Delete any related events from file #396.999
 . . S DVBIENEVENT=0
 . . F  S DVBIENEVENT=$O(^DVB(396.999,"OPTION",DVBIEN19,DVBIENEVENT)) Q:'DVBIENEVENT  D  ;
 . . . D DELEVENT^DVBAUDDIK(DVBIENEVENT)
 . . W !?2,$J(DVBCNT("DEL"),2),". ",?6,DVBOPTNAME
 . . W ?38,$$GET1^DIQ(19,DVBIEN19,4,"E",,"DVBERRMSG"),?55,"[Option Audit Removed]"
 ;
 W ! ; If any Options had their audits removed, display the statistics
 ;
 I DVBCNT("DEL")>0 D  ;
 . W !,"Number of options where the AMIE audits were deleted: "
 . W DVBCNT("DEL")
 . W !
 . W !,"Editing process completed."
 . ;
 . D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 I DVBCNT("DEL")=0,DVBENTRYPT="AUDITBLD" D  ;
 . N DVBMSG
 . ; ZEXCEPT: DVBXPDNM
 . S DVBMSG="No Options were found for KIDS Build "_DVBXPDNM
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . S DVBMSG="that have 'D AUDIT^DVBAUDOA' in the ENTRY ACTION of the"
 . S DVBMSG=DVBMSG_" Option."
 . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 Q  ; Quit DELETE^DVBAUDU3S
 ;
EXITACT ; Format the EXIT ACTION field #15 for the OPTION
 ;
 N DVBIENOSF
 ;
 ; **2** Begin 10/15/2018
 S DVBEXACTION("AFT")=DVBEXACTION("BEF") ;Initialize EXIT ACTION to existing
 ; **2** End   10/15/2018
 ;
 ; Retrieve the IEN of the OPTION SCHEDULING file #19.2
 S DVBIENOSF=$$FIND1^DIC(19.2,"","BO",DVBOPT("NAME"))
 ;
 ; If the option is in the SCHEDULING OPTION file #19.2
 ;
 I DVBIENOSF,DVBEXACTION("BEF")'["D PTIME^DVBAUDOA" D  ;
 . N DVBOPTSCH ; Array of Option Scheduling attributes
 . D OPTSCH^DVBAUDDIQ(DVBIENOSF) ; Place #19.2 data in DVBOPTSCH(array)
 . Q:'$$OPTSCHOK^DVBAUDU1($T(+0),.DVBOPTSCH)  ; Option is screened
 . ;
 . S DVBEXACTION("AFT")="D PTIME^DVBAUDOA" I DVBEXACTION("BEF")'="" D  ;
 . . S DVBEXACTION("AFT")="D PTIME^DVBAUDOA "_DVBEXACTION("BEF")
 ;
 Q  ; Quit EXITACT^DVBAUDU3S
 ;
MESSAGE(DVBENTRYPT) ; Display informational message to user loading the
 ;
 ; Quit if we encounter an invalid input parameter value
 I "^AUDITBLD^AUDITSPC^DELBLD^DELSPC^"'[("^"_DVBENTRYPT_"^") Q
 ;
 S DVBFLAG1=0 ; Reset flag to zero, only displays messages the 1st time.
 ;
 I DVBENTRYPT="AUDITBLD" D  Q
 . ;
 . N DVBFOUND
 . S DVBFOUND=$G(DVBFOUND,0)
 . I $O(DVBTARGET(""))="" D  Q  ; If no target options were found
 . . N DVBMSG
 . . S DVBMSG="No active Option(s) were found for '"_DVBNAMSPC_"' for your selected"
 . . I DVBFOUND=0 S DVBMSG=DVBMSG_"." ; No options were found, add a period
 . . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . . I DVBFOUND D  ;
 . . . I DVBACTION="CREATE" S DVBMSG="that are not already audited."
 . . . I DVBACTION="DELETE" D  ;
 . . . . S DVBMSG="with an ENTRY ACTION containing 'D AUDIT^DVBAUDOA'."
 . . . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . ;
 . I $O(DVBTARGET(""))]"" D  Q  ; If target options were found
 . . W !
 . . W !?1,"Modification of eligible OPTION(s) associated with KIDS Build "
 . . D CENTER^DVBAUDPRT1(DVBXPDNM,1,IOM,0)
 . . W !?1,"will now take place.  The ENTRY ACTION code for each of the Options"
 . . W !?1,"will be prefixed with 'D AUDIT^DVBAUDOA' to automatically initiate t"
 . . W !?1,"Option Audit feature.  In addition, an AMIE AUDIT SUMMARY BY OPTION"
 . . W !?1,"record will be created to allow accurate reports to be produced by "
 . . W !
 . . W !?1,"The following option's ENTRY ACTION code have been modified as prev"
 . . W !?1,"described: "
 . . W !
 ;
 I DVBENTRYPT="AUDITSPC" D  Q  ; Building or deleting audits by namespace
 . ;
 . I $O(DVBTARGET(""))="" D  Q  ; If no target options were found
 . . N DVBMSG
 . . S DVBMSG="No active Option(s) were found for the namespace of "
 . . S DVBMSG=DVBMSG_"'"_$S($D(DVBNAMSPC):DVBNAMSPC,1:DVBNAMESPC)_"'"
 . . D CENTER^DVBAUDPRT1(DVBMSG,2,IOM,1)
 . . S DVBMSG="for your selected criteria"
 . . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . . I DVBACTION="CREATE" S DVBMSG="that are not already audited."
 . . I DVBACTION="DELETE" D  ;
 . . . S DVBMSG="with an ENTRY ACTION containing 'D AUDIT^DVBAUDOA'."
 . . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . ;
 . I $O(DVBTARGET(""))]"" D  Q  ; If target options were found
 . . W !
 . . W !?1,"Modification of eligible OPTION(s) for the namespace of '",DVBNAMESPC
 . . W !?1,"will now take place.  The ENTRY ACTION code for each of the Options"
 . . W !?1,"Option Audit feature.  In addition, an AMIE AUDIT SUMMARY BY OPTIO"
 . . W !?1,"record will be created to allow accurate reports to be produced by "
 . . W !
 . . W !?1,"The following option's ENTRY ACTION code have been modified as prev"
 . . W !?1,"described: "
 . . W !
 ;
 I DVBENTRYPT="DELBLD" D  Q  ;
 . W !
 . W !?1,"Modification of eligible OPTION(s) associated with KIDS Build "
 . D CENTER^DVBAUDPRT1(DVBXPDNM,1,IOM,0)
 . W !?1,"will now take place.  The 'D AUDIT^DVBAUDOA' code for each of the Opti"
 . W !?1,"will be removed from the ENTRY ACTION to delete the audit feature fro"
 . W !?1,"Option."
 . W !
 . W !?1,"The following option's ENTRY ACTION code have been modified as previo"
 . W !?1,"described: "
 . W !
 ;
 I DVBENTRYPT="DELSPC" D  Q  ;
 . W !
 . W !?1,"Modification of eligible OPTION(s) for the namespace of '",DVBNAMESPC,"'"
 . W !?1,"will now take place.  The 'D AUDIT^DVBAUDOA' code for each of the Opti"
 . W !?1,"will be removed from the ENTRY ACTION to delete the audit feature fro"
 . W !?1,"Option."
 . W !
 . W !?1,"The following option's ENTRY ACTION code have been modified as previo"
 . W !?1,"described: "
 . W !
 ;
 Q  ; Quit MESSAGE^DVBAUDU3S
