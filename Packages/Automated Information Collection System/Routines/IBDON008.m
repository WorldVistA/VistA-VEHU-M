IBDON008 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",827,1,6,0)
 ;;=than one clinic.
 ;;^UTILITY(U,$J,"PRO",827,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",827,2,1,0)
 ;;=DF
 ;;^UTILITY(U,$J,"PRO",827,2,"B","DF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",827,20)
 ;;=D DELFORM^IBDF6A
 ;;^UTILITY(U,$J,"PRO",827,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",828,0)
 ;;=IBDF CREATE EMPTY BLOCK^New Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",828,1,0)
 ;;=^^2^2^2930322^
 ;;^UTILITY(U,$J,"PRO",828,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",828,1,2,0)
 ;;=Allows the user to add a new empty block to the form.
 ;;^UTILITY(U,$J,"PRO",828,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",828,2,1,0)
 ;;=NB
 ;;^UTILITY(U,$J,"PRO",828,2,"B","NB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",828,20)
 ;;=D NEWBLOCK^IBDF5C
 ;;^UTILITY(U,$J,"PRO",828,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",829,0)
 ;;=IBDF TEXT AREA^Text Area^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",829,1,0)
 ;;=^^3^3^2930326^
 ;;^UTILITY(U,$J,"PRO",829,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",829,1,2,0)
 ;;=Allows the user to specify text and a rectangular area on the block that
 ;;^UTILITY(U,$J,"PRO",829,1,3,0)
 ;;=the text should appear in.
 ;;^UTILITY(U,$J,"PRO",829,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",829,2,1,0)
 ;;=TA
 ;;^UTILITY(U,$J,"PRO",829,2,"B","TA",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",829,20)
 ;;=D TEXT^IBDF9E
 ;;^UTILITY(U,$J,"PRO",829,99)
 ;;=56301,49967
 ;;^UTILITY(U,$J,"PRO",830,0)
 ;;=IBDF CHANGE CLINIC^Change Clinic^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",830,1,0)
 ;;=^^3^3^2930413^
 ;;^UTILITY(U,$J,"PRO",830,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",830,1,2,0)
 ;;=Allows the user to specify a different clinic. The  setup for the new
 ;;^UTILITY(U,$J,"PRO",830,1,3,0)
 ;;=clinic will then be displayed.
 ;;^UTILITY(U,$J,"PRO",830,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",830,2,1,0)
 ;;=CC
 ;;^UTILITY(U,$J,"PRO",830,2,"B","CC",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",830,20)
 ;;=D CHNGCLNC^IBDF6
 ;;^UTILITY(U,$J,"PRO",830,99)
 ;;=56301,49959
 ;;^UTILITY(U,$J,"PRO",831,0)
 ;;=IBDF EDIT FORM NAME/DESCR/SIZE^Form Name/Descr/Size^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",831,1,0)
 ;;=^^1^1^2930420^
 ;;^UTILITY(U,$J,"PRO",831,1,1,0)
 ;;=Allows the user to select a form, then edit its name, description, and size.
 ;;^UTILITY(U,$J,"PRO",831,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",831,2,1,0)
 ;;=NM
 ;;^UTILITY(U,$J,"PRO",831,2,"B","NM",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",831,20)
 ;;=D EDITFORM^IBDF6C
 ;;^UTILITY(U,$J,"PRO",831,99)
 ;;=56301,49963
 ;;^UTILITY(U,$J,"PRO",832,0)
 ;;=IBDF SHIFT BLOCK CONTENTS^Shift Contents^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",832,1,0)
 ;;=^^4^4^2930510^
 ;;^UTILITY(U,$J,"PRO",832,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",832,1,2,0)
 ;;=The user can use this action to move the contents of a block. He can
 ;;^UTILITY(U,$J,"PRO",832,1,3,0)
 ;;=specify the type of object to shift, the area to be affected and the
 ;;^UTILITY(U,$J,"PRO",832,1,4,0)
 ;;=direction and distance of the shift.
 ;;^UTILITY(U,$J,"PRO",832,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",832,2,1,0)
 ;;=SH
 ;;^UTILITY(U,$J,"PRO",832,2,"B","SH",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",832,15)
 ;;=D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 ;;^UTILITY(U,$J,"PRO",832,20)
 ;;=D SHIFT^IBDF10()
 ;;^UTILITY(U,$J,"PRO",832,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",833,0)
 ;;=IBDF REDRAW FORM^Re Display Screen^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",833,1,0)
 ;;=^^5^5^2930510^
 ;;^UTILITY(U,$J,"PRO",833,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",833,1,2,0)
 ;;=Causes the form to be re-displayed. Should be used if it is suspected that
 ;;^UTILITY(U,$J,"PRO",833,1,3,0)
 ;;=the display is incorrect. This differs from the refresh action that comes
 ;;^UTILITY(U,$J,"PRO",833,1,4,0)
 ;;=with the List Processor in that the array which contains the list of form
 ;;^UTILITY(U,$J,"PRO",833,1,5,0)
 ;;=lines is re-built.
 ;;^UTILITY(U,$J,"PRO",833,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",833,2,1,0)
 ;;=RD
 ;;^UTILITY(U,$J,"PRO",833,2,"B","RD",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",833,20)
 ;;=D REDRAW^IBDF5C
 ;;^UTILITY(U,$J,"PRO",833,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",839,0)
 ;;=IBDF TOOL KIT FORMS MENU^IBDF TOOL KIT FORMS MENU^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",839,1,0)
 ;;=^^2^2^2930624^^^
 ;;^UTILITY(U,$J,"PRO",839,1,1,0)
 ;;=Displays the tool kit forms. Allows the user to edit them, create new ones,
 ;;^UTILITY(U,$J,"PRO",839,1,2,0)
 ;;=etc.
 ;;^UTILITY(U,$J,"PRO",839,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",839,10,0)
 ;;=^101.01PA^6^10
