%AAHDDC ;402,DJB,11/2/91,EDD**File Characteristics
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
CHAR ;Identifiers, Post Selection Actions, Special Look-up Program
 I '$D(^DD(ZNUM,0,"ID")),'$D(^DD(ZNUM,0,"ACT")),'$D(^DD(ZNUM,0,"DIC")) W !?10,"No Identifiers, Post Selection Actions, or Special Look-up Program." S FLAGG=1 Q
 NEW LINE,STRING
 D INIT^%AAHDDPR G:FLAGQ EX
 W !?21,"F I L E   C H A R A C T E R I S T I C S",!?20,"-----------------------------------------"
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 W !!?1,"1. POST SELECTION ACTION:" I $D(^DD(ZNUM,0,"ACT")) D
 .W "  The following code is executed after an entry to"
 .W !?28,"this file has been selected. If Y=-1 entry will"
 .W !?28,"not be selected:"
 .W !?14,"CODE:" S STRING=^DD(ZNUM,0,"ACT") D STRING
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 W !!?1,"2. SPECIAL LOOK-UP PROGRAM: " I $D(^DD(ZNUM,0,"DIC")) W "^",^DD(ZNUM,0,"DIC")
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 W !!?1,"3. IDENTIFIERS:"
 I $D(^DD(ZNUM,0,"ID")) D NOTE,HD S GEMXX="" F  S GEMXX=$O(^DD(ZNUM,0,"ID",GEMXX)) Q:GEMXX=""!FLAGQ  D   W !
 .W !?1,$J(GEMXX,11),?14,$S(+GEMXX=GEMXX:"Yes",1:"No") S STRING=^DD(ZNUM,0,"ID",GEMXX) D STRING
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EX ;Exit
 Q
STRING ;String=code - Prints a string in lines of 55 characters
 F I=1,58,115,172,229,286 Q:$L(STRING)<I  W:I>1 ! W ?M3,$E(STRING,I,I+56) I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
PAGE ;
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! D HD Q
 R !!?2,"<RETURN> to continue, ""^"" to quit, ""^^"" to exit:  ",Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 W @GEMIOF D HD
 Q
NOTE ;
 W "  If ASK=Yes, field is asked when a new entry is added.",!
 Q
HD ;Heading
 W !?7,"FIELD",?14,"ASK",?(M3+10),"WRITE STATEMENT TO GENERATE DISPLAY",!?7,"-----",?14,"---",?M3,"-------------------------------------------------------"
 Q
