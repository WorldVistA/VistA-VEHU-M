NURCCG7G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,4,0)
 ;;=3141^Pain, Chronic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,5,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,6,0)
 ;;=2078^Hopelessness ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,7,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,8,0)
 ;;=2197^Thought Processes, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3139,0)
 ;;=Adjustment Impairment (to be developed)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3140,0)
 ;;=Pain, Acute^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3141,0)
 ;;=Pain, Chronic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3142,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^76^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3142,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,3142,1,1,0)
 ;;=3143^restoration of patient well-being^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3142,1,2,0)
 ;;=3144^reduction in anxiety to low or moderate levels^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3142,1,3,0)
 ;;=3145^verbalization of reduction in problems or concerns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3142,1,4,0)
 ;;=16556^[Extra Goal]^3^NURSC^425
 ;;^UTILITY("^GMRD(124.2,",$J,3142,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3143,0)
 ;;=restoration of patient well-being^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3143,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3143,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3144,0)
 ;;=reduction in anxiety to low or moderate levels^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3144,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3144,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3145,0)
 ;;=verbalization of reduction in problems or concerns^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3145,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3145,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3146,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^69^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,1,0)
 ;;=3147^assess effect of denial as a coping strategy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,2,0)
 ;;=3148^avoid confrontation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,3,0)
 ;;=3149^assess for S/S of increased anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,4,0)
 ;;=3150^provide factual information about object of concern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,5,0)
 ;;=3151^provide supportive environment for verbalization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,6,0)
 ;;=3152^support verbalization anxieties or fears^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,7,0)
 ;;=3153^teach alternative coping skills [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3146,1,8,0)
 ;;=16557^[Extra Order]^3^NURSC^433
 ;;^UTILITY("^GMRD(124.2,",$J,3146,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3146,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3147,0)
 ;;=assess effect of denial as a coping strategy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3147,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3147,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3148,0)
 ;;=avoid confrontation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3148,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3148,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3149,0)
 ;;=assess for S/S of increased anxiety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3149,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3149,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3150,0)
 ;;=provide factual information about object of concern^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3150,9)
 ;;=D EN2^NURCCPU2
