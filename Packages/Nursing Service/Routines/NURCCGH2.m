NURCCGH2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15881,1,4,0)
 ;;=10709^instruct in use of assistive devices^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15881,1,5,0)
 ;;=1006320^[Extra Order]^3^NURSC^117
 ;;^UTILITY("^GMRD(124.2,",$J,15881,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15881,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15882,0)
 ;;=teach mobility skills^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15882,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15882,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15885,0)
 ;;=Pain, Acute^2^NURSC^2^18^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15885,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15885,1,1,0)
 ;;=4205^Defining Characteristics^2^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,15885,1,2,0)
 ;;=2763^Etiology/Related and/or Risk Factors^2^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,15885,1,3,0)
 ;;=15886^Goals/Expected Outcomes^2^NURSC^322
 ;;^UTILITY("^GMRD(124.2,",$J,15885,1,4,0)
 ;;=15888^Nursing Intervention/Orders^2^NURSC^324
 ;;^UTILITY("^GMRD(124.2,",$J,15885,1,5,0)
 ;;=3154^Related Problems^2^NURSC^65
 ;;^UTILITY("^GMRD(124.2,",$J,15885,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15885,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15885,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15886,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^322^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15886,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15886,1,1,0)
 ;;=2793^demonstrates use of pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15886,1,2,0)
 ;;=15880^verbalizes diminished pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15886,1,3,0)
 ;;=15901^[Extra Goal]^3^NURSC^25
 ;;^UTILITY("^GMRD(124.2,",$J,15886,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15887,0)
 ;;=[Extra Goal]^3^NURSC^9^24^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15887,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15887,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15888,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^324^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15888,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15888,1,1,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15888,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15888,1,3,0)
 ;;=15889^teach pain relief measures:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15888,1,4,0)
 ;;=1006321^[Extra Order]^3^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,15888,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15888,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15889,0)
 ;;=teach pain relief measures:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15889,1,1,0)
 ;;=4601^breathing exercises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,1,2,0)
 ;;=4602^distraction techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,1,3,0)
 ;;=15890^medication usage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,1,4,0)
 ;;=4605^positioning techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,1,5,0)
 ;;=15891^phantom pain relief techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15889,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15889,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15890,0)
 ;;=medication usage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15891,0)
 ;;=phantom pain relief techniques^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15892,0)
 ;;=encourage verbalization of physical/emotional changes^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15892,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15892,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15893,0)
 ;;=Alteration in Self-Concept^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15893,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,15893,1,1,0)
 ;;=15894^Defining Characteristics^2^NURSC^91
