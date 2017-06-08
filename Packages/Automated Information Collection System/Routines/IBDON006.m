IBDON006 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",813,10,5,0)
 ;;=823^LN^5^^^Straight Line
 ;;^UTILITY(U,$J,"PRO",813,10,5,"^")
 ;;=IBDF STRAIGHT LINE
 ;;^UTILITY(U,$J,"PRO",813,10,7,0)
 ;;=829^TA^6^^^Text Area
 ;;^UTILITY(U,$J,"PRO",813,10,7,"^")
 ;;=IBDF TEXT AREA
 ;;^UTILITY(U,$J,"PRO",813,10,8,0)
 ;;=832^SH^7^^^Shift Contents
 ;;^UTILITY(U,$J,"PRO",813,10,8,"^")
 ;;=IBDF SHIFT BLOCK CONTENTS
 ;;^UTILITY(U,$J,"PRO",813,10,9,0)
 ;;=853^SD^9^^^Save/Discard Changes
 ;;^UTILITY(U,$J,"PRO",813,10,9,"^")
 ;;=IBDF SAVE/DISCARD BLOCK CHANGES
 ;;^UTILITY(U,$J,"PRO",813,10,10,0)
 ;;=1073^VD^8^^^View w/wo Data (Toggle)
 ;;^UTILITY(U,$J,"PRO",813,10,10,"^")
 ;;=IBDF VIEW FORM W/WO DATA
 ;;^UTILITY(U,$J,"PRO",813,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",813,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",813,99)
 ;;=56505,38482
 ;;^UTILITY(U,$J,"PRO",814,0)
 ;;=IBDF SELECTION LIST^Selection List^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",814,1,0)
 ;;=^^2^2^2930322^
 ;;^UTILITY(U,$J,"PRO",814,1,1,0)
 ;;=Allows the user to create a new selection list, delete or edit an already
 ;;^UTILITY(U,$J,"PRO",814,1,2,0)
 ;;=existing one, or change the contents of a list.
 ;;^UTILITY(U,$J,"PRO",814,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",814,2,1,0)
 ;;=SE
 ;;^UTILITY(U,$J,"PRO",814,2,"B","SE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",814,15)
 ;;=I $G(IBFASTXT) S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",814,20)
 ;;=D LIST^IBDF9A
 ;;^UTILITY(U,$J,"PRO",814,28)
 ;;=
 ;;^UTILITY(U,$J,"PRO",814,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",815,0)
 ;;=IBDF CREATE BLANK FORM^Create Blank Form^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",815,1,0)
 ;;=^^1^1^2951024^^^^
 ;;^UTILITY(U,$J,"PRO",815,1,1,0)
 ;;=Creates a new blank form and allows the user to add it to the clinic setup.
 ;;^UTILITY(U,$J,"PRO",815,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",815,2,1,0)
 ;;=CR
 ;;^UTILITY(U,$J,"PRO",815,2,"B","CR",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",815,20)
 ;;=D NEWFORM^IBDF6A
 ;;^UTILITY(U,$J,"PRO",815,28)
 ;;=Create Blank Form: 
 ;;^UTILITY(U,$J,"PRO",815,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",816,0)
 ;;=IBDF COPY FORM^Copy Form^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",816,1,0)
 ;;=^^2^2^2930127^
 ;;^UTILITY(U,$J,"PRO",816,1,1,0)
 ;;=Allows the user to choose any form and and copy it, giving it a new name. 
 ;;^UTILITY(U,$J,"PRO",816,1,2,0)
 ;;=He can then add it to the clinic setup.
 ;;^UTILITY(U,$J,"PRO",816,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",816,2,1,0)
 ;;=CP
 ;;^UTILITY(U,$J,"PRO",816,2,"B","CP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",816,20)
 ;;=D COPYFORM^IBDF6A
 ;;^UTILITY(U,$J,"PRO",816,28)
 ;;=Copy Form: 
 ;;^UTILITY(U,$J,"PRO",816,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",817,0)
 ;;=IBDF ADD TO CLINIC SETUP^Add Form to Setup^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",817,1,0)
 ;;=^^1^1^2930127^
 ;;^UTILITY(U,$J,"PRO",817,1,1,0)
 ;;=Allows the user to add a form to the clinic setup.
 ;;^UTILITY(U,$J,"PRO",817,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",817,2,1,0)
 ;;=CS
 ;;^UTILITY(U,$J,"PRO",817,2,2,0)
 ;;=AC
 ;;^UTILITY(U,$J,"PRO",817,2,"B","AC",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",817,2,"B","CS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",817,20)
 ;;=D SETUP^IBDF6A
 ;;^UTILITY(U,$J,"PRO",817,28)
 ;;=Add to Setup: 
 ;;^UTILITY(U,$J,"PRO",817,99)
 ;;=56301,49959
 ;;^UTILITY(U,$J,"PRO",818,0)
 ;;=IBDF DELETE FROM CLINIC SETUP^Delete from Setup^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",818,1,0)
 ;;=^^1^1^2930127^
 ;;^UTILITY(U,$J,"PRO",818,1,1,0)
 ;;=Allows the user to select a form and deletes it from the clinic setup.
 ;;^UTILITY(U,$J,"PRO",818,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",818,2,1,0)
 ;;=DC
 ;;^UTILITY(U,$J,"PRO",818,2,"B","DC",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",818,20)
 ;;=D DSETUP^IBDF6C
 ;;^UTILITY(U,$J,"PRO",818,28)
 ;;=Delete From Clinic Setup: 
 ;;^UTILITY(U,$J,"PRO",818,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",819,0)
 ;;=IBDF DELETE A BLOCK^Delete Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",819,1,0)
 ;;=^^1^1^2930127^^
 ;;^UTILITY(U,$J,"PRO",819,1,1,0)
 ;;=Allows the user to select a block from the form and delete it.
 ;;^UTILITY(U,$J,"PRO",819,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",819,2,1,0)
 ;;=DB
 ;;^UTILITY(U,$J,"PRO",819,2,"B","DB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",819,20)
 ;;=D DELETE^IBDF5
 ;;^UTILITY(U,$J,"PRO",819,28)
 ;;=Delete a Block: 
 ;;^UTILITY(U,$J,"PRO",819,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",820,0)
 ;;=IBDF RESIZE BLOCK (WHILE EDITING BLOCK)^Block Size^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",820,1,0)
 ;;=^^2^2^2930510^
