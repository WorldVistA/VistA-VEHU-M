NURCCG7H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3150,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3151,0)
 ;;=provide supportive environment for verbalization^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3151,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3151,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3152,0)
 ;;=support verbalization anxieties or fears^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3152,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3152,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3153,0)
 ;;=teach alternative coping skills [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3153,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3153,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3154,0)
 ;;=Related Problems^2^NURSC^7^65^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3154,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3155,0)
 ;;=Related Problems^2^NURSC^7^66^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,2,0)
 ;;=121^Activity Intolerance^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,3,0)
 ;;=1383^Activity Intolerance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,4,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,5,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,7,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,8,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,1,9,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3155,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3156,0)
 ;;=increases self care ability [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3156,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3156,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3157,0)
 ;;=evaluates environment for safety risks^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3157,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3157,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3158,0)
 ;;=administer pharmacological agents as ordered/per protocol^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3158,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3158,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3159,0)
 ;;=recognizes signs/symptoms of [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3159,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3159,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3160,0)
 ;;=states interventions for complications of [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3160,9)
 ;;=D EN5^NURCCPU0
