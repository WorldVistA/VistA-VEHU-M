NURCCG56 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2035,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2035,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2036,0)
 ;;=spend [ ]min [freq]q shift to identify associated factors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2036,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2036,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2037,0)
 ;;=use active listening techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2037,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2037,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2038,0)
 ;;=awareness of body language regarding loss of body part^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2039,0)
 ;;=identify and encourage anxiety-reducing activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2039,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2039,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2040,0)
 ;;=administer anti-anxiety medication as prescribed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2040,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2040,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2041,0)
 ;;=teach/review medication use^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2041,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2041,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2042,0)
 ;;=awareness of body language regarding disfigurement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2043,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^55^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,1,0)
 ;;=2052^genetic factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,2,0)
 ;;=2053^sociocultural drinking patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,3,0)
 ;;=2054^peer pressure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,4,0)
 ;;=2058^psychological needs such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,5,0)
 ;;=2064^increased stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2043,1,6,0)
 ;;=2066^pattern of pathological alcohol use such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2043,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2044,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^54^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2044,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2044,1,1,0)
 ;;=2080^free from all S/S of withdrawal within [ ]days of admission^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2044,1,2,0)
 ;;=2110^verbalizes cause of withdrawl symptoms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2044,1,3,0)
 ;;=2111^verbalizes impact alcohol had on life style^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2044,1,4,0)
 ;;=2112^verbalizes support systems to be used after discharge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2044,1,5,0)
 ;;=2918^[Extra Goal]^3^NURSC^99^0
 ;;^UTILITY("^GMRD(124.2,",$J,2044,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2045,0)
 ;;=unchallenged exploration of what loss means to him^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2046,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^50^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,1,0)
 ;;=2088^administer medication as ordered for S/S of withdrawal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,2,0)
 ;;=1199^encourage fluid intake (pt preference) to [ ]cc q [ ]hr^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,3,0)
 ;;=2097^encourage balanced nutritional intake each meal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,4,0)
 ;;=2098^check sensorium q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,5,0)
 ;;=2099^reassure patient at onset that symptoms are temporary^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,6,0)
 ;;=2100^provide quiet environment to decrease stimuli^3^NURSC^1^0
