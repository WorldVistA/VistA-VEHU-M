NURCCG9A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4887,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4888,0)
 ;;=[Extra Order]^3^NURSC^11^20^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4888,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4888,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4889,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^241^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4889,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4889,1,1,0)
 ;;=4922^[Extra Order]^3^NURSC^294
 ;;^UTILITY("^GMRD(124.2,",$J,4889,1,2,0)
 ;;=4923^[Extra Order]^3^NURSC^295
 ;;^UTILITY("^GMRD(124.2,",$J,4889,1,3,0)
 ;;=4924^[Extra Order]^3^NURSC^296
 ;;^UTILITY("^GMRD(124.2,",$J,4889,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4889,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4890,0)
 ;;=controls impulsive behavior dictated by psychosis^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4890,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4890,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4891,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^13^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4891,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4891,1,1,0)
 ;;=4894^Etiology/Related and/or Risk Factors^2^NURSC^237
 ;;^UTILITY("^GMRD(124.2,",$J,4891,1,2,0)
 ;;=4897^Goals/Expected Outcomes^2^NURSC^241
 ;;^UTILITY("^GMRD(124.2,",$J,4891,1,3,0)
 ;;=4920^Nursing Intervention/Orders^2^NURSC^244
 ;;^UTILITY("^GMRD(124.2,",$J,4891,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4891,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4891,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4892,0)
 ;;=identifies psychotic thoughts^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4892,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4892,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4893,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^236^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4893,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4893,1,1,0)
 ;;=4942^[etiology]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4893,1,2,0)
 ;;=4943^[etiology]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4893,1,3,0)
 ;;=4950^[etiology]^3^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,4893,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4894,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^237^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4894,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4894,1,1,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4894,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4896,0)
 ;;=[etiology]^3^NURSC^^94^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4897,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^241^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4897,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,4897,1,2,0)
 ;;=4905^hemodynamically stable^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4897,1,3,0)
 ;;=4915^[Extra Goal]^3^NURSC^222
 ;;^UTILITY("^GMRD(124.2,",$J,4897,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4898,0)
 ;;=communicates to staff feelings of loss of control^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4898,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4898,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4899,0)
 ;;=[etiology]^3^NURSC^^95^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4900,0)
 ;;=[etiology]^3^NURSC^^96^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4901,0)
 ;;=[Extra Goal]^3^NURSC^9^221^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4901,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4901,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4902,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^238^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4902,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4902,1,1,0)
 ;;=1851^situational crises^3^NURSC^1
