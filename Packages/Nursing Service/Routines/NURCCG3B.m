NURCCG3B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,8,0)
 ;;=1149^limit diuretic producing liquids:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,9,0)
 ;;=1150^positive reinforcement for voiding/absence of incontinence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,10,0)
 ;;=1151^initiate bladder training program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,11,0)
 ;;=1153^discuss reason for incontinence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,12,0)
 ;;=2979^[Extra Order]^3^NURSC^62^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1135,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1136,0)
 ;;=Related Problems^2^NURSC^7^21^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,1,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,2,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,3,0)
 ;;=1406^Cognitive Impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,4,0)
 ;;=1407^Sensory-Perceptual, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,5,0)
 ;;=1408^Stress Incontinence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,6,0)
 ;;=1409^Infection Potential (Specific to Elimination)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,7,0)
 ;;=1410^Urinary Elimination, Alteration In Pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,8,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,1,9,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1136,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1137,0)
 ;;=congestive heart failure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1138,0)
 ;;=cardiogenic shock^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1139,0)
 ;;=expresses knowledge of voiding patterns^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1139,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1139,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1140,0)
 ;;=arrhythmias associated with pump failure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1141,0)
 ;;=develops fluid intake schedule^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1141,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1141,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1142,0)
 ;;=intraventricular conduction disturbances^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1143,0)
 ;;=assess/record bladder distention q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1143,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1143,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1144,0)
 ;;=record patterns and amounts of incontinences^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1144,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1144,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1145,0)
 ;;=offer urinal/bedpan q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1145,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1145,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1146,0)
 ;;=take to bathroom q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1146,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1146,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1147,0)
 ;;=maintain fluid intake of [ ]cc q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1147,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1147,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1148,0)
 ;;=restrict fluids at bedtime^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1148,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1148,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1149,0)
 ;;=limit diuretic producing liquids:^2^NURSC^11^1^1^^T^1
