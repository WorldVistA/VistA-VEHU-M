NURCCG36 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1072,0)
 ;;=teach appropriate drug use and timing for pain management^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1072,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1072,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1073,0)
 ;;=evaluate for stress management^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1073,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1073,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1074,0)
 ;;=apply anti-embolic stockings as prescribed^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1074,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1074,1,1,0)
 ;;=1075^remove and reapply q [frequency] hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1074,1,2,0)
 ;;=1076^avoid wrinkles, check q [frequency] hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1074,1,3,0)
 ;;=1077^check pulse rate q [frequency] hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1074,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1074,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1074,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1074,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1075,0)
 ;;=remove and reapply q [frequency] hrs.^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1076,0)
 ;;=avoid wrinkles, check q [frequency] hrs.^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1077,0)
 ;;=check pulse rate q [frequency] hrs.^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1078,0)
 ;;=chronic physical/psychosocial disability^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1079,0)
 ;;=avoidance of Valsalva maneuver^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1080,0)
 ;;=risk factors, preventive measures for CAD^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1081,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^26^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,1,0)
 ;;=1092^inadequate perfusion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,2,0)
 ;;=1043^injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,3,0)
 ;;=458^disease process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,4,0)
 ;;=1093^seizure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,5,0)
 ;;=1094^surgery involving cerebral hemisphere^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,6,0)
 ;;=1095^sensory overload/monitoring^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,7,0)
 ;;=1096^depressive behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,8,0)
 ;;=1112^psychosis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,9,0)
 ;;=1097^hallucination^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,1,10,0)
 ;;=419^anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1081,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1082,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^25^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,1,0)
 ;;=1087^verbalizes understanding of health and self care situations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,2,0)
 ;;=1088^appears free from anxiety about health care situations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,3,0)
 ;;=1089^demonstrates the ability to maintain safety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,4,0)
 ;;=1090^has no injury due to altered cognitive ability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,5,0)
 ;;=1091^has an adequate balance of social and physical stimulation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1082,1,6,0)
 ;;=2890^[Extra Goal]^3^NURSC^67^0
 ;;^UTILITY("^GMRD(124.2,",$J,1082,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1083,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^22^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1083,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1083,1,1,0)
 ;;=1084^assess level of understanding and decision making ability^3^NURSC^1^0
