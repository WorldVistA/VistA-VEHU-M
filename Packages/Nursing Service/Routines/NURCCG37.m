NURCCG37 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1083,1,2,0)
 ;;=1085^delay teaching until transient condition stabilizes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1083,1,3,0)
 ;;=1086^alter teaching strategy to correspond with need/ability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1083,1,4,0)
 ;;=2977^[Extra Order]^3^NURSC^60^0
 ;;^UTILITY("^GMRD(124.2,",$J,1083,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1083,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1084,0)
 ;;=assess level of understanding and decision making ability^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1084,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1084,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1085,0)
 ;;=delay teaching until transient condition stabilizes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1085,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1085,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1086,0)
 ;;=alter teaching strategy to correspond with need/ability^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1086,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1086,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1087,0)
 ;;=verbalizes understanding of health and self care situations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1087,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1087,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1088,0)
 ;;=appears free from anxiety about health care situations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1088,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1088,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1089,0)
 ;;=demonstrates the ability to maintain safety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1089,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1089,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1090,0)
 ;;=has no injury due to altered cognitive ability^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1090,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1090,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1091,0)
 ;;=has an adequate balance of social and physical stimulation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1091,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1091,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1092,0)
 ;;=inadequate perfusion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1093,0)
 ;;=seizure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1094,0)
 ;;=surgery involving cerebral hemisphere^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1095,0)
 ;;=sensory overload/monitoring^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1096,0)
 ;;=depressive behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1097,0)
 ;;=hallucination^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1098,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^27^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,1,0)
 ;;=1101^anatomic deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,2,0)
 ;;=1102^cultural differences^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,3,0)
 ;;=1103^decrease in circulation to the brain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,4,0)
 ;;=1104^developmental/age-related^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,5,0)
 ;;=1106^physical barrier: brain tumor, tracheostomy, intubation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,6,0)
 ;;=1107^psychological barriers, psychosis, lack of stimuli^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,7,0)
 ;;=1108^inability to speak^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,8,0)
 ;;=92^impaired cognition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,9,0)
 ;;=1038^reduced consciousness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,10,0)
 ;;=1109^voice rest (medical protocol)^3^NURSC^1^0
