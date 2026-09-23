DVBAUDOAD ;ALB/CP - Delete DVBA Audit Code from Option   ; 10/15/18 1:35pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           YN^DICN ; IA #10000
 ;       $$GET1^DIQ  ; IA # 2056
 Q
 ;
ENTER ; Delete 'D AUDIT^DVBAUDOA' from the ENTRY ACTION of the select
 ;
 N DVBEDIT,DVBNAMSPC,DVBOPTION,DVBOPTYPE,DVBQUIT,DVBTARGET
 ;
PROMPT ; Prompt user
 ; ZEXCEPT: DUZ,IOF
 ;
 S DVBOPTION="Delete Audit Code from Option"
 W @IOF,!?1,"*** ",DVBOPTION," ***" S DVBQUIT=0
 S DVBNAMSPC="*" ; Set in case deleting out of order options
 ;
 D PGMACCSS^DVBAUDU1($T(+0),.DUZ) G:DVBQUIT EXIT ; Check DUZ(0) for '@'
 D SELEDIT^DVBAUDDIR($T(+0)) G:DVBQUIT EXIT ;.. Get DVBEDIT
 D MSGIGNOR^DVBAUDU1($T(+0))
 D SELTYPE^DVBAUDDIR($T(+0)) G:DVBQUIT PROMPT ; Option TYPEs audited
 ;
 ; Build DVBTARGET(OPTION,IEN)=TYPE for selected Options (DVBEDIT=1)
 I DVBEDIT=1 D OPTSIN^DVBAUDDIC($T(+0),DVBEDIT,DVBOPTYPE)
 G:DVBQUIT PROMPT ; Start over, user may not want to Exit quite yet
 ;
 ; If editing with Option NAMESPACE using WILDCARE * (DVBEDIT=2)
 I DVBEDIT=2 D SELWILD^DVBAUDU1(DVBEDIT) G:DVBQUIT PROMPT ; OPTION prefix
 G:DVBQUIT PROMPT ; Start over, user may not want to Exit quite yet
START ;
 ; Build DVBTARGET array from OPTION file (#19) to stuff for DVBNAMSPC
 I DVBEDIT=2 D  ;
 . N DVBACTION
 . S DVBACTION="DELETE" ; Needed in OPTBUILD^DVBAUDU2 for messages
 . D OPTBUILD^DVBAUDU2($T(+0),DVBEDIT,DVBOPTYPE,DVBNAMSPC)
 ;
 ; DVBEDIT=3 Build DVBTARGET(OPTION,IEN)=TYPE from file (#19.2)
 I DVBEDIT=3 D  ;
 . D BUILDOS^DVBAUDU2($T(+0),DVBEDIT,DVBOPTYPE)
 ;
 ; Build DVBTARGET by Options OUT OF ORDER
 I DVBEDIT=4 D BUILDOOO^DVBAUDU1($T(+0),DVBEDIT,DVBOPTYPE)
 G:DVBQUIT PROMPT ; Start over, user may not want to Exit quite yet
 ;
 D DELAUDIT ; Delete processing for selected Option(s)
 ;
 G PROMPT
 ;
EXIT ; Exit/Quit the deleting of 'D AUDIT^DVBAUDOA' from DVBTARGET options.
 ;
 Q  ; Routine DVBAUDOAD
 ;
ASKEDIT(DVBIEN19,DVBENACTAFT,DVBEXACTAFT) ; Prompt for '  OK to delete the DVB audit?"
 ;
 N @($$DICN^DVBAUDNEW1())
 ; ZEXCEPT: %,DVBCNT,DVBEDITOK,DVBQUIT
 ;
 ; Prompt for YES/NO or '^' DVBRESPONSE
 ;
 W !,"  OK to delete the AMIE audit functionality"
 S %=2 D YN^DICN ; Default to 'NO' DVBRESPONSE
 ;
 I %=-1 D  ; If  USER enters '^'
 . W "  <Editing aborted>",! ; User entered '^'
 . S DVBQUIT=1 ; Output variable to terminate processing
 Q:DVBQUIT  ; User entered an '^'
 ;
 I %=2 D  ; If  USER enters NO
 . S DVBEDITOK="NO" ; Output variable
 ;
 I %=1 D  ; If user entered 'YES'
 . N DVBENACTION,DVBEXACTION
 . S DVBENACTION("AFT")=DVBENACTAFT
 . S DVBEXACTION("AFT")=DVBEXACTAFT
 . D ENTRYACT^DVBAUDDIE(DVBIEN19,.DVBENACTION,.DVBEXACTION) Q:DVBQUIT
 . W "   [Edit completed]"
 . S DVBCNT("DEL")=DVBCNT("DEL")+1 ; Number opts where an audit was deleted.
 . S DVBEDITOK="YES" ; Output variable
 S DVBQUIT=0
 ;Q:DVBQUIT  ; Database server error was detected.
 ;
 Q  ; Quit ASKEDIT
 ;
ASKCLEAN(DVBRTN) ; Prompt for '  OK to edit the ENTRY ACTION?"
 ;
 N DVBCHOICE
 ; ZEXCEPT: DVBASK,DVBQUIT
 ;
 S DVBQUIT=0 ; Default to continue to process Option selections.
 ;
 S DVBCHOICE="  Can I clean-up the Option statistical summary information"
 S DVBASK=$$ASKYESNO^DVBAUDASK1(DVBCHOICE,"NO")
 I DVBASK="^" S DVBQUIT=1 Q  ; User wants to exit
 Q:DVBASK="N"
 ;
 ;
 Q  ; Quit ASKCLEAN
 ;
DELAUDIT ; Present user with option/original ENTRY ACTION/new ENTRY ACTION
 ;
 N DVBCNT,DVBDASHES,DVBENACTION,DVBLENGTH,DVBMSG
 N DVBOPTNAME,DVBRESPONSE,DVBQUIT,DVBSPACES,DVBSUB
 ; ZEXCEPT: DVBIEN19,IOM,DVBEDIT,DVBNAMSPC,DVBQUIT,DVBTARGET
 ;
 ;
 F DVBSUB="PRE","DEL","CLEANUP" S DVBCNT(DVBSUB)=0
 S $P(DVBDASHES,".",IOM+1)="" ; Line of DVBDASHES ('-')
 S $P(DVBSPACES," ",IOM+1)="" ; Line of DVBSPACES (' ')
 ;
 ;
 S (DVBOPTNAME,DVBQUIT)=0
 F  S DVBOPTNAME=$O(DVBTARGET(DVBOPTNAME)) Q:(DVBOPTNAME="")!DVBQUIT  D  ;
 . N DVBIEN19
 . S DVBIEN19=0
 . F  S DVBIEN19=$O(DVBTARGET(DVBOPTNAME,DVBIEN19)) Q:'DVBIEN19!DVBQUIT  D  ;
 . . N DIERR,DVBENACTION,DVBEXACTION,DVBMSG,DVBOPT,DVBERRMSG
 . . D OPTION^DVBAUDDIQ(DVBIEN19)
 . . S DVBENACTION("BEF")=DVBOPT("ENTRYACTION") ; Capture ENTRY ACTION
 . . S DVBENACTION("AFT")=$$STRIPAUD^DVBAUDU2(DVBENACTION("BEF"))
 . . S DVBEXACTION("BEF")=DVBOPT("EXITACTION") ;. Capture EXIT  ACTION
 . . ;
 . . S DVBCNT("PRE")=DVBCNT("PRE")+1 ; Number of eligible options presented
 . . W !!,$E(DVBDASHES,1,68)
 . . ;
 . . S DVBMSG="    Editing option "_DVBCNT("PRE")_": ",DVBLENGTH=$L(DVBMSG)
 . . W !!,$J(DVBMSG,DVBLENGTH),$$GET1^DIQ(19,DVBIEN19,1,"E",,"DVBERRMSG") ; DVBOPT. MENU TEXT
 . . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","DELAUDIT^"_$T(+0)) Q:DVBQUIT
 . . ;
 . . S DVBMSG="["_DVBOPT("NAME")_"]"
 . . W !,$E(DVBSPACES,1,DVBLENGTH),DVBMSG
 . . W !,$E(DVBSPACES,1,DVBLENGTH),"TYPE: ",$$GET1^DIQ(19,DVBIEN19,4,"E",,"DVBERRMSG")
 . . D DIERR^DVBAUDDILG1(60,5,"DVBERRMSG","DELAUDIT^"_$T(+0)) Q:DVBQUIT
 . . ;
 . . I DVBOPT("OOOMSG")]"" D  ;
 . . . ;
 . . . S DVBMSG="OUT OF ORDER MESSAGE: "
 . . . W !,$J(DVBMSG,DVBLENGTH),$E(DVBOPT("OOOMSG"),1,IOM-$X)
 . . ;
 . . N DVBAUDBY
 . . S DVBAUDBY=$$GET1^DIQ(3996.9991,DVBIEN19,7,"I") ; Internal format
 . . S:DVBAUDBY DVBAUDBY=$$NAME^XUSER(DVBAUDBY) ;... User's given name
 . . D CENTER^DVBAUDPRT1("Audit turned on by: "_DVBAUDBY,2,IOM,1)
 . . D CENTER^DVBAUDPRT1("Proposed ENTRY ACTION Modification",2,IOM,1)
 . . S DVBMSG="Change from: "
 . . W !!,$J(DVBMSG,DVBLENGTH),DVBENACTION("BEF")
 . . ;
 . . S DVBMSG="to: "
 . . W !,$J(DVBMSG,DVBLENGTH),DVBENACTION("AFT"),!
 . . ;
 . . ; **2** Begin 10/15/2018
 . . S DVBEXACTION("AFT")=DVBEXACTION("BEF") ; Initialized to prevent error
 . . ; **2** End   10/15/2018
 . . I DVBEXACTION("BEF")]"",DVBEXACTION("BEF")["D PTIME^DVBAUDOA" D  ;
 . . . D CENTER^DVBAUDPRT1("& Proposed EXIT ACTION Modification",1,IOM,1)
 . . . S DVBEXACTION("AFT")=$$STRIPAUD^DVBAUDU2(DVBEXACTION("BEF"))
 . . . S DVBMSG="Change from: "
 . . . W !!,$J(DVBMSG,DVBLENGTH),DVBEXACTION("BEF")
 . . . ;
 . . . S DVBMSG="to: "
 . . . W !,$J(DVBMSG,DVBLENGTH),DVBEXACTION("AFT"),!
 . . ;
 . . I DVBENACTION("BEF")=DVBENACTION("AFT") D  Q  ;
 . . . W !
 . . . D REVVIDEO^DVBAUDPRT1("ON")
 . . . W !,"Note: The ENTRY ACTION is not compatible with this Delete Audit Cod"
 . . . W !,"      utility, but is displayed in case you want to make note of th"
 . . . W !,"      for cleaning it up manually later."
 . . . D REVVIDEO^DVBAUDPRT1("OFF")
 . . . D CONTINUE^DVBAUDPRT1(2,"R")
 . . ;
 . . N DVBIENEVENT,DVBASK,DVBEDITOK
 . . D ASKEDIT(DVBIEN19,DVBENACTION("AFT"),DVBEXACTION("AFT")) Q:DVBQUIT!($G(DVBEDITOK)="N")
 . . D ASKCLEAN($T(+0)) Q:DVBQUIT
 . . Q:DVBASK'="Y"  ; DVBRESPONSE must be YES to cleanup statistical summary
 . . D USEROPT^DVBAUDDIK(DVBIEN19) ; Delete the OPTION subentry from #369.9992
 . . D OPTSUM^DVBAUDDIK(DVBIEN19) ;. Delete the SUMMARY record from #396.9991
 . . S DVBIENEVENT=0
 . . F  S DVBIENEVENT=$O(^DVB(396.999,"OPTION",DVBIEN19,DVBIENEVENT)) Q:'DVBIENEVENT  D  ;
 . . . D DELEVENT^DVBAUDDIK(DVBIENEVENT)
 . . S DVBCNT("CLEANUP")=DVBCNT("CLEANUP")+1
 ;
 W ! ; If more than 1 option was presented, display statistics
 I DVBCNT("PRE")>1 D  ;
 . W !,"Number of options presented for audit deletion.....: "
 . W DVBCNT("PRE")
 . W !,"Number of options where the AMIE audits were deleted.: "
 . W DVBCNT("DEL")
 . I DVBCNT("DEL")>0 D  ;
 . . W !,"For the options where AMIE audits were deleted, the number"
 . . W !,"of Options where statistical cleansing took place..: "
 . . W DVBCNT("CLEANUP")
 . W !
 ;
 W !,"Editing process completed."
 ;
 D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 Q  ; Quit DELAUDIT
