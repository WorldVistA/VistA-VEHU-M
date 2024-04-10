IBCNOR1 ;AITC/DTG - PATIENT MISSING COVERAGE REPORT ;08/14/23
 ;;2.0;INTEGRATED BILLING;**771**;21-MAR-94;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #1519-For using the KERNEL routine XUTMDEVQ
 ;
 Q
EN ; entry point
 ;
 ; IBCNOR("IBI")  = select INS 0 some, 1 all
 ; IBCNOR("IBIA") = only 1-Active Insurance Companies
 ; IBCNOR("IBIG") = 0-Selected, 1-All Group Plans
 ; IBCNOR("IBIGA")= only 1-Active Group Plans
 ; IBCNOR("IBIGN")= 1-Group Name, 2-Group Number, 3-Both Group Name and Group Number
 ; IBCNOR("IBFIL")= A^B^C where"
 ;                    A - 1-Begin with, 2-Contains, 3-Range
 ;                    B - A=1 Begin with text, A=2 Contains text, A=3 Range start text
 ;                    C - only if A=3 Range End text
 ; IBCNOR("IBOUT")  E-EXCEL, R-REPORT
 ;
 W !!,"This report allows the user to list patients who have an active medical"
 W !,"policy/coverage and are missing an active pharmacy policy/coverage.",!!
 ;
 N DIC,DIR,INACT,IBARRAY,IBB,IBCNOR,IBCNS,IBFILTER,IBLEVEL,IBI36,IBINAME
 N IBINM,IBINSLNM,IBITYP,IBOK,IBOK1,IBQUIT,IBRF,IBRFU,IBRL,IBSORT,IBTMP,IBTYP,IBXTFEED
 N IBRLU,IBSCR,IBSTOP,IIEN,INSCT,INSNAME,NGFLG,NGFND,POP,X,Y
 S (IBSTOP,IBQUIT)=""
 S IBCNOR("IBIA")=1  ;only active insurance companies
 S IBCNOR("IBIGA")=1  ;only active group plans
 ;
Q10 ; ask ins
 K IBARRAY
 K ^TMP("IBCNOR",$J,"INS"),^TMP($J,"IBCNOR")
 S IBSTOP=0 D SELI
 I IBSTOP G EXIT
 I 'IBCNOR("IBI") D
 . N IBCNS,INSCT
 . D EN^IBCNILK(1)  ; active only
 . I '$D(^TMP("IBCNILKA",$J)) S IBQUIT=1 Q  ; No Insurance Companies selected
 . K ^TMP($J,"IBCNOR","ILK") M ^TMP($J,"IBCNOR","ILK")=^TMP("IBCNILKA",$J)
 . S INSCT=0
 . S IBCNS="" F  S IBCNS=$O(^TMP("IBCNILKA",$J,IBCNS)) Q:IBCNS=""  D
 . . S INSCT=INSCT+1
 . . ; Add SELECTED Insurance Companies, add to ^TMP("IBCNOR")
 . . S ^TMP("IBCNOR",$J,"INS",INSCT)=IBCNS
 ;
 I IBQUIT W !!,"** No Insurance Companies selected! **",!! S DIR(0)="E" D ^DIR K DIR G EXIT
 ;
 ; If ALL Insurance Companies, add to ^TMP("IBCNOR")
 I IBCNOR("IBI") D  G Q50
 . S INSCT=0
 . S IBCNOR("IBIG")=1  ; default to all groups/plans of chosen insurance
 . S IBCNOR("IBIGN")=3 ; default to both name and number for groups/plans
 . S IBCNOR("IBFIL")="3^A^Z"  ; default to groups in range from A to Z
 ;
Q20 ; ask group
 ;
 S IBSTOP=0 D SELG I IBSTOP G EXIT
 ; No Groups found (NGFND=1), type enter to continue and exit
 I $G(NGFND)=1 S DIR(0)="E" D ^DIR K DIR G EXIT
 ;
 I IBCNOR("IBIG") D  G Q50  ; skip around when all groups/plans are selected
 . S IBCNOR("IBIGN")=3 ; default to both name and number for groups/plans
 . S IBCNOR("IBFIL")="3^A^Z"  ; default to groups in range from A to Z
 ;
 K ^TMP($J,"IBCNOR","ILK") M ^TMP($J,"IBCNOR","ILK")=^TMP("IBCNILKA",$J)
Q30 ; Group Name/Group Number/Both filter
 S IBSTOP=0 D SELGN I IBSTOP G EXIT
 ;
Q40 ; type of group
 ; Group(s)that Begin/Contain/Range XXX
 S (IBQUIT,IBSTOP)=0
 S IBFILTER=$$SELFILT^IBCNOR1()
 I +IBFILTER<0 S IBSTOP=1
 I IBSTOP G EXIT
 S IBCNOR("IBFIL")=IBFILTER
 ;
Q45 ; select groups if not all
 ;
 ;S (IBQUIT,IBSTOP)=0 I 'IBCNOR("IBIG") D  I IBSTOP G:$$STOP EXIT G Q40
 S (IBQUIT,IBSTOP)=0 I 'IBCNOR("IBIG") D  I IBSTOP G EXIT
 . ; loop through the insurance companies
 . N IBI,IBJ,IBN,IBSORT
 . K IBSORT
 . S IBI=0 F  S IBI=$O(^TMP("IBCNOR",$J,"INS",IBI)) Q:'IBI  D
 . . N IBNM
 . . S IBN=$G(^TMP("IBCNOR",$J,"INS",IBI)),IBNM=$$GET1^DIQ(36,IBN,.01)
 . . I IBNM="" Q
 . . S IBSORT(IBNM,IBN)=IBI
 . D BLDSELECT I IBQUIT!IBSTOP Q
 . ; go through insurances if no plans selected
 . N IBI,IBJ,IBN
 . S IBI="",IBN=0 F  S IBI=$O(^TMP("IBCNOR",$J,"INS",IBI)) Q:'IBI  D  Q:IBN
 . . S IBJ="" F  S IBJ=$O(^TMP("IBCNOR",$J,"INS",IBI,"GRP",IBJ)) Q:'IBJ  S IBN=1
 . I 'IBN S IBSTOP=1 D  Q
 . . W !," No Groups/Plans selected for the chosen insurances",!! S DIR(0)="E" D ^DIR K DIR
 ;
Q50 ; ask patient
 ;
 S IBSTOP=0
 D NR  ;patient name range
 I IBSTOP G EXIT
 ;
Q60 ; check if all and ask to proceed
 S IBSTOP=0
 I (IBCNOR("IBIG")&(IBCNOR("IBI"))&((IBRF="")&(IBRL="zzzzzz")!(IBRFU="A"&IBRLU="Z"))) D SELALL
 I IBSTOP G EXIT
 ;
Q70 ; Report or CSV output 
 S IBSTOP=0 D OUT
 I IBSTOP G EXIT
 ;
 D DEVICE
 ;
EXIT ; quit
 ;
 K ^TMP("IBCNOR",$J)
 K ^TMP($J,"IBSEL")
 ;
 Q
 ;
 ;
SELI ; Prompt user to select all or subset of insurance companies
 ; Count insurance companies with plans
 ; Returns: 0 - User selects insurance companies
 ;          1 - Run report for all insurance companies with plans
 ;     STOP=1 - No selection made
 ;
 N IBA,IBB,INACT
 S (IBA,IBB)=0
 F  S IBA=$O(^IBA(355.3,"B",IBA)) Q:'IBA  D
 . S INACT=+$$GET1^DIQ(36,IBA_",",.05,"I") ;1=Inactive, 0=Active
 . I 'INACT S IBB=IBB+1
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:List All "_IBB_" Active Ins. Companies;2:List Only Active Ins. Companies That You Select"
 S DIR("A",1)="1 - List All "_IBB_" Active Ins. Companies"
 S DIR("A",2)="2 - List Only Active Ins. Companies That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2.  Only active insurance"
 S DIR("?")="companies with one or more plans can be selected."
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S IBSTOP=1 G SELIQ
 S IBCNOR("IBI")=(+Y=1) K Y
 S IBCNOR("IBIA")=1
SELIQ ;
 Q
 ;
SELG ; Prompt user to select all or subset of group plans
 ; Count of group plans
 ; Returns: 0 - Selected Group Plans
 ;          1 - All Group Plans
 ;     STOP=1 - No selection made
 ;
 N IBA,IBA0,IBCT,INACT,IBIN
 ;
 S IBCNOR("IBIG")=1
 S IBCNOR("IBIGA")=1
 ; Get count of Group Plans from Insurance Company(s), ALL or Selected
 S (NGFLG,NGFND)=0
 S IBCT=0
 S IBA0=0,IBINSLNM="" F  S IBA0=$O(^TMP("IBCNOR",$J,"INS",IBA0)) Q:'IBA0  D
 . S IBA=^TMP("IBCNOR",$J,"INS",IBA0)
 . S IBINSLNM=$$GET1^DIQ(36,IBA_",",.01)
 . I '$D(^IBA(355.3,"B",IBA)) S NGFLG=1 Q
 . S IBB=0 F  S IBB=$O(^IBA(355.3,"B",IBA,IBB)) Q:'IBB  D
 . . S IBIN=+$$GET1^DIQ(355.3,IBB_",",.11,"I") I IBIN Q  ; quit back if inactive flag set
 . . S IBCT=IBCT+1
 ;
 ; If there are no groups for the selected Ins Company(s),display the following and set NGFND=1
 I 'IBCNOR("IBI"),IBCT=0 D  Q
 . W !!,"The selected Company(s) does not contain any Groups",!!
 . S NGFND=1,IBCNOR("IBIG")=0
 ;
 ; If there are No Groups found when one or more Ins Company(s) are selected
 ; display the following message
 I NGFLG W !!,"Some Selected Companies do not contain groups and will not display on the report"
 ;
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:List All "_IBCT_" Active Group Plans;2:List Only Active Group Plans That You Select"
 S DIR("A",1)="1 - List All "_IBCT_" Active Group Plans"
 S DIR("A",2)="2 - List Only Active Group Plans That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2."
 S DIR("?")="One or more group plans can be selected."
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S IBSTOP=1 G SELGQ
 S IBCNOR("IBIG")=(+Y=1) K Y
 S IBCNOR("IBIGA")=1
SELGQ ;
 Q
 ;
SELGN ; Prompt user to select Group Name/Group Number/Both filter
 ; Returns: 1   - Group Name
 ;          2   - Group Number
 ;          3   - Both Group Name and Group Number
 ;         -1   - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:GROUP NAME;2:GROUP NUMBER;3:BOTH"
 S DIR("A")="     Select 1 or 2 or 3: "
 S DIR("A",1)="1 - Select GROUP NAME"
 S DIR("A",2)="2 - Select GROUP NUMBER"
 S DIR("A",3)="3 - Select BOTH"
 S DIR("?",1)="  1 - Only allow selection of GROUP NAME"
 S DIR("?",2)="  2 - Only allow selection of GROUP NUMBER"
 S DIR("?")="  3 - Allow selection of GROUP NAME and GROUP NUMBER"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S IBSTOP=1 G SELGNQ
 S IBCNOR("IBIGN")=Y
SELGNQ ;
 Q
 ;
NR ; Ask Name Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
NRR ;
 W !!,"Enter Start With value or Press <ENTER> to start at the beginning of the list.",!
 S DIR(0)="FO",DIR("A")="START WITH PATIENT NAME"
 S DIR("?")="^D NRRHLP^IBCNOR1(""BEGIN"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBSTOP=1 Q
 S IBRF=Y
 S IBRFU=$$UP^XLFSTR(IBRF)
 ;
 W !!,"Enter Go To value or Press <ENTER> to finish at the end of the list.",!
 S DIR(0)="FO",DIR("A")="GO TO PATIENT NAME"
 S DIR("?")="^D NRRHLP^IBCNOR1(""END"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBSTOP=1 Q
 S:Y="" Y="zzzzzz" S IBRL=Y
 S IBRLU=IBRL I IBRL'="zzzzzz" S IBRLU=$$UP^XLFSTR(IBRL)
 I $G(IBRLU)']$G(IBRFU) W !!,?5,"* The Go to Patient Name must follow after the Start with Name. *",! G NRR
 Q
 ;
NRRHLP(IBLEVEL) ; ?? Help for the Range Prompt
 W !!,?5,"Enter a value the Patient Name should ",IBLEVEL," with."
 I IBLEVEL="BEGIN" W !,?5,"Press <ENTER> to start at the beginning of the list."
 I IBLEVEL="END" W !,?5,"Press <ENTER> to finish at the end of the list."
 Q
 ;
SELALL ; ask if user say run for all ins / groups / patients
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="Y",IBSTOP=0,DIR("B")="NO"
 S DIR("A",1)="WARNING: You have selected to run this report for all insurance companies,"
 S DIR("A",2)="all group plans, and all associated patients. In doing so, this report will"
 S DIR("A",3)="take a long time to run."
 S DIR("A",4)=" "
 S DIR("A")="Do you want to continue"
 S DIR("?")="Enter 'Y' to continue or 'N' to quit"
 D ^DIR K DIR
 I Y'="1" S Y=0
 I Y=0!($D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT)) S IBSTOP=1
SELALLQ ; back
 Q
 ;
DEVICE ;
 N I,POP,IBB
 W !!,"We recommend you queue this report as it will take awhile."
 I IBCNOR("IBOUT")="E" D
 . W !!,"For CSV output, turn logging or capture on now.",!
 ;
 ;  IBCNOR = Array of Params
 N IBJOB,POP,ZTDESC,ZTRTN,ZTSAVE
 S ZTRTN="COMPILE^IBCNOR1A(""IBCNOR"",.IBCNOR)"
 S ZTDESC="PC - PATIENT MISSING COVERAGE REPORT"
 S ZTSAVE("^TMP(""IBCNOR"",$J,")=""
 S ZTSAVE("^TMP(""IBCNILKA"",$J,")=""
 S IBJOB=$J
 F IBB="IBCNOR(","IBJOB","IBRL","IBRLU","IBRF","IBRFU" S ZTSAVE(IBB)=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")   ; ICR # 1519
 ;
 Q
ENQ ;
 Q
OUT ; Prompt to allow users to select output format
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
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S IBSTOP=1 G OUTQ
 S IBCNOR("IBOUT")=Y
OUTQ ;  
 Q
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
 I $D(DIRUT) S (IBSTOP,Y)=1 G STOPX
 I 'Y S IBSTOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
CHKINS(IBISN) ; check that insurance is allowed
 ;
 N IBA,IBB,IBC,IBL
 S IBOK=1
 S INACT=+$$GET1^DIQ(36,IBISN_",",.05,"I") ;1=Inactive, 0=Active
 S IBTYP=$$GET1^DIQ(36,IBISN_",",.13,"E")
 ; Is the Insurance Company Inactive?
 I INACT S IBOK=0 Q   ; Ins Company is Inactive and looking for Active only
 ; check on type
 ;Ins type is skipped
 I IBTYP="MEDI-CAL" S IBOK=0 Q
 I IBTYP="MEDICAID" S IBOK=0 Q
 I IBTYP="TORT/FEASOR" S IBOK=0 Q
 I IBTYP="VA SPECIAL CLASS" S IBOK=0 Q
 I IBTYP="WORKERS' COMPENSATION" S IBOK=0 Q
 I IBTYP="INDEMNITY" S IBOK=0 Q
 I IBTYP="DISABILITY INCOME INSURANCE" S IBOK=0 Q
 I IBTYP="SUBSTANCE ABUSE ONLY" S IBOK=0 Q
 I IBTYP="MEDICARE" S IBOK=0 Q
 Q
CHKNM(INSNAME) ; check name
 ; check on ins name
 S INSNAME=$G(INSNAME) I INSNAME="" S IBOK=0 Q
 N IBA,IBB,IBL,INSNAM
 S IBOK=1,INSNAM=$$UP^XLFSTR(INSNAME)
 I INSNAM["(WNR)" S IBOK=0 Q
 I INSNAM["MCR" S IBOK=0 Q
 I INSNAM["WNR" S IBOK=0 Q
 I INSNAM["MEDICARE" S IBOK=0 Q
 I INSNAM["MEDICAID" S IBOK=0 Q
 I INSNAM["CAMP LEJEUNE" S IBOK=0 Q
 I INSNAM["IVF" S IBOK=0 Q
 I INSNAM["VHA DIRECTIVE 1029" S IBOK=0 Q
 I INSNAM["CLAY HUNT" S IBOK=0 Q
 I INSNAM["DEPARTMENT OF LABOR" S IBOK=0 Q
 I INSNAM["REGIONAL COUNSEL" S IBOK=0 Q
 ;
 Q
 ;
SELFILT() ; Group Plan filter
 ; Returns: A^B^C Where:
 ;           A - 1 - Search for Group(s) that begin with
 ;                   the specified text (case insensitive)
 ;               2 - Search for Group(s) that contain
 ;                   the specified text (case insensitive)
 ;               3 - Search for Group(s) in a specified
 ;                   range (inclusive, case insensitive)
 ;               4 - Search for Group(s) that are BLANK or null 
 ;           B - Begin with text if A=1, Contains Text if A=2 or
 ;               the range start if A=3
 ;           C - Range End text (only present when A=3)
 ;         -1 if a valid filter was not selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILTER,X,XX,Y
 ;
 ; First ask what kind of filter to use
 W !
 S DIR(0)="SA^1:Begins with;2:Contains;3:Range;4:Blank"
 S DIR("A")="     Select 1, 2, 3 or 4: "
 S DIR("A",1)="1 - Select Group(s) that Begin with: XXX"
 S DIR("A",2)="2 - Select Group(s) that Contain: XXX"
 S DIR("A",3)="3 - Select Group(s) in Range: XXX - YYY"
 S DIR("A",4)="4 - Select Group(s) that are BLANK"
 S DIR("?",1)="Select the type of filter to determine what Group(s) will be "
 S DIR("?",2)="displayed as follows:"
 S DIR("?",3)="  Begins with - Displays all group(s) that begin with the"
 S DIR("?",4)="                specified text (inclusive, case insensitive)"
 S DIR("?",5)="  Contains    - Displays all group(s) that contain the"
 S DIR("?",6)="                specified text (inclusive, case insensitive)"
 S DIR("?",7)="  Range       - Displays all group(s) within the "
 S DIR("?",8)="                specified range (inclusive, case insensitive)"
 S DIR("?")="  Blank       - Displays all group(s) that are Blank or null"
 S XX="1:Begins with;2:Contains;3:Range;4:Blank"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) Q -1           ; No valid search selected
 S FILTER=Y
 I FILTER=4 G SELFILTQ
 ;
 ; Next ask for 'Begin with', 'Contains' or 'Range Start' text
 W !
 K DIR
 S DIR(0)="F^1;30"
 S XX=$S(FILTER=1:"that begin with",FILTER=2:"that contain",1:"Start of Range")
 S DIR("A")="     Select Group(s) "_XX
 I FILTER=1 D
 . S DIR("?")="Enter the text that each Group(s) will begin with"
 I FILTER=2 D
 . S DIR("?")="Enter the text that each Group(s) will contain"
 I FILTER=3 D
 . S DIR("?")="Enter the starting range text"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) Q -1           ; No valid search selected
 S $P(FILTER,"^",2)=Y
 I $P(FILTER,"^",1)'=3 G SELFILTQ
 ;
 ; Finally, ask for 'Range End' text if using a range filter
 W !
 K DIR
 S DIR(0)="F^1;30"
 S DIR("A")="     Select Group(s) End of Range"
 S DIR("B")=$P(FILTER,"^",2)
 S DIR("?")="Enter the ending Range text"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) Q -1           ; No valid search selected
 S $P(FILTER,"^",3)=Y
SELFILTQ ;
 Q FILTER
 ;
BLDSELECT ; go through selected insurances and get their groups
 ;
 N GCT,GIEN,IBINSN,IBC,IBCO,IBINS,IBP,PLANDATA,PLANOK
 K ^TMP($J,"IBCNOR","FND")
 ; user selected insurance companies
 I 'IBCNOR("IBIG") D
 . S IBINSN="",(IBQUIT,IBSTOP,IBCO)=0
 . F  S IBINSN=$O(IBSORT(IBINSN)) Q:IBINSN=""  D  I IBQUIT!(IBSTOP) Q
 . . S IBINS=0 F  S IBINS=$O(IBSORT(IBINSN,IBINS)) Q:'IBINS  D  I IBQUIT!(IBSTOP) Q
 . . . S IBC=IBSORT(IBINSN,IBINS),IBCO=IBCO+1
 . . . ;clear the plans before build
 . . . K ^TMP("IBCNOR",$J,"INS",IBC,"GRP")
 . . . ;
 . . . S IBOK=0 W !!,"Insurance Company # "_IBCO_": "_IBINSN
 . . . D OK^IBCNSM3
 . . . I IBQUIT S IBSTOP=1 Q
 . . . ;I 'IBOK K ^TMP("IBCNOR",$J,"INS",IBC) Q
 . . . I 'IBOK Q
 . . . W "   ...building a list of plans..."
 . . . ; The Groups listed will be filtered the based on the users selections above
 . . . K ^TMP($J,"IBSEL")
 . . . D LKP^IBCNSU21(IBINS,1,1,IBCNOR("IBIGN"),IBCNOR("IBFIL"))
 . . . I IBQUIT S IBSTOP=1 Q
 . . . I $G(^TMP($J,"IBSEL",0))=0 D
 . . . . K ^TMP("IBCNOR",$J,"INS",IBC,"GRP")
 . . . ;
 . . . ; Add SELECTED Plans to ^TMP("IBCNOR")
 . . . I $G(^TMP($J,"IBSEL",0))>0 D
 . . . . S GCT=0
 . . . . S GIEN=0 F  S GIEN=$O(^TMP($J,"IBSEL",GIEN)) Q:'GIEN  D
 . . . . . S GCT=GCT+1
 . . . . . S ^TMP("IBCNOR",$J,"INS",IBC,"GRP",GCT)=GIEN
 . K ^TMP($J,"IBCNOR","FND") M ^TMP($J,"IBCNOR","FND")=^TMP("IBCNOR",$J,"INS")
 Q
 ;
BLDINSGR ; go through insurances and get their groups
 ;
 N IBC,IBCT,GCT,GIEN,IBC,IBINS,IBP,PLANDATA,PLANOK
 ; user selected ALL insurance companies
 S IBCT=0
 I IBCNOR("IBIG") D
 . S (IBC,GCT,IBINS,IBSTOP)=0
 . F  S IBC=$O(^TMP("IBCNOR",$J,"INS",IBC)) Q:'IBC  S IBINS=$G(^TMP("IBCNOR",$J,"INS",IBC)) I IBINS D  Q:IBSTOP
 . . S GCT=0,IBP=0
 . . F  S IBP=$O(^IBA(355.3,"B",+IBINS,IBP)) Q:'IBP  D
 . . . S IBCT=IBCT+1 I $G(IOST)["C-"&(IBCT#1000=0) W "."
 . . . K PLANDATA,PLANOK
 . . . D GETS^DIQ(355.3,+IBP_",",".11;2.01;2.02","EI","PLANDATA")
 . . . I $G(PLANDATA(355.3,IBP,.11,"I")) Q  ; only get active plans
 . . . ;
 . . . S GCT=GCT+1
 . . . S ^TMP("IBCNOR",$J,"INS",IBC,"GRP",GCT)=IBP
 Q
 ;
