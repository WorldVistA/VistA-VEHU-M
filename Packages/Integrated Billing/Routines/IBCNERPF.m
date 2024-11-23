IBCNERPF ;BP/YMG - IBCNE eIV AUTO UPDATE REPORT ;09-MAY-2023
 ;;2.0;INTEGRATED BILLING;**416,528,549,595,668,737,763,794**;21-MAR-94;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; NOTE:
 ;   IB*2.0*763 is a major re-write of this report.  The comments from the previous patches
 ;   have either been removed or modified to remove the patch number if the comment is relevant.
 ;
 ; Variables:
 ;   IBCNESPC("BEGDT")   = start date for date range
 ;   IBCNESPC("ENDDT")   = end date for date range
 ;   IBCNESPC("IBOUT")   = "R" for Report format or "E" for Excel format
 ;   IBCNESPC("ICODETL") = 1 for displaying Ins Co Detail
 ;   IBCNESPC("INSCO")   = "A" (All ins. cos.) OR "S" (Selected ins. cos.)
 ;   IBCNESPC("PYR",ien) - payer iens for report, if IBCNESPC("PYR")="A", then include all
 ;                       = (1) ^ (2)
 ;     (1) Display insurance company detail - 0 = No / 1 = Yes
 ;     (2) Display all or some insurance companies - A = All companies/
 ;                                                   S = Specified companies
 ;   IBCNESPC("PYR",ien,coien) - payer iens and company ien for report
 ;                             = Count for insurance company
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("TYPE")    = report type: "S" - summary, "D" - detailed
 ;
 Q
EN ; entry point
 N IBCNESPC,STOP,TYPE
 ;
 S STOP=0
 W @IOF
 W !,"eIV Auto Update Report"
 ;
 ; Report Type - Summary or Detailed
TYPE ;Type of Report
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:Summary;D:Detailed"
 S DIR("A")="Run a (S)ummary or (D)etailed Report: "
 S DIR("B")="Summary"
 D ^DIR
 I $D(DIRUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) G EXIT
 S (TYPE,IBCNESPC("TYPE"))=Y
 I TYPE="S" G SUMMARY
 ;
DETAIL ; Prompts in specific order for Detail report.
 S IBCNESPC("ICODETL")=1
 ;
D10 ; Payer Selection parameter
 D PAYER I STOP G:$$STOP EXIT G TYPE
 ;
D20 ; Date Range parameters
 D DTRANGE I STOP G:$$STOP EXIT G D10
 ;
D30 ; Patient Selection parameter
 D PATIENT I STOP G:$$STOP EXIT G D20
 ;
 G IBOUT
 ;
SUMMARY ;Prompts in specific order for Summary report
 ;
 S IBCNESPC("INSCO")="A" ;All insurance companies
 S IBCNESPC("PAT")="A"   ;All Patients
 S IBCNESPC("PYR")="A"   ;All Payers
 ;
S10 ;Select Payer or Source of Information
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^P:Payer;S:Source of Information"
 S DIR("A")="Run for (P)ayer or (S)ource of Information: "
 S DIR("?",1)="When selecting '(P)ayer', the report displays the breakout of auto updated"
 S DIR("?",2)="entries based on the Payer name."
 S DIR("?",3)=""
 S DIR("?",4)="When selecting '(S)ource of Information', the report displays the breakout of"
 S DIR("?")="auto updated entries based on the Source of Information of the entry."
 D ^DIR I $D(DIRUT) G:$$STOP EXIT G TYPE
 S IBCNESPC("PS")=Y
 I Y="S" D  G S40  ;Source of Information does not prompt for Ins Co or Payer.
 . S (IBCNESPC("PYR"),IBCNESPC("PAT"))="A"
 . S IBCNESPC("ICODETL")=1
 ;
S20 ;Prompt for Insurance Company Detail
 D ICODETL I STOP G:$$STOP EXIT G S10
 ;
S30 ;Prompt for Payer Selection
 D PAYER I STOP G:$$STOP EXIT G S20
 ;
S40 ; Response Received Date
 D DTRANGE I STOP G:$$STOP EXIT G S10:(IBCNESPC("PS")="S") G S30
 ;
IBOUT ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S STOP=1 G:$$STOP EXIT G S40:TYPE="S" G D30
 S IBCNESPC("IBOUT")=Y
 I Y="E" D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter ""0;"_$S(TYPE="S":"132",1:"256")_";99999"" at the ""DEVICE:"""
 . W !,"prompt.",!
 I $G(IBCNESPC("TYPE"))="D" W:$G(IBCNESPC("IBOUT"))="R" !!!,"*** This report is 132 characters wide ***",!
 ;
 ; Select the output device
DEVICE ; Device Handler and possible TaskManager calls
 ;
 ; Output params:
 ;  STOP = Flag to stop routine
 ;
 ; Init vars
 N POP,ZTDESC,ZTRTN,ZTSAVE
 ;
 S ZTRTN="COMPILE^IBCNERPF(.IBCNESPC)"
 S ZTDESC="IBCNE eIV Auto Update Report"
 S ZTSAVE("IBCNESPC(")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 ;
EXIT ;
 Q
 ;
COMPILE(IBCNESPC) ; 
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNESPC = Array passed by ref of the report params
 ;
 ; Init scratch globals
 N ALLPAT,ALLPYR
 K ^TMP($J,"IBCNERPF")
 N IBOUT
 ; Compile
 S IBOUT=$G(IBCNESPC("IBOUT"))
 D EN^IBCNERPG(.IBCNESPC)
 ; Print
 I '$G(ZTSTOP) D PRINT^IBCNERPG(.IBCNESPC)
 ; Close device
 D ^%ZISC
 ; Kill scratch globals
 K ^TMP($J,"IBCNERPF")
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
COMPILX ; COMPILE exit pt
 Q
 ;
PAYER ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PIEN,X,Y
 W !
 S DIR("A")="Run for (A)ll Payers or (S)elected Payers: "
 S DIR("A",1)="PAYER SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S IBCNESPC("PYR")=Y I Y="A" Q  ; "All Payers" selected
 S DIC(0)="ABEQ"
 W !
 S DIC("A")="Select Payer: "
 ; Only include payers with eIV Auto Update flag = Yes
 S DIC("S")="I $$AUTOUPDT^IBCNERPF($P($G(Y),U,1))"
 S DIC="^IBE(365.12,"
 ;
PAYER1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PYR") Q
 S PIEN=$P(Y,U,1) K IBCNESPC("PYR",PIEN) S IBCNESPC("PYR",PIEN)=""
 I $G(IBCNESPC("ICODETL")) D GETCOMPS(PIEN,.IBCNESPC)
 W !
 I $$ANOTHER("Payer") W ! G PAYER1
 Q
 ;
AUTOUPDT(PIEN) ; Lookup screen to determine if the Auto update flag for payer = Yes
 ; Input:   PIEN        - IEN of the Payer (file 365.12)
 ; Returns  1 - Auto update flag is set to 'Y', 0 otherwise
 N AUTOUPDT,IENS,MULT
 S AUTOUPDT=0
 S MULT=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 I MULT D
 . S IENS=MULT_","_PIEN_","
 . S AUTOUPDT=$$GET1^DIQ(365.121,IENS,4.01,"I")
 Q AUTOUPDT
 ;
GETCOMPS(PIEN,IBCNESPC) ; Get companies linked to payer
 ; Get associated insurance companies 
 ; If user wants to display insurance companies, prompt only for those linked to payer
 ; Allow the user to select none, one, or multiple insurance companies associated with a given payer
 ;
 ; Input
 ;  PIEN     - Payer ID
 ;  IBCNESPC - Array holding payer id and related insurance companies
 ; Output
 ;  IBCNESPC - Array holding payer id and related insurance companies
 ;  IBCNESPC("PYR",PIEN) = (1)
 ;    (1) Display all or some insurance companies - A = All companies/ S = Specified companies
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 K DIR
 S DIR("A")="Run for (A)ll Insurance Companies or (S)elected Insurance Companies: "
 S DIR("B")="A"
 S DIR(0)="SA^A:All;S:Selected" D ^DIR
 Q:$D(DIRUT)
 S $P(IBCNESPC("PYR",PIEN),U)=Y
 I Y="A" Q  ; Run for all companies
 S IBCNESPC("INSCO")="S"
 K ^TMP("IBCNILKA",$J)
 D EN^IBCNILK(2,PIEN,5)
 I $D(^TMP("IBCNILKA",$J)) D
 . M IBCNESPC("PYR",PIEN)=^TMP("IBCNILKA",$J)
 K ^TMP("IBCNILKA",$J)
 Q
 ;
ICODETL ;Display Insurance Company Detail.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBCNS,X,Y
 W !
 S DIR("A")="Do you want to display insurance company detail"
 S DIR("B")="NO"
 S DIR(0)="Y" D ^DIR
 I $D(DIRUT) S STOP=1 G ICODETLX
 S IBCNESPC("ICODETL")=Y=1
ICODETLX ;
 Q
 ;
DTRANGE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,IBDT180
 ; Default start date to T-180 
T180 ; 
 W !
 S IBDT180=$$FMADD^XLFDT($$DT^XLFDT(),-180)
 S DIR(0)="D^::EX",DIR("B")=$$FMTE^XLFDT(IBDT180,"D")
 S DIR("A")="Earliest Date Received"
 S DIR("A",1)="RESPONSE RECEIVED DATE RANGE SELECTION:"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 I Y>DT W !!,"Future dates not allowed." G T180
 I Y<IBDT180 W !!,"Response must not be previous to "_$$FMTE^XLFDT(IBDT180,"D")_"." G T180
 S IBCNESPC("BEGDT")=Y
 ; End date
DTRANGE1 ;
 S DIR("B")="Today"
 K DIR("A") S DIR("A")="  Latest Date Received"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 I Y>DT W !!,"Future dates not allowed." G DTRANGE1
 I Y<IBCNESPC("BEGDT") W !,"     Latest Date must not precede the Earliest Date." G DTRANGE1
 S IBCNESPC("ENDDT")=Y
 Q
 ;
PATIENT ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; summary report is always run for all patients
 I $G(IBCNESPC("TYPE"))="S" S IBCNESPC("PAT")="A" Q
 W !
 S DIR("A")="Run for (A)ll Patients or (S)elected Patients: "
 S DIR("A",1)="PATIENT SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S IBCNESPC("PAT")="A" Q  ; "All Patients" selected
 S DIC(0)="AMEQ"  ;IB*794/DTG change ABEQ to AMEQ to allow for ssn lookup (multi-indexes)
 S DIC("A")="Select Patient: "
 S DIC="^DPT("
PATIENT1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PAT") Q
 S IBCNESPC("PAT",$P(Y,U,1))=""
 I $$ANOTHER("Patient") G PATIENT1
 Q
 ;
ANOTHER(TYPE) ; "Select Another" prompt
 ; returns 1, if response was "YES", returns 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Select Another "_TYPE S DIR(0)="Y",DIR("B")="NO"
 D ^DIR I $D(DIRUT) S STOP=1
 Q Y
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DTOUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
