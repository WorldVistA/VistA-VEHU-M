NURCCG9N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5095,1,3,0)
 ;;=5570^Infection Potential^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,5095,1,4,0)
 ;;=5665^[Extra Problem]^2^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,5096,0)
 ;;=Renal Failure^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,1,0)
 ;;=8044^Coping, Ineffective Individual^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,2,0)
 ;;=9437^Fluid Volume Deficit (Actual/Potential)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,3,0)
 ;;=9519^Nutrition, Alteration in:(Less Than Required)^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,4,0)
 ;;=9576^Knowledge Deficit^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,5,0)
 ;;=9683^Coping, Ineffective Family^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5096,1,6,0)
 ;;=15275^[Extra Problem]^2^NURSC^42
 ;;^UTILITY("^GMRD(124.2,",$J,5097,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^255^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5097,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5097,1,1,0)
 ;;=2566^assess eating patterns, satiety levels^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5097,1,2,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5097,1,3,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5097,1,4,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5097,1,5,0)
 ;;=5111^[Extra Order]^3^NURSC^230
 ;;^UTILITY("^GMRD(124.2,",$J,5097,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5097,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5098,0)
 ;;=Asthma/Chronic Obstructive Pulmonary Disease^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,1,0)
 ;;=8296^Airway Clearance, Ineffective^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,2,0)
 ;;=8447^Breathing Pattern, Ineffective^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,3,0)
 ;;=8587^Gas Exchange, Impaired^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,4,0)
 ;;=8722^Activity Intolerance^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,5,0)
 ;;=8789^Knowledge Deficit^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,5098,1,6,0)
 ;;=8931^[Extra Problem]^2^NURSC^21
 ;;^UTILITY("^GMRD(124.2,",$J,5099,0)
 ;;=Pleural Effusion/Pneumothorax/Hemothorax/Empyema^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,1,0)
 ;;=8944^Gas Exchange, Impaired^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,2,0)
 ;;=9047^Breathing Pattern, Ineffective^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,3,0)
 ;;=9139^Infection Potential^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,4,0)
 ;;=9216^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,5,0)
 ;;=9360^Pain, Acute^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,5099,1,6,0)
 ;;=9423^[Extra Problem]^2^NURSC^22
 ;;^UTILITY("^GMRD(124.2,",$J,5100,0)
 ;;=Cancer of the Lung (Surgical)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,1,0)
 ;;=10911^Airway Clearance, Ineffective^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,2,0)
 ;;=11009^Breathing Pattern, Ineffective^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,3,0)
 ;;=11101^Gas Exchange, Impaired^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,4,0)
 ;;=11204^Infection Potential^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,5,0)
 ;;=11278^Pain, Acute^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,5100,1,6,0)
 ;;=11342^[Extra Problem]^2^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,5101,0)
 ;;=Chemotherapy/Radiation Therapy^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,0)
 ;;=^124.21IP^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,1,0)
 ;;=9657^Nutrition, Alteration in:(Less Than Required)^2^NURSC^4
