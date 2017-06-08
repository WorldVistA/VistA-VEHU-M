NURCCG6A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,10,0)
 ;;=2574^frequent cool clear liquids [ ]cc every [ ] hours^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,11,0)
 ;;=2575^elevate head to [ ] degrees for [ ] min. after meals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,12,0)
 ;;=2576^provide rest periods after meals for [ ] hours^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,13,0)
 ;;=2577^provide financial resource contact for food purchase^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,14,0)
 ;;=2578^initiate consult(s)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,15,0)
 ;;=2539^provide pt. education resources on nutrition as needed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,16,0)
 ;;=2581^teach suppression of vomiting reflex^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,17,0)
 ;;=3019^[Extra Order]^3^NURSC^105^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2564,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2565,0)
 ;;=assess food source and abilities to prepare meals^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2565,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2565,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2566,0)
 ;;=assess eating patterns, satiety levels^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2566,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2566,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2567,0)
 ;;=assess need for calorie count q[specify frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2567,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2567,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2568,0)
 ;;=maintain activity level commensurate with caloric intake:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2568,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,2568,1,1,0)
 ;;=2569^maintain activity level; increase calories to [#] cal/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2568,1,2,0)
 ;;=2570^decrease activity level; maintain calories at [#] cal/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2568,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2568,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2568,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2568,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2569,0)
 ;;=maintain activity level; increase calories to [#] cal/day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2570,0)
 ;;=decrease activity level; maintain calories at [#] cal/day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2571,0)
 ;;=minimize noxious stimuli in environment^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2571,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2571,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2572,0)
 ;;=restrict liquid intake to [ ]cc before meals^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2572,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2572,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2573,0)
 ;;=provide nourishment at [ ] am and [ ] pm^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2573,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2573,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2574,0)
 ;;=frequent cool clear liquids [ ]cc every [ ] hours^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2574,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2574,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2575,0)
 ;;=elevate head to [ ] degrees for [ ] min. after meals^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2575,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2575,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2576,0)
 ;;=provide rest periods after meals for [ ] hours^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2576,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2576,10)
 ;;=D EN1^NURCCPU3
