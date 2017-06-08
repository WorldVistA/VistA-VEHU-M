PRCPO010 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",133,10,4,"^")
 ;;=PRCP RECEIVE ISSUE BOOK RECEIVING
 ;;^UTILITY(U,$J,"PRO",133,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",133,99)
 ;;=56064,53747
 ;;^UTILITY(U,$J,"PRO",134,0)
 ;;=PRCP RECEIVE ISSUE BOOK E/E ITEMS^E/E Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",134,1,0)
 ;;=^^3^3^2940120^
 ;;^UTILITY(U,$J,"PRO",134,1,1,0)
 ;;=This protocol allows the user to jump the the Enter/Edit Inventory Item
 ;;^UTILITY(U,$J,"PRO",134,1,2,0)
 ;;=data option, change inventory item data, and return to the receiving of
 ;;^UTILITY(U,$J,"PRO",134,1,3,0)
 ;;=the issue book.
 ;;^UTILITY(U,$J,"PRO",134,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",134,20)
 ;;=D EEITEMS^PRCPWPP0
 ;;^UTILITY(U,$J,"PRO",134,99)
 ;;=56064,53743
 ;;^UTILITY(U,$J,"PRO",135,0)
 ;;=PRCP RECEIVE ISSUE BOOK QTY TO ENTER^Qty (Receive) Enter^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",135,1,0)
 ;;=^^2^2^2940120^^
 ;;^UTILITY(U,$J,"PRO",135,1,1,0)
 ;;=This protocol allows the user to enter the quantity to receive for each
 ;;^UTILITY(U,$J,"PRO",135,1,2,0)
 ;;=line item.
 ;;^UTILITY(U,$J,"PRO",135,4)
 ;;=^^^QE
 ;;^UTILITY(U,$J,"PRO",135,20)
 ;;=D ENTER^PRCPWPP0
 ;;^UTILITY(U,$J,"PRO",135,99)
 ;;=56064,53747
 ;;^UTILITY(U,$J,"PRO",136,0)
 ;;=PRCP RECEIVE ISSUE BOOK QTY TO REMAIN^Qty (Receive) to Remain^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",136,1,0)
 ;;=^^3^3^2940120^^^^
 ;;^UTILITY(U,$J,"PRO",136,1,1,0)
 ;;=This protocol will allow the user to set the quantity to receive to the
 ;;^UTILITY(U,$J,"PRO",136,1,2,0)
 ;;=difference between the quantity posted by the warehouse and the quantity
 ;;^UTILITY(U,$J,"PRO",136,1,3,0)
 ;;=received by the primary.
 ;;^UTILITY(U,$J,"PRO",136,4)
 ;;=^^^QR
 ;;^UTILITY(U,$J,"PRO",136,20)
 ;;=D REMAIN^PRCPWPP0
 ;;^UTILITY(U,$J,"PRO",136,99)
 ;;=56064,53747
 ;;^UTILITY(U,$J,"PRO",137,0)
 ;;=PRCP RECEIVE ISSUE BOOK RECEIVING^Receive Issue Book^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",137,1,0)
 ;;=^^2^2^2940120^^^
 ;;^UTILITY(U,$J,"PRO",137,1,1,0)
 ;;=This protocol will allow the user to receive the issue book into the
 ;;^UTILITY(U,$J,"PRO",137,1,2,0)
 ;;=primary inventory point.
 ;;^UTILITY(U,$J,"PRO",137,4)
 ;;=^^^RI
 ;;^UTILITY(U,$J,"PRO",137,20)
 ;;=D RECEIVE^PRCPWPP3
 ;;^UTILITY(U,$J,"PRO",137,99)
 ;;=56064,53747
 ;;^UTILITY(U,$J,"PRO",138,0)
 ;;=PRCP UPLOAD BARCODE DATA MENU^Upload Barcode Data Menu^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",138,1,0)
 ;;=^^1^1^2950224^^
 ;;^UTILITY(U,$J,"PRO",138,1,1,0)
 ;;=This protocol controls the barcode upload for physical counts and usage.
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
