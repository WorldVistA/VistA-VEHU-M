NURCCG24 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,702,0)
 ;;=Casts^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,1,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,2,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,3,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,4,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,5,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,6,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,7,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,8,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,9,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,10,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,702,1,11,0)
 ;;=338^Activity Intolerance (Circulatory System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,0)
 ;;=Fractures^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,1,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,2,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,3,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,4,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,5,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,6,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,7,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,8,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,703,1,9,0)
 ;;=338^Activity Intolerance (Circulatory System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,0)
 ;;=Total Joint Replacement (knee, hip, elbow, fingers, wrist)^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,1,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,2,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,3,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,4,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,5,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,6,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,7,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,8,0)
 ;;=643^Sexual Pattern, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,9,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,704,1,10,0)
 ;;=338^Activity Intolerance (Circulatory System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,0)
 ;;=Traction^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,0)
 ;;=^124.21PI^14^13
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,1,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,2,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,3,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,4,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,5,0)
 ;;=338^Activity Intolerance (Circulatory System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,705,1,6,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
