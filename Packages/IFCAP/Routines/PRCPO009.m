PRCPO009 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",126,1,0)
 ;;=^^2^2^2940111^
 ;;^UTILITY(U,$J,"PRO",126,1,1,0)
 ;;=This protocol will allow the user to set the quantity to post to the
 ;;^UTILITY(U,$J,"PRO",126,1,2,0)
 ;;=current on-hand quantity in the warehouse inventory point.
 ;;^UTILITY(U,$J,"PRO",126,4)
 ;;=^^^QO
 ;;^UTILITY(U,$J,"PRO",126,20)
 ;;=D ONHAND^PRCPWPL0
 ;;^UTILITY(U,$J,"PRO",126,99)
 ;;=56064,53734
 ;;^UTILITY(U,$J,"PRO",127,0)
 ;;=PRCP ISSUE BOOK QTY TO ENTER^Qty (to post) Enter^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",127,1,0)
 ;;=^^2^2^2940111^
 ;;^UTILITY(U,$J,"PRO",127,1,1,0)
 ;;=This protocol allows the user to enter the quantity to post for each
 ;;^UTILITY(U,$J,"PRO",127,1,2,0)
 ;;=line item.
 ;;^UTILITY(U,$J,"PRO",127,4)
 ;;=^^^QE
 ;;^UTILITY(U,$J,"PRO",127,20)
 ;;=D ENTER^PRCPWPL0
 ;;^UTILITY(U,$J,"PRO",127,99)
 ;;=56064,53734
 ;;^UTILITY(U,$J,"PRO",128,0)
 ;;=PRCP ISSUE BOOK SHOW NSN^Show NSN^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",128,1,0)
 ;;=^^2^2^2940112^
 ;;^UTILITY(U,$J,"PRO",128,1,1,0)
 ;;=This protocol will allow the user to include the items NSN on the list
 ;;^UTILITY(U,$J,"PRO",128,1,2,0)
 ;;=manager's list.
 ;;^UTILITY(U,$J,"PRO",128,4)
 ;;=^^^SN
 ;;^UTILITY(U,$J,"PRO",128,20)
 ;;=D SHOWNSN^PRCPWPL0
 ;;^UTILITY(U,$J,"PRO",128,99)
 ;;=56064,53735
 ;;^UTILITY(U,$J,"PRO",129,0)
 ;;=PRCP ISSUE BOOK CANCEL LINE^Cancel Line Item^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",129,1,0)
 ;;=^^2^2^2940112^
 ;;^UTILITY(U,$J,"PRO",129,1,1,0)
 ;;=This protocol will allow the user to cancel a line item on the issue
 ;;^UTILITY(U,$J,"PRO",129,1,2,0)
 ;;=book request.
 ;;^UTILITY(U,$J,"PRO",129,4)
 ;;=^^^CL
 ;;^UTILITY(U,$J,"PRO",129,20)
 ;;=D CANCEL^PRCPWPL2
 ;;^UTILITY(U,$J,"PRO",129,99)
 ;;=56064,53720
 ;;^UTILITY(U,$J,"PRO",130,0)
 ;;=PRCP ISSUE BOOK SUBSTITUTE LINE^Substitute Line Item^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",130,1,0)
 ;;=^^3^3^2940112^
 ;;^UTILITY(U,$J,"PRO",130,1,1,0)
 ;;=This protocol will allow the user to substitute an item for an ordered
 ;;^UTILITY(U,$J,"PRO",130,1,2,0)
 ;;=item.  The line item will be cancelled and a new line item added to the
 ;;^UTILITY(U,$J,"PRO",130,1,3,0)
 ;;=issue book request.
 ;;^UTILITY(U,$J,"PRO",130,4)
 ;;=^^^SL
 ;;^UTILITY(U,$J,"PRO",130,20)
 ;;=D SUBST^PRCPWPL1
 ;;^UTILITY(U,$J,"PRO",130,99)
 ;;=56064,53736
 ;;^UTILITY(U,$J,"PRO",131,0)
 ;;=PRCP ISSUE BOOK POST^Post Issue Book^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",131,1,0)
 ;;=^^2^2^2940112^
 ;;^UTILITY(U,$J,"PRO",131,1,1,0)
 ;;=This protocol will allow the user to post the issue book to the primary
 ;;^UTILITY(U,$J,"PRO",131,1,2,0)
 ;;=inventory point.
 ;;^UTILITY(U,$J,"PRO",131,4)
 ;;=^^^PI
 ;;^UTILITY(U,$J,"PRO",131,20)
 ;;=D POST^PRCPWPL3
 ;;^UTILITY(U,$J,"PRO",131,99)
 ;;=56064,53721
 ;;^UTILITY(U,$J,"PRO",132,0)
 ;;=PRCP ISSUE BOOK MAKE FINAL^Make Final^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",132,1,0)
 ;;=^^1^1^2940113^
 ;;^UTILITY(U,$J,"PRO",132,1,1,0)
 ;;=This protocol will allow the user to make the issue book a final.
 ;;^UTILITY(U,$J,"PRO",132,4)
 ;;=^^^MF
 ;;^UTILITY(U,$J,"PRO",132,20)
 ;;=D FINAL^PRCPWPL2
 ;;^UTILITY(U,$J,"PRO",132,99)
 ;;=56064,53721
 ;;^UTILITY(U,$J,"PRO",133,0)
 ;;=PRCP RECEIVE ISSUE BOOK MENU^Issue Book Receiving^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",133,1,0)
 ;;=^^2^2^2940120^
 ;;^UTILITY(U,$J,"PRO",133,1,1,0)
 ;;=This is the top level menu for the protocol to Receive the Issue Book
 ;;^UTILITY(U,$J,"PRO",133,1,2,0)
 ;;=into the primary inventory point.
 ;;^UTILITY(U,$J,"PRO",133,4)
 ;;=26
 ;;^UTILITY(U,$J,"PRO",133,10,0)
 ;;=^101.01PA^4^4
 ;;^UTILITY(U,$J,"PRO",133,10,1,0)
 ;;=134^EE^1
 ;;^UTILITY(U,$J,"PRO",133,10,1,"^")
 ;;=PRCP RECEIVE ISSUE BOOK E/E ITEMS
 ;;^UTILITY(U,$J,"PRO",133,10,2,0)
 ;;=135^QE^11
 ;;^UTILITY(U,$J,"PRO",133,10,2,"^")
 ;;=PRCP RECEIVE ISSUE BOOK QTY TO ENTER
 ;;^UTILITY(U,$J,"PRO",133,10,3,0)
 ;;=136^QR^14
 ;;^UTILITY(U,$J,"PRO",133,10,3,"^")
 ;;=PRCP RECEIVE ISSUE BOOK QTY TO REMAIN
 ;;^UTILITY(U,$J,"PRO",133,10,4,0)
 ;;=137^RI^21
