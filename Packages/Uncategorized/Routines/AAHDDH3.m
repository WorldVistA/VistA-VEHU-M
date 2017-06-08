%AAHDDH3 ;402,DJB,11/2/91,EDD**Help Text - Main Menu Cont.
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
EX ;
 Q
TXT ;
 ;;;
 ;;;     12) Required Fields  - Lists all fields that are Required.
 ;;;
 ;;;     13) Acme Global Lister - If you have my "Acme Global Lister" package
 ;;;                              on your system, you can call it with this
 ;;;                              option. DUZ(0) must contain '@' or '#'.
 ;;;
 ;;;     14) Printing-On/Off  - Allows you to send screens to a printer. You will
 ;;;                             be offered the DEVICE: prompt. Enter printer.
 ;;;                             After <RETURN>, Main Menu will reappear and
 ;;;                             PRINTING STATUS, in the top half of the screen,
 ;;;                             will be set to 'ON'. You then select a Main
 ;;;                             Menu option and output will go to the selected
 ;;;                             device. When you return to the Main Menu,
 ;;;                             PRINTING STATUS will be 'OFF'. To print again
 ;;;                             you must select Printing On/Off option again
 ;;;                             to reset PRINTING STATUS to 'ON'. If PRINTING
 ;;;                             STATUS is 'ON' you may turn it off by selecting
 ;;;                             Printing On/Off option again. To slave
 ;;;                             print, enter '0;;60' at the DEVICE: prompt.
 ;;;
 ;;;                             NOTE: Since all screens are designed to be
 ;;;                             displayed on a CRT, printing to a 10 pitch
 ;;;                             80 margin printer looks best.
 ;;;***
PAGE ;
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF Q
PAUSE ;
 I $Y<GEMSIZE F I=1:1:(GEMSIZE-$Y) W !
 R !?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
