NURCCG3D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,2,0)
 ;;=1143^assess/record bladder distention q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,3,0)
 ;;=1193^assess patency of indwelling catheter^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,4,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,5,0)
 ;;=1194^record I/O q[frequency] until voiding [amt]cc/void^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,6,0)
 ;;=1195^monitor urine pH^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,7,0)
 ;;=1196^specific gravity q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,8,0)
 ;;=1197^monitor U/A C/S^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,9,0)
 ;;=1198^determine balance I/O q 24 hours^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,10,0)
 ;;=1199^encourage fluid intake (pt preference) to [ ]cc q [ ]hr^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,11,0)
 ;;=1200^cath care q[frequency]hr^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,12,0)
 ;;=1180^perineal hygiene q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,13,0)
 ;;=1202^female patients:cleanse perineum/urethra from front to back^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,14,0)
 ;;=1203^replace external cath. q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,15,0)
 ;;=1204^change collection [specify] bag q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,16,0)
 ;;=937^provide privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,17,0)
 ;;=1205^run water while attempting to void^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,18,0)
 ;;=1206^acidify urine by offering cranberry juice^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,19,0)
 ;;=1207^initiate teaching protocol on S/S of urinary infection:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,20,0)
 ;;=2980^[Extra Order]^3^NURSC^63^0
 ;;^UTILITY("^GMRD(124.2,",$J,1160,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1160,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1161,0)
 ;;=Related Problems^2^NURSC^7^22^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1161,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1161,1,1,0)
 ;;=1410^Urinary Elimination, Alteration In Pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1161,1,2,0)
 ;;=1412^Urinary Retention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1161,1,3,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1161,1,4,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1161,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1162,0)
 ;;=assess for EKG changes (leads II/III/AVF)^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,1,0)
 ;;=1167^sinus node disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,2,0)
 ;;=1168^escape beats and rhythm^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,3,0)
 ;;=1170^nonparoxysmal ventricular tachycardia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,4,0)
 ;;=1171^premature ventricular beats and ventricular fibrillation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,5,0)
 ;;=1172^AV block progressing to complete heart block^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1162,1,6,0)
 ;;=1173^atrial arrhythmias^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1162,5)
 ;;=; record and notify MD
 ;;^UTILITY("^GMRD(124.2,",$J,1162,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1162,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1162,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1163,0)
 ;;=invasive procedures^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1164,0)
 ;;=urinary collection device: external cath^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1165,0)
 ;;=urinary collection device: indwelling cath^3^NURSC^^1^^^T
