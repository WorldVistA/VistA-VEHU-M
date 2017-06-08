NURCCGGK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15597,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15598,0)
 ;;=provide information in short segments with reinforcement^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15598,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15598,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15599,0)
 ;;=instruct on dialysis vessel access care/complications^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15599,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15599,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15600,0)
 ;;=[Extra Order]^3^NURSC^11^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15600,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15600,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15601,0)
 ;;=temporary/permanent role change^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15602,0)
 ;;=bipolar disorder^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15603,0)
 ;;=family history^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15604,0)
 ;;=antidepressant medications^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15605,0)
 ;;=demonstrates effective coping skills^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15605,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15605,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15606,0)
 ;;=[Extra Goal]^3^NURSC^9^259^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15606,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15606,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15607,0)
 ;;=discuss importance of maintaining optimal health^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15607,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15607,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15608,0)
 ;;=encourage wearing medical I.D. bracelet for seizure activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15608,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15608,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15609,0)
 ;;=crossing legs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15610,0)
 ;;=restrictive clothing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15611,0)
 ;;=cold extremities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15613,0)
 ;;=demonstrates/directs treatment protocol^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15613,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15613,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15615,0)
 ;;=utilize protective aids [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15615,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15615,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15616,0)
 ;;=apply barrier cream to at risk skin areas^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15616,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15616,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15617,0)
 ;;=teach causative factors for ulcer development^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15617,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15617,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15619,0)
 ;;=assess patient's/caregiver's dressing technique^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15619,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15619,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15620,0)
 ;;=teach use & care of adpative equipment^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15620,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15620,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15621,0)
 ;;=verblizes understanding of functional status^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15621,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15621,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15622,0)
 ;;=demonstrates ability to direct caregiver in ADL needs^3^NURSC^9^1^^^T
