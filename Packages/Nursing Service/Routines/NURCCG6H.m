NURCCG6H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2662,0)
 ;;=intermittent catherization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2663,0)
 ;;=indwelling catheter^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2664,0)
 ;;=remains free of urinary tract infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2664,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2664,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2665,0)
 ;;=pain^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2666,0)
 ;;=burning^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2667,0)
 ;;=frequency on voiding^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2668,0)
 ;;=proper catheter care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2669,0)
 ;;=describes control measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2669,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2669,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2670,0)
 ;;=achieves intact mucosa^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2670,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2670,1,1,0)
 ;;=1725^clean^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2670,1,2,0)
 ;;=1728^moist^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2670,1,3,0)
 ;;=1729^without lesions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2670,1,4,0)
 ;;=1731^without hardened crusts^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2670,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,2670,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2670,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2670,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2671,0)
 ;;=identifies preventive measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2671,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2671,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2672,0)
 ;;=demonstrates ability to manage wound care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2672,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2672,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2673,0)
 ;;=demonstrates abilty to direct care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2673,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2673,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2674,0)
 ;;=demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2674,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2674,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2675,0)
 ;;=develops a mechanism (system) for communication^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2675,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2675,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2676,0)
 ;;=demonstrates compensatory techniques (i.e., scanning)^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2676,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2676,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2677,0)
 ;;=reduce isolation with assistive/adaptive devices [example]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2677,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2677,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2678,0)
 ;;=lighting^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2679,0)
 ;;=rugs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2680,0)
 ;;=waxed floors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2681,0)
 ;;=grab bars^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2682,0)
 ;;=decrease noise^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2683,0)
 ;;=demonstrates ability to direct care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2683,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2683,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2684,0)
 ;;=triceps skin fold measurements is <25 mm (women)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2685,0)
 ;;=urine C&S is negative for infection^3^NURSC^9^1^^^T
