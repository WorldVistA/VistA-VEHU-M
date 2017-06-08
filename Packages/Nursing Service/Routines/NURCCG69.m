NURCCG69 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2551,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2551,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2552,0)
 ;;=maintains nutritional intake to meet metabolic requirements^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,1,0)
 ;;=2553^stable weight greater than [specify] lbs/kgs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,2,0)
 ;;=2554^stable weight less than [specify] lbs/kgs ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,3,0)
 ;;=2555^daily intake of [number of] calories^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,4,0)
 ;;=2556^balance between activity and caloric intake^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,5,0)
 ;;=2557^weight is + or - 20% of IBW; [lbs/kgs]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2552,1,6,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2552,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,2552,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2552,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2552,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2553,0)
 ;;=stable weight greater than [specify] lbs/kgs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2554,0)
 ;;=stable weight less than [specify] lbs/kgs ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2555,0)
 ;;=daily intake of [number of] calories^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2556,0)
 ;;=balance between activity and caloric intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2557,0)
 ;;=weight is + or - 20% of IBW; [lbs/kgs]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2558,0)
 ;;=absence of negative nitrogen balance indicators^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2559,0)
 ;;=identifies/procures food source^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2559,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2559,1,1,0)
 ;;=2560^public meal programs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2559,1,2,0)
 ;;=2561^family support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2559,1,3,0)
 ;;=2562^social welfare programs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2559,1,4,0)
 ;;=2563^self-care ability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2559,5)
 ;;=through:
 ;;^UTILITY("^GMRD(124.2,",$J,2559,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2559,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2559,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2560,0)
 ;;=public meal programs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2561,0)
 ;;=family support^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2562,0)
 ;;=social welfare programs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2563,0)
 ;;=self-care ability^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2564,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^63^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,1,0)
 ;;=2565^assess food source and abilities to prepare meals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,2,0)
 ;;=2566^assess eating patterns, satiety levels^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,4,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,5,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,6,0)
 ;;=2568^maintain activity level commensurate with caloric intake:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,7,0)
 ;;=2571^minimize noxious stimuli in environment^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,8,0)
 ;;=2572^restrict liquid intake to [ ]cc before meals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2564,1,9,0)
 ;;=2573^provide nourishment at [ ] am and [ ] pm^3^NURSC^1^0
