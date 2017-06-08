NURCCG6F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2620,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2620,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2621,0)
 ;;=adequately alert and responsive^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2622,0)
 ;;=able to control mouth^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2623,0)
 ;;=cough/gag reflex present^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2624,0)
 ;;=can swallow own saliva^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2625,0)
 ;;=assess factors contributing to swallowing difficulties^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2625,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2625,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2626,0)
 ;;=position patient upright 60-90 degrees [ ] min before eating^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2626,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2626,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2627,0)
 ;;=flex patient's head about 45 degrees [ ] min before eating^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2627,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2627,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2628,0)
 ;;=maintain in upright position [ ] min after feedings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2628,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2628,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2629,0)
 ;;=oral hygiene before and after feedings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2629,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2629,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2630,0)
 ;;=stimulate salivation by providing [ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2630,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2630,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2631,0)
 ;;=feed slowly, assure previous bites swallowed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2631,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2631,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2632,0)
 ;;=teach progression of food types/textures^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2632,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2632,1,1,0)
 ;;=2633^liquids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2632,1,2,0)
 ;;=2634^mechanical soft^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2632,1,3,0)
 ;;=2635^small amounts^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2632,1,4,0)
 ;;=2636^various textures foods^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2632,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2632,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2632,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2632,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2633,0)
 ;;=liquids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2634,0)
 ;;=mechanical soft^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2635,0)
 ;;=small amounts^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2636,0)
 ;;=various textures foods^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2637,0)
 ;;=provide wet foods to make up for saliva deficit^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2637,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2637,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2638,0)
 ;;=minimize distractions during feeding^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2638,5)
 ;;=for concentration on swallowing
 ;;^UTILITY("^GMRD(124.2,",$J,2638,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2638,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2639,0)
 ;;=teach how to handle food^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2639,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2639,1,1,0)
 ;;=2640^move food to middle of tongue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2639,1,2,0)
 ;;=2641^raise tongue to roof of mouth^3^NURSC^1^0
