NURCCG5L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2224,0)
 ;;=environmental barriers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2225,0)
 ;;=knowledge/skill deficit about ways to enhance mutuality^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2226,0)
 ;;=limited physical mobility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2227,0)
 ;;=self concept disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2228,0)
 ;;=socio-cultural dissonance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2229,0)
 ;;=therapeutic isolation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2230,0)
 ;;=altered body structure or function^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2231,0)
 ;;=Diversional Activity, Deficit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2232,0)
 ;;=altered state of wellness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2233,0)
 ;;=delay in accomplishing developmental tasks^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2234,0)
 ;;=immature interests^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2235,0)
 ;;=inadequate personal resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2236,0)
 ;;=inability to engage in satisfying personal relationships^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2237,0)
 ;;=unaccepted social behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2238,0)
 ;;=unnaccepted social values^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2239,0)
 ;;=interacts with assigned staff and one pt of choice q[freq]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2239,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2239,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2240,0)
 ;;=Related Problems^2^NURSC^7^48^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,1,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,3,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,4,0)
 ;;=2231^Diversional Activity, Deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,5,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,6,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,1,7,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2240,5)
 ;;=, see:
 ;;^UTILITY("^GMRD(124.2,",$J,2240,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2241,0)
 ;;=attends and participates in group^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2241,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2241,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2242,0)
 ;;=uses assertive communication techniques^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2242,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2242,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2243,0)
 ;;=reports positive interactions with others^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2243,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2243,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2244,0)
 ;;=focus on interaction patterns and feelings of the present^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2244,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2244,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2245,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^60^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,1,0)
 ;;=2247^demonstrates an increase in social interaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,2,0)
 ;;=2256^interacts with an assigned staff member [ ] min/shift^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,3,0)
 ;;=2258^interacts with an assigned staff member [ ] min/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2245,1,4,0)
 ;;=2260^interacts with another patient [ ] times per shift^3^NURSC^1^0
