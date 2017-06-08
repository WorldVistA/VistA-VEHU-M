NURCCG55 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,4,0)
 ;;=2023^work^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,5,0)
 ;;=2026^character traits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,6,0)
 ;;=2027^interpersonal skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,7,0)
 ;;=2028^personal qualities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,8,0)
 ;;=2030^appearance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,5)
 ;;=in the following areas
 ;;^UTILITY("^GMRD(124.2,",$J,2017,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2017,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2017,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2018,0)
 ;;=Sleep Pattern Disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2019,0)
 ;;=hobbies^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2020,0)
 ;;=school^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2021,0)
 ;;=skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2022,0)
 ;;=identifies 3 signs and symptoms of anxiety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2022,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2022,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2023,0)
 ;;=work^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2024,0)
 ;;=identifies 3 precipitating events to anxiety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2024,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2024,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2025,0)
 ;;=reports decrease in signs/symptoms of anxiety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2025,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2025,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2026,0)
 ;;=character traits^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2027,0)
 ;;=interpersonal skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2028,0)
 ;;=personal qualities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2029,0)
 ;;=verbalizes 3 activities that promote feelings of comfort^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2029,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2029,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2030,0)
 ;;=appearance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2031,0)
 ;;=identifies 3 sources of support^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2031,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2031,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2032,0)
 ;;=monitor anxiety level/occurrence^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2032,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2032,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2033,0)
 ;;=help identify symptoms of anxiety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2033,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2033,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2034,0)
 ;;=point out observed behaviors indicative of anxiety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2034,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2034,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2035,0)
 ;;=encourage expression of feelings and be accepting of them^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2035,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2035,1,1,0)
 ;;=2038^awareness of body language regarding loss of body part^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2035,1,2,0)
 ;;=2042^awareness of body language regarding disfigurement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2035,1,3,0)
 ;;=2045^unchallenged exploration of what loss means to him^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2035,1,4,0)
 ;;=2047^assistance with basic needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2035,1,5,0)
 ;;=2049^reinforcement that present feeling are normal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2035,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,2035,7)
 ;;=D EN4^NURCCPU1
