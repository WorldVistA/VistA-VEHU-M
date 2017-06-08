NURCCG1V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,658,1,6,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,0)
 ;;=Endocarditis^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,1,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,2,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,3,0)
 ;;=344^Knowledge Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,4,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,5,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,6,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,659,1,7,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,0)
 ;;=Heart Failure^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,1,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,2,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,3,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,4,0)
 ;;=344^Knowledge Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,5,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,6,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,7,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,8,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,9,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,10,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,11,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,12,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,13,0)
 ;;=349^Nutrition, Alteration in:(More Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,660,1,14,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,0)
 ;;=Hypertension^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,1,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,2,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,3,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,4,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,5,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,6,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,661,1,7,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,0)
 ;;=Pericarditis^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,1,0)
 ;;=340^Pain, Chest^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,2,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,3,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,4,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,5,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,6,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,662,1,7,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,663,0)
 ;;=Peripheral Vascular Surgery Procedures^2^NURSC^8^1^1^^T^0
