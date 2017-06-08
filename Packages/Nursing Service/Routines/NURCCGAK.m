NURCCGAK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6380,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6381,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^175^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6381,1,0)
 ;;=^124.21PI^13^4
 ;;^UTILITY("^GMRD(124.2,",$J,6381,1,1,0)
 ;;=6382^perform skin assessment & document findings related to:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6381,1,8,0)
 ;;=6404^vital signs q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6381,1,10,0)
 ;;=6406^provide wound care/dressing change q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6381,1,13,0)
 ;;=6409^[Extra Order]^3^NURSC^131
 ;;^UTILITY("^GMRD(124.2,",$J,6381,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6381,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6382,0)
 ;;=perform skin assessment & document findings related to:^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,1,0)
 ;;=1805^area(s) in question [location] q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,2,0)
 ;;=1806^color q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,3,0)
 ;;=1808^size q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,4,0)
 ;;=1809^presence of pain/discomfort q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,5,0)
 ;;=1810^presence/absence of drainage q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,1,6,0)
 ;;=2952^temperature per[route] q[ frequency ]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6382,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6382,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6382,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6404,0)
 ;;=vital signs q[frequency]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6404,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6404,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6406,0)
 ;;=provide wound care/dressing change q[frequency]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6406,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6406,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6409,0)
 ;;=[Extra Order]^3^NURSC^11^131^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6409,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6409,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6410,0)
 ;;=Related Problems^2^NURSC^7^76^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6410,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6410,1,1,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6410,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6410,1,3,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6410,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6414,0)
 ;;=Defining Characteristics^2^NURSC^12^83^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6414,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6414,1,1,0)
 ;;=4225^destruction of skin layers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6414,1,2,0)
 ;;=4226^disruption of skin surface^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6414,1,3,0)
 ;;=4235^invasion of body structures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6414,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6418,0)
 ;;=Knowledge Deficit [specify]^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6418,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6418,1,1,0)
 ;;=6419^Etiology/Related and/or Risk Factors^2^NURSC^90
 ;;^UTILITY("^GMRD(124.2,",$J,6418,1,2,0)
 ;;=6427^Goals/Expected Outcomes^2^NURSC^89
 ;;^UTILITY("^GMRD(124.2,",$J,6418,1,3,0)
 ;;=6440^Nursing Intervention/Orders^2^NURSC^176
 ;;^UTILITY("^GMRD(124.2,",$J,6418,1,4,0)
 ;;=6457^Defining Characteristics^2^NURSC^84
 ;;^UTILITY("^GMRD(124.2,",$J,6418,7)
 ;;=D EN3^NURCCPU0
