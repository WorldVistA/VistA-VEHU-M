PRCPO012 ; ; 15-AUG-1994
 ;;5.0;IFCAP;;4/21/95
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",138,4)
 ;;=26^^^UB
 ;;^UTILITY(U,$J,"PRO",138,10,0)
 ;;=^101.01PA^3^3
 ;;^UTILITY(U,$J,"PRO",138,10,1,0)
 ;;=139^EE^1^^^E/E Inventory Items
 ;;^UTILITY(U,$J,"PRO",138,10,1,"^")
 ;;=PRCP UPLOAD BARCODE E/E ITEMS
 ;;^UTILITY(U,$J,"PRO",138,10,2,0)
 ;;=140^EQ^10^^^Edit Uploaded Qty
 ;;^UTILITY(U,$J,"PRO",138,10,2,"^")
 ;;=PRCP UPLOAD BARCODE EDIT QTY
 ;;^UTILITY(U,$J,"PRO",138,10,3,0)
 ;;=141^PI^20^^^Post Uploaded Items
 ;;^UTILITY(U,$J,"PRO",138,10,3,"^")
 ;;=PRCP UPLOAD BARCODE POST
 ;;^UTILITY(U,$J,"PRO",138,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",138,99)
 ;;=56064,53752
 ;;^UTILITY(U,$J,"PRO",139,0)
 ;;=PRCP UPLOAD BARCODE E/E ITEMS^E/E Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",139,1,0)
 ;;=^^3^3^2940203^^
 ;;^UTILITY(U,$J,"PRO",139,1,1,0)
 ;;=This protocol allows the user to jump to the Enter/Edit Inventory Item
 ;;^UTILITY(U,$J,"PRO",139,1,2,0)
 ;;=data option, change inventory item data, and return to the uploading
 ;;^UTILITY(U,$J,"PRO",139,1,3,0)
 ;;=of barcode data.
 ;;^UTILITY(U,$J,"PRO",139,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",139,20)
 ;;=D EEITEMS^PRCPBAL1
 ;;^UTILITY(U,$J,"PRO",139,99)
 ;;=56064,53751
 ;;^UTILITY(U,$J,"PRO",140,0)
 ;;=PRCP UPLOAD BARCODE EDIT QTY^Edit Uploaded Qty^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",140,1,0)
 ;;=^^2^2^2940203^
 ;;^UTILITY(U,$J,"PRO",140,1,1,0)
 ;;=This protocol allows the user to change the quantities for items which
 ;;^UTILITY(U,$J,"PRO",140,1,2,0)
 ;;=have been uploaded.
 ;;^UTILITY(U,$J,"PRO",140,4)
 ;;=^^^EQ
 ;;^UTILITY(U,$J,"PRO",140,20)
 ;;=D EDITQTY^PRCPBAL1
 ;;^UTILITY(U,$J,"PRO",140,99)
 ;;=56064,53751
 ;;^UTILITY(U,$J,"PRO",141,0)
 ;;=PRCP UPLOAD BARCODE POST^Post Uploaded Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",141,1,0)
 ;;=^^2^2^2940203^
 ;;^UTILITY(U,$J,"PRO",141,1,1,0)
 ;;=This protocol allows the user to post the uploaded quantities to the
 ;;^UTILITY(U,$J,"PRO",141,1,2,0)
 ;;=inventory point items.
 ;;^UTILITY(U,$J,"PRO",141,4)
 ;;=^^^PI
 ;;^UTILITY(U,$J,"PRO",141,20)
 ;;=D POST^PRCPBAL1
 ;;^UTILITY(U,$J,"PRO",141,99)
 ;;=56064,53752
