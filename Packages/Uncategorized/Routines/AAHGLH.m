%AAHGLH ;402,DJB,3/24/92**Help Text - Global Prompt
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW TEXT,FLAGQ S FLAGQ=0 W @GEMIOF
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 I 'FLAGQ D PAUSE
EX ;
 Q
TXT ;Start of text
 ;;; A G L . . . The Acme Global Lister . . . . . . . . . . David Bolduc-Togus,ME
 ;;;==============================================================================
 ;;; NOTE: DUZ(0) must contain either '@' or '#' to run AGL. DO ^AAHGEM for
 ;;;       instructions on setting up the GEM environment.
 ;;;
 ;;; A)  E N T R Y   P O I N T S:
 ;;;        ^%AAHGL - Normal entry point.
 ;;;       B^%AAHGL - Runs the basic global lister only. Use this entry point
 ;;;                  if your partition space is too small to handle the complete
 ;;;                  AGL package.
 ;;;                  your system.
 ;;;       S^%AAHGL - Sets page length=58. Use this entry point if you wish to
 ;;;                  slave print a portion of a global.
 ;;;
 ;;; B)  E N T E R:
 ;;;                A global reference
 ;;;                      -or-
 ;;;          <SPACE>.... to select global using a file name or number
 ;;;               *D.... for a directory list (DSM systems)
 ;;;              *%D.... for a library directory list (DSM systems)
 ;;;
 ;;;   The global reference may contain variables which must be defined.
 ;;;   Ranges can be specified with a ":" (colon), and multiple arguments
 ;;;   with a " " (space). Ending in a closed paren will prevent the display
 ;;;   from going below the last node specified.
 ;;;
 ;;;   EXAMPLES:
 ;;;
 ;;;       ^DD .................Will list all of ^DD.
 ;;;
 ;;;       ^VA(200 .............Will list all of global ^VA using first level
 ;;;                            subscript 200.
 ;;;
 ;;;       ^DPT(DFN ............Will list all of ^DPT using first level subscript
 ;;;                            equal to variable DFN.
 ;;;
 ;;;       ^DIC(4 9.4,1:10,0) ..In ^DIC the first level subscript may be either
 ;;;                            4 or 9.4, the second level subscript must be
 ;;;                            from 1 to 10, and the third level subscript
 ;;;                            must be 0.
 ;;;
 ;;;        ^DPT(,,, ...........Will display only those nodes of ^DPT whose
 ;;;                            subscript is 4 levels or lower.
 ;;;
 ;;;       ^DIZ(,500:) .........In ^DIZ, any first level subscript, and second 
 ;;;                            level subscript equal to or greater than 500.
 ;;;
 ;;;       <SPACE>
 ;;;       Select FILE: 4 ......Select global for file 4 [INSTITUTION..^DIC(4,].
 ;;;
 ;;; ^["MGR","ROU"]%EDI ........List %EDI global which resides in MGR.
 ;;;***
PAGE ;
 Q:$P($T(TXT+(I+1)),";;;",2)="***"
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!,$E(GEMLINE1,1,GEMIOM),! Q
PAUSE ;
 I $Y<GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
