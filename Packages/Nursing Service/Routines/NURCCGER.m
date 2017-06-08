NURCCGER ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13691,1,1,0)
 ;;=13693^[Extra Goal]^3^NURSC^380
 ;;^UTILITY("^GMRD(124.2,",$J,13691,1,2,0)
 ;;=13696^[Extra Goal]^3^NURSC^381
 ;;^UTILITY("^GMRD(124.2,",$J,13691,1,3,0)
 ;;=13699^[Extra Goal]^3^NURSC^382
 ;;^UTILITY("^GMRD(124.2,",$J,13691,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13693,0)
 ;;=[Extra Goal]^3^NURSC^9^380^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13693,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13693,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13696,0)
 ;;=[Extra Goal]^3^NURSC^9^381^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13696,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13696,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13699,0)
 ;;=[Extra Goal]^3^NURSC^9^382^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13699,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13699,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13701,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^297^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13701,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13701,1,1,0)
 ;;=13704^[Extra Order]^3^NURSC^387
 ;;^UTILITY("^GMRD(124.2,",$J,13701,1,2,0)
 ;;=13707^[Extra Order]^3^NURSC^388
 ;;^UTILITY("^GMRD(124.2,",$J,13701,1,3,0)
 ;;=13708^[Extra Order]^3^NURSC^389
 ;;^UTILITY("^GMRD(124.2,",$J,13701,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13701,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13704,0)
 ;;=[Extra Order]^3^NURSC^11^387^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13704,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13704,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13707,0)
 ;;=[Extra Order]^3^NURSC^11^388^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13707,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13707,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13708,0)
 ;;=[Extra Order]^3^NURSC^11^389^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13708,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13708,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13728,0)
 ;;=[Extra Goal]^3^NURSC^9^237^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13728,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13728,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13754,0)
 ;;=Urinary Elimination, Alteration In Pattern^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13754,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13754,1,1,0)
 ;;=13758^Etiology/Related and/or Risk Factors^2^NURSC^184
 ;;^UTILITY("^GMRD(124.2,",$J,13754,1,2,0)
 ;;=13766^Goals/Expected Outcomes^2^NURSC^182
 ;;^UTILITY("^GMRD(124.2,",$J,13754,1,3,0)
 ;;=13785^Nursing Intervention/Orders^2^NURSC^153
 ;;^UTILITY("^GMRD(124.2,",$J,13754,1,4,0)
 ;;=13826^Related Problems^2^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,13754,1,5,0)
 ;;=13841^Defining Characteristics^2^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,13754,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13754,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13754,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13754,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,13754,"TD",1,0)
 ;;=The state in which the individual experiences a disturbance in
 ;;^UTILITY("^GMRD(124.2,",$J,13754,"TD",2,0)
 ;;=urine elimination.
 ;;^UTILITY("^GMRD(124.2,",$J,13758,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^184^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13758,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13758,1,1,0)
 ;;=1255^mechanical trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13758,1,2,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13758,1,3,0)
 ;;=1256^sensory motor impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13758,7)
 ;;=D EN4^NURCCPU1
