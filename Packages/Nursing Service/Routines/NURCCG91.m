NURCCG91 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,5,0)
 ;;=4430^assess heart sounds q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,6,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,7,0)
 ;;=4433^assess assistance needed with ADL q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,8,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,9,0)
 ;;=4438^monitor lab values^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,10,0)
 ;;=4819^[Extra Order]^3^NURSC^218
 ;;^UTILITY("^GMRD(124.2,",$J,4785,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4786,0)
 ;;=[Extra Goal]^3^NURSC^9^283^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4786,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4786,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4787,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^230^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4787,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4787,1,1,0)
 ;;=4790^[Extra Order]^3^NURSC^288
 ;;^UTILITY("^GMRD(124.2,",$J,4787,1,2,0)
 ;;=4792^[Extra Order]^3^NURSC^289
 ;;^UTILITY("^GMRD(124.2,",$J,4787,1,3,0)
 ;;=4793^[Extra Order]^3^NURSC^290
 ;;^UTILITY("^GMRD(124.2,",$J,4787,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4787,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4788,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^225^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4788,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4788,1,1,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4788,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4789,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^230^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4789,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4789,1,1,0)
 ;;=4362^verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4789,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4789,1,3,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4789,1,4,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4789,1,5,0)
 ;;=4809^[Extra Goal]^3^NURSC^217
 ;;^UTILITY("^GMRD(124.2,",$J,4789,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4790,0)
 ;;=[Extra Order]^3^NURSC^11^288^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4790,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4790,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4791,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^231^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,1,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,2,0)
 ;;=4417^instruct patient to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,3,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,4,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,5,0)
 ;;=4822^[Extra Order]^3^NURSC^219
 ;;^UTILITY("^GMRD(124.2,",$J,4791,1,6,0)
 ;;=2805^teach splinting of the incision to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4791,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4791,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4792,0)
 ;;=[Extra Order]^3^NURSC^11^289^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4792,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4792,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4793,0)
 ;;=[Extra Order]^3^NURSC^11^290^^^T
