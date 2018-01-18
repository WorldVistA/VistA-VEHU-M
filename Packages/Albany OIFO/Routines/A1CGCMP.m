A1CGCMP ;JSH/TROY ; 22 OCT 87 10:29 AM
 ;;GLOBAL COMPARE OF PACKAGES
EN S SUB=$H I '$D(DUZ(0)) W "  PROGRAMMER ACCESS UNDEFINED" Q
 I DUZ(0)'="@" W "  FOR PROGRAMMERS ONLY" Q
 W !?30,"File Compare Program",!?30,"--------------------",!! F I=1:1:7 W !,$P($T(INTRO+I),";;",2,999)
R1 W !!,"This run has been assigned #: ",SUB,!! S %IS="Q",%IS("A")="Select Output Device (you may queue it): " D ^%ZIS Q:POP  I $D(IO("Q")) S %DT="FTXA",%DT("A")="For what date/time: " D ^%DT Q:Y'>0  S ZTDTH=Y
 ;
R K F,DATA,GLO,UCIVOL,^UTILITY("A1CGCMP",SUB),E R !!,"Enter the Name of the Package (2-4 characters): ",X:60 W:'$T "   Timed Out" Q:"^"=X  G:X?1"?".E QUES I X]"" S DIC(0)="EQMZ",DIC=9.4 D ^DIC I Y'>0 Q
 S (DPK,Q)=0 K ^UTILITY("A1CGCMP",SUB),F,DTL,E S U="^",%=0,%B="",DL=0,DIH="",DTL=X
 ;
R3 S:X]"" (DPK,Q)=+Y
STAR ;
 F DH=0:0 S DH=$N(^DIC(9.4,Q,4,DH)) G:DH'>0 L S Y=+^(DH,0) I $D(^DIC(Y,0))#2 S ^UTILITY("A1CGCMP",SUB,Y)=$P(^(0),U,1) W !,^UTILITY("A1CGCMP",SUB,Y) D SF
L W !!," PLEASE LIST ADDITIONAL FILES THAT YOU WISH TO EXAMINE---"
 F F=1:1 K DIC S DIC("W")="W ?50,^(0,""GL"")",DIC("S")="I Y'=1&'$D(^UTILITY(""A1CGCMP"",SUB,+Y))",DIC(0)="AQEZ",DIC="^DIC(" D ^DIC G:Y<0 Q:X[U,GL S ^UTILITY("A1CGCMP",SUB,+Y)=$P(Y,U,2) D F
GL ;
 ;
ASK S (%,DDLOOK)=1 W !!,"Would you like to Examine the Data Dictionaries " D YN^DICN Q:%=-1  S:%=2 DDLOOK=0 S (%,FILOOK)=1 W !!,"Would you like to Examine the File Entries " D YN^DICN Q:%=-1  S:%=2 FILOOK=0
 K UCIVOL D UCI^A1CGCMP1 Q:'$D(UCIVOL)
 I $D(IO("Q")) S ZTRTN="START^A1CGCMP",ZTIO=ION_";"_IOM_";"_IOSL,ZTDESC="File Compare Program" F G="SUB","DDLOOK","FILOOK","U","DT","UCIVOL(" S ZTSAVE(G)=""
 I $D(IO("Q")) D ^%ZTLOAD X ^%ZIS("C") K IO W !!,"TASK QUEUED!!" Q
 ;ENTER HERE FROM TASKMAN
START Q:'$D(^UTILITY("A1CGCMP",SUB))  D:DDLOOK ^A1CGCMP2 D:FILOOK ^A1CGCMP1
 D:$D(^UTILITY("A1CGCMP",SUB,"ERRD")) PRINT^A1CGCMP2 D:$D(^UTILITY("A1CGCMP",SUB,"ERRF")) ^A1CGCMP3
D1 X ^%ZIS("C") K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK K I,I0,F,D,Q,DATA,UCIVOL,GLO,ZTDTH,^UTILITY("A1CGCMP",SUB),SUB Q
 ;
T W !,DIC,?24,DH F F=0:0 S @("F=$N(^"_D_"(""B"",DH,F))"),DIC="" Q:F'>0  I @("$D(^"_D_"(F,0))"),$P(^(0),U,4)=X!'X S Q(D,F)="" G Q
 W *7," **NOT FOUND** " Q
 ;
SF G F:$N(^DIC(9.4,Q,4,DH,1,0))'>0
 S ^UTILITY("A1CGCMP",SUB,+Y,+Y,.01)=0 G E
F S ^UTILITY("A1CGCMP",SUB,+Y,+Y)=0,%=1 K %A
 F E=0:0 S E=$N(^UTILITY("A1CGCMP",SUB,+Y,E)) Q:E<0  F D=0:0 S D=$N(^DD(E,"SB",D)) Q:D<0  I Y-E!'$D(%A)!$D(%A(D)) S ^UTILITY("A1CGCMP",SUB,+Y,D)="" S:$D(%A) %A(D)=0
E S ^UTILITY("A1CGCMP",SUB,+Y,0)=^DIC(+Y,0,"GL")
Q K %A,%C,%Z,%V Q
ALL S DIC(0)="NE",DIC="^DIC(" F X=0:0 S X=$N(^DIC(X)) Q:X'>0  W !! D ^DIC S ^UTILITY("A1CGCMP",SUB,+Y)=$P(Y,U,2) D F
 Q
QUES S DIC="^DIC(9.4,",DIC(0)="EQMZ",D="B",DZ="?" D DQ^DICQ G R
INTRO ;;to be printed at beginning of routine
 ;;This program is intended to be used to verify that replicated
 ;;globals appear identical.  It may also be used during package
 ;;verification to identify old and new copies of files.
 ;;
 ;;This routine has one main drawback...it requires that each global
 ;;being examined has read access enabled for WORLD access.  If not,
 ;;you will see the program abort with <PROT> errors.
