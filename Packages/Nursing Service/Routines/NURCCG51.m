NURCCG51 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1967,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1967,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1968,0)
 ;;=encourage written plan and implementation of plan^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1968,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1968,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1969,0)
 ;;=learns and demonstrates coping strategies^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1969,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1969,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1970,0)
 ;;=monitor and record physiological S/S of autonomic arousal^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1970,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1970,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1971,0)
 ;;=assist in identifying source of fear^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1971,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1971,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1972,0)
 ;;=assist in identifying/modifying usual coping response^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1972,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1972,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1973,0)
 ;;=teach relaxation techniques^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1973,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1973,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1974,0)
 ;;=teach problem solving skills^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1974,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1974,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1975,0)
 ;;=teach assertiveness skills^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1975,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1975,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1976,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^53^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1976,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1976,1,1,0)
 ;;=1977^body image, disturbance in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1976,1,2,0)
 ;;=1978^biophysical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1976,1,3,0)
 ;;=1980^cognitive perceptual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1976,1,4,0)
 ;;=1981^cultural or spiritual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1976,1,5,0)
 ;;=1983^psychosocial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1976,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1977,0)
 ;;=body image, disturbance in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1978,0)
 ;;=biophysical^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1979,0)
 ;;=teach indicated coping strategies:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1979,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1979,1,1,0)
 ;;=1982^identify source^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1979,1,2,0)
 ;;=1984^avoidance or elimination of danger^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1979,1,3,0)
 ;;=1986^development of alternative goals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1979,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1979,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1979,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1980,0)
 ;;=cognitive perceptual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1981,0)
 ;;=cultural or spiritual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1982,0)
 ;;=identify source^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1983,0)
 ;;=psychosocial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1984,0)
 ;;=avoidance or elimination of danger^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1985,0)
 ;;=Related Problems^2^NURSC^7^40^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,1,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
