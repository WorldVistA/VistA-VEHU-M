NURCCG38 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,11,0)
 ;;=1110^tracheostomy (medical protocol)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,12,0)
 ;;=1111^intubation (medical protocol)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,13,0)
 ;;=1112^psychosis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,14,0)
 ;;=1113^language barriers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,15,0)
 ;;=1114^inability to understand^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,16,0)
 ;;=1115^impaired articulation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,17,0)
 ;;=573^surgery^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,1,18,0)
 ;;=1116^tissue damage-hearing loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1098,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1099,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^26^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1099,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1099,1,1,0)
 ;;=1117^preserves individual integrity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1099,1,2,0)
 ;;=2674^demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1099,1,3,0)
 ;;=2675^develops a mechanism (system) for communication^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1099,1,4,0)
 ;;=33^communicates within capacity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1099,1,5,0)
 ;;=2891^[Extra Goal]^3^NURSC^68^0
 ;;^UTILITY("^GMRD(124.2,",$J,1099,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1100,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^23^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1100,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1100,1,1,0)
 ;;=1444^assess for reliable response/successful communication mode:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1100,1,2,0)
 ;;=1450^if unreliable response/attempt communication mode:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1100,1,3,0)
 ;;=1455^reassess communication ability q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1100,1,4,0)
 ;;=2978^[Extra Order]^3^NURSC^61^0
 ;;^UTILITY("^GMRD(124.2,",$J,1100,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1100,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1101,0)
 ;;=anatomic deficit [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1102,0)
 ;;=cultural differences^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1103,0)
 ;;=decrease in circulation to the brain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1104,0)
 ;;=developmental/age-related^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1105,0)
 ;;=assess for EKG changes (lead 1/AVL/V1-V4)^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1105,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1105,1,1,0)
 ;;=1137^congestive heart failure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1105,1,2,0)
 ;;=1138^cardiogenic shock^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1105,1,3,0)
 ;;=1140^arrhythmias associated with pump failure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1105,1,4,0)
 ;;=1142^intraventricular conduction disturbances^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1105,5)
 ;;=; record and notify MD
 ;;^UTILITY("^GMRD(124.2,",$J,1105,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1105,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1105,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1106,0)
 ;;=physical barrier: brain tumor, tracheostomy, intubation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1107,0)
 ;;=psychological barriers, psychosis, lack of stimuli^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1108,0)
 ;;=inability to speak^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1109,0)
 ;;=voice rest (medical protocol)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1110,0)
 ;;=tracheostomy (medical protocol)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1111,0)
 ;;=intubation (medical protocol)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1112,0)
 ;;=psychosis^3^NURSC^^1^^^T
