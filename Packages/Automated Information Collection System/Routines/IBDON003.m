IBDON003 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",798,10,0)
 ;;=^101.01PA^5^6
 ;;^UTILITY(U,$J,"PRO",798,10,1,0)
 ;;=799^AD^1^^^Add Selection
 ;;^UTILITY(U,$J,"PRO",798,10,1,"^")
 ;;=IBDF ADD SELECTION
 ;;^UTILITY(U,$J,"PRO",798,10,2,0)
 ;;=808^ED^2^^^Edit
 ;;^UTILITY(U,$J,"PRO",798,10,2,"^")
 ;;=IBDF EDIT SELECTION
 ;;^UTILITY(U,$J,"PRO",798,10,3,0)
 ;;=809^DS^3^^^Delete
 ;;^UTILITY(U,$J,"PRO",798,10,3,1)
 ;;=Delete
 ;;^UTILITY(U,$J,"PRO",798,10,3,"^")
 ;;=IBDF DELETE SELECTION
 ;;^UTILITY(U,$J,"PRO",798,10,5,0)
 ;;=1069^PH^4^^^New Place Holder
 ;;^UTILITY(U,$J,"PRO",798,10,5,"^")
 ;;=IBDF ADD BLANK SELECTION
 ;;^UTILITY(U,$J,"PRO",798,10,6,0)
 ;;=1072^FA^5^^^Format All
 ;;^UTILITY(U,$J,"PRO",798,10,6,"^")
 ;;=IBDF FORMAT GROUP'S SELECTIONS
 ;;^UTILITY(U,$J,"PRO",798,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",798,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",798,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",798,99)
 ;;=56523,50755
 ;;^UTILITY(U,$J,"PRO",799,0)
 ;;=IBDF ADD SELECTION^Add To List^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",799,1,0)
 ;;=^^1^1^2930607^^
 ;;^UTILITY(U,$J,"PRO",799,1,1,0)
 ;;=Adds a new selection to the selection list.
 ;;^UTILITY(U,$J,"PRO",799,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",799,2,1,0)
 ;;=AL
 ;;^UTILITY(U,$J,"PRO",799,2,"B","AL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",799,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",799,20)
 ;;=D ADDSLCTN^IBDF4
 ;;^UTILITY(U,$J,"PRO",799,99)
 ;;=56351,48728
 ;;^UTILITY(U,$J,"PRO",800,0)
 ;;=IBDF DISPLAY GRP'S SLCTNS FOR EDIT^Group's Contents^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",800,1,0)
 ;;=^^1^1^2930510^
 ;;^UTILITY(U,$J,"PRO",800,1,1,0)
 ;;=Displays the group's selections and a menu of edit actions.
 ;;^UTILITY(U,$J,"PRO",800,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",800,2,1,0)
 ;;=ES
 ;;^UTILITY(U,$J,"PRO",800,2,"B","ES",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",800,15)
 ;;=I $G(IBFASTXT) S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",800,20)
 ;;=D EDTSLCTN^IBDF3
 ;;^UTILITY(U,$J,"PRO",800,99)
 ;;=56301,49961
 ;;^UTILITY(U,$J,"PRO",801,0)
 ;;=IBDF CLINIC'S FORMS MENU^Clinic's Setup^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",801,1,0)
 ;;=^^3^3^2960110^^^^
 ;;^UTILITY(U,$J,"PRO",801,1,1,0)
 ;;=Displays all of the forms used by a particular clinic. Allows the user
 ;;^UTILITY(U,$J,"PRO",801,1,2,0)
 ;;=to change the clinic setup, create new blank forms, copy forms, delete
 ;;^UTILITY(U,$J,"PRO",801,1,3,0)
 ;;=to change the clinic setup, create new blank forms, copy forms, delete
 ;;^UTILITY(U,$J,"PRO",801,2,0)
 ;;=^101.02A^^0
 ;;^UTILITY(U,$J,"PRO",801,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",801,10,0)
 ;;=^101.01PA^10^12
 ;;^UTILITY(U,$J,"PRO",801,10,1,0)
 ;;=802^EF^8^^^Edit Form
 ;;^UTILITY(U,$J,"PRO",801,10,1,"^")
 ;;=IBDF EDIT FORM
 ;;^UTILITY(U,$J,"PRO",801,10,2,0)
 ;;=815^CR^6^^^Create Blank Form
 ;;^UTILITY(U,$J,"PRO",801,10,2,"^")
 ;;=IBDF CREATE BLANK FORM
 ;;^UTILITY(U,$J,"PRO",801,10,3,0)
 ;;=816^CF^5^^^Copy Form
 ;;^UTILITY(U,$J,"PRO",801,10,3,1)
 ;;=Copy Form:
 ;;^UTILITY(U,$J,"PRO",801,10,3,"^")
 ;;=IBDF COPY FORM
 ;;^UTILITY(U,$J,"PRO",801,10,4,0)
 ;;=817^AS^3^^^Add Form to Setup
 ;;^UTILITY(U,$J,"PRO",801,10,4,"^")
 ;;=IBDF ADD TO CLINIC SETUP
 ;;^UTILITY(U,$J,"PRO",801,10,5,0)
 ;;=818^DS^4^^^Delete from Setup
 ;;^UTILITY(U,$J,"PRO",801,10,5,"^")
 ;;=IBDF DELETE FROM CLINIC SETUP
 ;;^UTILITY(U,$J,"PRO",801,10,7,0)
 ;;=827^DF^7^^^Delete Unused Form
 ;;^UTILITY(U,$J,"PRO",801,10,7,"^")
 ;;=IBDF DELETE FORM
 ;;^UTILITY(U,$J,"PRO",801,10,8,0)
 ;;=830^CC^1^^^Change Clinic
 ;;^UTILITY(U,$J,"PRO",801,10,8,"^")
 ;;=IBDF CHANGE CLINIC
 ;;^UTILITY(U,$J,"PRO",801,10,9,0)
 ;;=831^NM^2^^^Form Name/Descr/Size
 ;;^UTILITY(U,$J,"PRO",801,10,9,"^")
 ;;=IBDF EDIT FORM NAME/DESCR/SIZE
 ;;^UTILITY(U,$J,"PRO",801,10,11,0)
 ;;=1082^RC^10^^^Recompile Form
 ;;^UTILITY(U,$J,"PRO",801,10,11,"^")
 ;;=IBDF COMPILE FORM
 ;;^UTILITY(U,$J,"PRO",801,10,12,0)
 ;;=1466^FS^9^^^Fast Selection Edit
 ;;^UTILITY(U,$J,"PRO",801,10,12,"^")
 ;;=IBDF QUICK SELECTION EDIT
 ;;^UTILITY(U,$J,"PRO",801,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",801,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",801,99)
 ;;=56468,52362
 ;;^UTILITY(U,$J,"PRO",802,0)
 ;;=IBDF EDIT FORM^Edit Form^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",802,1,0)
 ;;=^^2^2^2941117^^^
 ;;^UTILITY(U,$J,"PRO",802,1,1,0)
 ;;=This protocol calls the list manager to display an encounter form. There
 ;;^UTILITY(U,$J,"PRO",802,1,2,0)
 ;;=is a menu of actions that allows the form description to be edited.
 ;;^UTILITY(U,$J,"PRO",802,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",802,2,1,0)
 ;;=EF
 ;;^UTILITY(U,$J,"PRO",802,2,"B","EF",1)
 ;;=
