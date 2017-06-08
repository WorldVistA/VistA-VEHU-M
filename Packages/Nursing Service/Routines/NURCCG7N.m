NURCCG7N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3233,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^71^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,1,0)
 ;;=3247^provide time and atmosphere for verbalizing feelings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,2,0)
 ;;=3248^allow decision making regarding own care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,3,0)
 ;;=3249^explain treatments/procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,4,0)
 ;;=3250^encourage participation in self care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,5,0)
 ;;=3251^assist in identifying available support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,6,0)
 ;;=3252^teach coping behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,7,0)
 ;;=3253^consult with clergy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,8,0)
 ;;=3254^consult with psychologist^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,9,0)
 ;;=3255^consult with social worker^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,1,10,0)
 ;;=1006319^[Extra Order]^3^NURSC^116
 ;;^UTILITY("^GMRD(124.2,",$J,3234,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3234,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3235,0)
 ;;=Related Problems^2^NURSC^7^68^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,1,0)
 ;;=1383^Activity Intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,2,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,3,0)
 ;;=3141^Pain, Chronic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,4,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,5,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,6,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,7,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,8,0)
 ;;=3241^Self Esteem Disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,9,0)
 ;;=1918^Social Isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,1,10,0)
 ;;=1919^Spiritual Distress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3235,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3236,0)
 ;;=prolonged activity restriction creating isolation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3237,0)
 ;;=deteriorating physiological condition^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3238,0)
 ;;=long-term stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3239,0)
 ;;=abandonment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3240,0)
 ;;=lost belief in values^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3241,0)
 ;;=Self Esteem Disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3242,0)
 ;;=describes adjustments to environment that give control^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3242,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3242,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3243,0)
 ;;=participates in self-care activities^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3243,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3243,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3244,0)
 ;;=verbalizes feelings of regained hope^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3244,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3244,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3245,0)
 ;;=utilizes available support systems^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3245,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3245,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3246,0)
 ;;=demonstrates use of coping behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3246,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3246,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3247,0)
 ;;=provide time and atmosphere for verbalizing feelings^3^NURSC^11^1^^^T
