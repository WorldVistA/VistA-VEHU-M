NURCCG4V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1878,1,1,0)
 ;;=1880^sheep skin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1878,1,2,0)
 ;;=842^alternating pressure pads^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1878,1,3,0)
 ;;=1881^foot cradle^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1878,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1878,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1878,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1878,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1879,0)
 ;;=assist in listing alternative methods of managing stressors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1879,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1879,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1880,0)
 ;;=sheep skin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1881,0)
 ;;=foot cradle^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1882,0)
 ;;=assist in evaluating current situation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1882,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1882,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1883,0)
 ;;=maintain comfortable room temperatures^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1883,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1883,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1884,0)
 ;;=help identify ways of fulfilling role expectations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1884,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1884,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1885,0)
 ;;=provide and document results of ordered analgesics^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1885,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1885,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1886,0)
 ;;=provide positive feedback for effective coping^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1886,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1886,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1887,0)
 ;;=involve patient in planning own care^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1887,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1887,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1888,0)
 ;;=teach the following:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1888,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1888,1,1,0)
 ;;=1889^assertiveness skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1888,1,2,0)
 ;;=1890^problem solving skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1888,1,3,0)
 ;;=3199^good basic health habits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1888,1,4,0)
 ;;=1870^body awareness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1888,1,5,0)
 ;;=1893^stress reduction/relaxation techniques^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1888,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1888,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1888,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1889,0)
 ;;=assertiveness skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1890,0)
 ;;=problem solving skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1891,0)
 ;;=avoid pillow under knee and elevating knee gatch^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1891,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1891,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1892,0)
 ;;=avoid dangling extremities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1892,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1892,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1893,0)
 ;;=stress reduction/relaxation techniques^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1894,0)
 ;;=avoid constrictive clothing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1894,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1894,10)
 ;;=D EN1^NURCCPU3
