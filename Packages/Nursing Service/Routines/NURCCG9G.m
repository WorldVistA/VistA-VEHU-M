NURCCG9G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4977,1,3,0)
 ;;=5014^[etiology]^3^NURSC^49
 ;;^UTILITY("^GMRD(124.2,",$J,4977,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4978,0)
 ;;=[etiology]^3^NURSC^^109^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4979,0)
 ;;=Pain, Acute^2^NURSC^2^17^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4979,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4979,1,1,0)
 ;;=4989^Goals/Expected Outcomes^2^NURSC^247
 ;;^UTILITY("^GMRD(124.2,",$J,4979,1,2,0)
 ;;=4994^Nursing Intervention/Orders^2^NURSC^248
 ;;^UTILITY("^GMRD(124.2,",$J,4979,1,3,0)
 ;;=2763^Etiology/Related and/or Risk Factors^2^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,4979,1,4,0)
 ;;=4205^Defining Characteristics^2^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,4979,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4979,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4979,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4980,0)
 ;;=[etiology]^3^NURSC^^110^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4981,0)
 ;;=[etiology]^3^NURSC^^111^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4982,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^246^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4982,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4982,1,1,0)
 ;;=4985^[Extra Goal]^3^NURSC^296
 ;;^UTILITY("^GMRD(124.2,",$J,4982,1,2,0)
 ;;=4986^[Extra Goal]^3^NURSC^297
 ;;^UTILITY("^GMRD(124.2,",$J,4982,1,3,0)
 ;;=4987^[Extra Goal]^3^NURSC^298
 ;;^UTILITY("^GMRD(124.2,",$J,4982,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4984,0)
 ;;=Angina/Chest Pain^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4984,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4984,1,1,0)
 ;;=4359^Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4984,1,2,0)
 ;;=5030^Pain, Chest^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4984,1,3,0)
 ;;=5051^[Extra Problem]^2^NURSC^47
 ;;^UTILITY("^GMRD(124.2,",$J,4985,0)
 ;;=[Extra Goal]^3^NURSC^9^296^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4985,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4985,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4986,0)
 ;;=[Extra Goal]^3^NURSC^9^297^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4986,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4986,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4987,0)
 ;;=[Extra Goal]^3^NURSC^9^298^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4987,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4987,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4988,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^247^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4988,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4988,1,1,0)
 ;;=4990^[Extra Order]^3^NURSC^303
 ;;^UTILITY("^GMRD(124.2,",$J,4988,1,2,0)
 ;;=4991^[Extra Order]^3^NURSC^304
 ;;^UTILITY("^GMRD(124.2,",$J,4988,1,3,0)
 ;;=4992^[Extra Order]^3^NURSC^305
 ;;^UTILITY("^GMRD(124.2,",$J,4988,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4988,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4989,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^247^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4989,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4989,1,1,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4989,1,2,0)
 ;;=5046^[Extra Goal]^3^NURSC^39
 ;;^UTILITY("^GMRD(124.2,",$J,4989,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4990,0)
 ;;=[Extra Order]^3^NURSC^11^303^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4990,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4990,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4991,0)
 ;;=[Extra Order]^3^NURSC^11^304^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4991,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4991,10)
 ;;=D EN1^NURCCPU3
