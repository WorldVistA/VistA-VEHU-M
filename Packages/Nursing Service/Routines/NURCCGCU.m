NURCCGCU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,0)
 ;;=^124.21PI^12^10
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,1,0)
 ;;=1677^recognizes knowledge deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,2,0)
 ;;=1678^describes cardiovascular status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,3,0)
 ;;=1443^accepts therapeutic regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,4,0)
 ;;=1680^verbalizes anxiety is resolved^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,5,0)
 ;;=10531^identifies ways to prevent recurrance of renal calculi^3^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,6,0)
 ;;=1681^maintains medication regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,9,0)
 ;;=1699^lists cardiac risk factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,10,0)
 ;;=1701^keeps clinic appointments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,11,0)
 ;;=1696^does not smoke^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,1,12,0)
 ;;=10774^[Extra Goal]^3^NURSC^177
 ;;^UTILITY("^GMRD(124.2,",$J,10520,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10531,0)
 ;;=identifies ways to prevent recurrance of renal calculi^3^NURSC^9^11^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10531,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10531,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^120^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,0)
 ;;=^124.21PI^13^11
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,1,0)
 ;;=1706^assess pt's knowledge base concerning his illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,2,0)
 ;;=1707^identify cause of lack of knowledge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,3,0)
 ;;=14812^[Extra Order]^3^NURSC^122
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,4,0)
 ;;=15311^instruct on:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,5,0)
 ;;=1715^relate pathology to patient's symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,6,0)
 ;;=1748^stress avoidance of crossing legs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,7,0)
 ;;=1750^stress avoidance of standing for long periods^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,8,0)
 ;;=1751^stress avoidance of restrictive clothing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,9,0)
 ;;=1753^elevate legs when feasible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,10,0)
 ;;=1755^include S/O when instructing as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,1,13,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10555,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10672,0)
 ;;=Related Problems^2^NURSC^7^124^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10672,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,10672,1,1,0)
 ;;=139^coping, ineffective, individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10672,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10672,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,10672,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10675,0)
 ;;=Defining Characteristics^2^NURSC^12^123^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10675,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,10675,1,1,0)
 ;;=4110^inability to wash body,obtain water & regulate water temp^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10675,1,2,0)
 ;;=4112^inability to dress & groom self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10675,1,3,0)
 ;;=4113^inability to feed self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10675,1,4,0)
 ;;=4114^inability to toilet self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10675,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10680,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10680,1,0)
 ;;=^124.21PI^5^5
