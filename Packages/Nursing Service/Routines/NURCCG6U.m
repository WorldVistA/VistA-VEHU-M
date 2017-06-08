NURCCG6U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,12,0)
 ;;=350^Swallowing, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,13,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,14,0)
 ;;=353^Incontinence, Bowel^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,15,0)
 ;;=354^Incontinence, Urine^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,16,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,17,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,18,0)
 ;;=358^Urinary Retention^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,19,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,20,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,21,0)
 ;;=363^Skin Ulcer (See Skin Integrity, Impairment (Actual))^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,22,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,23,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,24,0)
 ;;=368^Communication Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,25,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,26,0)
 ;;=643^Sexual Pattern, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,27,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,28,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,29,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2807,1,30,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,0)
 ;;=Aspiration Potential^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2808,1,1,0)
 ;;=2809^Etiology/Related and/or Risk Factors^2^NURSC^71^0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,1,2,0)
 ;;=2810^Goals/Expected Outcomes^2^NURSC^71^0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,1,3,0)
 ;;=2811^Nursing Intervention/Orders^2^NURSC^171^0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,1,4,0)
 ;;=2812^Related Problems^2^NURSC^31^0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2808,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2808,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2809,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^71^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,1,0)
 ;;=2813^reduced level of consciousness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,2,0)
 ;;=2814^depressed cough and gag reflex^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,3,0)
 ;;=2815^presence of endotracheal/tracheal tube^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,4,0)
 ;;=2816^incomplete esophageal sphincter^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,5,0)
 ;;=2817^gastrointestinal tubes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,6,0)
 ;;=989^tube feedings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,7,0)
 ;;=2818^medication administration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,8,0)
 ;;=2819^increased intragastric pressure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,9,0)
 ;;=2820^increased gastric residual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,10,0)
 ;;=2821^decreased gastrointestinal motility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,11,0)
 ;;=2822^delayed gastric emptying^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,12,0)
 ;;=2823^wired jaws^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,13,0)
 ;;=2824^impaired swallowing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,14,0)
 ;;=2825^facial/oral/neck surgery/trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2809,1,15,0)
 ;;=2826^situations hindering elevation of upper body^3^NURSC^1^0
