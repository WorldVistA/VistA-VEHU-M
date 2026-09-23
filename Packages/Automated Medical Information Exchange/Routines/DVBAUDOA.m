DVBAUDOA ;ALB/CP - Option Audit Routine  ; 10/15/18 1:38pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;    $$FIND1^DIC        ; # 2051 Find IEN of OPTION SCHEDULING entry
 ;         YN^DICN       ; #10009 Prompt for a YES/NO value
 ;     $$GET1^DIQ        ; # 2056 Retrieve a single value
 ;    XQY                ; #  167 To determine Option IEN
 Q  ; You must execute a supported entry point, listed above.
 ;
AUDIT ; 
 ;
 N DIERR,DVBERRMSG,DVBQUIT,DVBSAVDUZ,DVBUSERNAME
 ; ZEXCEPT: DUZ,DVBQUIT,XQJMP,XQY
 ;
 S DVBQUIT=0 ; Initialize quit flag to successful (No, don't quit)
 S DVBSAVDUZ=$G(^DISV(DUZ,"^VA(200,")) ; Save orig. DUZ **1**
 ;
 S DVBUSERNAME=$$GET1^DIQ(200,+$G(DUZ),.01,"E",,"DVBERRMSG")
 D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","AUDIT^"_$T(+0)) Q:DVBQUIT
 Q:DVBUSERNAME=""  Q:'$G(XQY)
 ;
 D AUDEVENT^DVBAUDDIE(XQY,DUZ) ; AMIE OPTION AUDIT EVENT file
 Q:DVBQUIT  ; Problem found when adding a DETAIL file record
 D SUMSTUB^DVBAUDDIE(+XQY) ; Init. the SUMMARY BY OPTION stub record
 Q:DVBQUIT  ; Problem found when creating the SUMMARY file record
 I DVBSAVDUZ S ^DISV(DUZ,"^VA(200,")=DVBSAVDUZ ; Restore DUZ **1**
 ;
 Q
 ;
EDITOPT(DVBEDIT,DVBTARGET) ; Present user with DVBTARGET(OPTION,IEN)=OptionType,
 ;
 N DVBCNT,DVBDASHES,DVBMAXLEN,DVBOPTNAME,DVBQUIT,DVBSPACES,DVBSUB
 ; ZEXCEPT: IOM
 ;
 ; Note: 'PRE' = Presented & 'SEL' = Selected
 F DVBSUB="PRE","SEL" S DVBCNT(DVBSUB)=0 ; Initialize Option counts
 ;
 S DVBMAXLEN=229 ; Maximum DVBLENGTH of ENTRY ACTION and EXIT ACTION
 S $P(DVBDASHES,".",IOM+1)="" ; Line of DVBDASHES ('-')
 S $P(DVBSPACES," ",IOM+1)="" ; Line of DVBSPACES (' ')
 ;
 S DVBQUIT=0
 S DVBOPTNAME=""
 F  S DVBOPTNAME=$O(DVBTARGET(DVBOPTNAME)) Q:(DVBOPTNAME="")!DVBQUIT  D  ;
 . N DVBIEN19
 . S DVBIEN19=0
 . F  S DVBIEN19=$O(DVBTARGET(DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19!DVBQUIT  D  ;
 . . N DIERR,DVBENACTION,DVBEXACTION,DVBLENGTH,DVBMSG,DVBOPT,DVBERRMSG
 . . D OPTION^DVBAUDDIQ(DVBIEN19)
 . . S DVBENACTION("BEF")=DVBOPT("ENTRYACTION") ; Capture ENTRY ACTION
 . . S DVBEXACTION("BEF")=DVBOPT("EXITACTION") ;. Capture EXIT  ACTION
 . . Q:DVBENACTION("BEF")["AUDIT^DVBAUDOA"  ; Prevent adding mult. times
 . . ;
 . . ; Prevent ENTRY ACTION from exceeding maximum DVBLENGTH, display DVBMSG
 . . I $L(DVBENACTION("BEF"))>DVBMAXLEN D  Q  ;
 . . . D EDITWARN(DVBOPTNAME,"ENTRY",.DVBENACTION)
 . . ; Prevent EXIT ACTION from exceeding max DVBLENGTH, display DVBMSG.
 . . I $L(DVBEXACTION("BEF"))>DVBMAXLEN D  Q  ;
 . . . D EDITWARN(DVBOPTNAME,"EXIT",.DVBEXACTION) Q
 . . S DVBENACTION("AFT")="D AUDIT^DVBAUDOA"
 . . I DVBENACTION("BEF")'="" D  ;
 . . . S DVBENACTION("AFT")="D AUDIT^DVBAUDOA "_DVBENACTION("BEF")
 . . ;
 . . S DVBEXACTION("AFT")=DVBEXACTION("BEF") ; Init the EXIT ACTION **2**
 . . ;
 . . S DVBCNT("PRE")=DVBCNT("PRE")+1 ; Number of eligible options presented
 . . W !!,"------------------------------------------------------"
 . . ;
 . . S DVBMSG="Editing option "_DVBCNT("PRE")_": "
 . . S DVBLENGTH=$L(DVBMSG) ;To be utilized as the 2nd parameter in $JUSTIFY
 . . ;
 . . W ! ; Display the Option's MENU TEXT
 . . W $J(DVBMSG,DVBLENGTH) ; Display: Editing option n
 . . W $$GET1^DIQ(19,DVBIEN19,1,"E",,"DVBERRMSG") ; Display the Menu Text
 . . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","EDITOPT^"_$T(+0)) Q:DVBQUIT
 . . ;
 . . W ! ; Display the DVBOPT NAME field in brackets under the menu text
 . . W $E(DVBSPACES,1,DVBLENGTH) ; Tab over with DVBSPACES, line up the display
 . . W "["_DVBOPT("NAME")_"]"
 . . ;
 . . W ! ; Display the Option DVBTYPE
 . . W $E(DVBSPACES,1,DVBLENGTH) ; Tab over with DVBSPACES, line up the display
 . . W "DVBTYPE: ",$$GET1^DIQ(19,DVBIEN19,4,"E",,"DVBERRMSG")
 . . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","EDITOPT^"_$T(+0)) Q:DVBQUIT
 . . ;
 . . D CENTER^DVBAUDPRT1("Proposed ENTRY ACTION Modification",2,IOM,1)
 . . ;
 . . W !!,$J("Change from: ",DVBLENGTH),DVBENACTION("BEF")
 . . I DVBENACTION("BEF")="" D  ;
 . . . W "<Empty>" ;Let the user know the current ENTRY ACTION is null
 . . ;
 . . W !,$J("to: ",DVBLENGTH),DVBENACTION("AFT")
 . . N DVBIENOSF ; DVBIENOSF=IEN of the OPTION SCHEDULING file #19.2
 . . N DVBOPTSCH ; Array of Option Scheduling attributes
 . . S DVBIENOSF=$$FIND1^DIC(19.2,"","BO",DVBOPTNAME)
 . . ;
 . . ; If the option is in the SCHEDULING OPTION file #19.2
 . . ;
 . . I DVBIENOSF,DVBEXACTION("BEF")'["D PTIME^DVBAUDOA" D  ;
 . . . D OPTSCH^DVBAUDDIQ(DVBIENOSF) ; Place #19.2 data in DVBOPTSCH(array)
 . . . Q:'$$OPTSCHOK^DVBAUDU1($T(+0),.DVBOPTSCH)  ; Option is screened
 . . . ;
 . . . S DVBMSG="Rescheduling Frequency: "_DVBOPTSCH("FREQ")
 . . . I DVBOPTSCH("QTORUNTIME")]"" D  ; Display next queued to run time
 . . . . S DVBMSG=DVBMSG_" (queued to run "_DVBOPTSCH("QTORUNTIME")_")"
 . . . W !,$J(DVBMSG,DVBLENGTH)
 . . . ;
 . . . S DVBMSG="               Task ID: "_DVBOPTSCH("TASKID")
 . . . W !,$J(DVBMSG,DVBLENGTH)
 . . . ;
 . . . S DVBEXACTION("AFT")="D PTIME^DVBAUDOA" I DVBEXACTION("BEF")'="" D  ;
 . . . . S DVBEXACTION("AFT")="D PTIME^DVBAUDOA "_DVBEXACTION("BEF")
 . . . ;
 . . . D CENTER^DVBAUDPRT1("& Proposed EXIT ACTION Modification",2,IOM,1)
 . . . ;
 . . . S DVBMSG="Change from: "
 . . . W !!,$J(DVBMSG,DVBLENGTH),DVBEXACTION("BEF")
 . . . W:DVBEXACTION("BEF")="" "<Empty>"
 . . . ;
 . . . S DVBMSG="to: "
 . . . W !,$J(DVBMSG,DVBLENGTH),DVBEXACTION("AFT")
 . . . ;
 . . S DVBMSG="   OK to edit"
 . . W !!,$J(DVBMSG,DVBLENGTH)
 . . ;
 . . N @($$DICN^DVBAUDNEW1())
 . . ; ZEXCEPT: %
 . . S %=2 D YN^DICN ; Default to 'NO' response (%=2)
 . . I %<1 S DVBQUIT=1 W "  <Editing aborted>",! Q  ; User entered '^'
 . . I %=1 D  ; If user entered 'YES'
 . . . ; Update ENTRY ACTION
 . . . D ENTRYACT^DVBAUDDIE(DVBIEN19,.DVBENACTION,.DVBEXACTION) Q:DVBQUIT
 . . . W "   [Edit completed]"
 . . . S DVBCNT("SEL")=DVBCNT("SEL")+1 ; Number of options selected
 . . . D SUMSTUB^DVBAUDDIE(DVBIEN19) ; Create the SUMMARY record stub
 . . S DVBQUIT=0
 W !
 ; If more than 1 eligible option was presented, display statistics
 I DVBCNT("PRE")>1 D  ;
 . W !,"Number of options presented for auditing: ",DVBCNT("PRE")
 . W !,"Number of options selected  for auditing: ",DVBCNT("SEL"),!
 ;
 W !,"Editing process completed."
 ;
 D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 Q  ; Quit EDITOPT
 ;
EDITWARN(DVBOPTNAME,DVBTYPE,DVBACTION) ; Entry action DVBLENGTH will exceed the maximum,
 ;                      display a warning message to the user
 ; ZEXCEPT: DTIME
 ;
 W !,!,"------------------------------------------------------"
 W !,">>> Editing the ",DVBTYPE," ACTION for option "_DVBOPTNAME_" will exceed the ma"
 W !,">>> DVBLENGTH of 245 characters allowed for an M code string.  No action tak",!
 ;
 W:DVBTYPE="ENTRY" !,"Current ENTRY ACTION: ",!,DVBACTION("BEF")
 W:DVBTYPE="EXIT" !,"Current EXIT ACTION: ",!,DVBACTION("BEF")
 ;
 D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 Q  ; Quit EDITWARN
 ;
PTIME ; Record the processing time for a OPTION SCHEDULING task by
 ;
 N DVBEVENT,DVBIENEVENT,DVBJOB,DVBQUIT
 ;
 S DVBJOB=$J
 S DVBIENEVENT=$O(^DVB(396.999,"AJOB",DVBJOB,0)) Q:'DVBIENEVENT
 S DVBQUIT=0 D EVENT^DVBAUDDIQ(DVBIENEVENT) Q:DVBQUIT
 Q:DVBEVENT("TASKEDI")'=1  ; E-TASKED AUDIT? is not 1:YES
 Q:DVBEVENT("DTENDED")]""  ; E-TASK END DATE/TIME already exists
 D EVENTEND^DVBAUDDIE(DVBIENEVENT)
 ;
 Q  ; Quit PTIME^DVBAUDOA
 ;
STUFF ; Stuff programmer hooks into the OPTION file #19 entry
 ;
 N DVBEDIT,DVBNAMSPC,DVBOPTION,DVBOPTYPE,DVBQUIT,DVBTARGET
 ; ZEXCEPT: DVBACTION,DUZ,IOF,IOM
 ;
STUFF1 ; Branch back to here from below
 ;
 ; Display DVBOPTION and prompt user for which OPTIONs to stuff
 ;
 S DVBQUIT=0
 S DVBOPTION="Add Audit Code to Option ENTRY ACTION"
 W @IOF,!?1,"*** ",DVBOPTION," ***"
 ;
 ;D PGMACCSS^DVBAUDU1($T(+0),.DUZ) G:DVBQUIT STUFFX ; Check DUZ(0) for @
 D SELEDIT^DVBAUDDIR($T(+0)) G:DVBQUIT STUFFX ; Get DVBEDIT
 D MSGIGNOR^DVBAUDU1($T(+0)) ; Display educa. DVBMSG. on what is ignored
 D SELTYPE^DVBAUDDIR($T(+0)) G:DVBQUIT STUFF1 ; Select OPTION TYPEs
 ;
 ; Select OPTIONS by OPTION NAME (DVBEDIT=1), build DVBTARGET(array)
 D:DVBEDIT=1 OPTSIN^DVBAUDDIC($T(+0),DVBEDIT,DVBOPTYPE)
 G:DVBQUIT STUFF1 ; Start over, user may not want to Exit yet
 ;
 ; DVBEDIT=2 Enter OPTION prefix with wildcard(*), store in DVBNAMSPC
 I DVBEDIT=2 D  G:DVBQUIT STUFF1 ; Start over, user may not want to Exit
 . D SELWILD^DVBAUDU1(DVBEDIT) Q:DVBQUIT
 . ;
 . N DVBACTION S DVBACTION="BUILD"
 . D OPTBUILD^DVBAUDU2($T(+0),DVBEDIT,DVBOPTYPE,DVBNAMSPC) ;DVBTARGETarray
 ;
 ; DVBEDIT=3 Build DVBTARGET(array) from OPTION SCHEDULING file (#19.2)
 I DVBEDIT=3 D OPTSCH^DVBAUDU1($T(+0),DVBEDIT,DVBOPTYPE)
 G:DVBQUIT STUFF1 ; Start over, user may not want to Exit quite yet
 ;
 D EDITOPT(DVBEDIT,.DVBTARGET)
 ;
 G STUFF1
 ;
STUFFX ; STUFF eXit
 ;
 Q  ; Quit STUFF^DVBAUDOA
