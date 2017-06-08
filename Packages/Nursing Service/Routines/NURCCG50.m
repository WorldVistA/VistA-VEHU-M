NURCCG50 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,6,0)
 ;;=1964^encourage ventilation of inadequacies in role performance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,7,0)
 ;;=1966^encourage ventilation of frustration in role performance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,8,0)
 ;;=1968^encourage written plan and implementation of plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,9,0)
 ;;=1973^teach relaxation techniques^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,10,0)
 ;;=1974^teach problem solving skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,11,0)
 ;;=1975^teach assertiveness skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,12,0)
 ;;=3002^[Extra Order]^3^NURSC^88^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1951,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1952,0)
 ;;=conditioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1953,0)
 ;;=modeling from others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1954,0)
 ;;=identification with others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1955,0)
 ;;=provide choices to encourage decision making^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1955,5)
 ;;=when possible
 ;;^UTILITY("^GMRD(124.2,",$J,1955,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1955,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1956,0)
 ;;=natural or innate origins, such as:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1956,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1956,1,1,0)
 ;;=1957^sudden noise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1956,1,2,0)
 ;;=1958^loss of physical support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1956,1,3,0)
 ;;=1960^heights^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1956,1,4,0)
 ;;=1045^pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1956,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1957,0)
 ;;=sudden noise^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1958,0)
 ;;=loss of physical support^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1959,0)
 ;;=assist in identifying behaviors and situations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1959,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1959,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1960,0)
 ;;=heights^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1961,0)
 ;;=assist in identifying alternatives to current behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1961,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1961,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1962,0)
 ;;=provide assistance in self-care activities as needed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1962,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1962,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1963,0)
 ;;=provide positive encouragement to attain self-care^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1963,5)
 ;;=activities
 ;;^UTILITY("^GMRD(124.2,",$J,1963,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1963,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1964,0)
 ;;=encourage ventilation of inadequacies in role performance^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1964,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1964,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1965,0)
 ;;=reports reduction/elimination of fear^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1965,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1965,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1966,0)
 ;;=encourage ventilation of frustration in role performance^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1966,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1966,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1967,0)
 ;;=absence of signs/symptoms of autonomic arousal^3^NURSC^9^1^^^T
