NURCCG3F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1182,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1183,0)
 ;;=assess and record:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,1,0)
 ;;=1184^voiding patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,2,0)
 ;;=1185^sensations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,3,0)
 ;;=1174^burning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,4,0)
 ;;=1187^dysuria^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,5,0)
 ;;=1188^character of urine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,6,0)
 ;;=1175^frequency on voiding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,7,0)
 ;;=1190^amount^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,8,0)
 ;;=1191^hematuria^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,1,9,0)
 ;;=1192^proteinuria^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1183,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1183,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1183,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1184,0)
 ;;=voiding patterns^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1185,0)
 ;;=sensations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1186,0)
 ;;=heart rate/rhythm unchanged^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1187,0)
 ;;=dysuria^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1188,0)
 ;;=character of urine^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1189,0)
 ;;=skin color and temperature unchanged^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1190,0)
 ;;=amount^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1191,0)
 ;;=hematuria^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1192,0)
 ;;=proteinuria^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1193,0)
 ;;=assess patency of indwelling catheter^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1193,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1193,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1194,0)
 ;;=record I/O q[frequency] until voiding [amt]cc/void^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1194,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1194,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1195,0)
 ;;=monitor urine pH^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1195,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1195,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1196,0)
 ;;=specific gravity q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1196,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1196,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1197,0)
 ;;=monitor U/A C/S^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1197,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1197,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1198,0)
 ;;=determine balance I/O q 24 hours^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1198,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1198,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1199,0)
 ;;=encourage fluid intake (pt preference) to [ ]cc q [ ]hr^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1199,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1199,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1200,0)
 ;;=cath care q[frequency]hr^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1200,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1200,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1201,0)
 ;;=level of energy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1202,0)
 ;;=female patients:cleanse perineum/urethra from front to back^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1202,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1202,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1203,0)
 ;;=replace external cath. q [frequency]^3^NURSC^11^1^^^T
