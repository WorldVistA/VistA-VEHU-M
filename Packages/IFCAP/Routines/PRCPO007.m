PRCPO007 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",113,1,2,0)
 ;;=to the inventory point.
 ;;^UTILITY(U,$J,"PRO",113,4)
 ;;=^^^FC
 ;;^UTILITY(U,$J,"PRO",113,20)
 ;;=D FCP^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",113,24)
 ;;=I PRCPTYPE="W"!(PRCPTYPE="P")
 ;;^UTILITY(U,$J,"PRO",113,99)
 ;;=56064,53697
 ;;^UTILITY(U,$J,"PRO",114,0)
 ;;=PRCP INVENTORY EDIT DISTRPTS^Distribution Points^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",114,1,0)
 ;;=2
 ;;^UTILITY(U,$J,"PRO",114,1,1,0)
 ;;=This protocol allows the user to edit the distribution points assigned
 ;;^UTILITY(U,$J,"PRO",114,1,2,0)
 ;;=to the inventory point.
 ;;^UTILITY(U,$J,"PRO",114,4)
 ;;=^^^DP
 ;;^UTILITY(U,$J,"PRO",114,20)
 ;;=D DISTRPTS^PRCPENE2
 ;;^UTILITY(U,$J,"PRO",114,24)
 ;;=I PRCPTYPE="W"!(PRCPTYPE="P"&($G(PRCP("I"))))
 ;;^UTILITY(U,$J,"PRO",114,99)
 ;;=56064,53696
 ;;^UTILITY(U,$J,"PRO",115,0)
 ;;=PRCP INVENTORY EDIT MISCOST^MIS Costing^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",115,1,0)
 ;;=^^1^1^2940105^
 ;;^UTILITY(U,$J,"PRO",115,1,1,0)
 ;;=This protocol allows the user to edit the MIS costing section.
 ;;^UTILITY(U,$J,"PRO",115,4)
 ;;=^^^MC
 ;;^UTILITY(U,$J,"PRO",115,20)
 ;;=D MISCOST^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",115,24)
 ;;=I PRCPTYPE="P"!(PRCPTYPE="S")
 ;;^UTILITY(U,$J,"PRO",115,99)
 ;;=56064,53698
 ;;^UTILITY(U,$J,"PRO",116,0)
 ;;=PRCP INVENTORY EDIT USERS^Authorized Users^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",116,1,0)
 ;;=^^2^2^2940105^
 ;;^UTILITY(U,$J,"PRO",116,1,1,0)
 ;;=This protocol allows the user to give authorized users access to the
 ;;^UTILITY(U,$J,"PRO",116,1,2,0)
 ;;=inventory point.
 ;;^UTILITY(U,$J,"PRO",116,4)
 ;;=^^^AU
 ;;^UTILITY(U,$J,"PRO",116,20)
 ;;=D USERS^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",116,99)
 ;;=56064,53699
 ;;^UTILITY(U,$J,"PRO",117,0)
 ;;=PRCP INVENTORY EDIT STOCKEDBY^Stocked By^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",117,1,0)
 ;;=^^2^2^2940105^
 ;;^UTILITY(U,$J,"PRO",117,1,1,0)
 ;;=This protocol allows the user to add/delete inventory points which
 ;;^UTILITY(U,$J,"PRO",117,1,2,0)
 ;;=stock this inventory point.
 ;;^UTILITY(U,$J,"PRO",117,4)
 ;;=^^^SB
 ;;^UTILITY(U,$J,"PRO",117,20)
 ;;=D STOCKED^PRCPENE2
 ;;^UTILITY(U,$J,"PRO",117,24)
 ;;=I PRCPTYPE'="W"
 ;;^UTILITY(U,$J,"PRO",117,99)
 ;;=56064,53699
 ;;^UTILITY(U,$J,"PRO",118,0)
 ;;=PRCP INVENTORY EDIT FLAGS^Flags^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",118,1,0)
 ;;=^^3^3^2940106^
 ;;^UTILITY(U,$J,"PRO",118,1,1,0)
 ;;=This protocol allows the user to edit the inventory flags which include
 ;;^UTILITY(U,$J,"PRO",118,1,2,0)
 ;;=the emergency stock level, automatic purge, and regular whse issues due
 ;;^UTILITY(U,$J,"PRO",118,1,3,0)
 ;;=date.
 ;;^UTILITY(U,$J,"PRO",118,4)
 ;;=^^^FL
 ;;^UTILITY(U,$J,"PRO",118,20)
 ;;=D FLAGS^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",118,99)
 ;;=56064,53697
 ;;^UTILITY(U,$J,"PRO",119,0)
 ;;=PRCP PURCHASE ORDER RECEIPT MENU^Purchase Order Receipt Menu^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",119,1,0)
 ;;=^^2^2^2940126^
 ;;^UTILITY(U,$J,"PRO",119,1,1,0)
 ;;=This protocol is the main protocol for receiving purchase orders into
 ;;^UTILITY(U,$J,"PRO",119,1,2,0)
 ;;=the inventory point.
 ;;^UTILITY(U,$J,"PRO",119,4)
 ;;=26^^^PO
 ;;^UTILITY(U,$J,"PRO",119,10,0)
 ;;=^101.01PA^3^3
 ;;^UTILITY(U,$J,"PRO",119,10,1,0)
 ;;=120^RO^^^^Receive Order
 ;;^UTILITY(U,$J,"PRO",119,10,1,"^")
 ;;=PRCP PURCHASE ORDER RECEIVE
 ;;^UTILITY(U,$J,"PRO",119,10,2,0)
 ;;=121^DC^1^^^Distribution Cost
 ;;^UTILITY(U,$J,"PRO",119,10,2,"^")
 ;;=PRCP PURCHASE ORDER DIST COST
 ;;^UTILITY(U,$J,"PRO",119,10,3,0)
 ;;=122^EE^4^^^E/E Inventory Item
 ;;^UTILITY(U,$J,"PRO",119,10,3,"^")
 ;;=PRCP PURCHASE ORDER E/E ITEMS
 ;;^UTILITY(U,$J,"PRO",119,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",119,99)
 ;;=56064,53742
 ;;^UTILITY(U,$J,"PRO",120,0)
 ;;=PRCP PURCHASE ORDER RECEIVE^Receive Order^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",120,1,0)
 ;;=^^2^2^2940107^
 ;;^UTILITY(U,$J,"PRO",120,1,1,0)
 ;;=This protocol allows the user to receive the purchase order into the
 ;;^UTILITY(U,$J,"PRO",120,1,2,0)
 ;;=inventory point.
