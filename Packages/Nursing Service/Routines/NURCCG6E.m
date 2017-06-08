NURCCG6E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2614,1,1,0)
 ;;=2615^ingests p.o., [specify # of] calories q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2614,1,2,0)
 ;;=2616^maintains adequate nutritional status^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2614,1,3,0)
 ;;=2617^ingests [#] cc of fluid q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2614,1,4,0)
 ;;=2618^demonstrates oral hygiene techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2614,1,5,0)
 ;;=2934^[Extra Goal]^3^NURSC^115^0
 ;;^UTILITY("^GMRD(124.2,",$J,2614,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2615,0)
 ;;=ingests p.o., [specify # of] calories q[frequency]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2615,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2615,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2616,0)
 ;;=maintains adequate nutritional status^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2616,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2616,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2617,0)
 ;;=ingests [#] cc of fluid q [frequency]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2617,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2617,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2618,0)
 ;;=demonstrates oral hygiene techniques^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2618,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2618,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2619,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^65^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,1,0)
 ;;=2620^assess ability to swallow^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,2,0)
 ;;=2625^assess factors contributing to swallowing difficulties^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,3,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,4,0)
 ;;=2626^position patient upright 60-90 degrees [ ] min before eating^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,5,0)
 ;;=2627^flex patient's head about 45 degrees [ ] min before eating^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,6,0)
 ;;=2628^maintain in upright position [ ] min after feedings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,7,0)
 ;;=2629^oral hygiene before and after feedings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,8,0)
 ;;=2630^stimulate salivation by providing [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,9,0)
 ;;=2631^feed slowly, assure previous bites swallowed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,10,0)
 ;;=2632^teach progression of food types/textures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,11,0)
 ;;=2637^provide wet foods to make up for saliva deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,12,0)
 ;;=2638^minimize distractions during feeding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,13,0)
 ;;=2639^teach how to handle food^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,14,0)
 ;;=2578^initiate consult(s)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,1,15,0)
 ;;=3021^[Extra Order]^3^NURSC^107^0
 ;;^UTILITY("^GMRD(124.2,",$J,2619,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2619,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2620,0)
 ;;=assess ability to swallow^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2620,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2620,1,1,0)
 ;;=2621^adequately alert and responsive^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2620,1,2,0)
 ;;=2622^able to control mouth^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2620,1,3,0)
 ;;=2623^cough/gag reflex present^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2620,1,4,0)
 ;;=2624^can swallow own saliva^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2620,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,2620,7)
 ;;=D EN4^NURCCPU1
