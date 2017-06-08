NURCCGA3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5600,0)
 ;;=delays seeking or refuses health care attentioon^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5601,0)
 ;;=[Extra Goal]^3^NURSC^9^312^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5601,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5601,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5602,0)
 ;;=does not perceive personal relevance of symptoms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5603,0)
 ;;=[Extra Goal]^3^NURSC^9^313^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5603,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5603,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5604,0)
 ;;=teach risk factors for urinary tract infection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5604,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5604,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5605,0)
 ;;=[Extra Order]^3^NURSC^11^318^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5605,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5605,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5606,0)
 ;;=[Extra Order]^3^NURSC^11^319^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5606,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5606,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5607,0)
 ;;=assess adequacy of personal hygiene^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5607,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5607,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5610,0)
 ;;=[Extra Order]^3^NURSC^11^320^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5610,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5610,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5614,0)
 ;;=[Extra Order]^3^NURSC^11^44^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5614,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5614,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5643,0)
 ;;=[etiology]^3^NURSC^^82^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5665,0)
 ;;=[Extra Problem]^2^NURSC^2^13^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5665,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5665,1,1,0)
 ;;=5771^Goals/Expected Outcomes^2^NURSC^264
 ;;^UTILITY("^GMRD(124.2,",$J,5665,1,2,0)
 ;;=5776^Nursing Intervention/Orders^2^NURSC^266
 ;;^UTILITY("^GMRD(124.2,",$J,5665,1,3,0)
 ;;=15691^Etiology/Related and/or Risk Factors^2^NURSC^300
 ;;^UTILITY("^GMRD(124.2,",$J,5665,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5665,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5665,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5677,0)
 ;;=[etiology]^3^NURSC^^83^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5693,0)
 ;;=[etiology]^3^NURSC^^84^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5771,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^264^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5771,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5771,1,1,0)
 ;;=5773^[Extra Goal]^3^NURSC^314
 ;;^UTILITY("^GMRD(124.2,",$J,5771,1,2,0)
 ;;=5774^[Extra Goal]^3^NURSC^315
 ;;^UTILITY("^GMRD(124.2,",$J,5771,1,3,0)
 ;;=5775^[Extra Goal]^3^NURSC^316
 ;;^UTILITY("^GMRD(124.2,",$J,5771,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5773,0)
 ;;=[Extra Goal]^3^NURSC^9^314^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5773,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5773,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5774,0)
 ;;=[Extra Goal]^3^NURSC^9^315^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5774,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5774,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5775,0)
 ;;=[Extra Goal]^3^NURSC^9^316^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5775,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5775,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5776,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^266^1^^T
