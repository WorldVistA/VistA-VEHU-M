NURCCG9W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5202,1,2,0)
 ;;=5205^evidence of development of complications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5202,1,3,0)
 ;;=5207^evidence of exacerbation of symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5202,1,4,0)
 ;;=5208^failure to keep appointments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5202,1,5,0)
 ;;=5226^failure to progress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5202,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5204,0)
 ;;=behavior indicative of failure to adhere^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5205,0)
 ;;=evidence of development of complications^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5207,0)
 ;;=evidence of exacerbation of symptoms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5208,0)
 ;;=failure to keep appointments^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5218,0)
 ;;=assist with use and care of respiratory equipment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5218,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5218,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5226,0)
 ;;=failure to progress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5338,0)
 ;;=[Extra Order]^3^NURSC^11^271^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5338,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5338,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5339,0)
 ;;=[Extra Problem]^2^NURSC^2^48^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5339,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5339,1,1,0)
 ;;=5340^Etiology/Related and/or Risk Factors^2^NURSC^252
 ;;^UTILITY("^GMRD(124.2,",$J,5339,1,2,0)
 ;;=5346^Goals/Expected Outcomes^2^NURSC^260
 ;;^UTILITY("^GMRD(124.2,",$J,5339,1,3,0)
 ;;=5352^Nursing Intervention/Orders^2^NURSC^261
 ;;^UTILITY("^GMRD(124.2,",$J,5339,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5339,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5339,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5340,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^252^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5340,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5340,1,1,0)
 ;;=5344^[etiology]^3^NURSC^131
 ;;^UTILITY("^GMRD(124.2,",$J,5340,1,2,0)
 ;;=5345^[etiology]^3^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,5340,1,3,0)
 ;;=5643^[etiology]^3^NURSC^82
 ;;^UTILITY("^GMRD(124.2,",$J,5340,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5341,0)
 ;;=[etiology]^3^NURSC^^130^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5344,0)
 ;;=[etiology]^3^NURSC^^131^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5345,0)
 ;;=[etiology]^3^NURSC^^132^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5346,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^260^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5346,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5346,1,1,0)
 ;;=5348^[Extra Goal]^3^NURSC^308
 ;;^UTILITY("^GMRD(124.2,",$J,5346,1,2,0)
 ;;=5349^[Extra Goal]^3^NURSC^309
 ;;^UTILITY("^GMRD(124.2,",$J,5346,1,3,0)
 ;;=5350^[Extra Goal]^3^NURSC^310
 ;;^UTILITY("^GMRD(124.2,",$J,5346,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5347,0)
 ;;=Urinary Elimination, Alteration In Pattern^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5347,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5347,1,1,0)
 ;;=5356^Goals/Expected Outcomes^2^NURSC^261
 ;;^UTILITY("^GMRD(124.2,",$J,5347,1,2,0)
 ;;=5378^Nursing Intervention/Orders^2^NURSC^262
 ;;^UTILITY("^GMRD(124.2,",$J,5347,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5347,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5347,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5348,0)
 ;;=[Extra Goal]^3^NURSC^9^308^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5348,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5348,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5349,0)
 ;;=[Extra Goal]^3^NURSC^9^309^^^T
