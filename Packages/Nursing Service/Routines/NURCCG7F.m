NURCCG7F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3124,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3124,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3125,0)
 ;;=assess physical and mental demands^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3125,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3125,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3126,0)
 ;;=assess family/SO understanding of patient fatigue^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3126,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3126,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3127,0)
 ;;=assess patient perception of fatigue^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3127,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3127,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3128,0)
 ;;=assist in identifying low-demand sodial activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3128,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3128,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3129,0)
 ;;=assist in identifying activity priorities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3129,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3129,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3130,0)
 ;;=identify factors contributing to fatigue (Dx/Rx/Tx)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3130,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3130,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3131,0)
 ;;=evaluate rest/activity schedule^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3131,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3131,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3132,0)
 ;;=teach energy conservation techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3132,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3132,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3133,0)
 ;;=monitor effectiveness of energy conservation techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3133,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3133,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3134,0)
 ;;=Ineffective Denial^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,3134,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3134,1,1,0)
 ;;=3135^Etiology/Related and/or Risk Factors^2^NURSC^76^0
 ;;^UTILITY("^GMRD(124.2,",$J,3134,1,2,0)
 ;;=3138^Related Problems^2^NURSC^64^0
 ;;^UTILITY("^GMRD(124.2,",$J,3134,1,3,0)
 ;;=3142^Goals/Expected Outcomes^2^NURSC^76^0
 ;;^UTILITY("^GMRD(124.2,",$J,3134,1,4,0)
 ;;=3146^Nursing Intervention/Orders^2^NURSC^69^0
 ;;^UTILITY("^GMRD(124.2,",$J,3134,1,5,0)
 ;;=5598^Defining Characteristics^2^NURSC^72
 ;;^UTILITY("^GMRD(124.2,",$J,3134,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3134,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3134,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3135,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^76^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3135,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,3135,1,1,0)
 ;;=3136^nature of action precluded^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3135,1,2,0)
 ;;=3137^context of situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3135,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3136,0)
 ;;=nature of action precluded^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3137,0)
 ;;=context of situation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3138,0)
 ;;=Related Problems^2^NURSC^7^64^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,1,0)
 ;;=3139^Adjustment Impairment (to be developed)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,2,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3138,1,3,0)
 ;;=3140^Pain, Acute^3^NURSC^1^0
