NURCCGCA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9586,0)
 ;;=Related Problems^2^NURSC^7^111^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9586,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,9586,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9586,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9586,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^128^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,0)
 ;;=^124.21PI^15^13
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,1,0)
 ;;=1677^recognizes knowledge deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,2,0)
 ;;=1678^describes cardiovascular status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,3,0)
 ;;=1443^accepts therapeutic regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,4,0)
 ;;=1680^verbalizes anxiety is resolved^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,5,0)
 ;;=980^verbalizes medication regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,6,0)
 ;;=1681^maintains medication regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,9,0)
 ;;=1699^lists cardiac risk factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,10,0)
 ;;=9607^verbalizes need for con't follow-up: disease progression^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,11,0)
 ;;=1696^does not smoke^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,12,0)
 ;;=9684^[Extra Goal]^3^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,13,0)
 ;;=15303^verbalizes adequate healthcare knowledge for H-C decisions ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,14,0)
 ;;=15305^verbalizes appropriate knowledge base: reduce kidney damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,1,15,0)
 ;;=15306^verbalizes knowledge of self-care needs & to leave hospital^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9589,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9607,0)
 ;;=verbalizes need for con't follow-up: disease progression^3^NURSC^9^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9607,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9607,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9609,0)
 ;;=[Extra Goal]^3^NURSC^9^160^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9609,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9609,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^109^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,0)
 ;;=^124.21PI^20^17
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,1,0)
 ;;=1706^assess pt's knowledge base concerning his illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,2,0)
 ;;=1707^identify cause of lack of knowledge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,3,0)
 ;;=1709^determine readiness/ability to learn^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,5,0)
 ;;=1715^relate pathology to patient's symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,6,0)
 ;;=1748^stress avoidance of crossing legs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,7,0)
 ;;=1750^stress avoidance of standing for long periods^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,8,0)
 ;;=1751^stress avoidance of restrictive clothing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,9,0)
 ;;=1753^elevate legs when feasible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,10,0)
 ;;=1755^include S/O when instructing as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,13,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,14,0)
 ;;=9648^teach importance: diet & meds to minimize disease progress^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,15,0)
 ;;=9895^[Extra Order]^3^NURSC^167
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,16,0)
 ;;=172^implement teaching plan based on readiness/ability to learn^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,17,0)
 ;;=174^evaluate effectiveness of teaching plan^3^NURSC^1
