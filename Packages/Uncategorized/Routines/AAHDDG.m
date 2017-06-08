%AAHDDG ;402,DJB,11/2/91,EDD**Globals In ASCII Order
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
GL ;List Globals in ASCII order
 NEW AA,BB,HD,TEMP,VAR
 D:'$D(^UTILITY("EDD/GL")) HELP
GLTOP D @$S($D(^UTILITY("EDD/GL")):"GLRANGE",1:"GLRANGE1") G:FLAGQ GLEX D INIT S HD="HD" D @HD
 D GLLIST G:FLAGQ GLEX
GLEX ;Global Exit
 Q
GLRANGE ;Starting and Ending Global
 I FLAGP W !?2,"Enter Global range...Include Starting & Ending Global:"
GLRANGE1 R !?2,"Starting Global: ^",AA:GEMTIME S:'$T!(AA="") AA="^" S:AA["^" FLAGQ=1 S:AA="^^" FLAGE=1 Q:FLAGQ
 I AA="?"!(AA="*R") D:AA="?" HELP1 D:AA="*R" GLLOAD G GLRANGE
 I '$D(^UTILITY("EDD/GL")) W *7,"   Enter '*R' to build your Global listing." G GLRANGE1
 S AA=$S(AA="*":0,1:"^"_AA)
 S BB="^ZZZZZZZZZ" I FLAGP R !?2,"Ending Global: ^",BB:GEMTIME S:'$T!(BB="") BB="^" G:BB="^" GLRANGE S BB="^"_BB I BB']AA W *7,"   Ending Global must 'follow' Starting Global" G GLRANGE1
 I FLAGP S TEMP=$O(^UTILITY("EDD/GL",AA)) I TEMP=""!(TEMP]BB) W *7,"   No globals in this range" G GLRANGE1
 Q
GLLIST ;Start listing Globals
 F  S AA=$O(^UTILITY("EDD/GL",AA)) Q:AA=""!(AA]BB)  W !?2,AA,?23,$J($P(^(AA),U),14),?40,$E($P(^(AA),U,2),1,35) I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
GLLOAD ;
 S AA=0 K ^UTILITY("EDD/GL")
 F  S AA=$O(^DIC(AA)) Q:AA'>0  I $D(^DIC(AA,0,"GL"))#2,$D(^DIC(AA,0))#2 S ^UTILITY("EDD/GL",^DIC(AA,0,"GL"))=AA_"^"_$P(^DIC(AA,0),"^") W "."
 Q
HELP ;No data in ^UTILITY("EDD/GL")
 W *7,?35,"You have no data in ^UTILITY(""EDD/GL"")."
 W !?35,"You must first build your Global listing."
 W !?35,"Enter '?' at the 'Starting Global:' prompt."
 Q
HELP1 ;"Starting Global" prompt
 W !!?8,"1. Enter Global you want listing to start with.",!?11,"Examples: ^DPT , ^L , or ^%ZIS."
 W !?8,"2. Enter '*' to list all globals."
 W !?8,"3. Enter '*R' to Build/Update your Global listing."
 W !?14,"Your Global listing is kept in ^UTILITY(""EDD/GL""). If this is the"
 W !?14,"first time you've used this utility, or if you have added or"
 W !?14,"deleted any files on your system, enter '*R' here to build/update"
 W !?14,"your listing. It will take approximately 30 seconds to run."
 Q
PAGE ;
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! D @HD Q
 R !!?2,"<RETURN> to continue, '^' to quit, '^^' to exit: ",Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 W @GEMIOF D @HD
 Q
HD ;
 W !?2,"Globals in ASCII order.."
 W !?10,"GLOBAL",?28,"FILE NUM",?46,"FILE (Truncated to 35)"
 W !,?2,"----------------------",?27,"----------",?40,"-----------------------------------"
 Q
INIT ;
 I FLAGP W:$E(GEMIOST,1,2)="P-" "  Printing.." U IO
 W @GEMIOF Q
