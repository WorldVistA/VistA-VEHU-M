%AAHDDH1 ;402,DJB,11/2/91,EDD**Help Text - Main Menu
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW TEXT D INIT G:FLAGQ EX
 I FLAGP,$E(GEMIOST,1,2)="P-" W !!!
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 I 'FLAGQ D ^%AAHDDH2
EX ;
 Q
TXT ;Start of text
 ;;; E D D . . . Electronic Data Dictionary . . . . . . . David Bolduc-Togus,ME
 ;;;==============================================================================
 ;;; NOTE: When you're in EDD, enter '?' at any prompt for help. If you do not
 ;;; have the VA KERNEL software on your system call EDD at P^%AAHDD. If you do
 ;;; not have the DEVICE or TERMINAL TYPE files, option 13 Printing-On/Off is
 ;;; disabled. To run AGL option, DUZ(0) must contain either '@' or '#'. DO
 ;;; ^AAHGEM for instructions on setting up the GEM environment.
 ;;;
 ;;; A)  E N T R Y   P O I N T S:
 ;;;
 ;;;        ^%AAHDD  - Main entry point. At 'Select FILE:' prompt enter File name,
 ;;;                   File Number, or File Global in the form ^DG or ^RA(.
 ;;;      GL^%AAHDD  - Gives listing of your system's globals sorted in ASCII
 ;;;                   order, including file number and name.
 ;;;     PRT^%AAHDD  - Bypasses opening screen and suppressess some page feeds.
 ;;;                   Use if you're on a printing/keyboard device such as a
 ;;;                   counsol.
 ;;;     DIR^%AAHDD  - Bypasses opening screen.
 ;;;
 ;;; B)  M E N U   O P T I O N S:
 ;;;
 ;;;     1) Cross References - An '*' in the far left column indicates this
 ;;;                           XREF can be used for lookup purposes. If you
 ;;;                           concantenate the global shown on the Main Menu
 ;;;                           screen with this XREF, there will be data.
 ;;;
 ;;;     2) Pointers IN - Lists all files that point to this file.
 ;;;
 ;;;     3) Pointers OUT - Lists all fields in this file that are
 ;;;                            pointers, and the files they point to. An 'M' in
 ;;;                            the far left column indicates the pointing field
 ;;;                            is a multiple. Use 'Trace a Field' to determine
 ;;;                            it's path.
 ;;;
 ;;;     4) Groups - In Filemanager Groups are a shorthand way for a user to
 ;;;                            call up several fields at once for Print or
 ;;;                            Entry/Edit purposes. Also, some programmers
 ;;;                            use Groups to keep track of locally added/alterred
 ;;;                            fields. See VA FILEMAN USER'S MANUAL to learn
 ;;;                            how to use Groups.
 ;;;***
PAGE ;
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! Q
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF Q
INIT ;
 I FLAGP W:$E(GEMIOST,1,2)="P-" "  Printing.." U IO
 W @GEMIOF Q
