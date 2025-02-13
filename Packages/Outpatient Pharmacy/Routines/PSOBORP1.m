PSOBORP1 ;ALBANY/BLD - TRICARE-CHAMPVA BYPASS/OVERRIDE AUDIT REPORT (CONT) ;10/17/12 3:38pm
 ;;7.0;OUTPATIENT PHARMACY;**358,385,415,427,528**;DEC 1997;Build 10
 ;
 ;***********copied from routine BPSRPT3 AND BPSRPT4************
 ;
 Q
 ;
 ;
 ;                    
SELPHARM(PSOSEL) N DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ; Select the ECME Pharmacy or Pharmacies
 ; 
 ; Input Variable -> none
 ; Return Value ->   "" = Valid Entry or Entries Selected
 ;                                        ^ = Exit
 ;                                       
 ; Output Variable -> PSOPHARM = "D" One or More Pharmacies Selected
 ;                             = "A" User Entered 'ALL'
 ;                            
 ; If PSOPHARM = 1 then the PSOPHARM array will be defined where:
 ;    PSOPHARM(ptr) = ptr ^ BPS PHARMACY NAME and
 ;    ptr = Internal Pointer to OUTPATIENT SITE file (#59)
 ;
 ;Reset PSOPHARM array
 K PSOPHARM
 ;
 ;First see if they want to enter individual divisions or ALL
 S DIR(0)="S^D:DIVISION;A:ALL"
 S DIR("A")="Select Certain Pharmacy (D)ivisions or (A)LL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     D         DIVISION"
 S DIR("L",4)="     A         ALL"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, otherwise define PSOPHARM
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 E  S (PSOSEL("DIVISION"),PSOPHARM)=Y
 ;If division selected, ask prompt
 I $G(PSOPHARM)="D" F  D  Q:Y="^"!(Y="") 
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=59,DIC("A")="Select ECME Pharmacy Division(s): "
 .W ! D ^DIC
 .;
 .;Check for "^" or timeout 
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) K PSOPHARM S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(X)="" S Y=$S($D(PSOPHARM)>9:"",1:"^") K:Y="^" PSOPHARM Q
 .;
 .;Handle Deletes
 .I $D(PSOPHARM(+Y)) D  Q:Y="^"  I 1
 ..N P
 ..S P=Y  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO" D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) K PSOPHARM S Y="^" Q
 ..I Y="Y" K PSOPHARM(+P),PSOPHARM("B",$P(P,U,2),+P)
 ..S Y=P  ;Restore Original Value
 ..K P
 .E  D
 ..;Define new entries in PSOPHARM array
 ..S PSOPHARM(+Y)=Y
 ..S PSOPHARM("B",$P(Y,U,2),+Y)=""
 .;
 .;Display a list of selected divisions
 .I $D(PSOPHARM)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(PSOPHARM("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 K PSOPHARM("B")
 M PSOSEL("DIVISION")=PSOPHARM
 Q Y
 ;
 ;
SELSMDET(DFLT) ;
 ;
 ; Display (S)ummary or (D)etail Format
 ; 
 ; Input Variable -> DFLT = 1 Summary
 ;                          2 Detail
 ;                          
 ; Return Value ->   "S" = Summary
 ;                   "D" = Detail
 ;                    ^  = Exit
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DFLT=$S($G(DFLT)=1:"Summary",$G(DFLT)=2:"Detail",1:"Detail")
 S DIR(0)="S^S:Summary;D:Detail",DIR("A")="Display (S)ummary or (D)etail Format",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 Q Y
 ;
 ;                 
SELDATE(TYPE) ;select begin date
 ; Enter Date Range
 ;
 ; Input Variable -> TYPE = TRANSACTION
 ;                          
 ;
 ; Return Value -> P1^P2
 ; 
 ;           where P1 = From Date
 ;                    = ^ Exit
 ;                 P2 = To Date
 ;                    = blank for Exit
 N PSOSIBDT,DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 ;
SELDATE1 ;
 N VAL
 S VAL="",DIR(0)="DA^:DT:EX",DIR("A")="START WITH "_TYPE_" DATE: ",DIR("B")="T-1"
 W ! D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^"
 ;
 I VAL="" D
 .S $P(VAL,U)=Y
 .S DIR(0)="DA^"_VAL_":DT:EX",DIR("A")="  GO TO "_TYPE_" DATE: ",DIR("B")="T"
 .D ^DIR
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^" Q
 .;
 .;Define Entry
 .S $P(VAL,U,2)=Y
 ;
 Q VAL
 ;
SELATYP(DFLT) ;
 ;
 ; Display (T)RICARE or (C)HAMPVA OR (A)LL Format
 ; 
 ; Input Variable -> DFLT = A ALL
 ; T TRICARE
 ; C CHAMPVA
 ; 
 ; Return Value -> A = ALL
 ; T = TRICARE
 ; C = CHAMPVA
 ; ^ = Exit
 ;
 N DIR,DIRUT,DTOUT,DUOUT,EXIT,X,Y
 S EXIT=0
 S DFLT=$S($G(DFLT)="T":"TRICARE",$G(DFLT)="C":"CHAMPVA",1:"ALL")
 S DIR(0)="SO^T:TRICARE;C:CHAMPVA;A:ALL",DIR("A")="Display (T)RICARE or (C)HAMPVA or (A)LL Entries",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 I Y="A" K PSOSEL("ELIG_TYPE") D
 .S PSOSEL("ELIG_TYPE")="A"
 .S PSOSEL("ELIG_TYPE","T")="TRICARE"
 .S PSOSEL("ELIG_TYPE","C")="CHAMPVA"
 .S EXIT=1
 I EXIT Q Y
 I Y'="" S PSOSEL("ELIG_TYPE")=Y,PSOSEL("ELIG_TYPE",Y)=$S(Y="T":"TRICARE",Y="C":"CHAMPVA",1:"ALL")
 Q Y
 ;
SELTCCD(PSOSEL) ;
 ;
 ;Prompt to Include (I)npatient,(N)on-Billable, (R)eject, (P)artial, or A)ll: (no default)
 ;
 N DIC,DIR,DIRUT,DUOUT,EXIT,REJ,X,Y,I
 S EXIT=0
 F I=1:1:2 D  Q:Y="A"!(EXIT)
 .S DIR(0)="SO^I:INPATIENT;N:NON-BILLABLE;R:REJECT OVERRIDE;P:PARTIAL FILL;A:ALL"
 .S DIR("A")="Select one of the following: **Can select multiples - limit of 2**  "
 .D ^DIR
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) S EXIT=1,Y="^" Q
 .I Y="A" K PSOSEL("REJECT CODES") D  Q
 ..S PSOSEL("REJECT CODES")="A"
 ..S PSOSEL("REJECT CODES","I")="INPATIENT"
 ..S PSOSEL("REJECT CODES","N")="NON-BILLABLE"
 ..S PSOSEL("REJECT CODES","R")="REJECT OVERRIDE"
 ..S PSOSEL("REJECT CODES","P")="PARTIAL FILL"
 ..S EXIT=1
 .I Y="",$D(PSOSEL("REJECT CODES")) S EXIT=1 Q
 .I Y="",'$D(PSOSEL("REJECT CODES")) S EXIT=0,I=0 Q
 .I Y'="" S PSOSEL("REJECT CODES",Y)=$S(Y="I":"INPATIENT",Y="N":"NON-BILLABLE",Y="R":"REJECT OVERRIDE",Y="P":"PARTIAL FILL",1:"ALL")
 ;
 Q Y
 ;
SELPHMST(PSOSEL) ;
 ;
 ; Select to include (S)pecific Pharmacist or (A)ll pharmacists
 ;
 N DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 K PSOPHARM,DIR
 ;
 ;First see if they want to enter individual divisions or ALL
 S DIR(0)="S^S:SPECIFIC PHARMACIST(S);A:ALL PHARMACISTS"
 S DIR("A")="Select Specific Pharmacist(s) or All Pharmacists"
 S DIR("B")="ALL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     S         Specific Pharmacist(s)"
 S DIR("L",4)="     A         All Pharmacists"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, otherwise define PSOPHARM 
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 E  S (PSOSEL("PHARMACIST"),PSOPHARM)=Y
 ;
 ;If pharmacist selected, ask prompt
 I $G(PSOPHARM)="S" F  D  Q:Y="^"!(Y="") 
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=200,DIC("A")="Select Pharmacist: "
 .S DIC("S")="I $D(^XUSEC(""PSORPH"",Y))"
 .W ! D ^DIC
 .;
 .;Check for "^" or timeout 
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) K PSOPHARM S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(X)="" S Y=$S($D(PSOPHARM)>9:"",1:"^") K:Y="^" PSOPHARM Q
 .;
 .;Handle Deletes
 .I $D(PSOPHARM(+Y)) D  Q:Y="^"  I 1
 ..N P
 ..S P=Y  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO" D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) K PSOPHARM S Y="^" Q
 ..I Y="Y" K PSOPHARM(+P),PSOPHARM("B",$P(P,U,2),+P)
 ..S Y=P  ;Restore Original Value
 ..K P
 .E  D
 ..;Define new entries in PSOPHARM array
 ..S PSOPHARM(+Y)=Y
 ..S PSOPHARM("B",$P(Y,U,2),+Y)=""
 .;
 .;Display a list of selected providers
 .I $D(PSOPHARM)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(PSOPHARM("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 K PSOPHARM("B")
 M PSOSEL("PHARMACIST")=PSOPHARM
 Q Y
 ;
SELPROV(PSOSEL) ;
 ;
 ;select to include (S)pecific Provider or (A)ll Providers
 ;
 N DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 K PSOPROV
 ;
 ;First see if they want to enter individual divisions or ALL
 S DIR(0)="S^S:SPECIFIC PROVIDER(S);A:ALL PROVIDERS"
 S DIR("A")="Select Specific Provider(s) or include ALL Providers"
 S DIR("B")="ALL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     S         Specific Provider(s)"
 S DIR("L",4)="     A         ALL Providers"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, otherwise define PSOPROV 
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 E  S (PSOSEL("PROVIDER"),PSOPROV)=Y
 ;
 ;If provider selected, ask prompt
 I $G(PSOPROV)="S" F  D  Q:Y="^"!(Y="") 
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=200,DIC("A")="Select Provider: "
 .S DIC("S")="I +$G(^VA(200,Y,""PS""))"
 .W ! D ^DIC
 .;
 .;Check for "^" or timeout 
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) K PSOPROV S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(X)="" S Y=$S($D(PSOPROV)>9:"",1:"^") K:Y="^" PSOPROV Q
 .;
 .;Handle Deletes
 .I $D(PSOPROV(+Y)) D  Q:Y="^"  I 1
 ..N P
 ..S P=Y  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO" D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) K PSOPROV S Y="^" Q
 ..I Y="Y" K PSOPROV(+P),PSOPROV("B",$P(P,U,2),+P)
 ..S Y=P  ;Restore Original Value
 ..K P
 .E  D
 ..;Define new entries in PSOPROV array
 ..S PSOPROV(+Y)=Y
 ..S PSOPROV("B",$P(Y,U,2),+Y)=""
 .;
 .;Display a list of selected providers
 .I $D(PSOPROV)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(PSOPROV("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 K PSOPROV("B")
 M PSOSEL("PROVIDER")=PSOPROV
 Q Y
 ;
PSOTOTAL(PSOSEL) ;
 ;
 ;Prompt to Include Group/Subtotal Report by (R) Pharmacy or (P)rovider/Provider
 ;ADDED BY BLD
 ;Returns ()
 ;
 N Y,DUOUT,DTOUT,IBQUIT,DIROUT,DIR
 N PSONPI
 S DIR(0)="S^R:Pharmacist;P:Provider/Prescriber Name"
 S DIR("A")="Group/Subtotal Report by (R)Pharmacist or (P)Provider"
 ;S DIR("B")="PHARMACIST"
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^" Q Y
 S PSONPI=Y
 ;
 Q Y
 ;
 ;
 ;Print Header 2 Line 1
 ;
 ; Input variable: PSORTYPE -> Report Type (1-7)
 ;
 ;
SELEXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 Q:PSOSEL("SUM_DETAIL")="S"
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 ;Display Excel display message
 I EXCEL=1 D EXMSG
 ;
 Q EXCEL
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
 ;Display the message about capturing to an Excel file format
 ; 
EXMSG ;
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 Q
 ;
 ;
 ;Screen Pause
 ;
PAUSE ;
 Q:$G(PSOSCR)'=1  S PSOUT=""
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSOUT=1
 Q
