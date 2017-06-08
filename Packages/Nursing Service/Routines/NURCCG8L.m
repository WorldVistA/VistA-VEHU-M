NURCCG8L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4578,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4578,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4578,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4579,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^211^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4579,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4579,1,1,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4579,1,2,0)
 ;;=4591^[Extra Goal]^3^NURSC^210
 ;;^UTILITY("^GMRD(124.2,",$J,4579,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4580,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4580,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4580,1,1,0)
 ;;=4721^Etiology/Related and/or Risk Factors^2^NURSC^220
 ;;^UTILITY("^GMRD(124.2,",$J,4580,1,2,0)
 ;;=4724^Goals/Expected Outcomes^2^NURSC^225
 ;;^UTILITY("^GMRD(124.2,",$J,4580,1,3,0)
 ;;=4730^Nursing Intervention/Orders^2^NURSC^225
 ;;^UTILITY("^GMRD(124.2,",$J,4580,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4580,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4580,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4583,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^212^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4583,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4583,1,1,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4583,1,2,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4583,1,3,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4583,1,4,0)
 ;;=4599^teach pain control interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4583,1,5,0)
 ;;=4609^[Extra Order]^3^NURSC^211
 ;;^UTILITY("^GMRD(124.2,",$J,4583,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4583,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4588,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^212^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4588,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4588,1,1,0)
 ;;=4362^verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4588,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4588,1,3,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4588,1,4,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4588,1,5,0)
 ;;=4597^[Extra Goal]^3^NURSC^211
 ;;^UTILITY("^GMRD(124.2,",$J,4588,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^213^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,1,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,2,0)
 ;;=4417^instruct patient to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,3,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,5,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,6,0)
 ;;=2805^teach splinting of the incision to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,1,7,0)
 ;;=4610^[Extra Order]^3^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,4590,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4590,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4591,0)
 ;;=[Extra Goal]^3^NURSC^9^210^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4591,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4591,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4592,0)
 ;;=Pain, Acute^2^NURSC^2^14^1^^T^0
