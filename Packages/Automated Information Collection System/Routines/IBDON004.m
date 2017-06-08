IBDON004 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",802,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",802,15)
 ;;=I $G(IBFASTXT) S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",802,20)
 ;;=D EDITFORM^IBDF6
 ;;^UTILITY(U,$J,"PRO",802,28)
 ;;=Edit Form: 
 ;;^UTILITY(U,$J,"PRO",802,99)
 ;;=56301,49961
 ;;^UTILITY(U,$J,"PRO",803,0)
 ;;=IBDF DISPLAY TOOL KIT BLOCKS FOR ADDING^Add Toolkit Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",803,1,0)
 ;;=^^1^1^2931015^^^^
 ;;^UTILITY(U,$J,"PRO",803,1,1,0)
 ;;=Allows the user to select a block from the tool kit and add it to the form.
 ;;^UTILITY(U,$J,"PRO",803,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",803,2,1,0)
 ;;=AT
 ;;^UTILITY(U,$J,"PRO",803,2,"B","AT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",803,15)
 ;;=I $G(IBFASTXT) S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",803,20)
 ;;=D ADD^IBDF7
 ;;^UTILITY(U,$J,"PRO",803,28)
 ;;=Add Tool Kit Block: 
 ;;^UTILITY(U,$J,"PRO",803,99)
 ;;=56301,49961
 ;;^UTILITY(U,$J,"PRO",804,0)
 ;;=IBDF MENU FOR EDITING DISPLAYED FORM^Add Tool Kit Block^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",804,1,0)
 ;;=^^1^1^2941206^^^^
 ;;^UTILITY(U,$J,"PRO",804,1,1,0)
 ;;=Allows the user to edit the form.
 ;;^UTILITY(U,$J,"PRO",804,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",804,10,0)
 ;;=^101.01PA^12^16
 ;;^UTILITY(U,$J,"PRO",804,10,1,0)
 ;;=803^AT^1
 ;;^UTILITY(U,$J,"PRO",804,10,1,"^")
 ;;=IBDF DISPLAY TOOL KIT BLOCKS FOR ADDING
 ;;^UTILITY(U,$J,"PRO",804,10,2,0)
 ;;=810^MV^4^^^Move Block
 ;;^UTILITY(U,$J,"PRO",804,10,2,"^")
 ;;=IBDF MOVE BLOCK
 ;;^UTILITY(U,$J,"PRO",804,10,3,0)
 ;;=811^BS^6
 ;;^UTILITY(U,$J,"PRO",804,10,3,"^")
 ;;=IBDF RESIZE BLOCK (WHILE EDITING FORM)
 ;;^UTILITY(U,$J,"PRO",804,10,4,0)
 ;;=812^EB^8^^^Edit Block
 ;;^UTILITY(U,$J,"PRO",804,10,4,"^")
 ;;=IBDF DISPLAY FORM BLOCK FOR EDIT
 ;;^UTILITY(U,$J,"PRO",804,10,5,0)
 ;;=819^DB^7^^^Delete Block
 ;;^UTILITY(U,$J,"PRO",804,10,5,"^")
 ;;=IBDF DELETE A BLOCK
 ;;^UTILITY(U,$J,"PRO",804,10,7,0)
 ;;=825^FH^10^^^Form Header
 ;;^UTILITY(U,$J,"PRO",804,10,7,"^")
 ;;=IBDF EDIT HEADER BLOCK
 ;;^UTILITY(U,$J,"PRO",804,10,8,0)
 ;;=828^NB^2^^^New Block
 ;;^UTILITY(U,$J,"PRO",804,10,8,1)
 ;;=New Block
 ;;^UTILITY(U,$J,"PRO",804,10,8,"^")
 ;;=IBDF CREATE EMPTY BLOCK
 ;;^UTILITY(U,$J,"PRO",804,10,9,0)
 ;;=833^RD^11^^^Re Display Screen
 ;;^UTILITY(U,$J,"PRO",804,10,9,"^")
 ;;=IBDF REDRAW FORM
 ;;^UTILITY(U,$J,"PRO",804,10,13,0)
 ;;=852^SH^5^^^Shift Blocks
 ;;^UTILITY(U,$J,"PRO",804,10,13,"^")
 ;;=IBDF SHIFT BLOCKS
 ;;^UTILITY(U,$J,"PRO",804,10,14,0)
 ;;=1073^VD^12^^^View w/wo Data (Toggle)
 ;;^UTILITY(U,$J,"PRO",804,10,14,"^")
 ;;=IBDF VIEW FORM W/WO DATA
 ;;^UTILITY(U,$J,"PRO",804,10,15,0)
 ;;=846^CF^3^^^Copy From Other Form
 ;;^UTILITY(U,$J,"PRO",804,10,15,"^")
 ;;=IBDF COPY FORM BLOCK
 ;;^UTILITY(U,$J,"PRO",804,10,16,0)
 ;;=1543^FE^9^^^Fast Selection Edit
 ;;^UTILITY(U,$J,"PRO",804,10,16,"^")
 ;;=IBDF QUICK SELECTION EDIT 2ND SCREEN
 ;;^UTILITY(U,$J,"PRO",804,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",804,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",804,99)
 ;;=56468,47481
 ;;^UTILITY(U,$J,"PRO",805,0)
 ;;=IBDF SELECT TOOL KIT BLOCK^Add Tool Kit Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",805,1,0)
 ;;=^^4^4^2930510^
 ;;^UTILITY(U,$J,"PRO",805,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",805,1,2,0)
 ;;=Allows the user to select a block from the list of toolkit blocks. The
 ;;^UTILITY(U,$J,"PRO",805,1,3,0)
 ;;=block is then pasted to the form at a position given by the user. He can
 ;;^UTILITY(U,$J,"PRO",805,1,4,0)
 ;;=also change the header, size, and description of the block.
 ;;^UTILITY(U,$J,"PRO",805,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",805,2,1,0)
 ;;=ST
 ;;^UTILITY(U,$J,"PRO",805,2,2,0)
 ;;=SB
 ;;^UTILITY(U,$J,"PRO",805,2,"B","SB",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",805,2,"B","ST",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",805,20)
 ;;=D SELECT^IBDF7
 ;;^UTILITY(U,$J,"PRO",805,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",806,0)
 ;;=IBDF MENU FOR ADDING TOOL KIT BLOCK^Add Toolkit Block^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",806,1,0)
 ;;=^^2^2^2931015^^^
 ;;^UTILITY(U,$J,"PRO",806,1,1,0)
 ;;=A menu of actions available in connection with adding a block from the 
 ;;^UTILITY(U,$J,"PRO",806,1,2,0)
 ;;=tool kit to a form.
 ;;^UTILITY(U,$J,"PRO",806,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",806,2,1,0)
 ;;=AT
 ;;^UTILITY(U,$J,"PRO",806,2,"B","AT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",806,4)
 ;;=40^4
 ;;^UTILITY(U,$J,"PRO",806,10,0)
 ;;=^101.01PA^3^3
 ;;^UTILITY(U,$J,"PRO",806,10,1,0)
 ;;=805^AT^2
 ;;^UTILITY(U,$J,"PRO",806,10,1,"^")
 ;;=IBDF SELECT TOOL KIT BLOCK
 ;;^UTILITY(U,$J,"PRO",806,10,2,0)
 ;;=807^VB^1
