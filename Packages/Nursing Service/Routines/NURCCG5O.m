NURCCG5O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2269,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2270,0)
 ;;=reinforce new behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2270,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2270,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2271,0)
 ;;=teach problem solving skills^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2271,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2271,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2272,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^169^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,1,0)
 ;;=2276^sit quietly with patient if (s)he is not verbalizing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,2,0)
 ;;=2278^assess factors which contribute to withdrawl^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,3,0)
 ;;=2282^encourage discussion of 'here and now'^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,4,0)
 ;;=2285^encourage verbalization of feelings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,5,0)
 ;;=2286^give positive reinforcement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,6,0)
 ;;=2291^involve the patient in activities/interactions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,7,0)
 ;;=2293^encourage interactions/activities with family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,1,8,0)
 ;;=3012^[Extra Order]^3^NURSC^98^0
 ;;^UTILITY("^GMRD(124.2,",$J,2272,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2272,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2273,0)
 ;;=teach assertive communication skills^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2273,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2273,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2274,0)
 ;;=refer to social work or community agency for family therapy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2274,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2274,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2275,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^63^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2275,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2275,1,1,0)
 ;;=2281^perceived potential loss of personal possessions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2275,1,2,0)
 ;;=2283^perceived potential loss of physiopsychosocial well-being^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2275,1,3,0)
 ;;=2284^perceived potential loss of S/O^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2275,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2276,0)
 ;;=sit quietly with patient if (s)he is not verbalizing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2276,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2276,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2277,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^62^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2277,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2277,1,1,0)
 ;;=2287^discusses three feelings about potential loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2277,1,2,0)
 ;;=2288^identifies three successful coping methods^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2277,1,3,0)
 ;;=2289^attends to own ADL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2277,1,4,0)
 ;;=2926^[Extra Goal]^3^NURSC^107^0
 ;;^UTILITY("^GMRD(124.2,",$J,2277,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2278,0)
 ;;=assess factors which contribute to withdrawl^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2278,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2278,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2279,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^57^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2279,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2279,1,1,0)
 ;;=2290^assess for dysfunctional grieving^3^NURSC^1^0
