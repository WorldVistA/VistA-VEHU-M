NURCCG4W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1895,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^50^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1895,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1895,1,1,0)
 ;;=1940^environmental stimuli^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1895,1,2,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1895,1,3,0)
 ;;=1113^language barriers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1895,1,4,0)
 ;;=1950^learned response, such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1895,1,5,0)
 ;;=1956^natural or innate origins, such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1895,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1896,0)
 ;;=provide patient instruction^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,1,0)
 ;;=1900^the use, effects, and side effects of medication^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,2,0)
 ;;=1901^daily exercise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,3,0)
 ;;=1902^dietary restriction such as excess cholesterol/lipids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,4,0)
 ;;=1903^avoidance of injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,5,0)
 ;;=1904^avoid emotional stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,6,0)
 ;;=1905^avoid crossing legs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,7,0)
 ;;=1906^avoid wearing tight clothes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,8,0)
 ;;=1907^avoid getting chilled^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,1,9,0)
 ;;=1908^need to report changes promptly to MD, etc.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1896,5)
 ;;=in the following:
 ;;^UTILITY("^GMRD(124.2,",$J,1896,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1896,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1896,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1897,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^49^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1897,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1897,1,1,0)
 ;;=1965^reports reduction/elimination of fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1897,1,2,0)
 ;;=1967^absence of signs/symptoms of autonomic arousal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1897,1,3,0)
 ;;=1969^learns and demonstrates coping strategies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1897,1,4,0)
 ;;=2913^[Extra Goal]^3^NURSC^94^0
 ;;^UTILITY("^GMRD(124.2,",$J,1897,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1898,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^45^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,1,0)
 ;;=1970^monitor and record physiological S/S of autonomic arousal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,2,0)
 ;;=1971^assist in identifying source of fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,3,0)
 ;;=1972^assist in identifying/modifying usual coping response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,4,0)
 ;;=1979^teach indicated coping strategies:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,5,0)
 ;;=1874^encourage verbalization of feelings^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1898,1,6,0)
 ;;=3000^[Extra Order]^3^NURSC^86^0
 ;;^UTILITY("^GMRD(124.2,",$J,1898,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1898,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1899,0)
 ;;=Related Problems^2^NURSC^7^38^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1899,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1899,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1899,1,2,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1899,1,3,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1899,1,4,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1^0
