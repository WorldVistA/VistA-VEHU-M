NURCCG3C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1149,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1149,1,1,0)
 ;;=1285^coffee^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1149,1,2,0)
 ;;=1286^tea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1149,1,3,0)
 ;;=640^other [ ADDITIONAL TEXT ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1149,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1149,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1149,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1150,0)
 ;;=positive reinforcement for voiding/absence of incontinence^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1150,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1150,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1151,0)
 ;;=initiate bladder training program^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1151,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1151,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1152,0)
 ;;=establish procedures/treatments for LCA occlusion^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1152,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1152,1,1,0)
 ;;=1154^IABP assist^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1152,1,2,0)
 ;;=1155^temporary pacemaker^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1152,1,3,0)
 ;;=1156^antiarrhythmic agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1152,1,4,0)
 ;;=1157^defibrillation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1152,1,5,0)
 ;;=1718^Swan-Ganz line^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1152,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1152,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1152,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1152,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1153,0)
 ;;=discuss reason for incontinence^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1153,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1153,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1154,0)
 ;;=IABP assist^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1155,0)
 ;;=temporary pacemaker^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1156,0)
 ;;=antiarrhythmic agents^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1157,0)
 ;;=defibrillation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1158,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^30^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1158,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1158,1,1,0)
 ;;=1163^invasive procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1158,1,2,0)
 ;;=1164^urinary collection device: external cath^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1158,1,3,0)
 ;;=1165^urinary collection device: indwelling cath^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1158,1,4,0)
 ;;=1166^urinary collection device: straight cath^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1158,1,5,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1158,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1159,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^28^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1159,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1159,1,1,0)
 ;;=1169^remains free of S/S of infection^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1159,1,2,0)
 ;;=1177^expresses understanding of S/S of possible urine infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1159,1,3,0)
 ;;=1178^demonstrates practices to prevent recurrence^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1159,1,4,0)
 ;;=2685^urine C&S is negative for infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1159,1,5,0)
 ;;=2893^[Extra Goal]^3^NURSC^72^0
 ;;^UTILITY("^GMRD(124.2,",$J,1159,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1160,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^25^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,0)
 ;;=^124.21PI^20^20
 ;;^UTILITY("^GMRD(124.2,",$J,1160,1,1,0)
 ;;=1183^assess and record:^2^NURSC^1^0
