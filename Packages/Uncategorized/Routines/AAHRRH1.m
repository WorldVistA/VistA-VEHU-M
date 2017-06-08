%AAHRRH1 ;402,DJB,7/15/92**Help Text
 ;;GEM III;;
 ;;David Bolduc - Augusta, ME
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 D:'FLAGQ ^%AAHRRH2
EX ;
 Q
TXT ;Start of text
 ;;;
 ;;;  B R A N C H   Submenu
 ;;;
 ;;;    P         Branch to selected Program. Use this option when you encounter
 ;;;              a DO command in the current program and you wish to temporarily
 ;;;              view the Program being called. You can branch to up to 4 dif-
 ;;;              ferent programs in succession. The top line of the display will
 ;;;              indicate the number of programs you have branched to and the name
 ;;;              of the current program.
 ;;;
 ;;;    A         Allows you to view a global if you have my Acme Global Lister
 ;;;              package on your system. DUZ(0) must contain '@' or '#'.
 ;;;
 ;;;    E         Allows you to view a file if you have my Electronic Data
 ;;;              Dictionary package on your system.
 ;;;
 ;;;    RS        Routine search. Searches selected routines for selected strings.
 ;;;              Whenever a string is found and the display stops, you may enter
 ;;;              <RETURN> to continue, '^' to quit, '?' for Help, or 'A' for
 ;;;              Autoprint. When Autoprint is active, the display will not stop
 ;;;              when a string is located.
 ;;;
 ;;;  O T H E R   Submenu
 ;;;
 ;;;    SP        Toggles back and forth between single and double spacing. Use
 ;;;              single spacing to rapidly move through the program, and double
 ;;;              spacing to make the code easier to read.
 ;;;
 ;;;    M         Marks the line at the top of the display. To return to this
 ;;;              line, enter 'G' for GOTO and 'M' at the LINE NUMBER prompt.
 ;;;              This can be used as a place holder while you move elsewhere in
 ;;;              the program to follow a DO or GOTO command.
 ;;;
 ;;;  COL'n'      Entering COL and a number is a quick way to collapse backwards
 ;;;              when you've branched to a number of programs. If you are
 ;;;              currently in the 4th program, entering COL1 will return you
 ;;;              back to the 1st program.
 ;;;
 ;;;    R         Redraws the current screen.
 ;;;***
PAGE ;
 Q:$P($T(TXT+(I+1)),";;;",2)="***"
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!,$E(GEMLINE1,1,GEMIOM),!
 Q
