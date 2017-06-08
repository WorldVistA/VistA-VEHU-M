NURCCG6N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,11,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,12,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,0)
 ;;=Organic Mental Disorder^2^NURSC^8^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,1,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,2,0)
 ;;=368^Communication Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,3,0)
 ;;=367^Cognitive Impairment^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,4,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,5,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,6,0)
 ;;=15^Health Maintenance, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,7,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,8,0)
 ;;=746^Depressive Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2761,1,10,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,0)
 ;;=Dissociative Disorders^2^NURSC^8^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,1,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,2,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,3,0)
 ;;=829^Post Trauma Response^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,4,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,5,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,6,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2762,1,7,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^40^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,1,0)
 ;;=630^fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,2,0)
 ;;=2777^immobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,3,0)
 ;;=2778^inflammation injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,4,0)
 ;;=2779^ischemia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,5,0)
 ;;=2780^muscle spasms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,6,0)
 ;;=2781^muscle tension^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,7,0)
 ;;=2782^contraction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,8,0)
 ;;=2783^physical activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,9,0)
 ;;=2784^procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,10,0)
 ;;=2785^surgical incision^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,12,0)
 ;;=419^anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,13,0)
 ;;=2152^fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,14,0)
 ;;=2403^depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,15,0)
 ;;=2787^hostility/anger^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,16,0)
 ;;=972^stress and anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,1,17,0)
 ;;=2788^altered thought process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2763,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2764,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^40^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,1,0)
 ;;=2789^verbalizes when in pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,3,0)
 ;;=2791^identifies factors that influence pain experience^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2764,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1^0
