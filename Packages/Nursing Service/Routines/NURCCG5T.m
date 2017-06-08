NURCCG5T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2335,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2336,0)
 ;;=explain the reality of the present situation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2336,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2336,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2337,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^65^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,1,0)
 ;;=2344^belief that stress, event or illness is uncontrollable^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,2,0)
 ;;=2345^cognitive errors; negative ideas of self, world, & future^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,3,0)
 ;;=2346^crises, situational & maturational (separation,death,loss)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,4,0)
 ;;=458^disease process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,5,0)
 ;;=2052^genetic factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,6,0)
 ;;=2348^hormonal imbalances and/or changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,7,0)
 ;;=2349^neurotransmitted dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,1,8,0)
 ;;=2380^neurotransmitter dysfunction^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2337,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2338,0)
 ;;=be clear and concrete in your statements^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2338,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2338,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2339,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^64^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,1,0)
 ;;=2256^interacts with an assigned staff member [ ] min/shift^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,2,0)
 ;;=2260^interacts with another patient [ ] times per shift^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,3,0)
 ;;=2264^attends and participates in assigned groups^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,4,0)
 ;;=2353^reports feeling less depressed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,5,0)
 ;;=2355^sets small goals for accomplishing tasks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,6,0)
 ;;=2357^reports experiencing success in meeting goals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,7,0)
 ;;=2289^attends to own ADL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,8,0)
 ;;=2359^reports a return to own normal sleep pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,9,0)
 ;;=2360^makes one positive statement about self q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,10,0)
 ;;=2362^demonstrates problem solving skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,11,0)
 ;;=2363^developes plan to deal with contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,12,0)
 ;;=2364^identifies three alternative methods to deal with stressors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,1,13,0)
 ;;=2928^[Extra Goal]^3^NURSC^109^0
 ;;^UTILITY("^GMRD(124.2,",$J,2339,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2340,0)
 ;;=interject doubt regarding delusions (if able to accept)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2340,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2340,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2341,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^59^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,1,0)
 ;;=583^assess causative, contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,2,0)
 ;;=2368^monitor for suicide potential^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,3,0)
 ;;=2370^monitor ADL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,4,0)
 ;;=2374^monitor physiological S/S of depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,5,0)
 ;;=2375^monitor sleep pattern^3^NURSC^1^0
