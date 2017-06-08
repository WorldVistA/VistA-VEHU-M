NURCCG63 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,13,0)
 ;;=2463^difficulty sleeping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,14,0)
 ;;=2464^interrupted sleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,15,0)
 ;;=2465^sleep pattern reversal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,5)
 ;;=; monitor and document:
 ;;^UTILITY("^GMRD(124.2,",$J,2451,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2451,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2451,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2452,0)
 ;;=early morning headache^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2453,0)
 ;;=increasing irritability ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2454,0)
 ;;=restlessness, changes in position^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2455,0)
 ;;=disorientation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2456,0)
 ;;=listlessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2457,0)
 ;;=mild fleeting nystagmus^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2458,0)
 ;;=slight hand tremors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2459,0)
 ;;=ptosis of eyelids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2460,0)
 ;;=dark circles under the eyes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2461,0)
 ;;=frequent yawning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2462,0)
 ;;=loud snoring^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2463,0)
 ;;=difficulty sleeping^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2464,0)
 ;;=interrupted sleep^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2465,0)
 ;;=sleep pattern reversal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2466,0)
 ;;=schedule rest periods early in the day^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2466,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2466,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2467,0)
 ;;=has decreased S/S of sleep-pattern disturbance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2467,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2467,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2468,0)
 ;;=verbalizes improved ability to perform activities^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2468,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2468,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2469,0)
 ;;=verbalizes less trouble falling asleep^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2469,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2469,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2470,0)
 ;;=has less complaints of early awakening^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2470,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2470,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2471,0)
 ;;=has less complaints of sleep pattern reversal^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2471,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2471,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2472,0)
 ;;=has less complaints of interrupted sleep^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2472,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2472,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2473,0)
 ;;=discomfort^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2474,0)
 ;;=apnea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2475,0)
 ;;=personal stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2476,0)
 ;;=family stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2477,0)
 ;;=assist with the use and care of respiratory equipment^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2477,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2477,1,1,0)
 ;;=2478^CPAP set-up^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2477,1,2,0)
 ;;=2479^oxygen therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2477,1,3,0)
 ;;=2480^trach care^3^NURSC^1^0
