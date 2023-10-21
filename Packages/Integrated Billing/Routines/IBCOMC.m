IBCOMC ;ALB/CMS - IDENTIFY PT BY AGE WITH OR WITHOUT INSURANCE;10-09-98
 ;;2.0;INTEGRATED BILLING;**103,528,743,752**;21-MAR-94;Build 20
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
EN ;Entry point from option
 N DA,DIC,DIE,DIR,DIROUT,DIRUT,DTOUT,DR,DUOUT,X,Y
 N IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBSIN,IBSINF,IBSINL,IBAGEF,IBAGEL,IBOUT,IBQUIT
 S (IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBSIN,IBSINF,IBSINL,IBAGEF,IBAGEL,IBQUIT)=""
 N IBRFU,IBRLU,IBRET,IBSCREEN,IBSINFU,IBSINLU  ;IB*752/DTG added for case insensitive
 S (IBRFU,IBRLU,IBSINFU,IBSINLU)=""
 ;
 W !!,"This report will identify patients who were treated within a specified"
 W !,"date range who do or do not have insurance coverage."
 ;
INS ; -- sort by Insurance Company or no Insurance
 W !!,"Filter by Insurance Company or No Insurance"  ;IB*752/DTG change sort to filter
 S DIR("A",1)="1  - Insurance Company Range"
 S DIR("A",2)="2  - Selected Insurance Companies"
 S DIR("A",3)="3  - Patients with No Insurance"
 S DIR("A",4)="  "
 S DIR(0)="SAB^1:Insurance Range;2:Specific Companies;3:No Insurance"  ;IB*752/DTG change SAXB to SAB to allow lower case
 S DIR("A")=" Select Number: ",DIR("B")="1",DIR("??")="^D INSH^IBCOMC2" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBSIN=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 I IBSIN=1 D INSR
 I IBSIN=2 D INSS
 I $G(IBQUIT)=1 G EXIT
 ;
VISIT ; -- sort by Treated Date Range
 W !!,"Sort by Date Last Treated Range."
 S X=""  ;IB*752/DTG - setup for up-caret check
 D DATE^IBOUTL
 I IBBDT="" W *7,"    <Date Last Treated Range not entered>" G EXIT
 I IBEDT=""!($E($G(X),1)=U) G EXIT  ;IB*752/DTG exit if '^' up-caret. change & to ! to exit if no goto date
 I IBBDT,IBEDT="" S IBEDT=DT_".2400"
 ;
 W !! S DIR("A",1)="Filter report by"  ;IB*752/DTG - change Sort to Filter
 S DIR("A",2)="1  - Patient Name Range"
 S DIR("A",3)="2  - Terminal Digit Range"
 S DIR("A",4)="  "
 S DIR(0)="SAB^1:Patient Name;2:Terminal Digit"  ;IB*752/DTG change SAXB to SAB to allow lower case
 S DIR("A")=" Select Number: ",DIR("B")="1",DIR("??")="^D ENH^IBCOMC2" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBAIB=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 W !! D @$S(IBAIB=1:"NR",1:"TR")
 I $G(IBQUIT)=1 G EXIT
 ;
AGE ; -- sort by AGE optional
 W !!,"Sort by Patient Age Range.  (Optional)"
 S DIR("A")="Start AGE: ",DIR(0)="NAO^1:250",DIR("??")="^D AGEH^IBCOMC2" D ^DIR
 I X["^" S IBQUIT=1 G EXIT
 I +Y'>0 G AGEQ
 S IBAGEF=+Y,DIR(0)="NO^"_+IBAGEF_":250",DIR("B")="250",DIR("A")="To AGE" D ^DIR
 I X["^" S IBQUIT=1 G EXIT
 S IBAGEL=+Y
AGEQ K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 S IBOUT=$$OUT G:IBOUT="" EXIT
 ;
 W !! D QUE
 ;
EXIT Q
 ;
NR ; Ask Name Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
NRR ;
 ;IB*743/TAZ - Updated code to accept NULL to mean beginning of list.
 W !!,"Enter Start With value or Press <ENTER> to start at the beginning of the list.",!
 S DIR(0)="FO",DIR("A")="START WITH PATIENT NAME"
 S DIR("?")="^D NRRHLP^IBCOMC(""BEGIN"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRF=Y
 S IBRFU=$$UP^XLFSTR(IBRF)  ;IB*752/DTG - upper case for start name
 ;
 ;IB*743/TAZ - Updated code to accept NULL to mean end of list.
 W !!,"Enter Go To value or Press <ENTER> to finish at the end of the list.",!
 S DIR(0)="FO",DIR("A")="GO TO PATIENT NAME"
 S DIR("?")="^D NRRHLP^IBCOMC(""END"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="" Y="zzzzzz" S IBRL=Y
 ;IB*752/DTG - change user's response to upper case
 S IBRLU=IBRL I IBRL'="zzzzzz" S IBRLU=$$UP^XLFSTR(IBRL)
 ;I $G(IBRL)']$G(IBRF) W !!,?5,"The Go to Patient Name must follow the Start with Name.",! G NRR
 I $G(IBRLU)']$G(IBRFU) W !!,?5,"The Go to Patient Name must follow the Start with Name.",! G NRR
 Q
 ;
NRRHLP(LEVEL) ; ?? Help for the Range Prompt
 W !!,?5,"Enter a value the Patient Name should ",LEVEL," with."
 I LEVEL="BEGIN" W !,?5,"Press <ENTER> to start at the beginning of the list."
 I LEVEL="END" W !,?5,"Press <ENTER> to finish at the end of the list."
 Q
 ;
TR ; Ask Terminal Digit Range
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="FO^1:9^K:X'?1.9N X"
 S DIR("?")="Enter up to 9 digits of the Terminal Digit to include in Report"
 S DIR("B")="0000",DIR("A")="Start with Terminal Digit"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRF=$E((Y_"000000000"),1,9)
 S DIR("B")="9999",DIR("A")="GO to Terminal Digit"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRL=$E((Y_"999999999"),1,9)
 I IBRF>IBRL W !!,?5,"The Go to Terminal Digit must follow the Start with Digit.",! G TR
 Q
 ;
INSR ; -- sort by Insurance Company Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
INSR1 ;
 ;IB*743/TAZ - Updated code to accept NULL to mean beginning of list.
 W !!,"Enter Start With value or Press <ENTER> to start at the beginning of the list.",!
 S DIR(0)="FO",DIR("A")="START WITH INSURANCE COMPANY"
 S DIR("?")="^D INSRHLP^IBCOMC(""BEGIN"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBSINF=Y
 S IBSINFU=$$UP^XLFSTR(IBSINF)  ;IB*752/DTG - upper case for start insurance
 ;
 ;IB*743/TAZ - Updated code to accept NULL to mean end of list.
 W !!,"Enter Go To value or Press <ENTER> to finish at the end of the list.",!
 S DIR(0)="FO",DIR("A")="GO TO INSURANCE COMPANY"
 S DIR("?")="^D INSRHLP^IBCOMC(""END"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="" Y="zzzzzz" S IBSINL=Y
 ;IB*752/DTG - upper case for goto insurance
 S IBSINLU=IBSINL I IBSINL'="zzzzzz" S IBSINLU=$$UP^XLFSTR(IBSINL)
 ;I $G(IBSINL)']$G(IBSINF) W !!,?5,"The Go to Insurance Company must follow the Start with Insurance Company.",! G INSR1
 I $G(IBSINLU)']$G(IBSINFU) W !!,?5,"The Go to Insurance Company must follow the Start with Insurance Company.",! G INSR1  ;IB*752/DTG - change Company Name to Insurance Company
 Q
 ;
INSRHLP(LEVEL) ; ?? Help for the Range Prompt
 W !!,?5,"Enter a value the Insurance Company Name should ",LEVEL," with."
 I LEVEL="BEGIN" W !,?5,"Press <ENTER> to start at the beginning of the list."
 I LEVEL="END" W !,?5,"Press <ENTER> to finish at the end of the list."
 Q
 ;
INSS ; -- select Insurance Companies
 ;IB*752/DTG - change user's response to upper case & remove limit of 6 companies max
 ;N DIC,DA,IBX,X,Y S IBX=1
 ;S DIC(0)="AEQMZ",DIC="^DIC(36,",DIC("S")="I $$ANYGP^IBCNSJ(+Y,0,1),'$P($G(^DIC(36,+Y,0)),U,5)"
 ;S DIC("A")="Select INSURANCE COMPANY: " D ^DIC
 ;I Y<0 W "  <No Insurance Companies selected>" S IBQUIT=1 G INSSQ
 ;S IBSIN(IBX)=+Y_U_Y(0),DIC("A")="Select Another INSURANCE COMPANY: "
 ;F IBX=IBX+1:1:6 D  Q:(Y<0)
 ;.D ^DIC Q:Y<0
 ;.S IBSIN(IBX)=+Y_U_Y(0)
 ;
 N IBSINSAV
 S IBSCREEN="I $$ANYGP^IBCNSJ(+Y,0,1),'$P($G(^DIC(36,+Y,0)),U,5)"
 S IBSINSAV=$G(IBSIN) K IBSIN
 D INSOCAS^IBCNINSC(.IBRET,0,,.IBSCREEN)  ;IB*752 - use new lookup
 I '$G(IBRET) W "  <No Insurance Companies selected>" S IBQUIT=1,IBSIN=IBSINSAV K IBRET G INSSQ
 S IBI=0 F  S IBI=$O(IBRET(IBI)) Q:'IBI  S IBSIN(IBI)=IBRET(IBI)
 S IBSIN=IBSINSAV
 K IBRET
 Q
 ;
 ; IB*752/DTG end - change from standard DIC call for upper/lower
 ;
INSSQ Q
 ;
QUE ; Ask Device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 I $G(IBOUT)="E" W !,"To avoid undesired wrapping, please enter ""0;256;999"" at the 'DEVICE:' prompt."
 I $G(IBOUT)="R" W !,?10,"You may want to queue this report!",!
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="BEG^IBCOMC1"
 .F IBX="IBAIB","IBBDT","IBEDT","IBRF","IBRL","IBSIN","IBSIN(","IBSINF","IBSINL","IBAGEF","IBAGEL","IBOUT","IBQUIT" S ZTSAVE(IBX)=""
 .F IBX="IBRFU","IBRLU","IBSINFU","IBSINLU" S ZTSAVE(IBX)=""  ;IB*752/DTG - add items to ZTSAVE
 .S ZTDESC="IB - Identify Patients with/without Insurance"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"... One Moment Please ..."
 D BEG^IBCOMC1
 ;
QUEQ ; Exit clean-UP
 W ! D ^%ZISC K IBTMP,IBAIB,IBOUT,IBRF,IBRL,IBSIN,IBSTR,VA,VAERR,VADM,VAPA,^TMP("IBCOMC",$J)
 K IBRFU,IBRLU,IBSINFU,IBSINLU  ;IB*752/DTG clear new var's
 Q
 ;
OUT() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) Q ""
 Q $$UP^XLFSTR($E(Y,1))
