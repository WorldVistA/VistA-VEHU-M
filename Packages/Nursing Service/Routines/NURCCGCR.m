NURCCGCR ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10294,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10294,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^118^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,0)
 ;;=^124.21PI^19^15
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,1,0)
 ;;=1706^assess pt's knowledge base concerning his illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,2,0)
 ;;=1707^identify cause of lack of knowledge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,3,0)
 ;;=1709^determine readiness/ability to learn^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,5,0)
 ;;=1715^relate pathology to patient's symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,6,0)
 ;;=1748^stress avoidance of crossing legs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,7,0)
 ;;=1750^stress avoidance of standing for long periods^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,8,0)
 ;;=1751^stress avoidance of restrictive clothing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,9,0)
 ;;=1753^elevate legs when feasible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,10,0)
 ;;=1755^include S/O when instructing as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,13,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,15,0)
 ;;=10996^[Extra Order]^3^NURSC^182
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,16,0)
 ;;=15012^discuss importance of maintaining drug schedule (eye drops)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,17,0)
 ;;=15246^advise patient to report severe eye pain,inflammation,etc^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,18,0)
 ;;=15260^inform patient/SO: clinic visit,need for follow-up care,etc^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,1,19,0)
 ;;=15264^advise patient/SO to maintain safe home environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10318,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10323,0)
 ;;=identifies interventions to prevent/reduce risk of infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10323,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10323,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10332,0)
 ;;=[Extra Problem]^2^NURSC^2^23^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,10332,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10332,1,1,0)
 ;;=10335^Etiology/Related and/or Risk Factors^2^NURSC^269
 ;;^UTILITY("^GMRD(124.2,",$J,10332,1,2,0)
 ;;=10343^Goals/Expected Outcomes^2^NURSC^281
 ;;^UTILITY("^GMRD(124.2,",$J,10332,1,3,0)
 ;;=10354^Nursing Intervention/Orders^2^NURSC^285
 ;;^UTILITY("^GMRD(124.2,",$J,10332,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10332,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10332,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10335,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^269^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10335,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10335,1,1,0)
 ;;=10340^[etiology]^3^NURSC^64
 ;;^UTILITY("^GMRD(124.2,",$J,10335,1,2,0)
 ;;=10342^[etiology]^3^NURSC^65
 ;;^UTILITY("^GMRD(124.2,",$J,10335,1,3,0)
 ;;=10743^[etiology]^3^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,10335,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10338,0)
 ;;=[etiology]^3^NURSC^^66^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10340,0)
 ;;=[etiology]^3^NURSC^^64^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10342,0)
 ;;=[etiology]^3^NURSC^^65^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10343,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^281^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10343,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10343,1,1,0)
 ;;=10347^[Extra Goal]^3^NURSC^350
 ;;^UTILITY("^GMRD(124.2,",$J,10343,1,2,0)
 ;;=10349^[Extra Goal]^3^NURSC^351
