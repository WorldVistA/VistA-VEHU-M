NURCCG6G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2639,1,3,0)
 ;;=2642^think about swallowing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2639,1,4,0)
 ;;=2643^swallow^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2639,5)
 ;;=, i.e.,
 ;;^UTILITY("^GMRD(124.2,",$J,2639,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2639,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2639,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2640,0)
 ;;=move food to middle of tongue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2641,0)
 ;;=raise tongue to roof of mouth^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2642,0)
 ;;=think about swallowing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2643,0)
 ;;=swallow^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2644,0)
 ;;=actual loss^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2645,0)
 ;;=failure of regulatory mechanisms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2646,0)
 ;;=loss of fluids though abnormal routes (indwelling tubes)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2647,0)
 ;;=ear oximetry indicates oxygen saturation of 90% or greater^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2648,0)
 ;;=verbalizes/demonstrates physical conditioning techniques^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2648,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2648,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2649,0)
 ;;=Respiratory Therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2650,0)
 ;;=coordinating breathing with activity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2651,0)
 ;;=using pursed-lip breathing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2652,0)
 ;;=use of Home Oxygen Therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2653,0)
 ;;=using oral/inhaled bronchodialators (e.g., MDIs)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2654,0)
 ;;=skin color/texture during activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2654,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,2654,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2654,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2655,0)
 ;;=respiratory rate during activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2655,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,2655,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2655,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2656,0)
 ;;=utilizes management program^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2656,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2656,1,1,0)
 ;;=2657^suppository^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2656,1,2,0)
 ;;=2658^diet^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2656,1,3,0)
 ;;=2659^fluid intake [amount]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2656,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2656,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2656,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2656,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2657,0)
 ;;=suppository^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2658,0)
 ;;=diet^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2659,0)
 ;;=fluid intake [amount]^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2660,0)
 ;;=utilizes management program^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2660,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2660,1,1,0)
 ;;=2661^scheduled toileting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2660,1,2,0)
 ;;=2662^intermittent catherization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2660,1,3,0)
 ;;=2663^indwelling catheter^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2660,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2660,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2660,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2660,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2661,0)
 ;;=scheduled toileting^3^NURSC^^1^^^T
