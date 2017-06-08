NURCCGGF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15509,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15510,0)
 ;;=WBC above normal limits, and/or bacteria in urine^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15511,0)
 ;;=demonstrates gradual improvement in visual/spatial episodes^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15511,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15511,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15512,0)
 ;;=purulent drainage^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15513,0)
 ;;=[additional S/S]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15514,0)
 ;;=remains free of S/S of pulmonary infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15514,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15514,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15515,0)
 ;;=remains free of S/S of surgical wound infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15515,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15515,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15516,0)
 ;;=anemic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15517,0)
 ;;=hypertension^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15518,0)
 ;;=prone to CAD^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15520,0)
 ;;=change incisional dressings q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15520,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15520,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15521,0)
 ;;=assess integrity of chest tubes/drainage system q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15521,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,15521,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15521,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15522,0)
 ;;=assess incision site for S/S of infection q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15522,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,15522,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15522,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15523,0)
 ;;=monitor pulse/BP during activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15523,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15523,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15524,0)
 ;;=involve family in decisions as indicated by client^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15524,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15524,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15525,0)
 ;;=chronic illness required lifelong invasive/debilitating tx^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15526,0)
 ;;=cardiac enzymes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15528,0)
 ;;=weigh qd @ home (avoid 4# wt gain between tx)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15530,0)
 ;;=teach pt to turn/ambulate while supporting chest tubes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15530,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15530,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15531,0)
 ;;=review hx for evidence of non-compliance with treatment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15531,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15531,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15533,0)
 ;;=[Extra Problem]^2^NURSC^2^53^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15533,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15533,1,1,0)
 ;;=15534^Etiology/Related and/or Risk Factors^2^NURSC^296
 ;;^UTILITY("^GMRD(124.2,",$J,15533,1,2,0)
 ;;=15538^Goals/Expected Outcomes^2^NURSC^309
 ;;^UTILITY("^GMRD(124.2,",$J,15533,1,3,0)
 ;;=15542^Nursing Intervention/Orders^2^NURSC^311
 ;;^UTILITY("^GMRD(124.2,",$J,15533,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15533,9)
 ;;=D EN2^NURCCPU3
