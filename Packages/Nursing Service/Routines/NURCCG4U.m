NURCCG4U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1861,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1861,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1862,0)
 ;;=identifies three alternative methods of managing stressors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1862,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1862,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1863,0)
 ;;=identifies and develops plan to meet role expectations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1863,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1863,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1864,0)
 ;;=establishes written routine to meet basic needs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1864,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1864,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1865,0)
 ;;=expresses feeling of greater control over stressors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1865,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1865,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1866,0)
 ;;=demonstrates problem solving skills such as:^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1866,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1866,1,1,0)
 ;;=1869^good basic health habits^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1866,1,2,0)
 ;;=1870^body awareness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1866,1,3,0)
 ;;=1871^stress reduction/relaxation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1866,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1866,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1866,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1867,0)
 ;;=do not elevate bed; arterial & venous flow compromised^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1867,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1867,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1868,0)
 ;;=avoid prolonged sitting/standing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1868,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1868,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1869,0)
 ;;=good basic health habits^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1870,0)
 ;;=body awareness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1871,0)
 ;;=stress reduction/relaxation techniques^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1872,0)
 ;;=provide skin/foot care (bathe with warm water)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1872,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1872,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1873,0)
 ;;=oral hygiene q[frequency]hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1873,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1873,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1874,0)
 ;;=encourage verbalization of feelings^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1874,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1874,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1875,0)
 ;;=encourage discussion of blocks to coping^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1875,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1875,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1876,0)
 ;;=assist in listing factors contributing to inadequate coping^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1876,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1876,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1877,0)
 ;;=aseptic dressing change q [frequency]hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1877,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1877,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1878,0)
 ;;=provide comfort measures^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1878,1,0)
 ;;=^124.21PI^3^3
