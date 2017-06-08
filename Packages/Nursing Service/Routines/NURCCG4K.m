NURCCG4K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,6,0)
 ;;=1744^high-density lipoprotein (HDL)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,7,0)
 ;;=1745^discuss rationale for food restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1737,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1737,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1737,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1737,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1738,0)
 ;;=calories^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1739,0)
 ;;=sodium^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1740,0)
 ;;=potassium^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1741,0)
 ;;=cholesterol^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1742,0)
 ;;=low-density lipoprotein (LDL)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1743,0)
 ;;=inspect mouth daily for changes in lesions,sores,bleeding^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1743,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1743,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1744,0)
 ;;=high-density lipoprotein (HDL)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1745,0)
 ;;=discuss rationale for food restrictions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1746,0)
 ;;=administer pain relieving agent [specify] a.c.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1746,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1746,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1747,0)
 ;;=oral hygiene q[frequency]hrs^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1747,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1747,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1748,0)
 ;;=stress avoidance of crossing legs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1748,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1748,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1749,0)
 ;;=apply emollients to lips q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1749,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1749,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1750,0)
 ;;=stress avoidance of standing for long periods^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1750,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1750,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1751,0)
 ;;=stress avoidance of restrictive clothing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1751,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1751,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1752,0)
 ;;=if endotracheal tube - move daily^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1752,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1752,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1753,0)
 ;;=elevate legs when feasible^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1753,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1753,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1754,0)
 ;;=initiate dental consult^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1754,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1754,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1755,0)
 ;;=include S/O when instructing as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1755,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1755,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1756,0)
 ;;=encourage self-oral care q [frequency] times a day^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1756,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1756,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1757,0)
 ;;=demonstrate use of assistive devices [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1757,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1757,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1758,0)
 ;;=explain the common causes of mucosal irritation^3^NURSC^11^1^^^T
