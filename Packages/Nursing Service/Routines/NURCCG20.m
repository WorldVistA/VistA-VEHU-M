NURCCG20 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,681,1,12,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,682,0)
 ;;=Mallory-Weiss Syndrome^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,682,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,682,1,1,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,682,1,2,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,682,1,3,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,683,0)
 ;;=Pancreatitis^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,683,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,683,1,1,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,683,1,2,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,683,1,3,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,683,1,4,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,683,1,5,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,684,0)
 ;;=Peritonitis^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,684,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,684,1,1,0)
 ;;=364^Injury Potential^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,684,1,2,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,684,1,3,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,684,1,4,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,0)
 ;;=Surgical Procedures of the GI Tract^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,1,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,2,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,3,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,4,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,5,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,6,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,7,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,8,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,9,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,10,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,11,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,12,0)
 ;;=352^Diarrhea^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,685,1,13,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,686,0)
 ;;=Ulcers/Peptic^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,686,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,686,1,1,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,686,1,2,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,686,1,3,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,686,1,4,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,686,1,5,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,687,0)
 ;;=Anxiety^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,687,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,687,1,1,0)
 ;;=1989^Etiology/Related and/or Risk Factors^2^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,687,1,2,0)
 ;;=1991^Goals/Expected Outcomes^2^NURSC^52^0
 ;;^UTILITY("^GMRD(124.2,",$J,687,1,3,0)
 ;;=1992^Nursing Intervention/Orders^2^NURSC^48^0
 ;;^UTILITY("^GMRD(124.2,",$J,687,1,4,0)
 ;;=1994^Related Problems^2^NURSC^41^0
