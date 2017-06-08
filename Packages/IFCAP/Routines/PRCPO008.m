PRCPO008 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",120,4)
 ;;=^^^RO
 ;;^UTILITY(U,$J,"PRO",120,20)
 ;;=D RECEIVE^PRCPPOL1
 ;;^UTILITY(U,$J,"PRO",120,99)
 ;;=56064,53742
 ;;^UTILITY(U,$J,"PRO",121,0)
 ;;=PRCP PURCHASE ORDER DIST COST^Distribution Cost^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",121,1,0)
 ;;=^^2^2^2940107^
 ;;^UTILITY(U,$J,"PRO",121,1,1,0)
 ;;=This protocol allows the user to cost items to distribution points for
 ;;^UTILITY(U,$J,"PRO",121,1,2,0)
 ;;=those items which are not stored in the inventory point.
 ;;^UTILITY(U,$J,"PRO",121,4)
 ;;=^^^DC
 ;;^UTILITY(U,$J,"PRO",121,20)
 ;;=D DISTCOST^PRCPPOL0
 ;;^UTILITY(U,$J,"PRO",121,99)
 ;;=56064,53736
 ;;^UTILITY(U,$J,"PRO",122,0)
 ;;=PRCP PURCHASE ORDER E/E ITEMS^E/E Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",122,1,0)
 ;;=^^1^1^2940107^^
 ;;^UTILITY(U,$J,"PRO",122,1,1,0)
 ;;=This protocol allows the user to enter/edit inventory item data.
 ;;^UTILITY(U,$J,"PRO",122,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",122,20)
 ;;=D EEITEMS^PRCPPOL0
 ;;^UTILITY(U,$J,"PRO",122,99)
 ;;=56064,53737
 ;;^UTILITY(U,$J,"PRO",123,0)
 ;;=PRCP ISSUE BOOK POSTING MENU^Issue Book Posting^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",123,1,0)
 ;;=^^2^2^2940120^^
 ;;^UTILITY(U,$J,"PRO",123,1,1,0)
 ;;=This is the top level menu for the protocol to Post the Issue Book
 ;;^UTILITY(U,$J,"PRO",123,1,2,0)
 ;;=from the warehouse to the primary inventory point.
 ;;^UTILITY(U,$J,"PRO",123,4)
 ;;=26^^^IB
 ;;^UTILITY(U,$J,"PRO",123,10,0)
 ;;=^101.01PA^9^9
 ;;^UTILITY(U,$J,"PRO",123,10,1,0)
 ;;=124^EE^1
 ;;^UTILITY(U,$J,"PRO",123,10,1,"^")
 ;;=PRCP ISSUE BOOK E/E ITEMS
 ;;^UTILITY(U,$J,"PRO",123,10,2,0)
 ;;=125^QR^17^^^Qty to Remaining
 ;;^UTILITY(U,$J,"PRO",123,10,2,"^")
 ;;=PRCP ISSUE BOOK QTY TO REMAIN
 ;;^UTILITY(U,$J,"PRO",123,10,3,0)
 ;;=126^QO^14^^^Qty to On-Hand
 ;;^UTILITY(U,$J,"PRO",123,10,3,"^")
 ;;=PRCP ISSUE BOOK QTY TO ONHAND
 ;;^UTILITY(U,$J,"PRO",123,10,4,0)
 ;;=127^QE^11^^^Qty to Enter
 ;;^UTILITY(U,$J,"PRO",123,10,4,"^")
 ;;=PRCP ISSUE BOOK QTY TO ENTER
 ;;^UTILITY(U,$J,"PRO",123,10,5,0)
 ;;=128^SN^4^^^Show NSN
 ;;^UTILITY(U,$J,"PRO",123,10,5,"^")
 ;;=PRCP ISSUE BOOK SHOW NSN
 ;;^UTILITY(U,$J,"PRO",123,10,6,0)
 ;;=129^CL^21^^^Cancel Line Item
 ;;^UTILITY(U,$J,"PRO",123,10,6,"^")
 ;;=PRCP ISSUE BOOK CANCEL LINE
 ;;^UTILITY(U,$J,"PRO",123,10,7,0)
 ;;=130^SL^24^^^Substitute Line Item
 ;;^UTILITY(U,$J,"PRO",123,10,7,"^")
 ;;=PRCP ISSUE BOOK SUBSTITUTE LINE
 ;;^UTILITY(U,$J,"PRO",123,10,8,0)
 ;;=131^PI^27^^^Post Issue Book
 ;;^UTILITY(U,$J,"PRO",123,10,8,"^")
 ;;=PRCP ISSUE BOOK POST
 ;;^UTILITY(U,$J,"PRO",123,10,9,0)
 ;;=132^MF^7^^^Make Final
 ;;^UTILITY(U,$J,"PRO",123,10,9,"^")
 ;;=PRCP ISSUE BOOK MAKE FINAL
 ;;^UTILITY(U,$J,"PRO",123,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",123,99)
 ;;=56083,30714
 ;;^UTILITY(U,$J,"PRO",124,0)
 ;;=PRCP ISSUE BOOK E/E ITEMS^E/E Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",124,1,0)
 ;;=^^3^3^2940120^
 ;;^UTILITY(U,$J,"PRO",124,1,1,0)
 ;;=This protocol allows the user to jump to the Enter/Edit Inventory Item
 ;;^UTILITY(U,$J,"PRO",124,1,2,0)
 ;;=data option, change inventory item data, and return to the posting of
 ;;^UTILITY(U,$J,"PRO",124,1,3,0)
 ;;=the issue book.
 ;;^UTILITY(U,$J,"PRO",124,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",124,20)
 ;;=D EEITEMS^PRCPWPL0
 ;;^UTILITY(U,$J,"PRO",124,99)
 ;;=56064,53720
 ;;^UTILITY(U,$J,"PRO",125,0)
 ;;=PRCP ISSUE BOOK QTY TO REMAIN^Qty (to post) to Remaining^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",125,1,0)
 ;;=^^3^3^2940111^
 ;;^UTILITY(U,$J,"PRO",125,1,1,0)
 ;;=This protocol will allow the user to set the quantity to post to the
 ;;^UTILITY(U,$J,"PRO",125,1,2,0)
 ;;=quantity remaining to post (outstanding quantity) for all line items
 ;;^UTILITY(U,$J,"PRO",125,1,3,0)
 ;;=on the issue book request.
 ;;^UTILITY(U,$J,"PRO",125,4)
 ;;=^^^QR
 ;;^UTILITY(U,$J,"PRO",125,20)
 ;;=D REMAIN^PRCPWPL0
 ;;^UTILITY(U,$J,"PRO",125,99)
 ;;=56064,53735
 ;;^UTILITY(U,$J,"PRO",126,0)
 ;;=PRCP ISSUE BOOK QTY TO ONHAND^Qty (to post) to On-Hand^^A^^^^^^^^GENERIC INVENTORY PACKAGE
