NURCCG7D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3106,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3106,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3107,0)
 ;;=Fatigue^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,3107,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3107,1,1,0)
 ;;=3108^Etiology/Related and/or Risk Factors^2^NURSC^75^0
 ;;^UTILITY("^GMRD(124.2,",$J,3107,1,2,0)
 ;;=3115^Related Problems^2^NURSC^63^0
 ;;^UTILITY("^GMRD(124.2,",$J,3107,1,3,0)
 ;;=3117^Goals/Expected Outcomes^2^NURSC^75^0
 ;;^UTILITY("^GMRD(124.2,",$J,3107,1,4,0)
 ;;=3123^Nursing Intervention/Orders^2^NURSC^68^0
 ;;^UTILITY("^GMRD(124.2,",$J,3107,1,5,0)
 ;;=5566^Defining Characteristics^2^NURSC^69
 ;;^UTILITY("^GMRD(124.2,",$J,3107,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3107,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3107,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3108,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^75^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,1,0)
 ;;=3109^decreased/increased metabolic energy production^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,2,0)
 ;;=3110^overwhelming psychological/emotional demands^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,3,0)
 ;;=3111^increased energy requirements to perform ADLs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,4,0)
 ;;=3112^excessive social/role demands^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,5,0)
 ;;=3113^states of discomfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3108,1,6,0)
 ;;=3114^altered body chemistry^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3108,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3109,0)
 ;;=decreased/increased metabolic energy production^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3110,0)
 ;;=overwhelming psychological/emotional demands^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3111,0)
 ;;=increased energy requirements to perform ADLs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3112,0)
 ;;=excessive social/role demands^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3113,0)
 ;;=states of discomfort^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3114,0)
 ;;=altered body chemistry^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3115,0)
 ;;=Related Problems^2^NURSC^7^63^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,1,0)
 ;;=1383^Activity Intolerance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,2,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,3,0)
 ;;=1513^Cardiac Output, Decreased (Electical Factors)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,4,0)
 ;;=1514^Cardiac Output, Decreased (Mechanical Factors)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,6,0)
 ;;=3116^Disuse Syndrome Potential (to be developed)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,7,0)
 ;;=2231^Diversional Activity, Deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,8,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,9,0)
 ;;=1389^Health Maintenance, Alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,10,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,11,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,12,0)
 ;;=3091^Self-esteem Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,1,13,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3115,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3116,0)
 ;;=Disuse Syndrome Potential (to be developed)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3117,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^75^1^^T^1
