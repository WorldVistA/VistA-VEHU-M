NURCCG2D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,736,1,20,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,736,1,21,0)
 ;;=743^Grieving, Anticipatory^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,736,1,22,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,0)
 ;;=Sepsis^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,1,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,2,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,3,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,4,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,5,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,737,1,6,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,0)
 ;;=Lung Cancer:  Surgical Intervention^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,1,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,2,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,3,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,4,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,5,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,6,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,7,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,8,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,9,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,10,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,11,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,738,1,12,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,0)
 ;;=Pneumonia and Pleurisy^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,1,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,2,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,3,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,4,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,5,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,6,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,7,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,8,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,10,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,739,1,11,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,0)
 ;;=Pneumothorax/Hemothorax/Pleural Effusion^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,1,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,2,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,3,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,4,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,5,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
