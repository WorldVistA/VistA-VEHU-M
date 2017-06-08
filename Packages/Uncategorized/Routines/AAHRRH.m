%AAHRRH ;402,DJB,7/15/92**Help Text
 ;;GEM III;;
 ;;David Bolduc - Augusta, ME
 NEW TEXT,FLAGQ S FLAGQ=0 W @GEMIOF
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 D:'FLAGQ ^%AAHRRH1 D:'FLAGQ PAUSE
EX ;
 Q
TXT ;Start of text
 ;;; A R R . . . The Acme Routine Reader . . . . . . . . . . David Bolduc-Togus,ME
 ;;;==============================================================================
 ;;;
 ;;;  NOTES: ARR displays the line number for all program lines not having a
 ;;;         line tag. It also displays the total program lines at the top of
 ;;;         the screen. The 2 vertical bars at the left side of the top and
 ;;;         bottom borders, help delineate line tags.
 ;;;         Submenu 'ED=Edit' is only available if you have global ^%AAHE on
 ;;;         your system and you eXecute ^%AAHE.
 ;;;
 ;;;  E N T R Y   P O I N T S:
 ;;;
 ;;;        ^%AAHRR - Normal entry point.
 ;;;                  your system.
 ;;;        X ^%AAHE - ARR is also a routine editor. If you have ^%AAHE global on
 ;;;                  your system you may eXecute ^%AAHE to edit routines.
 ;;;
 ;;;
 ;;;  In the RESULT column, the word 'selected' indicates you will receive a
 ;;;  prompt asking you to enter the required value. T,G,F,L Options position
 ;;;  the selected line to the top of the display.
 ;;;
 ;;; E N T E R                            R  E  S  U  L  T
 ;;; ---------    ---------------------------------------------------------------
 ;;; <RETURN>     Continue on to next screen.
 ;;;
 ;;;    ^         Quit current session.
 ;;;
 ;;; <SPACE>      Quit current session.
 ;;;
 ;;;  N A V I G A T E   Submenu
 ;;;
 ;;;    T         Return to the top (line 1) of the program being displayed.
 ;;;
 ;;;    G         Go to selected line number. To move to the end of the program,
 ;;;              subtract approximately 12 lines (6 in double space mode) from
 ;;;              the total lines displayed above the top line, and GOTO that
 ;;;              line number.
 ;;;
 ;;;    F         Find selected Line Tag. If the Tag does not exist the display
 ;;;              will be blank. Use 'T' to return to top of program.
 ;;;
 ;;;    L         Locate selected string. If the string does not exist the display
 ;;;              will be blank. Use 'T' to return to top of program.
 ;;;
 ;;;   <AU>       Hitting the Up Arrow key will insert a line at the top of the
 ;;;              screen, thus backing up 1 line (VT100). If you try to back up
 ;;;              when you're at the top of the program, you will get beeped.
 ;;;
 ;;;   <AD>       Hitting the Down Arrow key will insert a line at the bottom,
 ;;;              thus moving ahead 1 line (VT100). If you try to insert a line
 ;;;              when you're at the end of the program, you will get beeped.
 ;;;
 ;;;   <AL>       Hitting the Left Arrow key will move you back 12 lines if you
 ;;;              are in single space mode, or 6 lines if in double space mode.
 ;;;
 ;;;   <AR>       Hitting the Right Arrow key will move you to the bottom of the
 ;;;              routine.
 ;;;***
PAGE ;
 Q:$P($T(TXT+(I+1)),";;;",2)="***"
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!,$E(GEMLINE1,1,GEMIOM),!
 Q
PAUSE ;
 I $Y<GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
