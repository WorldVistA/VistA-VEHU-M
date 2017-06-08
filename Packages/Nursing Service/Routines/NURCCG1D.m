NURCCG1D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,471,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,472,0)
 ;;=maintains intact mucous membranes^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,472,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,472,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,473,0)
 ;;=maintains optimal weight [specify lbs/kgs]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,473,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,473,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,474,0)
 ;;=maintains optimal fluid balance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,474,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,474,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,475,0)
 ;;=states actions taken to prevent cross infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,475,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,475,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,476,0)
 ;;=states S/S of infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,476,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,476,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,477,0)
 ;;=chronic disease^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,478,0)
 ;;=immunosuppression^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,479,0)
 ;;=inadequate acquired immunity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,480,0)
 ;;=inadequate primary defenses^3^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,481,0)
 ;;=inadequate secondary defenses^3^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,482,0)
 ;;=malnutrition^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,483,0)
 ;;=medical procedures^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,484,0)
 ;;=pharmaceutical agents^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,485,0)
 ;;=tissue destruction and increased environmental exposure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,486,0)
 ;;=oxygen flow, altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,487,0)
 ;;=mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,488,0)
 ;;=impaired cough mechanism^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,489,0)
 ;;=use of antibiotics^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,490,0)
 ;;=inability to breathe deeply due to weakness, chest pain etc^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,491,0)
 ;;=monitor sputum^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,491,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,491,1,1,0)
 ;;=492^increase in production^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,491,1,2,0)
 ;;=493^change in color^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,491,1,3,0)
 ;;=494^change in consistency^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,491,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,491,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,491,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,492,0)
 ;;=increase in production^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,493,0)
 ;;=change in color^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,494,0)
 ;;=change in consistency^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,495,0)
 ;;=culture sputum [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,495,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,495,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,495,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,496,0)
 ;;=ambulate q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,496,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,496,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,497,0)
 ;;=provide humidity q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,497,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,497,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,498,0)
 ;;=pacing activities, exercise, rest^3^NURSC^^1^^^T
