NURCCG6Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2771,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2771,1,10,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2771,1,11,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2771,1,12,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2771,1,13,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2772,0)
 ;;=Interstitial Lung Disease^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,1,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,2,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,3,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,4,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,5,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2772,1,6,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2773,0)
 ;;=Sleep Apnea^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2773,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2773,1,1,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2773,1,2,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2773,1,3,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2773,1,4,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2774,0)
 ;;=Tuberculosis^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,1,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,2,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,3,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,4,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,5,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,6,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,7,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,8,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,10,0)
 ;;=641^Infection Potential^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,11,0)
 ;;=14207^Airway Clearance, Ineffective^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,12,0)
 ;;=14364^Breathing Pattern, Ineffective^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,13,0)
 ;;=14556^Gas Exchange, Impaired^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,14,0)
 ;;=14672^Infection Potential^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,15,0)
 ;;=14745^Nutrition, Alteration in:(Less Than Required)^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,2774,1,16,0)
 ;;=14802^[Extra Problem]^2^NURSC^41
 ;;^UTILITY("^GMRD(124.2,",$J,2775,0)
 ;;=Esophagitis/Esophageal Reflux/Esophageal Stricture^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2775,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2775,1,1,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2775,1,2,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2775,1,3,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2775,1,4,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,0)
 ;;=Gastroenteritis/Gastritis^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,0)
 ;;=^124.21PI^7^7
