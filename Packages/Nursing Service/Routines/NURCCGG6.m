NURCCGG6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15275,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15276,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^291^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15276,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15276,1,1,0)
 ;;=15278^[etiology]^3^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,15276,1,2,0)
 ;;=15279^[etiology]^3^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,15276,1,3,0)
 ;;=15535^[etiology]^3^NURSC^88
 ;;^UTILITY("^GMRD(124.2,",$J,15276,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15277,0)
 ;;=[etiology]^3^NURSC^^126^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15278,0)
 ;;=[etiology]^3^NURSC^^124^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15279,0)
 ;;=[etiology]^3^NURSC^^125^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15280,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^305^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15280,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15280,1,1,0)
 ;;=15281^[Extra Goal]^3^NURSC^404
 ;;^UTILITY("^GMRD(124.2,",$J,15280,1,2,0)
 ;;=15282^[Extra Goal]^3^NURSC^405
 ;;^UTILITY("^GMRD(124.2,",$J,15280,1,3,0)
 ;;=15283^[Extra Goal]^3^NURSC^406
 ;;^UTILITY("^GMRD(124.2,",$J,15280,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15281,0)
 ;;=[Extra Goal]^3^NURSC^9^404^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15281,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15281,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15282,0)
 ;;=[Extra Goal]^3^NURSC^9^405^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15282,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15282,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15283,0)
 ;;=[Extra Goal]^3^NURSC^9^406^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15283,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15283,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15284,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^307^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15284,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15284,1,1,0)
 ;;=15285^[Extra Order]^3^NURSC^411
 ;;^UTILITY("^GMRD(124.2,",$J,15284,1,2,0)
 ;;=15286^[Extra Order]^3^NURSC^412
 ;;^UTILITY("^GMRD(124.2,",$J,15284,1,3,0)
 ;;=15287^[Extra Order]^3^NURSC^413
 ;;^UTILITY("^GMRD(124.2,",$J,15284,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15284,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15285,0)
 ;;=[Extra Order]^3^NURSC^11^411^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15285,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15285,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15286,0)
 ;;=[Extra Order]^3^NURSC^11^412^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15286,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15286,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15287,0)
 ;;=[Extra Order]^3^NURSC^11^413^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15287,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15287,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15288,0)
 ;;=healthy oral mucous membranes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15289,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^292^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15289,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15289,1,1,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15289,1,2,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15289,1,3,0)
 ;;=795^pain and discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15289,1,4,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15289,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15290,0)
 ;;=describes diet,fluid restrictions,& food content^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15290,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15290,10)
 ;;=D EN2^NURCCPU1
