TIUMOBJ1 ;XAN/AJB - MEDICATION OBJECT TESTER;Aug 02, 2024@13:51:48
 ;;1.0;TEXT INTEGRATION UTILITIES;**365**;Jun 20, 1997;Build 1
 ;
 ; Reference to ^DPT( in ICR #10035
 ; Reference to *^%ZIS in ICR #10086
 ; Reference to ^DIC in ICR #10006
 ; Reference to ^DIR in ICR #10026
 ; Reference to *^XGF in ICR #3173
 ; Reference to *^XLFDT in ICR #10103
 ; Reference to *^XLFSTR in ICR #10104
 ; Reference to *^XPAR in ICR #2263
 ;
 Q
EN N C,MENU,NUM,POP,XPARSYS,X,Y D HOME^%ZIS,PREP^XGF W $C(27)_"[?25h"
 F  D  Q:'C
 . D CLS F NUM=0:1 S Y=$P($T(MENU+NUM),";;",2) Q:Y=""  D
 . . I 'NUM D SAY^XGF(0,0,$$CJ^XLFSTR(Y,IOM),"U1") Q
 . . D SAY^XGF(NUM+1,26,NUM_"."),SAY^XGF(,30,$P(Y,U)) D:NUM=1 SAY^XGF(,59," [Status: "_$S($$GET^XPAR("SYS","TIUMOBJ STATUS"):"ON",1:"OFF")_"]")
 . S NUM=NUM-1 W ! S C=$$FMR("NOA^1:"_NUM,"31;Selection:  ",,"^D HELP^TIUMOBJ1(""1^""_NUM,$X,$Y)") Q:'C
 . D @($P($P($T(MENU+C),";;",2),U,2)),CLS
 D CLEAN^XGF
 Q
MENU ;;Medication Object Tester
 ;;Turn TIUMOBJ Parameter On/Off^PRM
 ;;Test One Patient [Select Parameters]^TEST(0)
 ;;Test One Patient [ALL Parameters]^TEST(1)
 ;;Medication Object Parameters^OBJ
 ;
 ;;Test All Patients^ALL
 Q
PRM ;
 N X,XPARSYS S X=$$GET^XPAR("SYS","TIUMOBJ STATUS") D EN^XPAR("SYS","TIUMOBJ STATUS",1,$S(X=0:1,X=1:0))
 Q
TEST(ACTION) ; test a patient
 D CLS
 N DFN,VER,X S VER=$$GET^XPAR("SYS","TIUMOBJ STATUS")
 S DFN=$$GPT Q:DFN'>0  D CLS
 ;S X(1)="Test a Patient",X(2)=$S(VER:"[NEW",1:"[OLD")_" Medication Object]"
 ;S X=0 F  S X=$O(X(X)) Q:'X  D SAY^XGF(X-1,0,$$CJ^XLFSTR(X(X),IOM),$S('$O(X(X)):"U1",1:"")) K X(X)
 I 'ACTION N P,PRM D GETPARM(.P) Q:'$D(P)  D  ; select parameters
 . N OUT I $$LIST^TIULMED(+DFN,"OUT",P("A"),P("D"),P("M"),P("O"),P("CS"),P("SU"))
 . S OUT=$O(OUT(""),-1) I OUT(OUT,0)=" " K OUT(OUT,0)
 . S OUT=0 F  S OUT=$O(OUT(OUT)) Q:'OUT  W !,OUT(OUT,0) W:'$O(OUT(OUT)) !
 I ACTION D  ; all parameters
 . N P F P("SU")=0:1:1 F P("CS")=0:1:2 F P("O")=0:1:1 F P("M")=0:1:6 F P("D")=0:1:1 F P("A")=0:1:2 D
 . . N OUT W !,"Parameters=("_+DFN_",""OUT"","_P("A")_","_P("D")_","_P("M")_","_P("O")_","_P("CS")_","_P("SU")_")",!
 . . I $$LIST^TIULMED(+DFN,"OUT",P("A"),P("D"),P("M"),P("O"),P("CS"),P("SU"))
 . . S OUT=$O(OUT(""),-1) I OUT(OUT,0)=" " K OUT(OUT,0)
 . . S OUT=0 F  S OUT=$O(OUT(OUT)) Q:'OUT  W !,OUT(OUT,0) W:'$O(OUT(OUT)) !
 F X=$Y:1:(IOSL-3) W !
 I $$FMR("EA","Press <Enter> to continue.")
 Q
GETPARM(P) ;
 N PRM,X S X=0 F PRM="A","D","M","O","CS","SU" D  Q:P(PRM)=U
 . N NUM,Y S X=X+1 F NUM=1:1 S Y=$P($T(@PRM+NUM),";;",2) Q:Y="EOM"  D
 . . D:NUM=1 SAY^XGF(NUM,30,"Parameter "_X_" (of 6):")
 . . D SAY^XGF(NUM+2,30,Y)
 . N RANGE S RANGE="0^"_$P($T(@PRM),";;",2)
 . S P(PRM)=$$FMR("NOA^0:"_+$P($T(@PRM),";;",2),"31;Parameter Value:  ",$S(PRM="SU":1,1:0),"^D HELP^TIUMOBJ1(RANGE,$X,$Y)") Q:P(PRM)=U
 . D CLS
 I P(PRM)=U K P
 Q
OBJ ; display/create an object
 N P,PRM,X D CLS,GETPARM(.P) Q:'$D(P)
 D SAY^XGF(0,0,$$CJ^XLFSTR("Medication Object Parameters",IOM),"U1"),IOXY^XGF(2,0)
 W "Parameter Values",!,"================"
 F X="A","D","M","O","CS","SU" D
 . I X="A" W !,$S('P(X):"Active & Recently Expired",P(X)=1:"Active",P(X)=2:"Recently Expired")_" Medications"
 . I X="D" W !,$S('P(X):"Standard",1:"Detailed")_" Output"
 . I X="M",P(X)<5 W !,$S('P(X):"Inpatient or Outpatient [Based on Patient Status]",P(X)=1:"Clinic, Inpatient, and Outpatient",P(X)=2:"Inpatient",P(X)=3:"Outpatient",P(X)=4:"Clinic",1:"")_$S(P(X)<5:" Medications",1:"")
 . I X="M",P(X)>4 W !,$S(P(X)=5:"Clinic and Inpatient",P(X)=6:"Clinic and Outpatient")_" Medications"
 . I X="O" W !,"Sort Medications by Type [Clinic, Inpatient, Outpatient]"_$S('P(X):", Status, and",1:"and")
 . I X="CS" W !,$S('P(X):"  Name [Alphabetically]",1:"  by Class [Alphabetically]"_$S(P(X)=2:" and Display Class Header",1:""))
 . I X="SU" W !,$S('P(X):"Exclude",1:"Include")_" Supplies"
 N OBJM S OBJM="S X=$$LIST^TIUMOBJ(DFN,""OUT"","_P("A")_","_P("D")_","_P("M")_","_P("O")_","_P("CS")_","_P("SU")_")"
 W !!,"Object Method:  "_OBJM W ! Q:'$$FMR("YAO","Create a new medication object with this method? ","YES")
 N ABRV,NAME S NAME=$$NAME Q:NAME=""!(NAME=U)  S ABRV=$$ABRV Q:ABRV=U
 D CLS W !,"Object Properties",!,"=================",!,"NAME:",?$S(ABRV'="":20,1:9),NAME W:ABRV'="" !,"ABBREVIATION:",?20,ABRV W !,"METHOD:",?$S(ABRV'="":20,1:9),OBJM
 W ! Q:'$$FMR("YAO","Create this object now? ","NO")
 S X=$$CROBJ^TIUCROBJ(NAME,ABRV,"",OBJM)
 I X W !!,"Object created successfully.",!
 E  W !!,"Error ",$P(X,U,2)
 F X=$Y:1:(IOSL-3) W !
 I $$FMR("EA","Press <Enter> to continue.")
 Q
NAME() ;
 N NAME D CLS F  D  Q:$D(NAME)
 . D SAY^XGF(1,0," ")
 . S NAME=$$UP^XLFSTR($$FMR("FAO^3:60","Enter the OBJECT NAME: ","","^D OBJH^TIUMOBJ1(""NAME"")")) Q:NAME=U!(NAME="")
 . D CLEAR^XGF(2,0,4,79),CLEAR^XGF(4,0,4,79) I NAME="@" K NAME D CLEAR^XGF(2,0,4,79),CLEAR^XGF(4,0,4,79),IOXY^XGF(1,0) Q
 . I '(NAME'?1P.E) D SAY^XGF(4,0,"Object NAME must not start with punctuation."),IOXY^XGF(1,0) K NAME Q
 . I $$CHKNAME^TIUCROBJ(NAME,"B;C;D") D SAY^XGF(4,0,NAME_" is already in use."),IOXY^XGF(1,0) K NAME
 Q NAME
ABRV() ;
 N ABRV D CLS F  D  Q:$D(ABRV)
 . D SAY^XGF(1,0," ")
 . S ABRV=$$UP^XLFSTR($$FMR("FAO^2:4","Enter the OBJECT ABBREVIATION: ","","^D OBJH^TIUMOBJ1(""ABV"")")) Q:ABRV=U!(ABRV="")
 . D CLEAR^XGF(2,0,2,79),CLEAR^XGF(4,0,4,79)
 . I ABRV'?2.4A D SAY^XGF(4,0,"ABBREVIATION must be 2 to 4 letters."),IOXY^XGF(1,0) K ABRV Q
 . I $$CHKNAME^TIUCROBJ(ABRV,"B;C;D") D SAY^XGF(4,0,ABRV_" is already in use."),IOXY^XGF(1,0) K ABRV
 Q ABRV
OBJH(HELP) ;
 I HELP="NAME" D CLEAR^XGF(4,0,4,79),SAY^XGF(4,0,"Object NAME must be 3-60 characters, not start with punctuation, and be unique.")
 I HELP="ABV" D CLEAR^XGF(4,0,4,79),SAY^XGF(4,0,"Object ABBREVIATION is optional and must be 2-4 letters and unique.")
 D CLEAR^XGF(0,0,3,79),SAY^XGF(0,0," ")
 Q
ALL ;
 W !!,"This may take an extended period of time.",! Q:'$$FMR("YAO","Do you want to continue? ","NO")
 N %,C,DFN,OUT,XPARSYS S C("DFNs")=0,C("Start")=$H,C("Ver")=$$GET^XPAR("SYS","TIUMOBJ STATUS")
 W !!,"Processing patients..."
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . S C("DFNs")=C("DFNs")+1
 . N PRM F PRM("M")=0:1:6 D
 . . I C("Ver") I $$LIST^TIUMOBJ(DFN,"OUT",0,0,PRM("M"),0,0,1)
 . . I 'C("Ver") I $$LIST^TIULMED(DFN,"OUT",0,0,PRM("M"),0,0,1)
 S C("End")=$H
 W !!,"# of Patients:    ",C("DFNs")
 W !,"Processing Time:  ",$$HDIFF^XLFDT(C("End"),C("Start"),3),!
 I $$FMR("EA","Press <Enter> to continue.")
 Q
CLS D CLEAR^XGF(0,0,(IOSL-1),(IOM-1)),IOXY^XGF(0,0)
 Q
FMR(DIR,PRM,DEF,HLP,SCR) ;
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 S X=+DIR("A"),Y=$P(DIR("A"),";",2) S:+X DIR("A")=$$SETSTR(Y,"",X,$L(Y))
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP)>1 M DIR=HLP
 D ^DIR
 Q $S(X="@":X,$D(DTOUT):U,$D(DUOUT):U,$D(DIROUT):U,$D(DIRUT):"",1:Y)
GPT() ; ask user for patient
 N %H,%I,DIC,DILOCKTM,DISYS,DTOUT,DUOUT,X,Y
 S DIC=2,DIC(0)="AEIMQ",DIC("A")=" Select PATIENT NAME: " W ! D ^DIC
 Q Y
HELP(NUM,X,Y) ;
 S NUM(1)=$P(NUM,U),NUM(2)=$P(NUM,U,2)
 D SAY^XGF(Y+1,30,"Enter a number from "_NUM(1)_"-"_NUM(2)_". '^' or <Enter> to exit.")
 D CLEAR^XGF(Y-1,30,Y-1,79),IOXY^XGF(Y-3,0)
 Q
SETSTR(S,V,X,L) ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
A ;;2
 ;;Filter by Medication Status
 ;;
 ;;Value  Display
 ;;=====  ========
 ;;  0    Active & Recently Expired [default]
 ;;  1    Active Only
 ;;  2    Recently Expired Only
 ;;
 ;;EOM
D ;;1
 ;;Standard or Detailed Display
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Standard [default]
 ;;  1    Detailed
 ;;
 ;;EOM
M ;;6
 ;;Filter by Medication Type
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Inpatient or Outpatient based on Patient
 ;;         Status [default]
 ;;  1    Clinic, Inpatient, and Outpatient
 ;;  2    Inpatient Only
 ;;  3    Outpatient Only
 ;;  4    Clinic Only
 ;;  5    Clinic and Inpatient
 ;;  6    Clinic and Outpatient
 ;;
 ;;EOM
O ;;1
 ;;Sort Medications By Type and/or Status
 ;;
 ;;Type   [Inpatient/Outpatient/Clinic]
 ;;Status [Active/Pending/Inactive]
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Sort Meds by Type and Status [default]
 ;;  1    Sort Meds by Type Only
 ;;
 ;;EOM
CS ;;2
 ;;Sort Medications By Class
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Alphabetical by Name [default]
 ;;  1    By Class (Alphabetically)
 ;;  2    By Class (Alphabetically) and
 ;;         Display Class Header
 ;;
 ;;EOM
SU ;;1
 ;;Filter Supplies
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Exclude Supplies
 ;;  1    Include Supplies [default]
 ;;
 ;;EOM
