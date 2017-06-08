NURCCG7E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,1,0)
 ;;=3118^utilization of energy conservation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,2,0)
 ;;=3119^willingness to ask for help and/or delegate tasks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,3,0)
 ;;=3120^incorporation of a rest period into daily activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,4,0)
 ;;=3121^resumption of daily routine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,5,0)
 ;;=3122^increased interest in surroundings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,6,0)
 ;;=3226^maintains usual sleep-rest/activity cycle as appropriate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,7,0)
 ;;=3227^verbalizes having adequate energy to perform tasks^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,8,0)
 ;;=3228^does not sustain physical injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3117,1,9,0)
 ;;=16554^[Extra Goal]^3^NURSC^424
 ;;^UTILITY("^GMRD(124.2,",$J,3117,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3118,0)
 ;;=utilization of energy conservation techniques^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3118,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3118,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3119,0)
 ;;=willingness to ask for help and/or delegate tasks^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3119,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3119,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3120,0)
 ;;=incorporation of a rest period into daily activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3120,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3120,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3121,0)
 ;;=resumption of daily routine^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3121,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3121,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3122,0)
 ;;=increased interest in surroundings^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3122,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3122,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3123,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^68^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,1,0)
 ;;=3124^assess current level of energy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,2,0)
 ;;=3125^assess physical and mental demands^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,3,0)
 ;;=3126^assess family/SO understanding of patient fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,4,0)
 ;;=3127^assess patient perception of fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,5,0)
 ;;=3128^assist in identifying low-demand sodial activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,6,0)
 ;;=3129^assist in identifying activity priorities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,7,0)
 ;;=3130^identify factors contributing to fatigue (Dx/Rx/Tx)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,8,0)
 ;;=3131^evaluate rest/activity schedule^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,9,0)
 ;;=3132^teach energy conservation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,10,0)
 ;;=3133^monitor effectiveness of energy conservation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,11,0)
 ;;=3229^teach methods for achieving relaxation/sleep^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,12,0)
 ;;=3230^assess need for & response from medication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3123,1,13,0)
 ;;=16555^[Extra Order]^3^NURSC^432
 ;;^UTILITY("^GMRD(124.2,",$J,3123,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3123,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3124,0)
 ;;=assess current level of energy^3^NURSC^11^1^^^T
