NURCCG4P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,4,0)
 ;;=1809^presence of pain/discomfort q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,5,0)
 ;;=1810^presence/absence of drainage q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,6,0)
 ;;=2952^temperature per[route] q[ frequency ]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1802,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1802,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1802,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1803,0)
 ;;=passive ROM as tolerated q [frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1803,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1803,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1804,0)
 ;;=active exercises encouraged (if indicated) [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1804,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1804,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1805,0)
 ;;=area(s) in question [location] q [frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1806,0)
 ;;=color q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1807,0)
 ;;=provide hi-protein diet^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1807,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1807,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1808,0)
 ;;=size q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1809,0)
 ;;=presence of pain/discomfort q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1810,0)
 ;;=presence/absence of drainage q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1811,0)
 ;;=provide adequate fluids [ ]cc/day^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1811,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1811,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1812,0)
 ;;=institute skin care protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1812,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1812,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1813,0)
 ;;=use aseptic technique when changing dressing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1813,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1813,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1814,0)
 ;;=teach patient^2^NURSC^11^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1814,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1814,1,1,0)
 ;;=1815^dressing changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1814,1,2,0)
 ;;=1816^avoid temperature extremes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1814,1,3,0)
 ;;=1818^avoid noxious agents such as smoking and chemical abuse^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1814,1,4,0)
 ;;=1819^diet restrictions [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1814,1,5,0)
 ;;=1820^S/S of infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1814,5)
 ;;=the following:
 ;;^UTILITY("^GMRD(124.2,",$J,1814,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1814,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1814,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1815,0)
 ;;=dressing changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1816,0)
 ;;=avoid temperature extremes^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1816,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1816,1,1,0)
 ;;=138^bathing/hygiene^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1816,1,2,0)
 ;;=773^clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1816,1,3,0)
 ;;=1817^environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1816,5)
 ;;=related to
 ;;^UTILITY("^GMRD(124.2,",$J,1816,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1817,0)
 ;;=environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1818,0)
 ;;=avoid noxious agents such as smoking and chemical abuse^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1819,0)
 ;;=diet restrictions [specify]^3^NURSC^^1^^^T
