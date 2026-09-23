DVBAUDDEV1  ;ALB/CP - UTL Device related subroutines #1 ; 10/10/18 2:05pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this DVBROUTINE should not be modified
 ;           ^%ZIS    ; IA #10086
 ;       HOME^%ZIS    ; IA #10086
 ;           ^%ZISC   ; IA #10089
 ;           ^%ZTLOAD ; IA #10063
 Q
 ;
CLOSE ; Close the DEVICE, but NEW the appropriate variables first
 ;
 N @($$%ZISC^DVBAUDNEW1())
 W ! D ^%ZISC
 ;
 Q  ; Close
 ;
DEVICE(DVBROUTINE,DVBDEFAULT,DVBCOL,DVBQUE,DVBDESC) ; Get device -- see numbered list below:
 ;
 N @($$%ZIS^DVBAUDNEW1())
 N @($$%ZTLOAD^DVBAUDNEW1())
 ; ZEXCEPT: DVBQUIT,U,XQY0,ZTDESC,ZTRTN,ZTSAVE
 ;
 S DVBQUIT=0 ; DVBDEFAULT output state variable to successful
 S DVBDEFAULT=$G(DVBDEFAULT)
 S DVBCOL=$G(DVBCOL)
 S DVBDESC=$G(DVBDESC,$P($G(XQY0),U,1)) ; Defaults to OPTION NAME
 S ZTRTN="START^"_DVBROUTINE
 S ZTDESC=DVBDESC
 S ZTSAVE("AMIE*")=""
 S ZTSAVE("ST*")="" ; **1** Added for Symbol Table Validation
 S ZTSAVE("^TMP(""AMIE"",$J,")=""
 S ZTSAVE("^UTILITY($J,")=""
 I $G(DVBQUE)="Q" D TASK(DVBROUTINE,DVBDEFAULT,DVBCOL,DVBQUE)
 I $G(DVBQUE)'="Q" D TASK(DVBROUTINE,DVBDEFAULT,DVBCOL)
 ;
 Q  ; DEVICE
 ;
IOM80(DVBROUTINE) ; Set IOM to 80 columns & screen to 10 CPI using
 ;
 N @($$%ZIS^DVBAUDNEW1())
 N DVBPIOM
 ; ZEXCEPT: IOP,IOSL,IOST
 ;
 S DVBPIOM=$G(^TMP("AMIE",$J,"DVBPIOM",DVBROUTINE)) Q:DVBPIOM'=80
 ;
 I $E(IOST,1,2)="C-" D  ;
 . S IOP="HOME;80;"_IOSL D ^%ZIS ; Set to home device with IOM of 132
 . W $C(27),"[?3l" ; Change FONT to 10 CPI for 80 char. right margin
 ;
 Q  ; IOM80
 ;
IOM132(DVBROUTINE) ; Set IOM to 132 columns & screen to 16 CPI
 ;
 N @($$%ZIS^DVBAUDNEW1())
 N DVBPIOM
 ; ZEXCEPT: IOP,IOSL,IOST
 ;
 D IOMSAVE(DVBROUTINE)
 S DVBPIOM=$G(^TMP("AMIE",$J,"DVBPIOM",DVBROUTINE))
 ;
 Q:DVBPIOM'=80
 I $E(IOST,1,2)="C-" D  ;
 . S IOP="HOME;132;"_IOSL D ^%ZIS ; Set to home device with IOM of 132
 . W $C(27),"[?3h" ; Change FONT to 16 CPI for 132 char. right margin
 Q  ; IOM132
 ;
IOMRESET(DVBROUTINE) ; Reset IOM (typically at closing of Device)
 ;
 N DVBPIOM
 ;
 S DVBPIOM=$G(^TMP("AMIE",$J,"DVBPIOM",DVBROUTINE)) ; Retrieve saved IOM
 ;
 ; Reset IOM variable and CPI according to previously saved value.
 I DVBPIOM=80 D IOM80(DVBROUTINE) ;... Set IOM=80  & CPI=80
 I DVBPIOM=132 D IOM132(DVBROUTINE) ;. Set IOM=132 & CPI=16
 ;
 Q  ; IOMRESET
 ;
IOMSAVE(DVBROUTINE) ; When IOM=80, save IOM for later reset at close
 ;
 Q:IOM'=80
 S ^TMP("AMIE",$J,"DVBPIOM",DVBROUTINE)=IOM ; Used by IOMRESET^DVBAUDDEV1
 ;
 Q  ; IOMSAVE
 ;
MSGCOL(DVBCOL) ; Display recommended column width or device type
 ;
 W !,"<"_DVBCOL_"> ",$S(DVBCOL:"Column ",1:""),"device recommended"
 ;
 Q  ; MSGCOL
 ;
TASK(DVBROUTINE,DVBDEFAULT,DVBCOL,DVBQUE) ;Prompt for device and optionally queue the task
 ;
 N %L,%ZIS,%ZTSK,IOHG,IOP,IOPAR,IOUPAR,POP,ZTSK
 ; ZEXCEPT: IO,DVBQUIT
 W !
 S %ZIS="MQ" ; M=Right Margin ; Q=Queuing Allowed
 S %ZIS("B")=$G(DVBDEFAULT) ; Display DVBDEFAULT device if defined
 ;
 ;-> Display appropriate message(s) based upon input variables
 ;
 I $G(DVBQUE)="Q" S IOP="Q"
 I $G(DVBQUE)'="Q" D IOMSAVE(DVBROUTINE)
 I $G(DVBCOL)]"" D MSGCOL(DVBCOL) I $G(DVBQUE)="Q" W !
 ;
 ;-> Prompt for device
 ;
 S DVBQUIT=0 ; DVBDEFAULT output state variable to successful
 D ^%ZIS I POP S DVBQUIT=1 Q
 Q:'$D(IO("Q"))  ;-> Queuing not allowed
 ;
 D ^%ZTLOAD,HOME^%ZIS K IO("Q")
 ;
 I $G(ZTSK)'>0 W !!,"Request cancelled.."
 ;
 I $G(ZTSK)>0 W !!,"This task has been queued...Task #",ZTSK,!
 ;
 D CONTINUE^DVBAUDPRT1(2,"R") ; 2 line feeds, Press <ENTER> to continue
 S DVBQUIT=1 ;-> Indicates job is queued, or error found
 ;
 Q  ; TASK
