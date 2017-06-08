NURCCG7L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3205,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3206,0)
 ;;=maintains adequate bladder function^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3206,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3206,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3207,0)
 ;;=uses assistive devices [specify] correctly/consistently^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3207,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3207,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3208,0)
 ;;=participates in social and occupational activities^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3208,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3208,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3209,0)
 ;;=verbalizes accurate knowledge of decisions/treatment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3209,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3209,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3211,0)
 ;;=remains free of injury^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3211,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3211,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^70^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,1,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,2,0)
 ;;=3213^assess nutritional status q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,3,0)
 ;;=3214^monitor for S/S of urinary tract infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,4,0)
 ;;=333^chest percussion q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,5,0)
 ;;=3216^monitor urine pH q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,6,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,7,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,8,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,9,0)
 ;;=1955^provide choices to encourage decision making^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,10,0)
 ;;=1601^encourage fluid intake of [amt]cc/24hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,1,11,0)
 ;;=1006318^[Extra Order]^3^NURSC^115
 ;;^UTILITY("^GMRD(124.2,",$J,3212,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3212,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3213,0)
 ;;=assess nutritional status q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3213,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3213,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3214,0)
 ;;=monitor for S/S of urinary tract infection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3214,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3214,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3216,0)
 ;;=monitor urine pH q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3216,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3216,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3219,0)
 ;;=Related Problems^2^NURSC^7^67^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,0)
 ;;=^124.21PI^13^11
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,2,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,3,0)
 ;;=3221^Activity Intolerance, Actual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,4,0)
 ;;=3140^Pain, Acute^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,5,0)
 ;;=3222^Pain, Chest^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,7,0)
 ;;=3141^Pain, Chronic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,8,0)
 ;;=1577^Hyperthermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,9,0)
 ;;=3224^Hypothermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,10,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
