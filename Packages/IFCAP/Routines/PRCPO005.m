PRCPO005 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",101,4)
 ;;=^^^RI
 ;;^UTILITY(U,$J,"PRO",101,20)
 ;;=D DELETE^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",101,24)
 ;;=I $$CHECK^PRCPEILM
 ;;^UTILITY(U,$J,"PRO",101,99)
 ;;=56064,53680
 ;;^UTILITY(U,$J,"PRO",102,0)
 ;;=PRCP EDIT SECONDARY ITEMS^Edit Secondary Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",102,1,0)
 ;;=^^4^4^2931020^
 ;;^UTILITY(U,$J,"PRO",102,1,1,0)
 ;;=This protocol allows primary inventory point users to edit secondary
 ;;^UTILITY(U,$J,"PRO",102,1,2,0)
 ;;=inventory point item data.  The secondary inventory point must be defined
 ;;^UTILITY(U,$J,"PRO",102,1,3,0)
 ;;=as a distribution inventory point and the user must be an authorized
 ;;^UTILITY(U,$J,"PRO",102,1,4,0)
 ;;=inventory point user.
 ;;^UTILITY(U,$J,"PRO",102,4)
 ;;=^^^SI
 ;;^UTILITY(U,$J,"PRO",102,20)
 ;;=D SECOND^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",102,24)
 ;;=I PRCPTYPE="P"
 ;;^UTILITY(U,$J,"PRO",102,99)
 ;;=56064,53680
 ;;^UTILITY(U,$J,"PRO",103,0)
 ;;=PRCP DIST ORDER INV ITEM EDIT^Enter/Edit Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",103,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",103,1,1,0)
 ;;=This protocol allows the user to enter/edit inventory item data without
 ;;^UTILITY(U,$J,"PRO",103,1,2,0)
 ;;=having to leave the distribution order processing protocol menu and
 ;;^UTILITY(U,$J,"PRO",103,1,3,0)
 ;;=return.
 ;;^UTILITY(U,$J,"PRO",103,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",103,20)
 ;;=D EEITEMS^PRCPOPL
 ;;^UTILITY(U,$J,"PRO",103,99)
 ;;=56064,53665
 ;;^UTILITY(U,$J,"PRO",104,0)
 ;;=PRCP CHECK ORDER MENU^Check Distribution Order Menu^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",104,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",104,1,1,0)
 ;;=This protocol menu is generated if there are errors which need to be
 ;;^UTILITY(U,$J,"PRO",104,1,2,0)
 ;;=corrected by the user before release and posting of items on a
 ;;^UTILITY(U,$J,"PRO",104,1,3,0)
 ;;=distribution order.
 ;;^UTILITY(U,$J,"PRO",104,4)
 ;;=^^^CO
 ;;^UTILITY(U,$J,"PRO",104,10,0)
 ;;=^101.01PA^1^1
 ;;^UTILITY(U,$J,"PRO",104,10,1,0)
 ;;=105^EE^5^^^E/E Inventory Items
 ;;^UTILITY(U,$J,"PRO",104,10,1,"^")
 ;;=PRCP CHECK ORDER ITEM EDIT
 ;;^UTILITY(U,$J,"PRO",104,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",104,99)
 ;;=56075,45507
 ;;^UTILITY(U,$J,"PRO",105,0)
 ;;=PRCP CHECK ORDER ITEM EDIT^Enter/Edit Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",105,1,0)
 ;;=^^3^3^2931025^^
 ;;^UTILITY(U,$J,"PRO",105,1,1,0)
 ;;=This protocol allows the user to enter/edit inventory item data and
 ;;^UTILITY(U,$J,"PRO",105,1,2,0)
 ;;=correct errors on the spot without having to leave the option and
 ;;^UTILITY(U,$J,"PRO",105,1,3,0)
 ;;=return.
 ;;^UTILITY(U,$J,"PRO",105,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",105,20)
 ;;=D EEITEMS^PRCPOPER
 ;;^UTILITY(U,$J,"PRO",105,99)
 ;;=56064,53661
 ;;^UTILITY(U,$J,"PRO",106,0)
 ;;=PRCP CC/IK EDIT INVENTORY ITEMS^Enter/Edit Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",106,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",106,1,1,0)
 ;;=This protocol allows the user to enter/edit inventory item data
 ;;^UTILITY(U,$J,"PRO",106,1,2,0)
 ;;=from within the cc/ik protocol menu without having to leave the
 ;;^UTILITY(U,$J,"PRO",106,1,3,0)
 ;;=option and return.
 ;;^UTILITY(U,$J,"PRO",106,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",106,20)
 ;;=D EEITEMS^PRCPOPPC
 ;;^UTILITY(U,$J,"PRO",106,99)
 ;;=56064,53646
 ;;^UTILITY(U,$J,"PRO",107,0)
 ;;=PRCP CC/IK CHECK ITEMS MENU^Check CC/IK Items^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",107,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",107,1,1,0)
 ;;=This protocol menu is generated if there are errors which need to be
 ;;^UTILITY(U,$J,"PRO",107,1,2,0)
 ;;=corrected by the user before release and posting of items on a
 ;;^UTILITY(U,$J,"PRO",107,1,3,0)
 ;;=distribution order.
 ;;^UTILITY(U,$J,"PRO",107,4)
 ;;=^^^CO
 ;;^UTILITY(U,$J,"PRO",107,10,0)
 ;;=^101.01PA^1^1
 ;;^UTILITY(U,$J,"PRO",107,10,1,0)
 ;;=108^EE^5^^^E/E Inventory Items
 ;;^UTILITY(U,$J,"PRO",107,10,1,"^")
 ;;=PRCP CC/IK CHECK ITEMS EDIT
