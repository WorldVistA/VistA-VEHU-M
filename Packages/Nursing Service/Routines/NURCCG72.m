NURCCG72 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2935,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2936,0)
 ;;=[Extra Goal]^3^NURSC^9^117^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2936,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2936,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2937,0)
 ;;=ABGs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2938,0)
 ;;=assess knowledge base^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2939,0)
 ;;=determine ability to learn and implement plan^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2940,0)
 ;;=decide what patient needs to know^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2941,0)
 ;;=evaluate effectiveness of teaching plan^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2942,0)
 ;;=implement teaching plan based on readiness/ability to learn^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2943,0)
 ;;=involve S/O in teaching plan^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2944,0)
 ;;=PT/PTT^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2945,0)
 ;;=call light^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2946,0)
 ;;=provide privacy^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2947,0)
 ;;=avoid constrictive clothing^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2948,0)
 ;;=apply antiemboli hose^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2949,0)
 ;;=ABGs^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2950,0)
 ;;=hematocrit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2951,0)
 ;;=hemoglobin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2952,0)
 ;;=temperature per[route] q[ frequency ]^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2953,0)
 ;;=[Extra Order]^3^NURSC^11^23^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2953,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2953,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2954,0)
 ;;=[Extra Order]^3^NURSC^11^26^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2954,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2954,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2955,0)
 ;;=[Extra Order]^3^NURSC^11^27^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2955,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2955,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2956,0)
 ;;=[Extra Order]^3^NURSC^11^28^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2956,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2956,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2957,0)
 ;;=[Extra Order]^3^NURSC^11^31^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2957,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2957,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2958,0)
 ;;=[Extra Order]^3^NURSC^11^32^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2958,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2958,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2959,0)
 ;;=[Extra Order]^3^NURSC^11^36^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2959,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2959,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2960,0)
 ;;=[Extra Order]^3^NURSC^11^37^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2960,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2960,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2961,0)
 ;;=[Extra Order]^3^NURSC^11^38^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2961,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2961,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2962,0)
 ;;=[Extra Order]^3^NURSC^11^39^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2962,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2962,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2963,0)
 ;;=[Extra Order]^3^NURSC^11^40^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2963,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2963,10)
 ;;=D EN1^NURCCPU3
