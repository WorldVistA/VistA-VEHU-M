NURCCGC8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9533,1,2,0)
 ;;=9535^stable weight:  [specify weight range] lbs/kgs ^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9533,1,3,0)
 ;;=9536^daily intake of [number of] calories, and [number of]cc/day^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9533,1,6,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9533,1,7,0)
 ;;=15288^healthy oral mucous membranes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9533,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,9533,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9533,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9533,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9534,0)
 ;;=stable weight [specify weight range]lbs/kgs, w/i 20% ideal^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9535,0)
 ;;=stable weight:  [specify weight range] lbs/kgs ^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9536,0)
 ;;=daily intake of [number of] calories, and [number of]cc/day^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9545,0)
 ;;=[Extra Goal]^3^NURSC^9^159^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9545,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9545,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^108^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,0)
 ;;=^124.21PI^25^23
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,1,0)
 ;;=2565^assess food source and abilities to prepare meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,2,0)
 ;;=2566^assess eating patterns, satiety levels^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,4,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,5,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,7,0)
 ;;=2571^minimize noxious stimuli in environment^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,8,0)
 ;;=2572^restrict liquid intake to [ ]cc before meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,10,0)
 ;;=2574^frequent cool clear liquids [ ]cc every [ ] hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,11,0)
 ;;=2575^elevate head to [ ] degrees for [ ] min. after meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,12,0)
 ;;=2576^provide rest periods after meals for [ ] hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,13,0)
 ;;=2577^provide financial resource contact for food purchase^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,14,0)
 ;;=9562^initiate consult(s):^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,15,0)
 ;;=2539^provide pt. education resources on nutrition as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,16,0)
 ;;=2581^teach suppression of vomiting reflex^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,17,0)
 ;;=9868^[Extra Order]^3^NURSC^166
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,18,0)
 ;;=2524^assess dietary habits^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,19,0)
 ;;=2599^assess factors contributing to increased food intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,20,0)
 ;;=2568^maintain activity level commensurate with caloric intake:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,21,0)
 ;;=2600^record caloric intake q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,22,0)
 ;;=2604^refer to support groups^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,23,0)
 ;;=2606^teach behavior modification techniques related to intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,24,0)
 ;;=2605^teach METS activities and progression of same^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,1,25,0)
 ;;=2629^oral hygiene before and after feedings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9546,9)
 ;;=D EN1^NURCCPU2
