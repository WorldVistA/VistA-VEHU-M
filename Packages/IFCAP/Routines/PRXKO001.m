PRXKO001 ; ; 12-DEC-1995
 ;;5.0;IFCAP;**38**;4/21/95
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1746,0)
 ;;=PRCP ENTER/EDIT INVENTORY ITEMS MENU^E/E Inventory Items^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",1746,1,0)
 ;;=^^1^1^2951205^^
 ;;^UTILITY(U,$J,"PRO",1746,1,1,0)
 ;;=This protocol menu allows the user to add/edit the inventory item data.
 ;;^UTILITY(U,$J,"PRO",1746,4)
 ;;=26^^^EE
 ;;^UTILITY(U,$J,"PRO",1746,10,0)
 ;;=^101.01PA^2^12
 ;;^UTILITY(U,$J,"PRO",1746,10,5,0)
 ;;=1760^QT^12^^^Quantities
 ;;^UTILITY(U,$J,"PRO",1746,10,5,"^")
 ;;=PRCP EDIT QUANTITIES
 ;;^UTILITY(U,$J,"PRO",1746,10,8,0)
 ;;=1764^VN^26^^^Vendors
 ;;^UTILITY(U,$J,"PRO",1746,10,8,"^")
 ;;=PRCP EDIT SOURCES
 ;;^UTILITY(U,$J,"PRO",1746,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1746,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^"),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",1746,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1746,99)
 ;;=56586,30729
 ;;^UTILITY(U,$J,"PRO",1760,0)
 ;;=PRCP EDIT QUANTITIES^Edit Quantities^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",1760,1,0)
 ;;=^^2^2^2951205^^
 ;;^UTILITY(U,$J,"PRO",1760,1,1,0)
 ;;=This protocol allows the user to make adjustments to the inventory quantity
 ;;^UTILITY(U,$J,"PRO",1760,1,2,0)
 ;;=on-hand and total value.
 ;;^UTILITY(U,$J,"PRO",1760,4)
 ;;=^^^QT
 ;;^UTILITY(U,$J,"PRO",1760,20)
 ;;=D QUANTITY^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",1760,24)
 ;;=I PRCPTYPE'="W"
 ;;^UTILITY(U,$J,"PRO",1760,99)
 ;;=56376,31836
 ;;^UTILITY(U,$J,"PRO",1764,0)
 ;;=PRCP EDIT SOURCES^Edit Vendors^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",1764,1,0)
 ;;=^^1^1^2931020^
 ;;^UTILITY(U,$J,"PRO",1764,1,1,0)
 ;;=This protocol allows the user to edit the procurement sources for the item.
 ;;^UTILITY(U,$J,"PRO",1764,4)
 ;;=^^^VN
 ;;^UTILITY(U,$J,"PRO",1764,20)
 ;;=D SOURCES^PRCPEIL1
 ;;^UTILITY(U,$J,"PRO",1764,99)
 ;;=56586,30662
