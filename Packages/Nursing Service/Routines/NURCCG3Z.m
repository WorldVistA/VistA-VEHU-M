NURCCG3Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1461,0)
 ;;=PAW WNL (baseline)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1462,0)
 ;;=I&O q[frequency]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1462,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1462,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1462,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1463,0)
 ;;=assess for S/S of pulmonary edema q [frequency]^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1463,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1463,1,1,0)
 ;;=1464^interstitial edema on x-ray^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1463,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1463,1,3,0)
 ;;=1466^PND/cough (dry, hacking)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1463,1,4,0)
 ;;=1467^increased JVD^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1463,1,5,0)
 ;;=1468^tachypnea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1463,4)
 ;;=; monitor, document, and notify MD
 ;;^UTILITY("^GMRD(124.2,",$J,1463,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1463,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1463,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1464,0)
 ;;=interstitial edema on x-ray^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1465,0)
 ;;=dyspnea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1466,0)
 ;;=PND/cough (dry, hacking)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1467,0)
 ;;=increased JVD^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1468,0)
 ;;=tachypnea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1469,0)
 ;;=assess for ankle edema/anasarca/ascitis^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1469,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1469,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1469,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1470,0)
 ;;=assess for abdominal tenderness q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1470,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1470,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1471,0)
 ;;=assess for EKG changes q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1471,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1471,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1471,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1472,0)
 ;;=assess for extra heart sounds q [frequency] and record^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1472,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1472,1,1,0)
 ;;=991^S3 or S4^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1472,1,2,0)
 ;;=1473^murmur^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1472,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1472,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1472,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1473,0)
 ;;=murmur^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1474,0)
 ;;=lab data^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,1,0)
 ;;=1475^increased specific gravity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,2,0)
 ;;=1476^significant proteinuria^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,3,0)
 ;;=1477^granular casts^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,4,0)
 ;;=1478^elevated BUN^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,5,0)
 ;;=1479^serum levels of K+, Na+, and CO2^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,6,0)
 ;;=1480^elevated MCV^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,7,0)
 ;;=1481^low hemoglobin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,8,0)
 ;;=1482^low hematocrit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,1,9,0)
 ;;=1540^Dixogin levels^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1474,5)
 ;;=; assess, monitor, and document
