NURCCG7M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,11,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,12,0)
 ;;=3225^Neglect, Unilateral^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,1,13,0)
 ;;=1407^Sensory-Perceptual, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3219,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3221,0)
 ;;=Activity Intolerance, Actual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3222,0)
 ;;=Pain, Chest^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3224,0)
 ;;=Hypothermia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3225,0)
 ;;=Neglect, Unilateral^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3226,0)
 ;;=maintains usual sleep-rest/activity cycle as appropriate^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3226,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3226,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3227,0)
 ;;=verbalizes having adequate energy to perform tasks^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3227,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3227,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3228,0)
 ;;=does not sustain physical injury^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3228,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3228,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3229,0)
 ;;=teach methods for achieving relaxation/sleep^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3229,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3229,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3230,0)
 ;;=assess need for & response from medication^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3230,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3230,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3231,0)
 ;;=Hopelessness^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3231,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3231,1,1,0)
 ;;=3232^Etiology/Related and/or Risk Factors^2^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,3231,1,2,0)
 ;;=3233^Goals/Expected Outcomes^2^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,3231,1,3,0)
 ;;=3234^Nursing Intervention/Orders^2^NURSC^71
 ;;^UTILITY("^GMRD(124.2,",$J,3231,1,4,0)
 ;;=3235^Related Problems^2^NURSC^68
 ;;^UTILITY("^GMRD(124.2,",$J,3231,1,5,0)
 ;;=4209^Defining Characteristics^2^NURSC^32
 ;;^UTILITY("^GMRD(124.2,",$J,3231,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3231,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3231,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^78^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3232,1,1,0)
 ;;=3236^prolonged activity restriction creating isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,1,2,0)
 ;;=3237^deteriorating physiological condition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,1,3,0)
 ;;=3238^long-term stress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,1,4,0)
 ;;=3239^abandonment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,1,5,0)
 ;;=3240^lost belief in values^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3232,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^78^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,1,0)
 ;;=3242^describes adjustments to environment that give control^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,2,0)
 ;;=3243^participates in self-care activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,3,0)
 ;;=3244^verbalizes feelings of regained hope^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,4,0)
 ;;=3245^utilizes available support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,5,0)
 ;;=3246^demonstrates use of coping behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3233,1,6,0)
 ;;=1006313^[Extra Goal]^3^NURSC^170
