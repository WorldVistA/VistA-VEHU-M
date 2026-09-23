DVBAUDU3 ;ALB/CP - API Calls Routine #3 for programmers ; 4/12/18 7:28pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified5
 ;    $$FIND1^DIC        ; IA # 2051
 ;     $$GET1^DIQ        ; IA # 2056
 ;           ^%ZOSF(     ; IA #10096
 ;           ^DISV       ; IA #  510
 ;           ^XPD(9.6,   ; IA # 1125
 ;
 ;
 Q  ; You must execute a supported entry point
 ;
AUDIT ; Interactive version of AUDITBLD or AUDITSPC designed to
 ;   build/initiate or delete option audits for either a BUILD
 ;   or NAMESPACE (See TYPE input var.)
 ;
 N DVBDRFAULT,DVBFLAG1
 ; ZEXCEPT: DUZ
 ;
 S DVBFLAG1=1 ; 1st time flag
 ;
AUDIT1 ; Return here when the user wants to start over
 ;
 N DVBACTION,DVBSOURCE,DVBQUIT
 ;
 S DVBQUIT=0
 ;
 ; *** Prompt for 'Which Option Audit ACTION' ***
 ;
 S DVBDRFAULT=$G(^DISV(DUZ,$T(+0),"DVBACTION"),1) I DVBFLAG1=0 D  ;
 . S DVBDRFAULT="" ; No DVBDRFAULT allows an easy exit on the 2nd time thru
 W !
 W !,"Which Option Audit ACTION"
 W !,?3,"1) Create Option Audits"
 W !,?3,"2) Delete Existing Option Audits"
 S DVBACTION=$$ASKNUM^DVBAUDASK1(2,DVBDRFAULT,,2) G:DVBQUIT AUDITEX
 I DVBACTION="^" S DVBQUIT=1 G AUDITEX
 S ^DISV(DUZ,$T(+0),"DVBACTION")=DVBACTION
 S DVBACTION=$S(DVBACTION=1:"CREATE",1:"DELETE")
 S DVBFLAG1=0
 ;
 ; *** Prompt for 'Which Option Audit SOURCE' ***
 ;
 S DVBDRFAULT=$G(^DISV(DUZ,$T(+0),"DVBSOURCE"),1)
 W !
 W !,"Which Option Audit SOURCE"
 W !,?3,"1) Source is a KIDS BUILD"
 W !,?3,"2) Source is a NAMESPACE"
 S DVBSOURCE=$$ASKNUM^DVBAUDASK1(2,DVBDRFAULT,,2) G:DVBQUIT AUDIT1
 I DVBSOURCE="^" S DVBQUIT=1 G AUDIT1 ; Start over
 S ^DISV(DUZ,$T(+0),"DVBSOURCE")=DVBSOURCE
 S DVBSOURCE=$S(DVBSOURCE=1:"BUILD",1:"NAMESPACE")
 ;
 I DVBSOURCE="BUILD" W ! D  ;
 . N DVBASK,DVBBUILD,DVBMSG,DVBOPTYPE
 . D BUILD^DVBAUDDIC Q:DVBQUIT
 . D SELTYPE^DVBAUDDIR($T(+0)) Q:DVBQUIT
 . W ! S DVBMSG="Is it OK to implement these changes"
 . I $$ASKYESNO^DVBAUDASK1(DVBMSG,"NO")'="Y" S DVBQUIT=1 Q
 . D AUDITBLD(DVBBUILD,DVBACTION,DVBOPTYPE)
 G:DVBQUIT AUDIT1 ; Start over
 ;
 I DVBSOURCE="NAMESPACE" D  ;
 . N DVBASK,DVBNAMSPC,DVBMSG,DVBOPTYPE
 . D SELWILD^DVBAUDU1(2) Q:DVBQUIT
 . D SELTYPE^DVBAUDDIR($T(+0)) Q:DVBQUIT
 . W ! S DVBMSG="Is it OK to implement these changes"
 . I $$ASKYESNO^DVBAUDASK1(DVBMSG,"NO")'="Y" S DVBQUIT=1 Q
 . D AUDITSPC(DVBNAMSPC,DVBACTION,DVBOPTYPE)
 G:DVBQUIT AUDIT1 ; Start over
 ;
 ;
AUDITEX ; Exit the AUDIT api
 ;
 Q  ; Quit AUDIT & AUDIT1
 ;
AUDITBLD(DVBXPDNM,DVBACTION,DVBOPTYPES) ; Stuff 'D AUDIT^DVBAUDOA' into ENTRY ACTION
 ;   of every eligible OPTION for a DVBXPDNM of the KIDS Build.
 N X,DVBOPTNAME,DVBXPDIEN,DVBXPDTYPE
 ; ZEXCEPT: U
 ;
 S X="DVBAUDOA" X ^%ZOSF("TEST") Q:'$T
 ;
 ; Validate that the following files exist:
 Q:'$$FIND1^DIC(1,"","BO","AMIE OPTION AUDIT EVENT")
 Q:'$$FIND1^DIC(1,"","BO","AMIE AUDIT SUMMARY BY OPTION")
 ;
 ;
 ; Validate input variable ACTION
 S DVBACTION=$G(DVBACTION,"CREATE")
 I DVBACTION'="CREATE",DVBACTION'="DELETE" Q  ; Must be 'CREATE' or 'DELETE'
 ; Validate input variable DVBXPDNM
 Q:$G(DVBXPDNM)=""  ; Quit if DVBXPDNM is not defined
 S DVBXPDIEN=+$$FIND1^DIC(9.6,"","BO",DVBXPDNM) Q:DVBXPDIEN=0  ; IEN?
 ;
 ; Validate input variable DVBOPTYPES
 S DVBOPTYPES=$G(DVBOPTYPES,$S(DVBACTION="CREATE":"AEIPRXSC",1:"AEIMPRXSC"))
 Q:'$$OPTYPEOK(DVBOPTYPES)
 ;
 N DVBFLAGMP ; To avoid too many 'Press <Enter> to continue' prompts
 S DVBXPDTYPE=$$GET1^DIQ(9.6,DVBXPDIEN,2)
 I DVBXPDTYPE="MULTI-PACKAGE" D BUNDLE(DVBXPDIEN,DVBOPTYPES,DVBACTION) Q
 ;
 Q:DVBXPDTYPE="GLOBAL PACKAGE"  ; Quit,  if this is a GLOBAL PACKAGE
 ; Quit, if there are no OPTION components in this SINGLE PACKAGE
 Q:'$P($G(^XPD(9.6,DVBXPDIEN,"KRN",19,"NM",0)),U,4)
 ;
 ;
 N DVBTARGET ; Output array of OPTION candidates for Option Auditing
 S DVBOPTNAME=""
 F  S DVBOPTNAME=$O(^XPD(9.6,DVBXPDIEN,"KRN",19,"NM","B",DVBOPTNAME)) Q:DVBOPTNAME=""  D  ;
 . N DVBXPDIEN2
 . S DVBXPDIEN2=0
 . F  S DVBXPDIEN2=$O(^XPD(9.6,DVBXPDIEN,"KRN",19,"NM","B",DVBOPTNAME,DVBXPDIEN2)) Q:'DVBXPDIEN2=""  D 
 . . N DVBACTION,DVBIEN19
 . . ;
 . . S DVBIEN19=$$FIND1^DIC(19,"","BO",DVBOPTNAME) Q:'DVBIEN19
 . . ;
 . . S DVBACTION=$$GET1^DIQ(9.68,XPDIEN2_",19,"_XPDIEN_",",.03)
 . . Q:DVBACTION="DELETE AT SITE"
 . . ;
 . . ; Place the option in the DVBTARGET array
 . . S DVBTARGET(DVBOPTNAME,DVBIEN19)=DVBXPDIEN2
 Q:$O(DVBTARGET(""))=""  ; No DVBTARGET option candidates found
 ;
 I DVBACTION="CREATE" D BUILD^DVBAUDU3S("AUDITBLD",.DVBTARGET,DVBOPTYPES)
 I DVBACTION="DELETE" D DELETE^DVBAUDU3S("AUDITBLD",.DVBTARGET,DVBOPTYPES)
 ;
 Q  ; Quit AUDITBLD
 ;
AUDITSPC(DVBNAMESPC,DVBACTION,DVBOPTYPES) ; Stuff 'D AUDIT^DVBAUDOA' into ENTRY ACTION
 ;
 N X
 ; ZEXCEPT: DVBFLAG1,U
 ;
 ; IF   the DVBAUDOA routine is not loaded in this environment
 ;      exit the API.
 S X="DVBAUDOA" X ^%ZOSF("TEST") Q:'$T
 ;
 ; Validate that the following files exist:
 Q:'$$FIND1^DIC(1,"","BO","AMIE OPTION AUDIT EVENT")
 Q:'$$FIND1^DIC(1,"","BO","AMIE AUDIT SUMMARY BY OPTION")
 ;
 ; Validate input variable DVBNAMESPC (namespace)
 ; DVBNAMESPC must be at least 1 characters in length & not null
 Q:$L(DVBNAMESPC)<1
 ; Attach wildcard (*) to namespace if it doesn't exist
 S:$E(DVBNAMESPC,$L(DVBNAMESPC),$L(DVBNAMESPC))'="*" DVBNAMESPC=DVBNAMESPC_"*"
 ;
 ; Validate input variable DVBACTION
 S DVBACTION=$G(DVBACTION,"CREATE")
 I DVBACTION'="CREATE",DVBACTION'="DELETE" Q  ; Must be 'CREATE' or 'DELETE'
 ;
 ; Validate input variable DVBOPTYPES
 S DVBOPTYPES=$G(DVBOPTYPES,$S(DVBACTION="CREATE":"AEIPRXSC",1:"AEIMPRXSC"))
 I '$$OPTYPEOK(DVBOPTYPES) D  Q
 . W !?1,"Invalid Option TYPE encountered -- terminating processing..."
 ;
 ;Build DVBTARGET(DVBOPTNAME,DVBIEN19)="" array of Options based upon DVBNAMESPC
 ;
 N DVBFLAG1,DVBTARGET
 S DVBFLAG1=1 ; 1st time flag
 D OPTBUILD^DVBAUDU2($T(+0),2,DVBOPTYPES,DVBNAMESPC) ; Bld DVBTARGET array
 ;
 I DVBACTION="DELETE" D DELETE^DVBAUDU3S("AUDITSPC",.DVBTARGET,DVBOPTYPES)
 I DVBACTION="DELETE",$O(DVBTARGET(""))="" D  ;
 . D MESSAGE^DVBAUDU3S("AUDITSPC")
 . D CONTINUE^DVBAUDPRT1(2,"R")
 Q:DVBACTION="DELETE"  ; Remainder of code is for ACTION 'CREATE'
 ;
 ; At this point we know the ACTION="CREATE"
 N DVBCNT,DVBMAXLEN,DVBOPTNAME,DVBQUIT
 ;
 S DVBCNT("SEL")=0 ; Number of DVBTARGET options selected for auditing
 S DVBCNT("CRE")=0 ; Number of DVBTARGET options where audits were created
 S DVBQUIT=0 ;.... Quit/terminate flag, initialized to off (0)
 S DVBMAXLEN=229 ;.. Maximum length of ENTRY ACTION and EXIT ACTION
 S DVBOPTNAME=0
 F  S DVBOPTNAME=$O(DVBTARGET(DVBOPTNAME)) Q:(DVBOPTNAME="")!DVBQUIT  D  ;
 . N DIERR,DVBENACTION,DVBEXACTION,DVBIEN19,DVBERRMSG
 . S DVBIEN19=0 ; DVBIEN19 is the IEN of OPTION file #19
 . F  S DVBIEN19=$O(DVBTARGET(DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19  D  ;
 . . N DIERR,DVBENACTION,DVBEXACTION,DVBOPT,DVBERRMSG
 . . D OPTION^DVBAUDDIQ(DVBIEN19)
 . . S DVBENACTION("BEF")=DVBOPT("ENTRYACTION") ; Capture ENTRY ACTION
 . . S DVBEXACTION("BEF")=DVBOPT("EXITACTION") ;. Capture EXIT  ACTION
 . . ;
 . . ; Prevent ENTRY ACTION from exceeding maximum length, display msg
 . . I $L(DVBENACTION("BEF"))>DVBMAXLEN Q
 . . ; Prevent EXIT ACTION from exceeding maximum length, display msg.
 . . I $L(DVBEXACTION("BEF"))>DVBMAXLEN Q
 . . ;
 . . S DVBENACTION("AFT")="D AUDIT^DVBAUDOA" I DVBENACTION("BEF")'="" D  ;
 . . . S DVBENACTION("AFT")="D AUDIT^DVBAUDOA "_DVBENACTION("BEF")
 . . ;
 . . D EXITACT^DVBAUDU3S ; Format EXIT ACTION in DVBEXACTION("AFT")
 . . ;
 . . ; Edit the Option's ENTRY and EXIT ACTION fields
 . . I DVBFLAG1=1,$O(DVBTARGET(""))]"" D MESSAGE^DVBAUDU3S("AUDITSPC")
 . . S DVBCNT("SEL")=DVBCNT("SEL")+1 ; Number of options selected for audit
 . . W !?3,$J(DVBCNT("SEL"),3),". ",?8,DVBOPTNAME
 . . W ?40,$$GET1^DIQ(19,DVBIEN19,4,"E",,"DVBERRMSG")
 . . D ENTRYACT^DVBAUDDIE(DVBIEN19,.DVBENACTION,.DVBEXACTION)
 . . W ?57 W:DVBQUIT=0 "[Option Audit Added]"
 . . I DVBQUIT=1 W ! Q
 . . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","AUDITSPC^"_$T(+0)) Q:DVBQUIT
 . . D SUMSTUB^DVBAUDDIE(DVBIEN19) ; Create the SUMMARY record stub
 . . S DVBCNT("CRE")=DVBCNT("CRE")+1 ; Number of option audits created
 . . Q:DVBQUIT
 . S DVBQUIT=0
 ;
 ;
 ; If no DVBTARGET array of option audit candidates, display msg & quit
 I $O(DVBTARGET(""))="" D MESSAGE^DVBAUDU3S("AUDITSPC") Q
 ;
 W !
 ;
 ; If more than 1 eligible option was presented, display statistics
 I DVBCNT("SEL")>1 D  ;
 . W !,"Number of options selected for auditing.: ",DVBCNT("SEL")
 . W !,"Number of option audits actually created: ",DVBCNT("CRE")
 . W !
 . W !,"Editing process completed for the namespace of '",DVBNAMESPC,"'."
 . D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 Q  ; Quit AUDITSPC
 ;
BUNDLE(DVBXPDIEN,DVBOPTYPES,DVBACTION) ; Handles all of the KIDS Builds
 ;                      within a MULTI-PACKAGE bundle
 N DVBXPDIEN1,DVBXPDNM
 ; ZEXCEPT: DVBFLAGMP
 ;
 ; Flag MP indicates MULTI PACKAGE, used to avoid too msny
 ; 'Press <Enter> to continue' prompts after each child package
 S DVBFLAGMP=1
 ;
 ; Note: MULTIPLE BUILD (multiple) is node 10 of file #9.6
 ;
 S DVBXPDIEN1=0
 F  S DVBXPDIEN1=$O(^XPD(9.6,DVBXPDIEN,10,DVBXPDIEN1)) Q:'DVBXPDIEN1  D  ;
 . N DVBIENS
 . S DVBIENS=XPDIEN1_","_XPDIEN_","
 . S DVBXPDNM=$$GET1^DIQ(9.63,DVBIENS,.01) Q:DVBXPDNM=""
 . I '$O(^XPD(9.6,DVBXPDIEN,10,DVBXPDIEN1)) S DVBFLAGMP=0 ; Last package,
 . D AUDITBLD(DVBXPDNM,DVBOPTYPES,DVBACTION) W !
 ;
 Q  ; Quit BUNDLE
 ;
OPTYPEOK(DVBOPTYPES) ; Extrinsic to verify DVBOPTYPES input variable
 ;          Return 1 if DVBOPTYPES are OK
 ;                 0 if any of the DVBOPTYPES are invalid
 N DVBPOS,DVBVAL
 I $L(DVBOPTYPES)'>0 Q 0
 S DVBVAL=1 F DVBPOS=1:1:$L(DVBOPTYPES) D  ;
 . I "AEIMPRXSC"'[$E(DVBOPTYPES,DVBPOS,DVBPOS) S DVBVAL=0
 Q DVBVAL ; Quit $$OPTOK extrinsic
