IBCNERPO ;AITC/CKB - PATIENT POLICY AUTOLOAD REPORT ; 20-JAN-2026
 ;;2.0;INTEGRATED BILLING;**836**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variables:
 ;   IBCNERPO("BEGDT")   = Start with DATE - start date range
 ;   IBCNERPO("ENDDT")   = Go to DATE - end date range
 ;   IBCNERPO("IBOUT")   = "R" for Report format or "E" for Excel format
 ;   IBCNERPO("TYPE")    = report type: "S" - summary, "D" - detailed
 ;   IBCNERPO("SORT")    = (1)Patient Name - (2)Date Autoloaded
 ;
 Q
EN ; entry point
 N IBCNERPO,STOP,TYPE
 ;
 S STOP=0
 W @IOF
 W !,"Patient Policy Autoload Report"
 W !!,"This report provides data for patient Medicare Policies that have been"
 W !,"Autoloaded by the eIV Autoload Process.",!
 ;
DATE ; Date Range parameters
 D DTRANGE I STOP G EXIT
 ;
 ; Report Type - Summary or Detailed 
TYPE ;Type of Report
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:Summary;D:Detailed"
 S DIR("A")="Do you wish to print a (S)ummary or (D)etailed Report? "
 D ^DIR
 I $D(DIRUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1
 I STOP G EXIT
 S (TYPE,IBCNERPO("TYPE"))=Y
 ; If Summary report is selected, DO NOT prompt for report format or sort
 I TYPE="S" W !! G DEVICE
 ;
IBOUT ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S STOP=1
 I STOP G EXIT
 S IBCNERPO("IBOUT")=Y
 ;
SORT ;
 I TYPE="D"&(IBCNERPO("IBOUT")="R") D  I STOP=1 G EXIT ;;*****G:$$STOP EXIT
 . W !
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR("A",1)="Sort report by"
 . S DIR("A",2)="1  - Patient Name"
 . S DIR("A",3)="2  - Date Autoloaded"
 . S DIR("A",4)="  "
 . S DIR(0)="SAB^1:Patient Name;2:Date Autoloaded"
 . S DIR("A")="Select Number: "
 . D ^DIR
 . I $D(DIRUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1
 . I STOP G EXIT
 . S IBCNERPO("SORT")=Y
 ;
 I IBCNERPO("IBOUT")="E" D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter ""0;256;99999"" at the ""DEVICE:"""
 . W !,"prompt.",!
 I $G(IBCNERPO("TYPE"))="D" I $G(IBCNERPO("IBOUT"))="R" D
 . W !!!,"*** You will need a 132 column printer for this report. ***",!
 . W "To avoid undesired wrapping of the data when printing to the screen,",!
 . W "please enter ""0;132;"" at the ""DEVICE:"" prompt.",!
 ;
 ; Select the output device
DEVICE ; Device Handler and possible TaskManager calls
 ; Output params:  STOP = Flag to stop routine
 ;
 ; Init vars
 N POP,ZTDESC,ZTRTN,ZTSAVE
 S ZTRTN="COMPILE^IBCNERPO(.IBCNERPO)"
 S ZTDESC="Patient Policy Autoload Report"
 S ZTSAVE("IBCNERPO(")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
EXIT ;
 Q
 ;
COMPILE(IBCNERPO) ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNERPO = Array passed by ref of the report params
 ;
 ; Init scratch globals
 K ^TMP($J,"IBCNERPO")
 N IBOUT
 S IBOUT=$G(IBCNERPO("IBOUT"))
 ; Compile
 D EN^IBCNERPO1(.IBCNERPO)
 ; Print
 I '$G(ZTSTOP) D PRINT^IBCNERPO1(.IBCNERPO)
 ; Close device
 D ^%ZISC
 ; Kill scratch globals
 K ^TMP($J,"IBCNERPO")
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
COMPILX ; COMPILE exit pt
 Q
 ;
 ;
DTRANGE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,IBDT180
DT10 ; Start with DATE - default is 6 months (or 180 days)in the past 
 W !
 S IBDT180=$$FMADD^XLFDT($$DT^XLFDT(),-180)
 S DIR(0)="D^::EX"
 S DIR("B")=$$FMTE^XLFDT(IBDT180,"D")
 S DIR("A")="Start with DATE"
 S DIR("?",1)="Please enter a valid date no more than 6 months in the past."
 S DIR("?")="Future dates are not allowed."
 D ^DIR I $D(DIRUT) S STOP=1 Q
 I (Y>DT)!(Y<IBDT180) D  G DT10
 . W !!,"Please enter a valid date no more than 6 months in the past."
 . W !,"Future dates are not allowed."
 S IBCNERPO("BEGDT")=Y
 ; 
DT20 ; Go to DATE - no default
 K DIR("A"),DIR("B")
 S DIR("A")="Go to DATE"
 S DIR("?",1)="Please enter a valid date no more than 6 months in the past."
 S DIR("?")="Future dates are not allowed."
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 ;
 I Y>DT D  G DT20
 . W !!,"Please enter a valid date no more than 6 months in the past."
 . W !,"Future dates are not allowed.",!
 I Y<IBCNERPO("BEGDT") W !!,"Go to DATE must not precede the Start with DATE.",! G DT20
 S IBCNERPO("ENDDT")=Y
 Q
