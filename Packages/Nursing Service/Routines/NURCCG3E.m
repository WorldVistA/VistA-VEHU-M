NURCCG3E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1166,0)
 ;;=urinary collection device: straight cath^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1167,0)
 ;;=sinus node disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1168,0)
 ;;=escape beats and rhythm^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1169,0)
 ;;=remains free of S/S of infection^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1169,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1169,1,1,0)
 ;;=2665^pain^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1169,1,2,0)
 ;;=2666^burning^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1169,1,3,0)
 ;;=2667^frequency on voiding^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1169,1,4,0)
 ;;=2686^afebrile^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1169,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,1169,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1169,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1169,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1170,0)
 ;;=nonparoxysmal ventricular tachycardia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1171,0)
 ;;=premature ventricular beats and ventricular fibrillation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1172,0)
 ;;=AV block progressing to complete heart block^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1173,0)
 ;;=atrial arrhythmias^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1174,0)
 ;;=burning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1175,0)
 ;;=frequency on voiding^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1176,0)
 ;;=establish procedures/treatments for RCA occlusion^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1176,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1176,1,1,0)
 ;;=1155^temporary pacemaker^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1176,1,2,0)
 ;;=1156^antiarrhythmic agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1176,1,3,0)
 ;;=1157^defibrillation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1176,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1176,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1176,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1176,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1177,0)
 ;;=expresses understanding of S/S of possible urine infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1177,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1177,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1178,0)
 ;;=demonstrates practices to prevent recurrence^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1178,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1178,1,1,0)
 ;;=1179^voiding schedule^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1178,1,2,0)
 ;;=1181^self-cath with clean technique^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1178,1,3,0)
 ;;=2668^proper catheter care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1178,1,4,0)
 ;;=2861^perineal hygiene^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1178,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1178,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1178,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1179,0)
 ;;=voiding schedule^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1180,0)
 ;;=perineal hygiene q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1180,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1180,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1181,0)
 ;;=self-cath with clean technique^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1182,0)
 ;;=adequate cardiac output while using commode^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1182,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1182,1,1,0)
 ;;=1186^heart rate/rhythm unchanged^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1182,1,2,0)
 ;;=1189^skin color and temperature unchanged^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1182,5)
 ;;=as evidenced by
