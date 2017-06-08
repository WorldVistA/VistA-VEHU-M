NURCCG6M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2758,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,2758,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,2758,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,2759,0)
 ;;=Craniotomy^2^NURSC^8^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,0)
 ;;=^124.21PI^29^29
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,1,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,2,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,3,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,4,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,5,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,6,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,7,0)
 ;;=350^Swallowing, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,8,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,9,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,10,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,11,0)
 ;;=15^Health Maintenance, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,12,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,13,0)
 ;;=370^Neglect, Unilateral^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,14,0)
 ;;=367^Cognitive Impairment^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,15,0)
 ;;=368^Communication Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,16,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,17,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,18,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,19,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,20,0)
 ;;=354^Incontinence, Urine^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,21,0)
 ;;=1049^Injury, Potential For^2^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,22,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,23,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,24,0)
 ;;=743^Grieving, Anticipatory^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,25,0)
 ;;=744^Grieving, Dysfunctional^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,26,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,27,0)
 ;;=643^Sexual Pattern, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,28,0)
 ;;=558^Spiritual Distress^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2759,1,29,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,0)
 ;;=Seizure/Headache^2^NURSC^8^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,1,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,2,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,3,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,4,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,5,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,6,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,7,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,8,0)
 ;;=366^Pain, Chronic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2760,1,10,0)
 ;;=745^Powerlessness^2^NURSC^1^0
