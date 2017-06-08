NURCCG9E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4945,1,2,0)
 ;;=4958^[Extra Goal]^3^NURSC^294
 ;;^UTILITY("^GMRD(124.2,",$J,4945,1,3,0)
 ;;=4961^[Extra Goal]^3^NURSC^295
 ;;^UTILITY("^GMRD(124.2,",$J,4945,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4946,0)
 ;;=[Extra Order]^3^NURSC^11^224^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4946,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4946,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4947,0)
 ;;=[Extra Goal]^3^NURSC^9^290^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4947,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4947,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4948,0)
 ;;=[Extra Goal]^3^NURSC^9^291^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4948,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4948,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4949,0)
 ;;=[Extra Goal]^3^NURSC^9^223^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4949,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4949,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4950,0)
 ;;=[etiology]^3^NURSC^^118^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4951,0)
 ;;=[Extra Goal]^3^NURSC^9^292^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4951,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4951,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^245^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,0)
 ;;=^124.21PI^9^7
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,1,0)
 ;;=4959^administer medications as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,2,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,3,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,4,0)
 ;;=4650^activity: chair q[frequency] or ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,5,0)
 ;;=4417^instruct patient to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,8,0)
 ;;=4971^teach patient pain management techniques^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,1,9,0)
 ;;=4975^[Extra Order]^3^NURSC^226
 ;;^UTILITY("^GMRD(124.2,",$J,4952,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4952,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4953,0)
 ;;=[etiology]^3^NURSC^^119^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4954,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^246^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4954,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4954,1,1,0)
 ;;=4963^[Extra Order]^3^NURSC^300
 ;;^UTILITY("^GMRD(124.2,",$J,4954,1,2,0)
 ;;=4964^[Extra Order]^3^NURSC^301
 ;;^UTILITY("^GMRD(124.2,",$J,4954,1,3,0)
 ;;=4965^[Extra Order]^3^NURSC^302
 ;;^UTILITY("^GMRD(124.2,",$J,4954,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4954,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4955,0)
 ;;=[etiology]^3^NURSC^^120^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4956,0)
 ;;=[Extra Goal]^3^NURSC^9^293^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4956,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4956,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4957,0)
 ;;=[Extra Order]^3^NURSC^11^297^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4957,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4957,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4958,0)
 ;;=[Extra Goal]^3^NURSC^9^294^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4958,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4958,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4959,0)
 ;;=administer medications as ordered^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4959,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4959,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4960,0)
 ;;=[Extra Order]^3^NURSC^11^298^^^T
