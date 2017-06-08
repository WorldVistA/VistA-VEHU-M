NURCCG66 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2514,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2514,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2514,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2514,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2515,0)
 ;;=obtain [#] meals per day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2516,0)
 ;;=prepare [#] meals per day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2517,0)
 ;;=consume [#] meals per day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2518,0)
 ;;=displays increased social interaction at meals with S/O^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2518,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2518,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2519,0)
 ;;=describes rationale for (nutritional) treatment plan^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2519,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2519,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2520,0)
 ;;=selects menu within dietary restrictions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2520,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2520,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2521,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^62^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,1,0)
 ;;=2522^assess factors contributing to change in appetite^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,2,0)
 ;;=2523^assess oral cavity q [frequency] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,3,0)
 ;;=2524^assess dietary habits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,4,0)
 ;;=2525^minimize noxious stimuli in environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,5,0)
 ;;=2526^avoid painful experiences immediately before meals^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,6,0)
 ;;=2527^provide rest periods [ ] min. [number of times] per day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,7,0)
 ;;=2528^select menu within dietary restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,8,0)
 ;;=2529^provide food likes [describe]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,9,0)
 ;;=2530^oral hygiene q[frequency]hrs^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,10,0)
 ;;=2531^offer food non-irritating to oral mucous membrane^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,11,0)
 ;;=2535^increase social support systems during mealtime^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,12,0)
 ;;=2539^provide pt. education resources on nutrition as needed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,13,0)
 ;;=2540^explain rationale for type and schedule of food service^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,14,0)
 ;;=2541^Dietetic Consult^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,1,15,0)
 ;;=3018^[Extra Order]^3^NURSC^104^0
 ;;^UTILITY("^GMRD(124.2,",$J,2521,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2521,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2522,0)
 ;;=assess factors contributing to change in appetite^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2522,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2522,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2523,0)
 ;;=assess oral cavity q [frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2523,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2523,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2524,0)
 ;;=assess dietary habits^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2524,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2524,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2525,0)
 ;;=minimize noxious stimuli in environment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2525,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2525,10)
 ;;=D EN1^NURCCPU3
