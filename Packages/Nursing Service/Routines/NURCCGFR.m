NURCCGFR ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,14750,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14757,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^193^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14757,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14757,1,1,0)
 ;;=2551^expresses factors that contribute to decreased nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14757,1,2,0)
 ;;=14759^maintains nutritional intake to meet metabolic requirements^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14757,1,3,0)
 ;;=14766^identifies/procures food source^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14757,1,4,0)
 ;;=15038^[Extra Goal]^3^NURSC^252
 ;;^UTILITY("^GMRD(124.2,",$J,14757,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,0)
 ;;=maintains nutritional intake to meet metabolic requirements^2^NURSC^9^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,14759,1,1,0)
 ;;=2553^stable weight greater than [specify] lbs/kgs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,1,2,0)
 ;;=2554^stable weight less than [specify] lbs/kgs ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,1,3,0)
 ;;=2555^daily intake of [number of] calories^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,1,6,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,14759,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14759,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14759,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,0)
 ;;=identifies/procures food source^2^NURSC^9^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14766,1,1,0)
 ;;=2560^public meal programs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,1,2,0)
 ;;=2561^family support^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,1,3,0)
 ;;=2562^social welfare programs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,1,4,0)
 ;;=2563^self-care ability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,5)
 ;;=through:
 ;;^UTILITY("^GMRD(124.2,",$J,14766,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14766,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14766,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14771,0)
 ;;=[Extra Goal]^3^NURSC^9^249^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14771,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14771,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^162^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,1,0)
 ;;=2565^assess food source and abilities to prepare meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,2,0)
 ;;=2566^assess eating patterns, satiety levels^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,4,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,5,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,6,0)
 ;;=14778^maintain activity level commensurate with caloric intake^2^NURSC^8
