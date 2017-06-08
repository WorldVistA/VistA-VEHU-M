NURCCG95 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4826,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^230^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4826,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4826,1,1,0)
 ;;=4831^physical disability, chronic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4826,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4827,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^14^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4827,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4827,1,1,0)
 ;;=4829^Etiology/Related and/or Risk Factors^2^NURSC^231
 ;;^UTILITY("^GMRD(124.2,",$J,4827,1,2,0)
 ;;=4835^Goals/Expected Outcomes^2^NURSC^236
 ;;^UTILITY("^GMRD(124.2,",$J,4827,1,3,0)
 ;;=4845^Nursing Intervention/Orders^2^NURSC^237
 ;;^UTILITY("^GMRD(124.2,",$J,4827,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4827,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4827,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4828,0)
 ;;=[Extra Order]^3^NURSC^11^220^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4828,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4828,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4829,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^231^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4829,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4829,1,1,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4829,1,2,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4829,1,3,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4829,1,4,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4829,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4830,0)
 ;;=[Extra Goal]^3^NURSC^9^220^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4830,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4830,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4831,0)
 ;;=physical disability, chronic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4832,0)
 ;;=assess degree of peripheral dependent edema q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4832,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4832,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4834,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^235^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4834,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4834,1,1,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4834,1,2,0)
 ;;=4916^[Extra Goal]^3^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,4834,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4835,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^236^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4835,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,4835,1,4,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4835,1,5,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4835,1,6,0)
 ;;=4941^[Extra Goal]^3^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,4835,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4837,0)
 ;;=[Extra Goal]^3^NURSC^9^17^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4837,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4837,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4838,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^236^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4838,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,4838,1,1,0)
 ;;=1063^assess level, location and severity of pain q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4838,1,2,0)
 ;;=1065^provide appropriate medical treatment per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4838,1,4,0)
 ;;=4599^teach pain control interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4838,1,5,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
