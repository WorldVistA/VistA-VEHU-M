NURCCG9D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4929,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4930,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^239^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4930,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4930,1,1,0)
 ;;=2777^immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4930,1,2,0)
 ;;=4932^weakness/fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4930,1,3,0)
 ;;=4933^inflammatory injury process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4930,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4931,0)
 ;;=[Extra Order]^3^NURSC^11^25^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4931,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4931,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4932,0)
 ;;=weakness/fatigue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4933,0)
 ;;=inflammatory injury process^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4934,0)
 ;;=[Extra Order]^3^NURSC^11^17^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4934,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4934,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4936,0)
 ;;=identifies situations that contribute to loss of control^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4936,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4936,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4937,0)
 ;;=[Extra Problem]^2^NURSC^2^46^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4937,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4937,1,1,0)
 ;;=4939^Etiology/Related and/or Risk Factors^2^NURSC^240
 ;;^UTILITY("^GMRD(124.2,",$J,4937,1,2,0)
 ;;=4945^Goals/Expected Outcomes^2^NURSC^245
 ;;^UTILITY("^GMRD(124.2,",$J,4937,1,3,0)
 ;;=4954^Nursing Intervention/Orders^2^NURSC^246
 ;;^UTILITY("^GMRD(124.2,",$J,4937,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4937,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4937,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4938,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^244^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4938,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4938,1,1,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4938,1,2,0)
 ;;=2796^verbalizes comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4938,1,3,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4938,1,4,0)
 ;;=2789^verbalizes when in pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4938,1,5,0)
 ;;=4949^[Extra Goal]^3^NURSC^223
 ;;^UTILITY("^GMRD(124.2,",$J,4938,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4939,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^240^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4939,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4939,1,1,0)
 ;;=4953^[etiology]^3^NURSC^119
 ;;^UTILITY("^GMRD(124.2,",$J,4939,1,2,0)
 ;;=4955^[etiology]^3^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,4939,1,3,0)
 ;;=4968^[etiology]^3^NURSC^27
 ;;^UTILITY("^GMRD(124.2,",$J,4939,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4940,0)
 ;;=[etiology]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4941,0)
 ;;=[Extra Goal]^3^NURSC^9^14^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4941,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4941,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4942,0)
 ;;=[etiology]^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4943,0)
 ;;=[etiology]^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4944,0)
 ;;=teach methods/skills to control/redirect angry feelings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4944,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4944,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4945,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^245^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4945,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4945,1,1,0)
 ;;=4956^[Extra Goal]^3^NURSC^293
