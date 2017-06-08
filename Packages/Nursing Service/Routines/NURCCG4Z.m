NURCCG4Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1938,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1938,1,1,0)
 ;;=1939^expresses written plan to improve control of life^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1938,1,2,0)
 ;;=1947^assumes total responsibility for self-care activites^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1938,1,3,0)
 ;;=1949^increased feelings of adequacy in role performance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1938,1,4,0)
 ;;=2915^[Extra Goal]^3^NURSC^96^0
 ;;^UTILITY("^GMRD(124.2,",$J,1938,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1939,0)
 ;;=expresses written plan to improve control of life^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1939,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1939,1,1,0)
 ;;=1941^3 occurrences resulting in feeling of powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1939,1,2,0)
 ;;=1942^aspects of behavior decreasing feeling of powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1939,1,3,0)
 ;;=1943^alternative situations resulting in increased control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1939,5)
 ;;=situations by listing
 ;;^UTILITY("^GMRD(124.2,",$J,1939,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1939,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1939,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1940,0)
 ;;=environmental stimuli^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1941,0)
 ;;=3 occurrences resulting in feeling of powerlessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1942,0)
 ;;=aspects of behavior decreasing feeling of powerlessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1943,0)
 ;;=alternative situations resulting in increased control^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1943,5)
 ;;=or feelings of increased control
 ;;^UTILITY("^GMRD(124.2,",$J,1944,0)
 ;;=Grieving, Dysfunctional^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1945,0)
 ;;=Family Process, Alteration In^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1946,0)
 ;;=Violence, Potential For, Self Directed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1947,0)
 ;;=assumes total responsibility for self-care activites^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1947,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1947,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1948,0)
 ;;=Violence, Potential For, Directed At Others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1949,0)
 ;;=increased feelings of adequacy in role performance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1949,4)
 ;;=verbalizes
 ;;^UTILITY("^GMRD(124.2,",$J,1949,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1949,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1950,0)
 ;;=learned response, such as:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1950,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1950,1,1,0)
 ;;=1952^conditioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1950,1,2,0)
 ;;=1953^modeling from others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1950,1,3,0)
 ;;=1954^identification with others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1950,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1951,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^47^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,1,0)
 ;;=1955^provide choices to encourage decision making^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,2,0)
 ;;=1959^assist in identifying behaviors and situations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,3,0)
 ;;=1961^assist in identifying alternatives to current behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,4,0)
 ;;=1962^provide assistance in self-care activities as needed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1951,1,5,0)
 ;;=1963^provide positive encouragement to attain self-care^3^NURSC^1^0
