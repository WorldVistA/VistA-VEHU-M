NURCCG3H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,7,0)
 ;;=1293^provide with product resources to prevent wetting of clothes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,8,0)
 ;;=2981^[Extra Order]^3^NURSC^64^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1213,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1214,0)
 ;;=Related Problems^2^NURSC^7^23^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1214,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1214,1,1,0)
 ;;=1410^Urinary Elimination, Alteration In Pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1214,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1214,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1215,0)
 ;;=weak pelvic muscles and structural support^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1216,0)
 ;;=heart rate/rhythm q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1216,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1216,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1216,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1217,0)
 ;;=degenerative changes associated with increased age^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1218,0)
 ;;=high intra-abdominal pressure (e.g. obesity/gravid uterus)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1219,0)
 ;;=incompetent bladder outlet^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1220,0)
 ;;=overdistention between voiding^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1221,0)
 ;;=assess for presence of pulse deficit q[frequency] hrs.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1221,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1221,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1222,0)
 ;;=monitor for warning dysrhythmia^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1222,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1222,1,1,0)
 ;;=1224^PVCs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1222,1,2,0)
 ;;=1233^ventricular tachycardia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1222,1,3,0)
 ;;=1234^bradycardia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1222,1,4,0)
 ;;=1236^progressive heart block^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1222,4)
 ;;=assess and 
 ;;^UTILITY("^GMRD(124.2,",$J,1222,5)
 ;;=and document the following:
 ;;^UTILITY("^GMRD(124.2,",$J,1222,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1222,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1222,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1223,0)
 ;;=acknowledges need for muscle/sphincter exercises^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1223,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1223,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1224,0)
 ;;=PVCs^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1224,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1224,1,1,0)
 ;;=1226^two in a row (couplets or pairs)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1224,1,2,0)
 ;;=1227^bigeminy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1224,1,3,0)
 ;;=1229^multifocal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1224,1,4,0)
 ;;=1230^six or more a minute^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1224,1,5,0)
 ;;=1231^R on T pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1224,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1224,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1225,0)
 ;;=describes causes^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1225,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1225,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1226,0)
 ;;=two in a row (couplets or pairs)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1227,0)
 ;;=bigeminy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1228,0)
 ;;=demonstrates pelvic floor muscle exercises^3^NURSC^9^1^^^T
