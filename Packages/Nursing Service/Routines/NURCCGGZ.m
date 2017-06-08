NURCCGGZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15845,1,2,0)
 ;;=15851^Goals/Expected Outcomes^2^NURSC^319
 ;;^UTILITY("^GMRD(124.2,",$J,15845,1,3,0)
 ;;=15855^Nursing Intervention/Orders^2^NURSC^321
 ;;^UTILITY("^GMRD(124.2,",$J,15845,1,4,0)
 ;;=15857^Etiology/Related and/or Risk Factors^2^NURSC^306
 ;;^UTILITY("^GMRD(124.2,",$J,15845,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15845,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15845,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15846,0)
 ;;=teach alternate methods for task accomplishment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15846,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15846,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15847,0)
 ;;=teach assertive versus aggressive behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15847,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15847,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15849,0)
 ;;=teach effective methods for relieving tension/stress^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15849,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15849,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15850,0)
 ;;=teach family/SO use of assistive/adaptive devices^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15850,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15850,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15851,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^319^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15851,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15851,1,1,0)
 ;;=3211^remains free of injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15851,1,2,0)
 ;;=15873^[Extra Goal]^3^NURSC^23
 ;;^UTILITY("^GMRD(124.2,",$J,15851,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15852,0)
 ;;=teach patient signs/symptoms of infection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15852,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15852,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15853,0)
 ;;=teach positive coping methods for pain relief^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15853,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15853,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15854,0)
 ;;=teach positive methods for problem resolution^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15854,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15854,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15855,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^321^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15855,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15855,1,1,0)
 ;;=15715^provide safe environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15855,1,2,0)
 ;;=15859^[Extra Order]^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,15855,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15855,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15856,0)
 ;;=[Extra Order]^3^NURSC^11^269^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15856,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15856,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15857,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^306^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,1,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,2,0)
 ;;=1096^depressive behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,3,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,4,0)
 ;;=1097^hallucination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,5,0)
 ;;=1092^inadequate perfusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,6,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,7,0)
 ;;=1112^psychosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,8,0)
 ;;=1093^seizure^3^NURSC^1
