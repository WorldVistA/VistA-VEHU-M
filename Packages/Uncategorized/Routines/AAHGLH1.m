%AAHGLH1 ;402,DJB,3/24/92**Help Text - Main Screen
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW TEXT,FLAGQ S FLAGQ=0 W @GEMIOF
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 D:'FLAGQ ^%AAHGLH2 D:'FLAGQ PAUSE
EX ;
 Q
TXT ;Start of text
 ;;; A G L . . . The Acme Global Lister . . . . . . . . . . David Bolduc-Togus,ME
 ;;;==============================================================================
 ;;;
 ;;; E N T E R                            R  E  S  U  L  T
 ;;; ---------    ----------------------------------------------------------------
 ;;; <RETURN>     Continue on to next screen.
 ;;;
 ;;;    ^         Quit current session.
 ;;;
 ;;; <SPACE>      Quit current session.
 ;;;
 ;;;   'n'        Enter a number from the left hand column and the pieces of
 ;;;              the selected node will be displayed vertically. You can then
 ;;;              select a piece and view the data dictionary for the field
 ;;;              this piece represents.
 ;;;              The display will be 1 column if the number of pieces is less
 ;;;              than 18, 2 columns if between 18-34, and 3 columns if greater
 ;;;              than 34.
 ;;;              You can view a field's data dictionary directly by entering
 ;;;              "node,piece". Example: 12,3 will display the data dictionary
 ;;;              for the 3rd piece of node 12.
 ;;;              If the node you select is a Xref, the data dictionary for
 ;;;              the field setting the Xref, will be displayed. If the node is
 ;;;              a word processing field, the field will be displayed directly.
 ;;;              If the node is a zero node, information on the contents of a
 ;;;              zero node will be displayed.
 ;;;
 ;;;    B         Back up to previous screen.
 ;;;
 ;;;   J'n'       Typing J and a number will allow you to Jump to any screen
 ;;;              that you have already viewed. In the upper right hand corner
 ;;;              of the screen you will see the current Page number and the
 ;;;              Top number. Top is the highest numbered screen you have viewed.
 ;;;              You may Jump to any screen from 1 to Top.
 ;;;
 ;;;    A         This option allows you to start up an alternate session. If
 ;;;              you were in the Piece option viewing a data dictionary and
 ;;;              the field was a pointer, you can enter "A" and start a second
 ;;;              session to view the 'pointed to' global. When finished, you will
 ;;;              be returned to the calling point. This option is available at
 ;;;              both the Main screen and the Piece screen. You may only start
 ;;;              1 alternate session. The 1 in "A=Alt(1)" is the current session
 ;;;              number.
 ;;;
 ;;;    E         If you have my package "EDD - Electronic Data Dictionary"
 ;;;              on your system, you can call it with this option.
 ;;;***
PAGE ;
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!?1,"E N T E R",?38,"R  E  S  U  L  T",!?1,"---------",?14,"----------------------------------------------------------------"
 Q
PAUSE ;
 I $Y<GEMSIZE F I=$Y:1:GEMSIZE W !
 R !!?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
