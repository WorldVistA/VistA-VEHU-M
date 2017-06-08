NURCCG5K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,7,0)
 ;;=2236^inability to engage in satisfying personal relationships^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,8,0)
 ;;=2237^unaccepted social behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,9,0)
 ;;=2238^unnaccepted social values^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2217,0)
 ;;=alteration in mental status^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2218,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^61^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,1,0)
 ;;=2222^absence of available S/O or peers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,2,0)
 ;;=2223^communication barriers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,3,0)
 ;;=2224^environmental barriers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,4,0)
 ;;=2225^knowledge/skill deficit about ways to enhance mutuality^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,5,0)
 ;;=2226^limited physical mobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,6,0)
 ;;=2227^self concept disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,7,0)
 ;;=2228^socio-cultural dissonance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,1,8,0)
 ;;=2229^therapeutic isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2218,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2219,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^59^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2219,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2219,1,1,0)
 ;;=2239^interacts with assigned staff and one pt of choice q[freq]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2219,1,2,0)
 ;;=2241^attends and participates in group^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2219,1,3,0)
 ;;=2242^uses assertive communication techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2219,1,4,0)
 ;;=2243^reports positive interactions with others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2219,1,5,0)
 ;;=2923^[Extra Goal]^3^NURSC^104^0
 ;;^UTILITY("^GMRD(124.2,",$J,2219,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2220,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^55^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2220,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2220,1,1,0)
 ;;=2244^focus on interaction patterns and feelings of the present^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2220,1,2,0)
 ;;=2246^reinforce participation in assigned groups^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2220,1,3,0)
 ;;=2248^reinforce positive statements about self/others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2220,1,4,0)
 ;;=2249^teach assertiveness skills,methods to enhance self esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2220,1,5,0)
 ;;=3010^[Extra Order]^3^NURSC^96^0
 ;;^UTILITY("^GMRD(124.2,",$J,2220,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2220,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2221,0)
 ;;=Related Problems^2^NURSC^7^47^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,1,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,3,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,5,0)
 ;;=2231^Diversional Activity, Deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,1,7,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2221,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2222,0)
 ;;=absence of available S/O or peers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2223,0)
 ;;=communication barriers^3^NURSC^^1^^^T
