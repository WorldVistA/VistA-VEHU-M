PRCPO004 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",92,99)
 ;;=56064,53678
 ;;^UTILITY(U,$J,"PRO",93,0)
 ;;=PRCP EDIT ISSUE UNITS^Edit Issue Units^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",93,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",93,1,1,0)
 ;;=This protocol allows the user to edit the items issue units.
 ;;^UTILITY(U,$J,"PRO",93,4)
 ;;=^^^IU
 ;;^UTILITY(U,$J,"PRO",93,20)
 ;;=D ISSUNITS^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",93,99)
 ;;=56064,53679
 ;;^UTILITY(U,$J,"PRO",94,0)
 ;;=PRCP EDIT LEVELS^Edit Levels^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",94,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",94,1,1,0)
 ;;=This protocol allows the user to edit the items levels.
 ;;^UTILITY(U,$J,"PRO",94,4)
 ;;=^^^LE
 ;;^UTILITY(U,$J,"PRO",94,20)
 ;;=D LEVELS^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",94,99)
 ;;=56064,53679
 ;;^UTILITY(U,$J,"PRO",95,0)
 ;;=PRCP EDIT QUANTITIES^Edit Quantities^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",95,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",95,1,1,0)
 ;;=This protocol allows the user to make adjustments to the inventory quantity
 ;;^UTILITY(U,$J,"PRO",95,1,2,0)
 ;;=on-hand and total value.
 ;;^UTILITY(U,$J,"PRO",95,4)
 ;;=^^^QU
 ;;^UTILITY(U,$J,"PRO",95,20)
 ;;=D QUANTITY^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",95,24)
 ;;=I PRCPTYPE'="W"
 ;;^UTILITY(U,$J,"PRO",95,99)
 ;;=56064,53680
 ;;^UTILITY(U,$J,"PRO",96,0)
 ;;=PRCP EDIT DUEINS^Edit Due-Ins^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",96,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",96,1,1,0)
 ;;=This protocol allows the user to edit the items due-ins.
 ;;^UTILITY(U,$J,"PRO",96,4)
 ;;=^^^DI
 ;;^UTILITY(U,$J,"PRO",96,20)
 ;;=D DUEIN^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",96,24)
 ;;=I $$CHECK^PRCPEILM
 ;;^UTILITY(U,$J,"PRO",96,99)
 ;;=56064,53679
 ;;^UTILITY(U,$J,"PRO",97,0)
 ;;=PRCP EDIT SPECIAL PARAMETERS^Edit Special Parameters^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",97,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",97,1,1,0)
 ;;=This protocol allows the user to edit special miscellaneous item
 ;;^UTILITY(U,$J,"PRO",97,1,2,0)
 ;;=parameters.
 ;;^UTILITY(U,$J,"PRO",97,4)
 ;;=^^^SP
 ;;^UTILITY(U,$J,"PRO",97,20)
 ;;=D SPECIAL^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",97,99)
 ;;=56064,53681
 ;;^UTILITY(U,$J,"PRO",98,0)
 ;;=PRCP EDIT SOURCES^Edit Procurement Sources^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",98,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",98,1,1,0)
 ;;=This protocol allows the user to edit the procurement sources for the item.
 ;;^UTILITY(U,$J,"PRO",98,4)
 ;;=^^^PS
 ;;^UTILITY(U,$J,"PRO",98,20)
 ;;=D SOURCES^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",98,99)
 ;;=56064,53680
 ;;^UTILITY(U,$J,"PRO",99,0)
 ;;=PRCP EDIT DRUG ACCT^Edit Drug Accountability Parameters^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",99,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",99,1,1,0)
 ;;=This protocol allows the user to edit the drug accountability parameters.
 ;;^UTILITY(U,$J,"PRO",99,1,2,0)
 ;;=Before this protocol can be selected, the primary inventory point must be
 ;;^UTILITY(U,$J,"PRO",99,1,3,0)
 ;;=set up as a drug accountability inventory point.
 ;;^UTILITY(U,$J,"PRO",99,4)
 ;;=^^^DA
 ;;^UTILITY(U,$J,"PRO",99,20)
 ;;=D DRUGACCT^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",99,24)
 ;;=I $$CHECK^PRCPEILM,$P($G(^PRCP(445,PRCPINPT,0)),"^",20)="D"
 ;;^UTILITY(U,$J,"PRO",99,99)
 ;;=56064,53678
 ;;^UTILITY(U,$J,"PRO",100,0)
 ;;=PRCP EDIT ALL FIELDS^Edit All Fields^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",100,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",100,1,1,0)
 ;;=This protocol allows the user to edit all item data fields.  It is mostly
 ;;^UTILITY(U,$J,"PRO",100,1,2,0)
 ;;=used when adding new items to the inventory point.
 ;;^UTILITY(U,$J,"PRO",100,4)
 ;;=^^^AF
 ;;^UTILITY(U,$J,"PRO",100,20)
 ;;=D ALL^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",100,99)
 ;;=56064,53678
 ;;^UTILITY(U,$J,"PRO",101,0)
 ;;=PRCP EDIT REMOVE ITEM FROM INVPT^Delete Item From Inventory Point^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",101,1,0)
 ;;=^^1^1^2940812^^
 ;;^UTILITY(U,$J,"PRO",101,1,1,0)
 ;;=This protocol allows the user to remove an item from an inventory point.
