NURCCG7I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3160,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3161,0)
 ;;=demonstrates health management strategies for [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3161,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3161,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3162,0)
 ;;=identifies support system/resources^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3162,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3162,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3163,0)
 ;;=conveys attitude of own worth/positive body image^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3163,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3163,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3164,0)
 ;;=assess knowledge of health state^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3164,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,3164,1,1,0)
 ;;=3165^medical diagnosis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3164,1,2,0)
 ;;=3166^illness prevention behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3164,1,3,0)
 ;;=3167^health promotion behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3164,1,4,0)
 ;;=3168^use of orthotic devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3164,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3164,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3164,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3165,0)
 ;;=medical diagnosis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3166,0)
 ;;=illness prevention behaviors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3167,0)
 ;;=health promotion behaviors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3168,0)
 ;;=use of orthotic devices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3169,0)
 ;;=provide protective environment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3169,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3169,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3170,0)
 ;;=teach safety precautions^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3170,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,3170,1,1,0)
 ;;=3171^environmental assessment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3170,1,2,0)
 ;;=3172^environmental management^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3170,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3170,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3170,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3171,0)
 ;;=environmental assessment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3172,0)
 ;;=environmental management^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3173,0)
 ;;=assess understanding of prescribed medication q [frequency]^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3173,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3173,1,1,0)
 ;;=3174^knowledge of reason for taking^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3173,1,2,0)
 ;;=3175^tactile/visual identification^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3173,1,3,0)
 ;;=3176^knowledge of side effects^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3173,1,4,0)
 ;;=3177^knowledge of schedule^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3173,1,5,0)
 ;;=3178^knowledge of adminstration techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3173,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3173,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3173,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3174,0)
 ;;=knowledge of reason for taking^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3175,0)
 ;;=tactile/visual identification^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3176,0)
 ;;=knowledge of side effects^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3177,0)
 ;;=knowledge of schedule^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3178,0)
 ;;=knowledge of adminstration techniques^3^NURSC^^1^^^T
