PRCPO003 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",85,10,6,"^")
 ;;=PRCP DIST ORDER PICKING TICKET
 ;;^UTILITY(U,$J,"PRO",85,10,7,0)
 ;;=90^PO^35^^^Post Order
 ;;^UTILITY(U,$J,"PRO",85,10,7,"^")
 ;;=PRCP DIST ORDER POSTING
 ;;^UTILITY(U,$J,"PRO",85,10,8,0)
 ;;=103^EE^17^^^E/E Inventory Items
 ;;^UTILITY(U,$J,"PRO",85,10,8,"^")
 ;;=PRCP DIST ORDER INV ITEM EDIT
 ;;^UTILITY(U,$J,"PRO",85,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^"),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",85,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",85,99)
 ;;=56075,45490
 ;;^UTILITY(U,$J,"PRO",86,0)
 ;;=PRCP DIST ORDER DELETE^Delete Distribution Order^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",86,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",86,1,1,0)
 ;;=This protocol will delete the distribution order from the system.
 ;;^UTILITY(U,$J,"PRO",86,4)
 ;;=^^^DO
 ;;^UTILITY(U,$J,"PRO",86,20)
 ;;=D ORDRDELM^PRCPOPD
 ;;^UTILITY(U,$J,"PRO",86,24)
 ;;=I $$CHECK^PRCPOPL("DELETE")
 ;;^UTILITY(U,$J,"PRO",86,99)
 ;;=56064,53665
 ;;^UTILITY(U,$J,"PRO",87,0)
 ;;=PRCP DIST ORDER ITEM EDIT^Edit Items on Distribution Order^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",87,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",87,1,1,0)
 ;;=This protocol allows the user to add/edit items to the distribution order.
 ;;^UTILITY(U,$J,"PRO",87,4)
 ;;=^^^EI
 ;;^UTILITY(U,$J,"PRO",87,20)
 ;;=D EDIT^PRCPOPEE
 ;;^UTILITY(U,$J,"PRO",87,24)
 ;;=I $$CHECK^PRCPOPL("EDIT")
 ;;^UTILITY(U,$J,"PRO",87,99)
 ;;=56064,53666
 ;;^UTILITY(U,$J,"PRO",88,0)
 ;;=PRCP DIST ORDER ITEM DELETE^Delete Items on Distribution Order^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",88,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",88,1,1,0)
 ;;=This protocol allows the user to delete specific items from the
 ;;^UTILITY(U,$J,"PRO",88,1,2,0)
 ;;=distribution order.
 ;;^UTILITY(U,$J,"PRO",88,4)
 ;;=^^^DI
 ;;^UTILITY(U,$J,"PRO",88,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",88,20)
 ;;=D ITEMDELM^PRCPOPD
 ;;^UTILITY(U,$J,"PRO",88,24)
 ;;=I $$CHECK^PRCPOPL("DELETE")
 ;;^UTILITY(U,$J,"PRO",88,99)
 ;;=56064,53665
 ;;^UTILITY(U,$J,"PRO",89,0)
 ;;=PRCP DIST ORDER PICKING TICKET^Picking Ticket Print^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",89,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",89,1,1,0)
 ;;=This protocol allows the user to print a picking ticket of the order.
 ;;^UTILITY(U,$J,"PRO",89,1,2,0)
 ;;=Before the picking ticket can be printed, the order must be released.
 ;;^UTILITY(U,$J,"PRO",89,4)
 ;;=^^^PT
 ;;^UTILITY(U,$J,"PRO",89,20)
 ;;=D PICKLM^PRCPOPT
 ;;^UTILITY(U,$J,"PRO",89,24)
 ;;=I $$CHECK^PRCPOPL("PICKTICK")
 ;;^UTILITY(U,$J,"PRO",89,99)
 ;;=56064,53666
 ;;^UTILITY(U,$J,"PRO",90,0)
 ;;=PRCP DIST ORDER POSTING^Post Order^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",90,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",90,1,1,0)
 ;;=This protocol allows the user to post the items on the distribution order
 ;;^UTILITY(U,$J,"PRO",90,1,2,0)
 ;;=to the secondary inventory point.  Before the order can be posted, the
 ;;^UTILITY(U,$J,"PRO",90,1,3,0)
 ;;=order must have the picking ticket printed on a printer.
 ;;^UTILITY(U,$J,"PRO",90,4)
 ;;=^^^PO
 ;;^UTILITY(U,$J,"PRO",90,20)
 ;;=D POST^PRCPOPP
 ;;^UTILITY(U,$J,"PRO",90,24)
 ;;=I $$CHECK^PRCPOPL("POST")
 ;;^UTILITY(U,$J,"PRO",90,99)
 ;;=56064,53666
 ;;^UTILITY(U,$J,"PRO",91,0)
 ;;=PRCP EDIT ITEM DESCRIPTION^Edit Item Description^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",91,1,0)
 ;;=1
 ;;^UTILITY(U,$J,"PRO",91,1,1,0)
 ;;=This protocol allows the user to edit the items descriptive data.
 ;;^UTILITY(U,$J,"PRO",91,4)
 ;;=^^^DE
 ;;^UTILITY(U,$J,"PRO",91,20)
 ;;=D DESCRIP^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",91,99)
 ;;=56302,44642
 ;;^UTILITY(U,$J,"PRO",92,0)
 ;;=PRCP EDIT COSTING DATA^Edit Costing Data^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",92,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",92,1,1,0)
 ;;=This protocol allows the user to edit the item costing data.
 ;;^UTILITY(U,$J,"PRO",92,4)
 ;;=^^^CD
 ;;^UTILITY(U,$J,"PRO",92,20)
 ;;=D COST^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",92,24)
 ;;=I $$CHECK^PRCPEILM
