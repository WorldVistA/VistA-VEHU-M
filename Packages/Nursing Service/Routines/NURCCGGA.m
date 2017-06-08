NURCCGGA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15369,0)
 ;;=knowledge of diet^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15370,0)
 ;;=knowledge of respiratory equipment at home^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15371,0)
 ;;=knowledge of when to contact health care provider^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15372,0)
 ;;=assess function, routine, and amt. of assistance needed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15372,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15372,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15373,0)
 ;;=facilitate patient control over activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15373,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15373,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15374,0)
 ;;=debridement technique [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15374,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15374,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15375,0)
 ;;=assess and utilize support systems [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15375,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15375,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15377,0)
 ;;=determine communication for expressing needs [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15377,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15377,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15378,0)
 ;;=handwashing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15379,0)
 ;;=disposal of contaminants^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15380,0)
 ;;=divide tasks into the smallest steps possible^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15380,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15380,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15381,0)
 ;;=remains free of complications of immobility^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15381,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15381,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15383,0)
 ;;=verbalizes need to avoid certain positions [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15383,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15383,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15384,0)
 ;;=teach repositioning techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15384,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15384,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15385,0)
 ;;=normal repiratory rate and pattern [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15385,4)
 ;;=attains/maintains
 ;;^UTILITY("^GMRD(124.2,",$J,15385,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15385,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15388,0)
 ;;=hydration and nutrition q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15388,4)
 ;;=provide,assess,monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,15388,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15388,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15389,0)
 ;;=demonstrates,participates in measures to improve circulation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15389,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15389,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15390,0)
 ;;=teach use/care of wheelchair cushion^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15390,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15390,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15391,0)
 ;;=medicate prior to planned activities/exercises and prn^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15391,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15391,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15392,0)
 ;;=institute care of patient on mechanical ventilator protocol^3^NURSC^11^1^^^T
