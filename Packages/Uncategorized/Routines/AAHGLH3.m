%AAHGLH3 ;402,DJB,3/24/92**Help Text - Piece Screen
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW TEXT,FLAGQ S FLAGQ=0 W @GEMIOF
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 D:'FLAGQ PAUSE^%AAHGLH1
EX ;
 Q
TXT ;Start of text
 ;;;
 ;;; A G L . . . The Acme Global Lister . . . . . . . . . . David Bolduc-Togus,ME
 ;;;==============================================================================
 ;;; E N T E R                            R  E  S  U  L  T
 ;;; ---------    ---------------------------------------------------------------
 ;;; <RETURN>     Quit
 ;;;
 ;;;   'n'        Enter number of piece and view the data dictionary for the
 ;;;              field this piece represents. If a piece number has a "p"
 ;;;              instead of a ".", it indicates this piece contains a Pointer
 ;;;              field. If a number has an "s", the field is a Set-of-Codes.
 ;;;
 ;;;    I         This option will cause the piece listing to display the
 ;;;              internal value contained in each piece. This is the default
 ;;;              setting when you first select 'n'=Piece from the node screen.
 ;;;
 ;;;    X         External values are displayed for fields that are Pointers
 ;;;              or a Set-of-Codes. Internal values are displayed for all others.
 ;;;              Pointers are only resolved to their first level.
 ;;;
 ;;;    N         This option will cause the piece listing to display the
 ;;;              name of the field each piece represents.
 ;;;
 ;;;    A         This option allows you to start up an alternate session.
 ;;;              The 1 in A=Alt(1) is the current session number.
 ;;;
 ;;;    E         If you have my package "EDD - Electronic Data Dictionary"
 ;;;              on your system, you can call it with this option.
 ;;;***
PAGE ;
 Q:$P($T(TXT+(I+1)),";;;",2)="***"
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!?1,"E N T E R",?38,"R  E  S  U  L  T",!?1,"---------",?14,"---------------------------------------------------------------"
 Q
