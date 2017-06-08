NURCCG8W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4724,1,1,0)
 ;;=4726^free from paradoxical breathing/respiratory alternans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4724,1,2,0)
 ;;=4728^[Extra Goal]^3^NURSC^214
 ;;^UTILITY("^GMRD(124.2,",$J,4724,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4725,0)
 ;;=normal respiratory rate for pt [specify range]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4725,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4725,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4726,0)
 ;;=free from paradoxical breathing/respiratory alternans^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4726,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4726,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4727,0)
 ;;=Health Knowledge Deficit Related to Hypertension^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4727,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4727,1,1,0)
 ;;=4729^Etiology/Related and/or Risk Factors^2^NURSC^221
 ;;^UTILITY("^GMRD(124.2,",$J,4727,1,2,0)
 ;;=4739^Goals/Expected Outcomes^2^NURSC^226
 ;;^UTILITY("^GMRD(124.2,",$J,4727,1,3,0)
 ;;=4746^Nursing Intervention/Orders^2^NURSC^227
 ;;^UTILITY("^GMRD(124.2,",$J,4727,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4727,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4727,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4728,0)
 ;;=[Extra Goal]^3^NURSC^9^214^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4728,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4728,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4729,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^221^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4729,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4729,1,1,0)
 ;;=160^information misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4729,1,2,0)
 ;;=4735^unfamiliar with information resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4729,1,3,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4729,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4730,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^225^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4730,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4730,1,1,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4730,1,2,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4730,1,3,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4730,1,4,0)
 ;;=4848^[Extra Order]^3^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,4730,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4730,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4735,0)
 ;;=unfamiliar with information resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4736,0)
 ;;=attains,maintains patency of airway^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4736,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4736,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4737,0)
 ;;=[Extra Order]^3^NURSC^11^29^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4737,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4737,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4738,0)
 ;;=[Extra Problem]^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4738,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4738,1,1,0)
 ;;=4741^Etiology/Related and/or Risk Factors^2^NURSC^222
 ;;^UTILITY("^GMRD(124.2,",$J,4738,1,3,0)
 ;;=4749^Goals/Expected Outcomes^2^NURSC^227
 ;;^UTILITY("^GMRD(124.2,",$J,4738,1,4,0)
 ;;=4757^Nursing Intervention/Orders^2^NURSC^228
 ;;^UTILITY("^GMRD(124.2,",$J,4738,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4738,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4738,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4739,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^226^1^^T^1
