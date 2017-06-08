NURCCG5W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2368,0)
 ;;=monitor for suicide potential^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2368,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2368,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2369,0)
 ;;=neurotransmitter dysfunction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2370,0)
 ;;=monitor ADL^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2370,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2370,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2371,0)
 ;;=toxic substance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2372,0)
 ;;=very strong dependency needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2373,0)
 ;;=Related Problems^2^NURSC^7^53^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,1,0)
 ;;=1406^Cognitive Impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,3,0)
 ;;=1389^Health Maintenance, Alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,4,0)
 ;;=2376^Injury, Potential For^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,5,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,6,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,7,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,8,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,9,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,10,0)
 ;;=1407^Sensory-Perceptual, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,11,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,12,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,13,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,1,14,0)
 ;;=2197^Thought Processes, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2373,5)
 ;;=, see:
 ;;^UTILITY("^GMRD(124.2,",$J,2373,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2374,0)
 ;;=monitor physiological S/S of depression^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2374,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2374,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2375,0)
 ;;=monitor sleep pattern^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2375,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2375,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2376,0)
 ;;=Injury, Potential For^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2377,0)
 ;;=reinforce task completion^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2377,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2377,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2378,0)
 ;;=teach relaxation techniques^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2378,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2378,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2379,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^65^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,1,0)
 ;;=2383^will have adequate sleep and rest^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,2,0)
 ;;=2385^reports improved ability to concentrate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,3,0)
 ;;=2387^expresses realistic plans and ideas^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,4,0)
 ;;=2390^demonstrates increased ability to control motor behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,5,0)
 ;;=2391^demonstrates increased ability to control verbal behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2379,1,6,0)
 ;;=2929^[Extra Goal]^3^NURSC^110^0
