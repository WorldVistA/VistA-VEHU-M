NURCCG79 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,5,0)
 ;;=3060^support system deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,6,0)
 ;;=3061^multiple/divergent sources of information^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3055,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3056,0)
 ;;=unclear personal values/beliefs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3057,0)
 ;;=perceived threat to value system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3058,0)
 ;;=lack of experience or interface with decision making^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3059,0)
 ;;=lack of relevant information^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3060,0)
 ;;=support system deficit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3061,0)
 ;;=multiple/divergent sources of information^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3062,0)
 ;;=Related Problems^2^NURSC^7^61^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,1,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,2,0)
 ;;=3063^Coping, Defensive^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,3,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,4,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,5,0)
 ;;=2078^Hopelessness ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,7,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,8,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,9,0)
 ;;=1919^Spiritual Distress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,1,10,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3062,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3063,0)
 ;;=Coping, Defensive^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3064,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^73^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,1,0)
 ;;=3065^actions consistent with values [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,2,0)
 ;;=3066^ability to identify alternatives^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,3,0)
 ;;=2491^effective decision making skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,4,0)
 ;;=3067^utilizes skills required to implement decision [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,5,0)
 ;;=3068^verbalization of satifaction about decisions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,6,0)
 ;;=3069^restoration of self care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3064,1,7,0)
 ;;=16552^[Extra Goal]^3^NURSC^423
 ;;^UTILITY("^GMRD(124.2,",$J,3064,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3065,0)
 ;;=actions consistent with values [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3065,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3065,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3066,0)
 ;;=ability to identify alternatives^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3066,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3066,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3067,0)
 ;;=utilizes skills required to implement decision [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3067,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3067,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3068,0)
 ;;=verbalization of satifaction about decisions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3068,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3068,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3069,0)
 ;;=restoration of self care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3069,9)
 ;;=D EN5^NURCCPU0
