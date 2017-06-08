NURCCG67 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2526,0)
 ;;=avoid painful experiences immediately before meals^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2526,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2526,1,1,0)
 ;;=1815^dressing changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2526,1,2,0)
 ;;=2756^treatments^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2526,1,3,0)
 ;;=635^therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2526,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2526,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2526,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2526,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2527,0)
 ;;=provide rest periods [ ] min. [number of times] per day^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2527,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2527,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2528,0)
 ;;=select menu within dietary restrictions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2528,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2528,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2529,0)
 ;;=provide food likes [describe]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2529,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2529,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2530,0)
 ;;=oral hygiene q[frequency]hrs^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2530,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2530,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2531,0)
 ;;=offer food non-irritating to oral mucous membrane^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2531,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2531,1,1,0)
 ;;=2532^cold foods [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2531,1,2,0)
 ;;=2533^non-spicy [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2531,1,3,0)
 ;;=2534^non-acidic [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2531,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2531,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2531,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2531,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2532,0)
 ;;=cold foods [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2533,0)
 ;;=non-spicy [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2534,0)
 ;;=non-acidic [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2535,0)
 ;;=increase social support systems during mealtime^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2535,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2535,1,1,0)
 ;;=2536^staff member present during mealtime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2535,1,2,0)
 ;;=2537^family or S/O present during mealtime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2535,1,3,0)
 ;;=2538^patients/volunteers present during mealtime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2535,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,2535,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2535,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2535,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2536,0)
 ;;=staff member present during mealtime^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2537,0)
 ;;=family or S/O present during mealtime^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2538,0)
 ;;=patients/volunteers present during mealtime^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2539,0)
 ;;=provide pt. education resources on nutrition as needed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2539,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2539,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2540,0)
 ;;=explain rationale for type and schedule of food service^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2540,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2540,10)
 ;;=D EN1^NURCCPU3
