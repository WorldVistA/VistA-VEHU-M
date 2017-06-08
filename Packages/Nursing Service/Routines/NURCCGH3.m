NURCCGH3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15893,1,3,0)
 ;;=1976^Etiology/Related and/or Risk Factors^2^NURSC^53
 ;;^UTILITY("^GMRD(124.2,",$J,15893,1,4,0)
 ;;=15895^Goals/Expected Outcomes^2^NURSC^323
 ;;^UTILITY("^GMRD(124.2,",$J,15893,1,5,0)
 ;;=15902^Nursing Intervention/Orders^2^NURSC^325
 ;;^UTILITY("^GMRD(124.2,",$J,15893,1,6,0)
 ;;=1985^Related Problems^2^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,15893,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15893,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15893,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15894,0)
 ;;=Defining Characteristics^2^NURSC^12^91^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15894,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15894,1,1,0)
 ;;=605^altered body structure or function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15894,1,2,0)
 ;;=4120^changed ability to estimate relationship of body/environmt^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15894,1,3,0)
 ;;=4132^inability to accept positive reinforcement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15894,1,4,0)
 ;;=4127^missing body part^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15894,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15895,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^323^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15895,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15895,1,1,0)
 ;;=15896^demonstrates beginning adaptations to loss by:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15895,1,2,0)
 ;;=15933^[Extra Goal]^3^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,15895,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,0)
 ;;=demonstrates beginning adaptations to loss by:^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15896,1,1,0)
 ;;=15897^verbalization of feelings of self-worth^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,1,2,0)
 ;;=15898^active participation in ADLs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,1,3,0)
 ;;=15899^maintenance of relationships with significant others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,1,4,0)
 ;;=15900^participation in social activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15896,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15896,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15897,0)
 ;;=verbalization of feelings of self-worth^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15898,0)
 ;;=active participation in ADLs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15899,0)
 ;;=maintenance of relationships with significant others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15900,0)
 ;;=participation in social activities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15901,0)
 ;;=[Extra Goal]^3^NURSC^9^25^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15901,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15901,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15902,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^325^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,1,0)
 ;;=15892^encourage verbalization of physical/emotional changes^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,2,0)
 ;;=15904^help to identify alternative behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,3,0)
 ;;=14327^teach coping strategies^2^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,4,0)
 ;;=15905^assist patient to identify personal strengths^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,5,0)
 ;;=15906^assist patient to acknowledge limitations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15902,1,6,0)
 ;;=15907^[Extra Order]^3^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,15902,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15902,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15904,0)
 ;;=help to identify alternative behaviors^3^NURSC^11^1^^^T
