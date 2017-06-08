%AAHRRH2 ;402,DJB,7/15/92**Help Text
 ;;GEM III;;
 ;;David Bolduc - Augusta, ME
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
EX ;
 Q
TXT ;Start of text
 ;;;
 ;;;  E D I T   Submenu
 ;;;
 ;;;    I          Insert new code after selected line number. To insert a line
 ;;;               at the top of the routine, INSERT after line 0 (zero).
 ;;;
 ;;;    D          Delete selected line or range of lines. To select a range
 ;;;               use a dash. Ex. Delete lines 5-9.
 ;;;
 ;;;    C          Change (edit) code in selected line number. You may also
 ;;;               enter the line number directly, to edit the code.
 ;;;
 ;;;    LC         Locate and change string. This option will locate every
 ;;;               occurrance of the selected string and change it to the selected
 ;;;               value, within a selected range of lines.
 ;;;
 ;;;    SA         Save a line or range of lines. Use this option to move code
 ;;;               elsewhere in the program or to other programs.
 ;;;
 ;;;    UN         UNsave  copies SAved  code to a new location. The code will
 ;;;               be inserted after the selected line number. To UNSAVE a line
 ;;;               at the top of the routine, UNSAVE after line 0 (zero).
 ;;;
 ;;;    BR         Break a line into 2 lines. Trailing and leading spaces are
 ;;;               removed.
 ;;;
 ;;;    J          Join 2 selected lines. The 2nd line is joined to the end of
 ;;;               the 1st line and then deleted. Use Split to undo.
 ;;;
 ;;;    LE         When you select the CHANGE option to edit the code in a line,
 ;;;               you may use the basic line editor (REPLACE: WITH:) or a more
 ;;;               screen oriented version. LE is a toggle switch that allows you
 ;;;               to move back and forth between these 2 types of editors. The
 ;;;               default setting is Screen Editor. To use the Line Editor, type
 ;;;               LE before calling the CHANGE option. It will remain in the
 ;;;               Line mode until you type LE again.
 ;;;
 ;;;   PUR         The SAve and UNsave options use global ^%AAHE("SAVE",$J) as
 ;;;               a holding location. ^%AAHE("SAVE") does not grow to any great
 ;;;               extent, but it can be killed at any time with this purge
 ;;;               option.
 ;;;***
PAGE ;
 Q:$P($T(TXT+(I+1)),";;;",2)="***"
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!,$E(GEMLINE1,1,GEMIOM),!
 Q
