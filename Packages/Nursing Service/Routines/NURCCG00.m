NURCCG00 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1,0)
 ;;=Nursing Care Plan^2^NURSC^1^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1,1,1,0)
 ;;=518^Medical Diagnoses^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1,1,2,0)
 ;;=519^Nursing Problems^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1,1,3,0)
 ;;=4350^Optional Care Plans^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,1,7)
 ;;=D EN1^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1,9)
 ;;=K NURSCPE
 ;;^UTILITY("^GMRD(124.2,",$J,2,0)
 ;;=Health Management^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2,1,1,0)
 ;;=15^Health Maintenance, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2,1,2,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2,1,3,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3,0)
 ;;=Activities of Daily Living^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,3,1,1,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3,1,2,0)
 ;;=50^Home Maintenance Management, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3,1,3,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,4,0)
 ;;=Respiratory System^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,1,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,2,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,3,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,4,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,5,0)
 ;;=127^Infection Potential (Specific to Respiratory System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,4,1,6,0)
 ;;=2808^Aspiration Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,0)
 ;;=Circulatory System^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,0)
 ;;=^124.21PI^14^13
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,1,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,2,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,4,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,5,0)
 ;;=342^Hyperthermia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,6,0)
 ;;=343^Hypothermia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,7,0)
 ;;=344^Knowledge Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,8,0)
 ;;=345^Tissue Integrity, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,9,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,10,0)
 ;;=121^Activity Intolerance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,11,0)
 ;;=340^Pain, Chest^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,12,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,13,0)
 ;;=366^Pain, Chronic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,5,1,14,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,6,0)
 ;;=Nutrition-Metabolic Area^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,1,0)
 ;;=347^Appetite, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,2,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,3,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,4,0)
 ;;=349^Nutrition, Alteration in:(More Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,5,0)
 ;;=350^Swallowing, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,6,1,6,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
