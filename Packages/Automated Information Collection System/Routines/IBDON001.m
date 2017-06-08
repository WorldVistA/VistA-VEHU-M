IBDON001 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",634,0)
 ;;=VALM NEXT SCREEN^Next Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",634,1,0)
 ;;=^^2^2^2920519^^^
 ;;^UTILITY(U,$J,"PRO",634,1,1,0)
 ;;=This action will allow the user to view the next screen
 ;;^UTILITY(U,$J,"PRO",634,1,2,0)
 ;;=of entries, if any exist.
 ;;^UTILITY(U,$J,"PRO",634,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",634,2,1,0)
 ;;=NX
 ;;^UTILITY(U,$J,"PRO",634,2,"B","NX",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",634,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",634,20)
 ;;=D NEXT^VALM4
 ;;^UTILITY(U,$J,"PRO",634,99)
 ;;=56433,56737
 ;;^UTILITY(U,$J,"PRO",634,"MEN","IBDF HIDDEN ACTIONS")
 ;;=634^+^11
 ;;^UTILITY(U,$J,"PRO",635,0)
 ;;=VALM PREVIOUS SCREEN^Previous Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",635,1,0)
 ;;=^^2^2^2920113^^
 ;;^UTILITY(U,$J,"PRO",635,1,1,0)
 ;;=This action will allow the user to view the previous screen
 ;;^UTILITY(U,$J,"PRO",635,1,2,0)
 ;;=of entries, if any exist.
 ;;^UTILITY(U,$J,"PRO",635,2,0)
 ;;=^101.02A^3^2
 ;;^UTILITY(U,$J,"PRO",635,2,1,0)
 ;;=PR
 ;;^UTILITY(U,$J,"PRO",635,2,2,0)
 ;;=BK
 ;;^UTILITY(U,$J,"PRO",635,2,3,0)
 ;;=PR
 ;;^UTILITY(U,$J,"PRO",635,2,"B","BK",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",635,2,"B","PR",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",635,2,"B","PR",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",635,20)
 ;;=D PREV^VALM4
 ;;^UTILITY(U,$J,"PRO",635,99)
 ;;=56433,56737
 ;;^UTILITY(U,$J,"PRO",635,"MEN","IBDF HIDDEN ACTIONS")
 ;;=635^-^12
 ;;^UTILITY(U,$J,"PRO",636,0)
 ;;=VALM REFRESH^Re-Display Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",636,1,0)
 ;;=^^1^1^2911024^
 ;;^UTILITY(U,$J,"PRO",636,1,1,0)
 ;;=This actions allows the user to re-display the current screen.
 ;;^UTILITY(U,$J,"PRO",636,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",636,2,1,0)
 ;;=RE
 ;;^UTILITY(U,$J,"PRO",636,2,"B","RE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",636,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",636,20)
 ;;=D RE^VALM4
 ;;^UTILITY(U,$J,"PRO",636,99)
 ;;=56433,56741
 ;;^UTILITY(U,$J,"PRO",636,"MEN","IBDF HIDDEN ACTIONS")
 ;;=636^RD^24
 ;;^UTILITY(U,$J,"PRO",637,0)
 ;;=VALM LAST SCREEN^Last Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",637,1,0)
 ;;=^^1^1^2911026^
 ;;^UTILITY(U,$J,"PRO",637,1,1,0)
 ;;=The action will display the last items.
 ;;^UTILITY(U,$J,"PRO",637,20)
 ;;=D LAST^VALM4
 ;;^UTILITY(U,$J,"PRO",637,99)
 ;;=56433,56736
 ;;^UTILITY(U,$J,"PRO",637,"MEN","IBDF HIDDEN ACTIONS")
 ;;=637^LS^22
 ;;^UTILITY(U,$J,"PRO",638,0)
 ;;=VALM FIRST SCREEN^First Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",638,1,0)
 ;;=^^1^1^2911026^
 ;;^UTILITY(U,$J,"PRO",638,1,1,0)
 ;;=This action will display the first screen.
 ;;^UTILITY(U,$J,"PRO",638,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",638,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",638,20)
 ;;=D FIRST^VALM4
 ;;^UTILITY(U,$J,"PRO",638,99)
 ;;=56433,56736
 ;;^UTILITY(U,$J,"PRO",638,"MEN","IBDF HIDDEN ACTIONS")
 ;;=638^FS^21
 ;;^UTILITY(U,$J,"PRO",639,0)
 ;;=VALM UP ONE LINE^Up a Line^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",639,1,0)
 ;;=^^1^1^2911027^
 ;;^UTILITY(U,$J,"PRO",639,1,1,0)
 ;;=Move up a line
 ;;^UTILITY(U,$J,"PRO",639,20)
 ;;=D UP^VALM40
 ;;^UTILITY(U,$J,"PRO",639,99)
 ;;=56433,56742
 ;;^UTILITY(U,$J,"PRO",639,"MEN","IBDF HIDDEN ACTIONS")
 ;;=639^UP^13
 ;;^UTILITY(U,$J,"PRO",640,0)
 ;;=VALM DOWN A LINE^Down a Line^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",640,1,0)
 ;;=^^2^2^2911027^
 ;;^UTILITY(U,$J,"PRO",640,1,1,0)
 ;;=Move down a line.
 ;;^UTILITY(U,$J,"PRO",640,1,2,0)
 ;;=
 ;;^UTILITY(U,$J,"PRO",640,20)
 ;;=D DOWN^VALM40
 ;;^UTILITY(U,$J,"PRO",640,99)
 ;;=56433,56735
 ;;^UTILITY(U,$J,"PRO",640,"MEN","IBDF HIDDEN ACTIONS")
 ;;=640^DN^14
 ;;^UTILITY(U,$J,"PRO",642,0)
 ;;=VALM QUIT^Quit^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",642,.1)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",642,1,0)
 ;;=^^1^1^2911105^
 ;;^UTILITY(U,$J,"PRO",642,1,1,0)
 ;;=This protocol can be used as a generic 'quit' action.
 ;;^UTILITY(U,$J,"PRO",642,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",642,2,1,0)
 ;;=EXIT
 ;;^UTILITY(U,$J,"PRO",642,2,2,0)
 ;;=QUIT
 ;;^UTILITY(U,$J,"PRO",642,2,"B","EXIT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",642,2,"B","QUIT",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",642,20)
 ;;=Q
 ;;^UTILITY(U,$J,"PRO",642,99)
 ;;=56433,56738
 ;;^UTILITY(U,$J,"PRO",642,"MEN","IBDF HIDDEN ACTIONS")
 ;;=642^QU^34^^^Quit Screen
 ;;^UTILITY(U,$J,"PRO",644,0)
 ;;=VALM PRINT LIST^Print List^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",644,1,0)
 ;;=^^2^2^2920113^
 ;;^UTILITY(U,$J,"PRO",644,1,1,0)
 ;;=This action allws the user to print the entire list of
 ;;^UTILITY(U,$J,"PRO",644,1,2,0)
 ;;=entries currently being displayed.
 ;;^UTILITY(U,$J,"PRO",644,20)
 ;;=D PRTL^VALM1
 ;;^UTILITY(U,$J,"PRO",644,99)
 ;;=56433,56737
