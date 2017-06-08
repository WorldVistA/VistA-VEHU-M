NURCCG6I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2685,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2685,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2686,0)
 ;;=afebrile^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2687,0)
 ;;=maintains intact skin^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2687,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2687,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2688,0)
 ;;=demonstrates ability to do self assessment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2688,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2688,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2689,0)
 ;;=writes list of support persons/agencies before discharge^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2689,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2689,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2690,0)
 ;;=makes contact with support person/agency prior to D/C^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2690,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2690,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2691,0)
 ;;=has improved breath sounds^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2691,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2691,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2692,0)
 ;;=has no signs of paradoxical breathing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2692,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2692,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2693,0)
 ;;=has no signs of respiratory alternans^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2693,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2693,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2694,0)
 ;;=hemodynamically stable^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2694,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2694,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2694,1,2,0)
 ;;=2695^baseline B/P for pt [specify range]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2694,1,3,0)
 ;;=281^skin color and temperature WNL for pt^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2694,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,2694,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2694,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2694,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2695,0)
 ;;=baseline B/P for pt [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2696,0)
 ;;=ventilation, altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2697,0)
 ;;=respiratory altenans^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2698,0)
 ;;=paradoxical breathing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2699,0)
 ;;=ear oximetry q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2699,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2699,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2700,0)
 ;;=document use of accessory muscles q [ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2700,4)
 ;;=assess, monitor, and
 ;;^UTILITY("^GMRD(124.2,",$J,2700,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2700,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2701,0)
 ;;=peak flows [frequency]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2701,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2701,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2702,0)
 ;;=bronchial hygiene q[frequency]hrs^2^NURSC^11^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,1,0)
 ;;=2703^administer bronchodilators as ordered^3^NURSC^3^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,2,0)
 ;;=2704^administer aerosol via large volume nebulizer^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,3,0)
 ;;=2705^postural drainage q[specify]^3^NURSC^1^0
