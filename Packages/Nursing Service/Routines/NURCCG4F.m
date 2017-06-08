NURCCG4F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1674,0)
 ;;=Noncompliance/Nonadherence [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1675,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^43^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,1,0)
 ;;=1677^recognizes knowledge deficit^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,2,0)
 ;;=1678^describes cardiovascular status^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,3,0)
 ;;=1443^accepts therapeutic regimen^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,4,0)
 ;;=1680^verbalizes anxiety is resolved^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,5,0)
 ;;=980^verbalizes medication regimen^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,6,0)
 ;;=1681^maintains medication regimen^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,7,0)
 ;;=1683^adheres to dietary modification^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,8,0)
 ;;=1692^uses methods to improve circulation^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,9,0)
 ;;=1699^lists cardiac risk factors^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,10,0)
 ;;=1701^keeps clinic appointments^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,11,0)
 ;;=1696^does not smoke^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,12,0)
 ;;=2907^[Extra Goal]^3^NURSC^87^0
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,13,0)
 ;;=2487^verbalizes knowledge of disease process & treatment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1675,1,14,0)
 ;;=11354^discusses own role in preventing recurrence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,1675,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1676,0)
 ;;=inspect skin/mucous membranes q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1676,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1676,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1677,0)
 ;;=recognizes knowledge deficit^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1677,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1677,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1678,0)
 ;;=describes cardiovascular status^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1678,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1678,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1679,0)
 ;;=provide skin care q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1679,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1679,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1680,0)
 ;;=verbalizes anxiety is resolved^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1680,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1680,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1681,0)
 ;;=maintains medication regimen^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1681,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1681,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1682,0)
 ;;=provide patient teaching^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,1,0)
 ;;=2938^assess knowledge base^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,2,0)
 ;;=2940^decide what patient needs to know^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,3,0)
 ;;=2939^determine ability to learn and implement plan^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,4,0)
 ;;=2941^evaluate effectiveness of teaching plan^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,5,0)
 ;;=2942^implement teaching plan based on readiness/ability to learn^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1682,1,6,0)
 ;;=2943^involve S/O in teaching plan^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1682,5)
 ;;=by:
 ;;^UTILITY("^GMRD(124.2,",$J,1682,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1682,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1682,10)
 ;;=D EN1^NURCCPU3
