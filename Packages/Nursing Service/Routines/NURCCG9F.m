NURCCG9F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4960,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4960,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4961,0)
 ;;=[Extra Goal]^3^NURSC^9^295^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4961,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4961,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4962,0)
 ;;=[Extra Order]^3^NURSC^11^299^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4962,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4962,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4963,0)
 ;;=[Extra Order]^3^NURSC^11^300^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4963,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4963,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4964,0)
 ;;=[Extra Order]^3^NURSC^11^301^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4964,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4964,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4965,0)
 ;;=[Extra Order]^3^NURSC^11^302^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4965,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4965,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4966,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^241^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4966,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4966,1,1,0)
 ;;=4969^[etiology]^3^NURSC^28
 ;;^UTILITY("^GMRD(124.2,",$J,4966,1,2,0)
 ;;=4970^[etiology]^3^NURSC^29
 ;;^UTILITY("^GMRD(124.2,",$J,4966,1,3,0)
 ;;=4978^[etiology]^3^NURSC^109
 ;;^UTILITY("^GMRD(124.2,",$J,4966,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4967,0)
 ;;=[Extra Order]^3^NURSC^11^225^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4967,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4967,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4968,0)
 ;;=[etiology]^3^NURSC^^27^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4969,0)
 ;;=[etiology]^3^NURSC^^28^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4970,0)
 ;;=[etiology]^3^NURSC^^29^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4971,0)
 ;;=teach patient pain management techniques^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4971,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4971,1,1,0)
 ;;=4972^positioning to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4971,1,2,0)
 ;;=4606^purpose/use of analgesics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4971,1,3,0)
 ;;=4973^splinting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4971,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4971,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4971,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4972,0)
 ;;=positioning to decrease pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4973,0)
 ;;=splinting^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4975,0)
 ;;=[Extra Order]^3^NURSC^11^226^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4975,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4975,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4976,0)
 ;;=[Extra Problem]^2^NURSC^2^7^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4976,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4976,1,1,0)
 ;;=4977^Etiology/Related and/or Risk Factors^2^NURSC^242
 ;;^UTILITY("^GMRD(124.2,",$J,4976,1,2,0)
 ;;=4982^Goals/Expected Outcomes^2^NURSC^246
 ;;^UTILITY("^GMRD(124.2,",$J,4976,1,3,0)
 ;;=4988^Nursing Intervention/Orders^2^NURSC^247
 ;;^UTILITY("^GMRD(124.2,",$J,4976,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4976,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4976,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4977,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^242^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4977,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4977,1,1,0)
 ;;=4980^[etiology]^3^NURSC^110
 ;;^UTILITY("^GMRD(124.2,",$J,4977,1,2,0)
 ;;=4981^[etiology]^3^NURSC^111
