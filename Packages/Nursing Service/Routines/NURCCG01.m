NURCCG01 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,7,0)
 ;;=2808^Aspiration Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,0)
 ;;=Elimination^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,1,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,2,0)
 ;;=352^Diarrhea^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,3,0)
 ;;=353^Incontinence, Bowel^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,4,0)
 ;;=354^Incontinence, Urine^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,5,0)
 ;;=356^Stress Incontinence^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,6,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,7,0)
 ;;=358^Urinary Retention^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,8,0)
 ;;=355^Infection Potential (Specific to Elimination)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,7,1,9,0)
 ;;=3028^Constipation, Perceived^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,0)
 ;;=Integumentary (Skin)^2^NURSC^3^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,1,0)
 ;;=360^Oral Mucous Membrane, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,2,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,3,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,4,0)
 ;;=363^Skin Ulcer (See Skin Integrity, Impairment (Actual))^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,5,0)
 ;;=345^Tissue Integrity, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,8,1,6,0)
 ;;=359^Infection Potential (Specific to Integumentary System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,9,0)
 ;;=Musculoskeletal/Neurological^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,9,1,1,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,9,1,2,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,9,1,3,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,9,1,4,0)
 ;;=3194^Disuse Syndrome, Potential For^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10,0)
 ;;=Cognitive-Sensory Area^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,1,0)
 ;;=366^Pain, Chronic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,2,0)
 ;;=367^Cognitive Impairment^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,3,0)
 ;;=368^Communication Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,4,0)
 ;;=1049^Injury, Potential For^2^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,5,0)
 ;;=369^Knowledge Deficit for Cognitive-Sensory Problems^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,6,0)
 ;;=370^Neglect, Unilateral^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,7,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,8,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,10,1,9,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,11,0)
 ;;=Sleep/Rest^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,11,1,1,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,12,0)
 ;;=Sexual Functioning/Reproductive System^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12,1,1,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,12,1,2,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,12,1,3,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,12,1,4,0)
 ;;=643^Sexual Pattern, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,0)
 ;;=Psycho-Social Area^2^NURSC^3^1^1^^T^0
