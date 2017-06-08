%AAHDDH2 ;402,DJB,11/2/91,EDD**Help Text - Main Menu cont.
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 I 'FLAGQ D ^%AAHDDH3
EX ;
 Q
TXT ;
 ;;;
 ;;;     5) Trace a Field - Displays the pathway to fields that are decendent
 ;;;                          from a multiple.
 ;;;                          Example: When looking at PATIENT file, you type
 ;;;                          'MOV' at the 'Enter Field Name:' prompt. Trace
 ;;;                          a Field will display:
 ;;;                                  401 Admission Date/Time
 ;;;                                    5 Treating Specialty
 ;;;                                 1000 Movement Number
 ;;;                           This is the pathway to the MOVEMENT NUMBER field.
 ;;;                           You can now select 'I' and type in the field
 ;;;                           number of each field in the path. You will get
 ;;;                           the Individual Field Listing for the MOVEMENT
 ;;;                           NUMBER field.
 ;;;
 ;;;     6) Indiv Fld Summary - Lists contents of the Data Dictionary
 ;;;                           for selected field. This option is equivalent
 ;;;                           to Filemanager's LIST FILE ATTRIBUTES.
 ;;;
 ;;;     7) Fld Global Location - List of all fields and their global
 ;;;                           location (NODE;PIECE). When working with larger
 ;;;                           files, you may start the list at a particular
 ;;;                           field or a particular screen. See the 'HELP' that's
 ;;;                           available in this option.
 ;;;
 ;;;     8) Templates - Lists Print, Sort, and Input templates. If
 ;;;                           listing is too long for any type, you may
 ;;;                           enter 'S' and skip over to next type.
 ;;;
 ;;;     9) File Description - Narrative describing the selected file.
 ;;;
 ;;;     10) Globals In ASCII Order - Gives listing of your system's globals
 ;;;                             sorted in ASCII order. Includes file number
 ;;;                             and name. Example: If you are looking at the
 ;;;                             RADIOLOGY PATIENT file, the Main Menu screen
 ;;;                             shows it's data global as ^RADPT. If you
 ;;;                             wanted to identify other Radiology files,
 ;;;                             you would use this option and start the
 ;;;                             listing at ^R.
 ;;;
 ;;;     11) File Characteristics  - Displays post-selection actions, special
 ;;;                             look-up programs, and identifiers. For more
 ;;;                             information on any of these topics see Chapter 5
 ;;;                             Section D of the VA Fileman Programmers' manual
 ;;;                             (Version 18).
 ;;;***
PAGE ;
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! Q
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX="^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF Q
