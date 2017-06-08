NURCCG25 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,7,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,8,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,9,0)
 ;;=14^Spiritual Needs^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,10,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,11,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,12,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,13,0)
 ;;=345^Tissue Integrity, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,14,0)
 ;;=558^Spiritual Distress^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,706,0)
 ;;=Pressure Sores^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,706,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,706,1,1,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,706,1,2,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,706,1,3,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,706,1,4,0)
 ;;=345^Tissue Integrity, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,707,0)
 ;;=Skin Grafts^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,707,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,707,1,1,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,707,1,2,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,707,1,3,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,707,1,4,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,707,1,5,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,0)
 ;;=Addison's Disease (Adrenal Insufficiency)^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,1,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,2,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,3,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,4,0)
 ;;=347^Appetite, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,5,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,6,0)
 ;;=352^Diarrhea^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,7,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,8,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,708,1,10,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,0)
 ;;=Cushing's Disease^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,1,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,2,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,3,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,4,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,5,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,6,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,709,1,7,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,710,0)
 ;;=Hyperthyroidism (Graves' Disease)^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,710,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,710,1,1,0)
 ;;=352^Diarrhea^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,710,1,2,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
