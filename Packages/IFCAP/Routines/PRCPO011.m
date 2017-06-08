PRCPO011 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
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
