NURCCG3V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,13,0)
 ;;=1456^accepts and explains diagnostic procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,14,0)
 ;;=1457^left ventricular end diastolic pressure is decreased^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,15,0)
 ;;=1458^myocardial oxygen demand is minimized^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,16,0)
 ;;=1459^is hemodynamically stable^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,17,0)
 ;;=2901^[Extra Goal]^3^NURSC^80^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1389,0)
 ;;=Health Maintenance, Alteration in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1390,0)
 ;;=record I/O until voiding <[amt]cc void/residual <[amt]cc^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1390,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1390,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1391,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^33^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,0)
 ;;=^124.21PI^23^23
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,1,0)
 ;;=1216^heart rate/rhythm q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,2,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,3,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,4,0)
 ;;=1463^assess for S/S of pulmonary edema q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,5,0)
 ;;=1469^assess for ankle edema/anasarca/ascitis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,6,0)
 ;;=1470^assess for abdominal tenderness q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,7,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,8,0)
 ;;=1472^assess for extra heart sounds q [frequency] and record^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,9,0)
 ;;=1474^lab data^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,10,0)
 ;;=1483^maintains bed rest with commode privileges^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,11,0)
 ;;=1484^place in semi-Fowler's position^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,12,0)
 ;;=1485^assist with meals as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,13,0)
 ;;=1486^provide rest periods q [ ] min/24 hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,14,0)
 ;;=1487^give antiarrhythmic agents as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,15,0)
 ;;=1488^give diuretic therapy as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,16,0)
 ;;=1489^prepare for insertion of pulmonary artery catheterization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,17,0)
 ;;=1490^if PAW increases to 18-25 mmHg, anticipate^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,18,0)
 ;;=1494^if increased SVR, anticipate order for^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,19,0)
 ;;=1501^titrate drugs to therapeutic response and document^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,20,0)
 ;;=1502^reassure patient/SO; explain procedure/therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,21,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,22,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,1,23,0)
 ;;=2988^[Extra Order]^3^NURSC^73^0
 ;;^UTILITY("^GMRD(124.2,",$J,1391,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1391,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1392,0)
 ;;=notify MD if not voided by [time]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1392,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1392,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1393,0)
 ;;=establish daily management schedule [type] q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1393,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1393,10)
 ;;=D EN1^NURCCPU3
