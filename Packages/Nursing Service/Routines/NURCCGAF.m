NURCCGAF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,14,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,15,0)
 ;;=1786^prominence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,17,0)
 ;;=1789^skeletal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6184,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^85^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6184,1,0)
 ;;=^124.21PI^9^3
 ;;^UTILITY("^GMRD(124.2,",$J,6184,1,2,0)
 ;;=1797^achieves intact skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6184,1,7,0)
 ;;=2672^demonstrates ability to manage wound care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6184,1,9,0)
 ;;=6252^[Extra Goal]^3^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,6184,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6193,0)
 ;;=[Extra Goal]^3^NURSC^9^123^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6193,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6193,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6194,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^77^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6194,1,0)
 ;;=^124.21PI^14^3
 ;;^UTILITY("^GMRD(124.2,",$J,6194,1,1,0)
 ;;=6195^perform skin assessment & document findings related to:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6194,1,13,0)
 ;;=6222^[Extra Order]^3^NURSC^127
 ;;^UTILITY("^GMRD(124.2,",$J,6194,1,14,0)
 ;;=7407^wound care/drsg change(s) of [specify area] q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6194,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6194,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6195,0)
 ;;=perform skin assessment & document findings related to:^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6195,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,6195,1,1,0)
 ;;=1805^area(s) in question [location] q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6195,1,2,0)
 ;;=1806^color q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6195,1,4,0)
 ;;=1809^presence of pain/discomfort q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6195,1,5,0)
 ;;=1810^presence/absence of drainage q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6195,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6195,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6195,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6222,0)
 ;;=[Extra Order]^3^NURSC^11^127^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6222,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6222,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6223,0)
 ;;=Related Problems^2^NURSC^7^74^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6223,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6223,1,1,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6223,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6223,1,3,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6223,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6227,0)
 ;;=Defining Characteristics^2^NURSC^12^80^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6227,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6227,1,1,0)
 ;;=4225^destruction of skin layers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6227,1,2,0)
 ;;=4226^disruption of skin surface^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6227,1,3,0)
 ;;=4235^invasion of body structures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6227,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6231,0)
 ;;=Knowledge Deficit [specify]^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6231,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6231,1,1,0)
 ;;=6232^Etiology/Related and/or Risk Factors^2^NURSC^87
 ;;^UTILITY("^GMRD(124.2,",$J,6231,1,2,0)
 ;;=6240^Goals/Expected Outcomes^2^NURSC^86
 ;;^UTILITY("^GMRD(124.2,",$J,6231,1,3,0)
 ;;=6253^Nursing Intervention/Orders^2^NURSC^173
