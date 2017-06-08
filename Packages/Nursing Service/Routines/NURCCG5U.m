NURCCG5U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,6,0)
 ;;=2246^reinforce participation in assigned groups^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,7,0)
 ;;=2377^reinforce task completion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,8,0)
 ;;=1962^provide assistance in self-care activities as needed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,9,0)
 ;;=2378^teach relaxation techniques^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,10,0)
 ;;=1974^teach problem solving skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,11,0)
 ;;=1975^teach assertiveness skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,12,0)
 ;;=2041^teach/review medication use^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,13,0)
 ;;=2211^praise patient for use of physical exercise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,1,14,0)
 ;;=3015^[Extra Order]^3^NURSC^101^0
 ;;^UTILITY("^GMRD(124.2,",$J,2341,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2341,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2342,0)
 ;;=Related Problems^2^NURSC^7^52^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,1,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,3,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,4,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,5,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,6,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,7,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,1,8,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2342,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2343,0)
 ;;=encourage verbalization of feelings^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2343,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2343,1,1,0)
 ;;=419^anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2343,1,2,0)
 ;;=2152^fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2343,1,3,0)
 ;;=2062^low self-esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2343,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,2343,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2343,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2343,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2344,0)
 ;;=belief that stress, event or illness is uncontrollable^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2345,0)
 ;;=cognitive errors; negative ideas of self, world, & future^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2346,0)
 ;;=crises, situational & maturational (separation,death,loss)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2347,0)
 ;;=look for reality stimuli causing stress/explore factors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2347,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2347,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2348,0)
 ;;=hormonal imbalances and/or changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2349,0)
 ;;=neurotransmitted dysfunction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2350,0)
 ;;=interact with patient [specify] minutes/day^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2350,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2350,1,1,0)
 ;;=2351^discuss goals and alternatives^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2350,1,2,0)
 ;;=2352^provide positive reinforcement when initiates conversation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2350,1,3,0)
 ;;=2354^listen/chart patterns & symbols used in conversing^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2350,1,4,0)
 ;;=2356^discuss concrete realities^3^NURSC^1^0
