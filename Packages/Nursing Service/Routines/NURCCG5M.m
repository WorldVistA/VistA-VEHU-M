NURCCG5M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,5,0)
 ;;=2261^interacts with another patient [ ] times per day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,6,0)
 ;;=2264^attends and participates in assigned groups^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,7,0)
 ;;=2269^tasks with S/O for [ ] minutes each week^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,8,0)
 ;;=2924^[Extra Goal]^3^NURSC^105^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2246,0)
 ;;=reinforce participation in assigned groups^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2246,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2246,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2247,0)
 ;;=demonstrates an increase in social interaction^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2247,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2247,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2248,0)
 ;;=reinforce positive statements about self/others^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2248,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2248,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2249,0)
 ;;=teach assertiveness skills,methods to enhance self esteem^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2249,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2249,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2250,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^62^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2250,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,2250,1,1,0)
 ;;=2254^development transition and/or crisis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2250,1,2,0)
 ;;=2255^situational transition and/or crisis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2250,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2251,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^61^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2251,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2251,1,1,0)
 ;;=2259^reports effective communications among family members^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2251,1,2,0)
 ;;=2262^family demonstrates effective problem solving^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2251,1,3,0)
 ;;=2263^reports resolution of family conflicts^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2251,1,4,0)
 ;;=2265^family members demonstrate healthy family interactions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2251,1,5,0)
 ;;=2925^[Extra Goal]^3^NURSC^106^0
 ;;^UTILITY("^GMRD(124.2,",$J,2251,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2252,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^56^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,1,0)
 ;;=2266^observe family for healthy/pathological family dynamics^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,2,0)
 ;;=2267^mediate interpersonal communications without taking sides^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,3,0)
 ;;=2268^listen to expressions of fear of change^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,4,0)
 ;;=2270^reinforce new behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,5,0)
 ;;=2271^teach problem solving skills^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,6,0)
 ;;=2273^teach assertive communication skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,7,0)
 ;;=2274^refer to social work or community agency for family therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,1,8,0)
 ;;=3011^[Extra Order]^3^NURSC^97^0
 ;;^UTILITY("^GMRD(124.2,",$J,2252,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2252,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2253,0)
 ;;=Related Problems^2^NURSC^7^49^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,1,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1^0
