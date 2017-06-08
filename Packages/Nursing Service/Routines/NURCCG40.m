NURCCG40 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1474,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1474,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1474,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1475,0)
 ;;=increased specific gravity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1476,0)
 ;;=significant proteinuria^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1477,0)
 ;;=granular casts^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1478,0)
 ;;=elevated BUN^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1479,0)
 ;;=serum levels of K+, Na+, and CO2^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1480,0)
 ;;=elevated MCV^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1481,0)
 ;;=low hemoglobin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1482,0)
 ;;=low hematocrit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1483,0)
 ;;=maintains bed rest with commode privileges^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1483,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1483,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1484,0)
 ;;=place in semi-Fowler's position^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1484,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1484,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1485,0)
 ;;=assist with meals as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1485,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1485,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1486,0)
 ;;=provide rest periods q [ ] min/24 hrs.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1486,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1486,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1487,0)
 ;;=give antiarrhythmic agents as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1487,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1487,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1488,0)
 ;;=give diuretic therapy as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1488,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1488,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1489,0)
 ;;=prepare for insertion of pulmonary artery catheterization^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1489,5)
 ;;=as indicated (see protocol)
 ;;^UTILITY("^GMRD(124.2,",$J,1489,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1489,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1490,0)
 ;;=if PAW increases to 18-25 mmHg, anticipate^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1490,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1490,1,1,0)
 ;;=1491^fluid restriction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1490,1,2,0)
 ;;=1492^increased diuretic therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1490,1,3,0)
 ;;=1493^vasodilator therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1490,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1490,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1490,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1491,0)
 ;;=fluid restriction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1492,0)
 ;;=increased diuretic therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1493,0)
 ;;=vasodilator therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1494,0)
 ;;=if increased SVR, anticipate order for^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1494,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1494,1,1,0)
 ;;=1495^arterial dilators [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1494,1,2,0)
 ;;=1500^arterial/venous dilators [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1494,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1494,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1494,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1495,0)
 ;;=arterial dilators [specify]^3^NURSC^^1^^^T
