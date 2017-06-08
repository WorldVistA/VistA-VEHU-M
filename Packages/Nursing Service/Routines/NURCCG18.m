NURCCG18 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,31,0)
 ;;=2961^[Extra Order]^3^NURSC^38^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,418,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,419,0)
 ;;=anxiety^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,420,0)
 ;;=decreased energy and fatigue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,421,0)
 ;;=decreased lung expansion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,422,0)
 ;;=tracheobronchial obstruction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,423,0)
 ;;=establishes breathing pattern within normal rate^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,423,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,423,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,424,0)
 ;;=remains free from S/S of hypoxia and hypercapnia^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,424,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,424,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,425,0)
 ;;=identifies causative factors and preventive measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,425,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,425,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,426,0)
 ;;=level of consciousness q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,426,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,426,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,427,0)
 ;;=respiratory pattern q [frequency]^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,427,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,427,1,1,0)
 ;;=2697^respiratory altenans^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,427,1,2,0)
 ;;=2698^paradoxical breathing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,427,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,427,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,427,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,427,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,428,0)
 ;;=peak flows [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,428,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,428,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,429,0)
 ;;=reposition/turn q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,429,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,429,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,430,0)
 ;;=percussion q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,431,0)
 ;;=ambulate with assistance q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,431,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,431,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,432,0)
 ;;=provide for relief of pain^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,432,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,432,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,433,0)
 ;;=use relaxation techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,433,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,433,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,434,0)
 ;;=provide calm, supportive environment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,434,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,434,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,435,0)
 ;;=provide patient teaching on the mechanical ventilator^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,435,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,435,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,436,0)
 ;;=assess for complications of mechanical ventilation^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,436,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,436,1,1,0)
 ;;=438^Hypotension^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,436,1,2,0)
 ;;=439^tube displacement^3^NURSC^1^0
