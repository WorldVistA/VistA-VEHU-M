PRCPO001 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",77,0)
 ;;=PRCP CC/IK POSTING MENU^Posting CC/IK Items Menu^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",77,1,0)
 ;;=^^2^2^2931020^^^^
 ;;^UTILITY(U,$J,"PRO",77,1,1,0)
 ;;=This protocol allows the user to post specific items used in a case
 ;;^UTILITY(U,$J,"PRO",77,1,2,0)
 ;;=cart or instument kit to the using secondary and patient.
 ;;^UTILITY(U,$J,"PRO",77,4)
 ;;=26^4^^PM
 ;;^UTILITY(U,$J,"PRO",77,10,0)
 ;;=^101.01PA^5^5
 ;;^UTILITY(U,$J,"PRO",77,10,1,0)
 ;;=78^EL^5
 ;;^UTILITY(U,$J,"PRO",77,10,1,"^")
 ;;=PRCP CC/IK ITEM EDIT
 ;;^UTILITY(U,$J,"PRO",77,10,2,0)
 ;;=80^RC^20
 ;;^UTILITY(U,$J,"PRO",77,10,2,"^")
 ;;=PRCP CC/IK REMOVE CC/IK
 ;;^UTILITY(U,$J,"PRO",77,10,3,0)
 ;;=79^RR^15
 ;;^UTILITY(U,$J,"PRO",77,10,3,"^")
 ;;=PRCP CC/IK REMOVE REUSABLES
 ;;^UTILITY(U,$J,"PRO",77,10,4,0)
 ;;=81^PL^30
 ;;^UTILITY(U,$J,"PRO",77,10,4,"^")
 ;;=PRCP CC/IK POST
 ;;^UTILITY(U,$J,"PRO",77,10,5,0)
 ;;=106^EE^10^^^E/E Inventory Items
 ;;^UTILITY(U,$J,"PRO",77,10,5,"^")
 ;;=PRCP CC/IK EDIT INVENTORY ITEMS
 ;;^UTILITY(U,$J,"PRO",77,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",77,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",77,28)
 ;;=Select ACTION: 
 ;;^UTILITY(U,$J,"PRO",77,99)
 ;;=56090,42394
 ;;^UTILITY(U,$J,"PRO",78,0)
 ;;=PRCP CC/IK ITEM EDIT^Edit CC/IK Item List^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",78,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",78,1,1,0)
 ;;=This protocol allows the user to edit the quantity returned from the
 ;;^UTILITY(U,$J,"PRO",78,1,2,0)
 ;;=secondary inventory point for items contained in a case cart or
 ;;^UTILITY(U,$J,"PRO",78,1,3,0)
 ;;=instrument kit.
 ;;^UTILITY(U,$J,"PRO",78,4)
 ;;=^^^EL
 ;;^UTILITY(U,$J,"PRO",78,20)
 ;;=D EDIT^PRCPOPP1
 ;;^UTILITY(U,$J,"PRO",78,99)
 ;;=56064,53647
 ;;^UTILITY(U,$J,"PRO",79,0)
 ;;=PRCP CC/IK REMOVE REUSABLES^Remove Reusables^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",79,1,0)
 ;;=^^4^4^2931020^
 ;;^UTILITY(U,$J,"PRO",79,1,1,0)
 ;;=This protocol allows the user to remove all the reusable items contained
 ;;^UTILITY(U,$J,"PRO",79,1,2,0)
 ;;=in a case cart or instrument kit from the list of items to post.  This
 ;;^UTILITY(U,$J,"PRO",79,1,3,0)
 ;;=provides a more compact list of items to post and should be used if all
 ;;^UTILITY(U,$J,"PRO",79,1,4,0)
 ;;=reusable items ordered are returned.
 ;;^UTILITY(U,$J,"PRO",79,4)
 ;;=^^^RR
 ;;^UTILITY(U,$J,"PRO",79,20)
 ;;=D REMREUSE^PRCPOPP1
 ;;^UTILITY(U,$J,"PRO",79,99)
 ;;=56064,53659
 ;;^UTILITY(U,$J,"PRO",80,0)
 ;;=PRCP CC/IK REMOVE CC/IK^Remove CC or IK^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",80,1,0)
 ;;=^^4^4^2931020^
 ;;^UTILITY(U,$J,"PRO",80,1,1,0)
 ;;=This protocol allows the user to remove a case cart or instument kit
 ;;^UTILITY(U,$J,"PRO",80,1,2,0)
 ;;=from the list of case carts and instrument kits to post.  If a case
 ;;^UTILITY(U,$J,"PRO",80,1,3,0)
 ;;=cart or instrument kit is removed from the list, all items contained
 ;;^UTILITY(U,$J,"PRO",80,1,4,0)
 ;;=in the case cart or instrument kit will be removed from the list.
 ;;^UTILITY(U,$J,"PRO",80,4)
 ;;=^^^RC
 ;;^UTILITY(U,$J,"PRO",80,20)
 ;;=D REMCCIK^PRCPOPP1
 ;;^UTILITY(U,$J,"PRO",80,99)
 ;;=56064,53659
 ;;^UTILITY(U,$J,"PRO",81,0)
 ;;=PRCP CC/IK POST^Post CC/IK Item List^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",81,1,0)
 ;;=^^2^2^2931020^^^
 ;;^UTILITY(U,$J,"PRO",81,1,1,0)
 ;;=This protocol allows the user to post the items contained in the case cart
 ;;^UTILITY(U,$J,"PRO",81,1,2,0)
 ;;=or instrument kit to the secondary inventory point and patient.
 ;;^UTILITY(U,$J,"PRO",81,4)
 ;;=^^^PL
 ;;^UTILITY(U,$J,"PRO",81,20)
 ;;=D POST^PRCPOPP2
 ;;^UTILITY(U,$J,"PRO",81,99)
 ;;=56064,53648
 ;;^UTILITY(U,$J,"PRO",82,0)
 ;;=PRCP ENTER/EDIT INVENTORY ITEMS MENU^E/E Inventory Items^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",82,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",82,1,1,0)
 ;;=This protocol menu allows the user to add/edit the inventory item data.
 ;;^UTILITY(U,$J,"PRO",82,4)
 ;;=26^^^EE
 ;;^UTILITY(U,$J,"PRO",82,10,0)
 ;;=^101.01PA^12^12
