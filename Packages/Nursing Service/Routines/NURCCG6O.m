NURCCG6O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,5,0)
 ;;=2793^demonstrates use of pain relief measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,6,0)
 ;;=2794^patient/S.O. administers medications appropriately^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,7,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,8,0)
 ;;=2796^verbalizes comfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,9,0)
 ;;=2935^[Extra Goal]^3^NURSC^116^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2765,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^170^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,1,0)
 ;;=2797^assess pain episode using 0 (no) to 10 (worst) scale^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,3,0)
 ;;=2799^monitor stimulus responses to pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,5,0)
 ;;=2803^support verbalization of pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,6,0)
 ;;=2804^administer pharmacological agents as ordered/per protocol^3^NURSC^9^1
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,7,0)
 ;;=2805^teach splinting of the incision to minimize pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,8,0)
 ;;=2827^teach the purpose and use of analgesics^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,10,0)
 ;;=2855^teach techniques of massage to decrease pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,11,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,12,0)
 ;;=2857^teach breathing exercises to decrease pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,13,0)
 ;;=2858^teach distraction techniques to minimize pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,14,0)
 ;;=2859^teach the use of imagery to decrease pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,15,0)
 ;;=628^teach relaxation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,1,16,0)
 ;;=3022^[Extra Order]^3^NURSC^108^0
 ;;^UTILITY("^GMRD(124.2,",$J,2765,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2765,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2766,0)
 ;;=Borderline Personality Disorder^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,1,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,2,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,3,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,4,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,5,0)
 ;;=748^Violence Potential, Directed At Others^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,6,0)
 ;;=747^Violence, Potential For, Self Directed^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,7,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,8,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,9,0)
 ;;=749^Social Isolation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,10,0)
 ;;=853^Substance Abuse, Alcohol^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2766,1,11,0)
 ;;=854^Substance Abuse, Drugs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2767,0)
 ;;=Sexual Disorders^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2767,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2767,1,1,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
