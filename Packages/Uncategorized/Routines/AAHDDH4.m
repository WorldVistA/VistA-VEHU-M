%AAHDDH4 ;402,DJB,11/2/91,EDD**Help Text - Field Global Location
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW TEXT W @GEMIOF
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 I 'FLAGQ D ^%AAHDDH5
EX ;
 I 'FLAGQ D PAUSE
 Q
TXT ;
 ;;; E D D . . . Electronic Data Dictionary . . . . . . . David Bolduc-Togus,ME
 ;;;==============================================================================
 ;;; E N T E R                            R  E  S  U  L  T
 ;;; ---------    ----------------------------------------------------------------
 ;;;
 ;;;    ^         Quit back to Main Menu.
 ;;;
 ;;; <SPACE>      Quit back to Main Menu
 ;;;
 ;;;    ^^        Exit EDD completely.
 ;;;
 ;;;    B         Back up to previous screen.
 ;;;
 ;;;   'n'        Typing a number will allow you to Jump to any screen
 ;;;              that you have already viewed. In the upper right hand corner
 ;;;              of the screen you will see the current Page number and the
 ;;;              Top number. Top is the highest numbered screen you have viewed.
 ;;;              You may Jump to any screen from 1 to Top.
 ;;;
 ;;;    I         Allows you to zoom in on an individual field. It prompts you
 ;;;              for a field and then gives you the Individual Field Summary
 ;;;              for that field. When using 'I', you must start at the top
 ;;;              of the multiple. For example, if you were looking at the
 ;;;              Patient file and you had selected 'Admission Date' as the
 ;;;              starting point for Field Global Location and you <RETURNED>
 ;;;              thru 2 screens, you would see the field Treating Specialty.
 ;;;              To view the Individual Field Summary for this field you would
 ;;;              have to first select Admission Date and then Treating Specialty.
 ;;;              This is made easier by the design of the Field Global Location
 ;;;              screens. Each layer of multiple fields is preceeded by
 ;;;              dashes that indicate their level. You trace these dashes
 ;;;              back to locate the starting point for each layer. You can
 ;;;              also use the Trace a Field option.
 ;;;***
PAGE ;
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!?1,"E N T E R",?38,"R  E  S  U  L  T",!?1,"---------",?14,"----------------------------------------------------------------"
 Q
PAUSE ;
 I $Y<GEMSIZE F I=1:1:(GEMSIZE-$Y) W !
 R !?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
