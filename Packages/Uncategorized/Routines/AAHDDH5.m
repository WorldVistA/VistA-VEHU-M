%AAHDDH5 ;402,DJB,11/2/91,EDD**Help Text - Field Global Location cont.
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
TXT ;
 ;;;
 ;;;    R         Also allows you access to the Individual Field Summary but
 ;;;              you don't have to be concerned with multiple fields. R stands
 ;;;              for Reference Number which is printed in the REF column
 ;;;              to the far left of the screen. Typing R and entering this
 ;;;              number will give you the Individual Field Summary for the
 ;;;              corresponding field even if the field is a multiple. You
 ;;;              may request more than 1 field by using commas or a dash.
 ;;;              Example: Select REF NUMBER: 1,3,17 or 2-8
 ;;;
 ;;;    N         Allows you to do a look up by global node. At the 'Select
 ;;;              NODE:' prompt type '?' to see all nodes, or enter node. If
 ;;;              that node is a multiple you will be asked for subnode. You
 ;;;              will then get a list of all fields that are contained by
 ;;;              that node. You may then do an 'Individual Field Summary' on
 ;;;              any field listed.
 ;;;              Example: If you wanted to know what fields are contained
 ;;;                         in ^DPT(34,"DA",3,"T",0) you would enter '^DPT' at
 ;;;                         the 'Select FILE:' prompt, select option 7, enter
 ;;;                         'N' for node, and then enter the following:
 ;;;                              Select NODE: 'DA'
 ;;;                              Select 'DA' SUBNODE: 'T'
 ;;;                              Select 'T' SUBNODE: '0'
 ;;;                         EDD will now display all the fields contained in
 ;;;                         the selected node and allow you to do an 'Individual
 ;;;                         Field Summary'.
 ;;;
 ;;;    D         Data display. In addition to the data dictionary, you may
 ;;;              look at the actual data in the file. After selecting a REF
 ;;;              number or range of numbers, you select the type of display
 ;;;              you want. You have the following choices:
 ;;;                         E  = External values
 ;;;                         I  = Internal values
 ;;;                         EN = External values, null fields ignored
 ;;;                         IN = Internal values, null fields ignored
 ;;;              You will then be asked which entry you want to see. If any
 ;;;              of the fields you requested are multiples, you will also be
 ;;;              asked which multiple entry you want to see.  After viewing
 ;;;              the data, you are returned to the Global Location screen.
 ;;;
 ;;;    A         If you have my "Acme Global Lister" package on your system,
 ;;;              you can use this option to call it. DUZ(0) must contain
 ;;;              either '@' or '#'.
 ;;;***
PAGE ;
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX="^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!?1,"E N T E R",?38,"R  E  S  U  L  T",!?1,"---------",?14,"----------------------------------------------------------------"
 Q
