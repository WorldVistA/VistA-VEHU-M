IBDON002 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",644,"MEN","IBDF HIDDEN ACTIONS")
 ;;=644^PL^26
 ;;^UTILITY(U,$J,"PRO",659,0)
 ;;=VALM RIGHT^Shift View to Right^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",659,20)
 ;;=D RIGHT^VALM40(XQORNOD(0))
 ;;^UTILITY(U,$J,"PRO",659,99)
 ;;=56222,29860
 ;;^UTILITY(U,$J,"PRO",659,"MEN","IBDF HIDDEN ACTIONS")
 ;;=659^>^15
 ;;^UTILITY(U,$J,"PRO",660,0)
 ;;=VALM LEFT^Shift View to Left^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",660,20)
 ;;=D LEFT^VALM40(XQORNOD(0))
 ;;^UTILITY(U,$J,"PRO",660,99)
 ;;=56222,29860
 ;;^UTILITY(U,$J,"PRO",660,"MEN","IBDF HIDDEN ACTIONS")
 ;;=660^<^16
 ;;^UTILITY(U,$J,"PRO",663,0)
 ;;=VALM GOTO PAGE^Go to Page^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",663,1,0)
 ;;=^^1^1^2930113^
 ;;^UTILITY(U,$J,"PRO",663,1,1,0)
 ;;=
 ;;^UTILITY(U,$J,"PRO",663,20)
 ;;=D GOTO^VALM40
 ;;^UTILITY(U,$J,"PRO",663,99)
 ;;=56433,56736
 ;;^UTILITY(U,$J,"PRO",663,"MEN","IBDF HIDDEN ACTIONS")
 ;;=663^GO^23
 ;;^UTILITY(U,$J,"PRO",794,0)
 ;;=IBDF EDIT SELECTION LIST MENU^EDIT LIST^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",794,1,0)
 ;;=^^2^2^2950414^^^
 ;;^UTILITY(U,$J,"PRO",794,1,1,0)
 ;;=Displays all the selection groups defined for the list and provides
 ;;^UTILITY(U,$J,"PRO",794,1,2,0)
 ;;=a menu of actions for editing the contents of the list.
 ;;^UTILITY(U,$J,"PRO",794,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",794,10,0)
 ;;=^101.01PA^7^8
 ;;^UTILITY(U,$J,"PRO",794,10,1,0)
 ;;=795^AG^1^^^Add Group
 ;;^UTILITY(U,$J,"PRO",794,10,1,"^")
 ;;=IBDF ADD GROUP
 ;;^UTILITY(U,$J,"PRO",794,10,2,0)
 ;;=796^DG^2^^^Delete Group
 ;;^UTILITY(U,$J,"PRO",794,10,2,"^")
 ;;=IBDF DELETE GROUP
 ;;^UTILITY(U,$J,"PRO",794,10,3,0)
 ;;=797^GH^4^^^Group Header/Order
 ;;^UTILITY(U,$J,"PRO",794,10,3,"^")
 ;;=IBDF EDIT GROUP HDR/ORDER
 ;;^UTILITY(U,$J,"PRO",794,10,4,0)
 ;;=800^GC^3^^^Group's Contents
 ;;^UTILITY(U,$J,"PRO",794,10,4,"^")
 ;;=IBDF DISPLAY GRP'S SLCTNS FOR EDIT
 ;;^UTILITY(U,$J,"PRO",794,10,6,0)
 ;;=1070^AB^5^^^Add Blank
 ;;^UTILITY(U,$J,"PRO",794,10,6,"^")
 ;;=IBDF ADD BLANK GROUP
 ;;^UTILITY(U,$J,"PRO",794,10,7,0)
 ;;=1071^FA^6^^^Format All
 ;;^UTILITY(U,$J,"PRO",794,10,7,"^")
 ;;=IBDF FORMAT ALL SELECTIONS
 ;;^UTILITY(U,$J,"PRO",794,10,8,0)
 ;;=1310^RS^7^^^Resequence List
 ;;^UTILITY(U,$J,"PRO",794,10,8,"^")
 ;;=IBDF RESEQUENCE LIST
 ;;^UTILITY(U,$J,"PRO",794,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",794,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",794,99)
 ;;=56351,49141
 ;;^UTILITY(U,$J,"PRO",795,0)
 ;;=IBDF ADD GROUP^Add Group^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",795,1,0)
 ;;=^^1^1^2950203^^^^
 ;;^UTILITY(U,$J,"PRO",795,1,1,0)
 ;;=Adds a new group to the selection list.
 ;;^UTILITY(U,$J,"PRO",795,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",795,2,1,0)
 ;;=AG
 ;;^UTILITY(U,$J,"PRO",795,2,"B","AG",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",795,20)
 ;;=D ADDGRP^IBDF3
 ;;^UTILITY(U,$J,"PRO",795,99)
 ;;=56301,49959
 ;;^UTILITY(U,$J,"PRO",796,0)
 ;;=IBDF DELETE GROUP^Delete Group^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",796,1,0)
 ;;=^^3^3^2930510^
 ;;^UTILITY(U,$J,"PRO",796,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",796,1,2,0)
 ;;=Allows the user to select a group. The selected group, along with all of
 ;;^UTILITY(U,$J,"PRO",796,1,3,0)
 ;;=its selections, is deleted.
 ;;^UTILITY(U,$J,"PRO",796,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",796,2,1,0)
 ;;=DG
 ;;^UTILITY(U,$J,"PRO",796,2,"B","DG",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",796,20)
 ;;=D DELGRP^IBDF3
 ;;^UTILITY(U,$J,"PRO",796,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",797,0)
 ;;=IBDF EDIT GROUP HDR/ORDER^Group Header/Order^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",797,1,0)
 ;;=^^3^3^2930510^
 ;;^UTILITY(U,$J,"PRO",797,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",797,1,2,0)
 ;;=Allows a group to be selected. Then the header and print order can be
 ;;^UTILITY(U,$J,"PRO",797,1,3,0)
 ;;=edited.
 ;;^UTILITY(U,$J,"PRO",797,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",797,2,1,0)
 ;;=EG
 ;;^UTILITY(U,$J,"PRO",797,2,2,0)
 ;;=EH
 ;;^UTILITY(U,$J,"PRO",797,2,"B","EG",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",797,2,"B","EH",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",797,20)
 ;;=D EDITGRP^IBDF3
 ;;^UTILITY(U,$J,"PRO",797,99)
 ;;=56301,49963
 ;;^UTILITY(U,$J,"PRO",798,0)
 ;;=IBDF EDIT GROUP'S SELECTIONS MENU^Edit Contents^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",798,1,0)
 ;;=^^1^1^2930212^^^^
 ;;^UTILITY(U,$J,"PRO",798,1,1,0)
 ;;=Used to edit a group's selections.
 ;;^UTILITY(U,$J,"PRO",798,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",798,2,1,0)
 ;;=EC
 ;;^UTILITY(U,$J,"PRO",798,2,"B","EC",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",798,4)
 ;;=26^4
