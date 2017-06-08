IBDON013 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",873,20)
 ;;=D VIEW^IBDE3
 ;;^UTILITY(U,$J,"PRO",873,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",874,0)
 ;;=IBDE IMPORT TK BLOCK^Import Entry^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",874,1,0)
 ;;=^^1^1^2930817^
 ;;^UTILITY(U,$J,"PRO",874,1,1,0)
 ;;=Allows the user to select a tool kit block from the list, then imports it.
 ;;^UTILITY(U,$J,"PRO",874,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",874,2,1,0)
 ;;=IE
 ;;^UTILITY(U,$J,"PRO",874,2,"B","IE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",874,20)
 ;;=D IMPORT^IBDE3
 ;;^UTILITY(U,$J,"PRO",874,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",875,0)
 ;;=IBDF CHANGE BLOCK TK ORDER^Change TK Order^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",875,1,0)
 ;;=^^1^1^2930820^
 ;;^UTILITY(U,$J,"PRO",875,1,1,0)
 ;;=Allows the user to select a block from the tool kit, then change it's order.
 ;;^UTILITY(U,$J,"PRO",875,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",875,2,1,0)
 ;;=CH
 ;;^UTILITY(U,$J,"PRO",875,2,"B","CH",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",875,20)
 ;;=D CHGORDER^IBDF13
 ;;^UTILITY(U,$J,"PRO",875,99)
 ;;=56301,49959
 ;;^UTILITY(U,$J,"PRO",876,0)
 ;;=IBDF PRINT MANAGER CLINIC SETUP^Clinic Print Manager^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",876,1,0)
 ;;=^^2^2^2930831^^
 ;;^UTILITY(U,$J,"PRO",876,1,1,0)
 ;;=Allows the user to edit the setup used by the Print Manager in determining 
 ;;^UTILITY(U,$J,"PRO",876,1,2,0)
 ;;=what forms to print for an appointment at the clinic level.
 ;;^UTILITY(U,$J,"PRO",876,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",876,2,1,0)
 ;;=CL
 ;;^UTILITY(U,$J,"PRO",876,2,"B","CL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",876,20)
 ;;=D CLNCSUP2^IBDF11
 ;;^UTILITY(U,$J,"PRO",876,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",877,0)
 ;;=IBDF PRINT MANAGER DIVISION SETUP^Div Print Manager^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",877,1,0)
 ;;=^^2^2^2930831^
 ;;^UTILITY(U,$J,"PRO",877,1,1,0)
 ;;=Allows the user to edit the setup used by the Print Manager in determining
 ;;^UTILITY(U,$J,"PRO",877,1,2,0)
 ;;=what forms to print for an appointment at the division level.
 ;;^UTILITY(U,$J,"PRO",877,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",877,2,1,0)
 ;;=DV
 ;;^UTILITY(U,$J,"PRO",877,2,"B","DV",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",877,20)
 ;;=D DIVSUP2^IBDF11
 ;;^UTILITY(U,$J,"PRO",877,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",1069,0)
 ;;=IBDF ADD BLANK SELECTION^Add Blank^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1069,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",1069,1,1,0)
 ;;=Allows the user to add a blank selection, i.e., a place holder that takes
 ;;^UTILITY(U,$J,"PRO",1069,1,2,0)
 ;;=up space on the selection list but has no data that is displayed.
 ;;^UTILITY(U,$J,"PRO",1069,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1069,2,1,0)
 ;;=AB
 ;;^UTILITY(U,$J,"PRO",1069,2,"B","AB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1069,20)
 ;;=D ADDBLANK^IBDF4A
 ;;^UTILITY(U,$J,"PRO",1069,99)
 ;;=56301,49959
 ;;^UTILITY(U,$J,"PRO",1070,0)
 ;;=IBDF ADD BLANK GROUP^Add Blank^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1070,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",1070,1,1,0)
 ;;=Allows the user to add a group that has no displayable text - i.e., it is 
 ;;^UTILITY(U,$J,"PRO",1070,1,2,0)
 ;;=blank - serves to add space to the list.
 ;;^UTILITY(U,$J,"PRO",1070,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1070,2,1,0)
 ;;=AB
 ;;^UTILITY(U,$J,"PRO",1070,2,"B","AB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1070,20)
 ;;=D ADDEMPTY^IBDF3
 ;;^UTILITY(U,$J,"PRO",1070,99)
 ;;=56301,49959
 ;;^UTILITY(U,$J,"PRO",1071,0)
 ;;=IBDF FORMAT ALL SELECTIONS^Format All^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1071,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",1071,1,1,0)
 ;;=Allows the user to format all the selections on the selection list all at once.
 ;;^UTILITY(U,$J,"PRO",1071,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1071,2,1,0)
 ;;=FA
 ;;^UTILITY(U,$J,"PRO",1071,2,"B","FA",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1071,20)
 ;;=D FORMAT^IBDF9A1
 ;;^UTILITY(U,$J,"PRO",1071,99)
 ;;=56301,49965
 ;;^UTILITY(U,$J,"PRO",1072,0)
 ;;=IBDF FORMAT GROUP'S SELECTIONS^Format All^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1072,1,0)
 ;;=^^1^1^2931021^
 ;;^UTILITY(U,$J,"PRO",1072,1,1,0)
 ;;=Allows the user to format in mass all the selections in the group.
 ;;^UTILITY(U,$J,"PRO",1072,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1072,2,1,0)
 ;;=FA
 ;;^UTILITY(U,$J,"PRO",1072,2,"B","FA",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1072,20)
 ;;=D FORMAT2^IBDF9A1
 ;;^UTILITY(U,$J,"PRO",1072,99)
 ;;=56301,49965
