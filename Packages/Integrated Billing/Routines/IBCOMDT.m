IBCOMDT ;ALB/CKB - INSURANCE COMPANY MISSING DATA REPORT (DRIVER/PROMPTS) ; 12-APR-2023
 ;;2.0;INTEGRATED BILLING;**763**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #1519-For using the KERNEL routine XUTMDEVQ
 ;
 ;
 ;   IBCOMDT("IBI")    0-Selected, 1-ALL Insurance Companies
 ;
 ;   IBCOMDT("IBSL1")  0 = ignore MAIN MAILING Street Line 1
 ;                     1 = include MAIN MAILING Street Line 1
 ;
 ;   IBCOMDT("IBSL2")  0 = ignore MAIN MAILING Street Line 2
 ;                     1 = include MAIN MAILING Street Line 2
 ;
 ;   IBCOMDT("IBSL3")  0 = ignore MAIN MAILING Street Line 3
 ;                     1 = include MAIN MAILING Street Line 3
 ;
 ;   IBCOMDT("IBCTY")  0 = ignore MAIN MAILING City
 ;                     1 = include MAIN MAILING City
 ;
 ;   IBCOMDT("IBST")   0 = ignore MAIN MAILING State
 ;                     1 = include MAIN MAILING State
 ;
 ;   IBCOMDT("IBZIP")  0 = ignore MAIN MAILING Zip+4
 ;                     1 = include MAIN MAILING Zip+4
 ;
 ;   IBCOMDT("IBCOV")  0 = ignore Type of Coverage
 ;                     1 = include Type of Coverage
 ;   
 ;   IBCOMDT("IBFTF")  0 = ignore Missing Filing Time Frame filter
 ;                     1 = include Missing Filing Time Frame filter
 ;
 ;   IBCOMDT("IBOUT")  E-EXCEL, R-REPORT
 ;
 ;   IBCOMDT("$J") = $J of the parent job (if queued)
 ;   IBCNRTN = "IBCOMDT" (routine name passed into the COMPILE process)
 ;
 Q   ; Must call EN
 ;
EN ; Main Entry point.
 ; Initialize variables.
 N IBI,IBCOMDT,IBOUT,IBQUIT,POP,STOP,ZTDESC,ZTDEXC,ZTRTN,ZTSAVE,%ZIS
 ; 
 ; Describe report
 W @IOF
 W !!,"INSURANCE COMPANY MISSING DATA REPORT"
 W !!?5,"This report will generate a list of ACTIVE insurance companies"
 W !?5,"that are missing the data that you select to be reported upon.",!
 ;
C0 ; Start of filters, allowing users to go back to first prompt
 S IBCNRTN="IBCOMDT",IBCOMDT("$J")=$J
 K ^TMP(IBCNRTN,IBCOMDT("$J"))
 S (IBOUT,IBQUIT,STOP)=0
 ;
O10 ; Report or CSV output 
 D OUTPUT I STOP G EXIT
 ;
C10 ; User select ALL/Selected Insurance Companies
 D SELINS I STOP G:$$STOP EXIT G O10
 ;
C20 ; If ALL Insurance Companies, add to ^TMP(IBCNRTN
 I IBCOMDT("IBI") D
 . N IBCNS,IBIC
 . ; IBIC - Insurance Co Name / IBCNS - IEN of Insurance Co in file #36
 . S IBIC=""
 . F  S IBIC=$O(^DIC(36,"B",IBIC)) Q:IBIC=""  D
 . .S IBCNS=0
 . .F  S IBCNS=$O(^DIC(36,"B",IBIC,IBCNS)) Q:'IBCNS  D
 . . . I $$GET1^DIQ(36,IBCNS_",",.05,"I") Q  ; Only include Active Insurance Companies
 . . . S ^TMP(IBCNRTN,IBCOMDT("$J"),IBIC,IBCNS)=""
 ;
C30 ; If SELECTED Insurance Company(s), add to ^TMP(IBCNRTN
 ; Insurance Company look-up ListMan template to allow user selection
 I 'IBCOMDT("IBI") D
 . N IBCNS,IBIC
 . D EN^IBCNILK(1)  ; Only include Active Insurance Companies
 . I '$D(^TMP("IBCNILKA",IBCOMDT("$J"))) Q  ; No Insurance Companies selected
 . S IBCNS="" F  S IBCNS=$O(^TMP("IBCNILKA",IBCOMDT("$J"),IBCNS)) Q:IBCNS=""  D
 . . ; Insurance Company Name
 . . S IBIC=$$GET1^DIQ(36,IBCNS_",",.01)
 . . S ^TMP(IBCNRTN,IBCOMDT("$J"),IBIC,IBCNS)=""
 . K ^TMP("IBCNILKA",IBCOMDT("$J"))
 ;
 ; If No Insurance Company was selected.
 I '$D(^TMP(IBCNRTN,IBCOMDT("$J"))) W !!,"No Insurance Companies selected!",!! D PAUSE^IBCOMDT1 G EXIT
 ;
 ; If user chose Excel output, skip filters. Excel reports on ALL fields.
 I IBCOMDT("IBOUT")="E" G WARN
 ;
F0 ; Start of Filters
 S IBCOMDT("SUBHD")=""
 ;
 ; Filter on Missing Street Line 1
F10 D SELSL1
 I STOP G:$$STOP EXIT G C10
 I +IBCOMDT("IBSL1") D
 . S IBCOMDT("SUBHD")="ST LINE 1"
 ;
 ; Filter on Missing Street Line 2
F20 D SELSL2
 I STOP G:$$STOP EXIT G F10
 I +IBCOMDT("IBSL2") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"ST LINE 2"
 ;
 ; Filter on Missing Street Line 3
F30 D SELSL3
 I STOP G:$$STOP EXIT G F20
 I +IBCOMDT("IBSL3") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"ST LINE 3"
 ;
 ; Filter on Missing City
F40 D SELCTY
 I STOP G:$$STOP EXIT G F30
 I +IBCOMDT("IBCTY") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"CITY"
 ;
 ; Filter on Missing State
F50 D SELST
 I STOP G:$$STOP EXIT G F40
 I +IBCOMDT("IBST") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"STATE"
 ;
 ; Filter on Missing Zip+4
F60 D SELZIP
 I STOP G:$$STOP EXIT G F50
 I +IBCOMDT("IBZIP") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"ZIP+4"
 ;
 ; Filter on Missing Type of Coverage
F70 D SELCOV
 I STOP G:$$STOP EXIT G F60
 I +IBCOMDT("IBCOV") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"COVERAGE"
 ;
 ; Filter Filing Time Frame
F80 D SELFTF
 I STOP G:$$STOP EXIT G F70
 I +IBCOMDT("IBFTF") D
 . S IBCOMDT("SUBHD")=IBCOMDT("SUBHD")_$S(IBCOMDT("SUBHD")'="":", ",1:"")_"FTF"
 ;
 ; If NO Filters were selected take the user back to the first filter question
 I IBCOMDT("SUBHD")="" D  G:$D(DUOUT)!(IBQUIT) EXIT G F0
 . W !!,"** No Filters were selected **",!
 . D PAUSE^IBCOMDT1
 ;
WARN ;
 W !!,?14,"*** WARNING ***",!
 W " This report may take a little while to compile!",!
 ;
D10 ; Select Device (ie., queue, print to screen...)
 D DEVICE(IBCNRTN,.IBCOMDT)
 I STOP G EXIT
 ;
EXIT ; Exit point
 K ^TMP(IBCNRTN,IBCOMDT("$J"))
 K ^TMP(IBCOMDT("$J"),"PR")
 Q
 ;
 ;======================================Prompts==========================
SELINS ; Prompt user to select all or subset of insurance companies
 ; Count insurance companies with plans
 ; Returns: 0 - User selects insurance companies
 ;          1 - Run report for all insurance companies with plans
 ;     STOP=1 - No selection made
 ;
 N A,B
 S (A,B)=0
 F  S A=$O(^IBA(355.3,"B",A)) Q:'A  S B=B+1
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:List All "_B_" Ins. Companies;2:List Only Ins. Companies That You Select"
 S DIR("A",1)=" 1 - List All "_B_" Ins. Companies"
 S DIR("A",2)=" 2 - List Only Ins. Companies That You Select"
 S DIR("A")="      SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2.  Only insurance"
 S DIR("?")="companies with one or more plans can be selected."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELINSQ
 S IBCOMDT("IBI")=(+Y=1) K Y
SELINSQ ;
 Q
 ;
OUTPUT ; Prompt to allow users to select output format
 ; Returns: E - Output to excel
 ;          R - Output to report
 ;     STOP=1 - No Selection made
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 S DIR("?",1)="Select 'E' to create CSV output for import into Excel."
 S DIR("?")="Select 'R' to create a standard report."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G OUTQ
 S IBCOMDT("IBOUT")=Y
OUTQ ;  
 Q
DEVICE(IBCNRTN,IBCOMDT) ; Device Handler and possible TaskManager calls
 ; Input params:
 ;   IBCNRTN = Routine name for ^TMP(IBCNRTN,IBCOMDT("$J"),...
 ;   IBCOMDT = Array passed by ref of the report params
 ; Output params:
 ;      STOP = Flag to stop routine, exit option
 ;
 ; Init vars
 I IBCOMDT("IBOUT")="E" D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter ""0;256;99999"" at the ""DEVICE:"""
 . W !,"prompt.",!
 ;
 ;  IBCNGP = Array of Params
 N POP,ZTDESC,ZTRTN,ZTSAVE
 S ZTRTN="COMPILE^IBCOMDT1(IBCNRTN,.IBCOMDT)"
 S ZTDESC="INSURANCE COMPANY MISSING DATA REPORT"
 S ZTSAVE("^TMP(IBCNRTN,IBCOMDT(""$J""),")=""
 S ZTSAVE("IBCOMDT(")=""
 S ZTSAVE("IBCNRTN")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")   ; ICR # 1519
 I POP S STOP=1
 ;
DEVICEX ; DEVICE exit pt
 Q 
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Initialize Variables
 N DIR,DIRUT,X,Y
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)=" Enter YES to immediately exit out of this option."
 S DIR("?")=" Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
STOPX ; STOP Exit Point
 Q Y
 ;
 ;===============================Filter Prompts==========================
SELSL1 ; Prompt user to report missing Street Line 1
 ;
 ; 0 -- Do not print missing Street Line 1
 ; 1 -- Print missing Street Line 1
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing MAIN MAILING STREET LINE 1"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'STREET LINE 1' when missing."
 S DIR("?")="Answering No ignores missing Street Line 1."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELSL1Q
 S IBCOMDT("IBSL1")=+Y K Y
SELSL1Q ;
 Q
 ; 
SELSL2 ; Prompt user to report missing Street Line 2
 ;
 ; 0 -- Do not print missing Street Line 2
 ; 1 -- Print missing Street Line 2
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing MAIN MAILING STREET LINE 2"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'STREET LINE 2' when missing."
 S DIR("?")="Answering No ignores missing Street Line 2."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELSL2Q
 S IBCOMDT("IBSL2")=+Y K Y
SELSL2Q ;
 Q
 ;
SELSL3 ; Prompt user to report missing Street Line 3
 ;
 ; 0 -- Do not print missing Street Line 3
 ; 1 -- Print missing Street Line 3
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing MAIN MAILING STREET LINE 3"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'STREET LINE 3' when missing."
 S DIR("?")="Answering No ignores missing Street Line 3."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELSL3Q
 S IBCOMDT("IBSL3")=+Y K Y
SELSL3Q ;
 Q
 ;
SELCTY ; Prompt user to report missing City
 ;
 ; 0 -- Do not print missing City
 ; 1 -- Print missing City
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing MAIN MAILING CITY"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'CITY' when missing."
 S DIR("?")="Answering No ignores missing City."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELCTYQ
 S IBCOMDT("IBCTY")=+Y K Y
SELCTYQ ;
 Q
 ;
SELST ; Prompt user to report missing State
 ;
 ; 0 -- Do not print missing State
 ; 1 -- Print missing State
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing MAIN MAILING STATE"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'STATE' when missing."
 S DIR("?")="Answering No ignores missing State."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELSTQ
 S IBCOMDT("IBST")=+Y K Y
SELSTQ ;
 Q
 ;
SELZIP ; Prompt user to report missing Zip+4
 ;
 ; 0 -- Do not print missing Zip+4
 ; 1 -- Print missing Zip+4
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing MAIN MAILING ZIP+4"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'ZIP+4' when missing."
 S DIR("?")="Answering No ignores missing Zip+4."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELZIPQ
 S IBCOMDT("IBZIP")=+Y K Y
SELZIPQ ;
 Q
 ;
SELCOV ; Prompt user to report missing Type of Coverage
 ;
 ; 0 -- Do not print missing Type of Coverage
 ; 1 -- Print missing Type of Coverage
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing TYPE OF COVERAGE"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'TYPE OF COVERAGE' when missing."
 S DIR("?")="Answering No ignores missing Type of Coverage."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELCOVQ
 S IBCOMDT("IBCOV")=+Y K Y
SELCOVQ ;
 Q
 ;
SELFTF ; Prompt user to report missing Filing Time Frame
 ;
 ; 0 -- Do not print missing Filing Time Frame
 ; 1 -- Print missing Filing Time Frame
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Ins Co with a missing FILING TIME FRAME"
 S DIR("B")="YES"
 S DIR("?",1)="Answering Yes displays the text 'FILING TIME FRAME' when missing."
 S DIR("?")="Answering No ignores missing Filing Time Frame."
 W ! D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELFTFQ
 S IBCOMDT("IBFTF")=+Y K Y
SELFTFQ ;
 Q
