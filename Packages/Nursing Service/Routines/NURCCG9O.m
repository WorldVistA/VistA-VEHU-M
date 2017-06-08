NURCCG9O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,2,0)
 ;;=9769^Infection Potential^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,3,0)
 ;;=9897^Injury Potential^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,4,0)
 ;;=9963^Pain, Acute^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,5,0)
 ;;=10089^Pain, Chronic^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,6,0)
 ;;=10205^Knowledge Deficit^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,5101,1,7,0)
 ;;=10332^[Extra Problem]^2^NURSC^23
 ;;^UTILITY("^GMRD(124.2,",$J,5102,0)
 ;;=Acute Respiratory Failure/Adult Resp Distress Syndrome^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,0)
 ;;=^124.21IP^10^7
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,1,0)
 ;;=13053^Airway Clearance, Ineffective^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,2,0)
 ;;=13191^Gas Exchange, Impaired^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,4,0)
 ;;=13484^Breathing Pattern, Ineffective^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,7,0)
 ;;=13969^[Extra Problem]^2^NURSC^35
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,8,0)
 ;;=15394^Tissue Perfusion, Alteration in^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,9,0)
 ;;=15406^Fluid Volume (Deficit/Excess)^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5102,1,10,0)
 ;;=15430^Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5103,0)
 ;;=Hemodialysis^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,0)
 ;;=^124.21IP^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,1,0)
 ;;=7420^Fluid Volume Excess (Actual/Potential)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,2,0)
 ;;=7516^Infection Potential^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,3,0)
 ;;=7591^Activity Intolerance^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,4,0)
 ;;=7723^Knowledge Deficit^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,5,0)
 ;;=7820^Coping, Ineffective Family^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,6,0)
 ;;=9212^Coping, Ineffective Individual^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5103,1,7,0)
 ;;=15533^[Extra Problem]^2^NURSC^53
 ;;^UTILITY("^GMRD(124.2,",$J,5104,0)
 ;;=Renal/Urinary Calculi^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5104,1,0)
 ;;=^124.21IP^5^3
 ;;^UTILITY("^GMRD(124.2,",$J,5104,1,1,0)
 ;;=7247^Pain, Acute^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5104,1,3,0)
 ;;=7391^[Extra Problem]^2^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,5104,1,5,0)
 ;;=10492^Knowledge Deficit^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,5106,0)
 ;;=Ocular Disorder/Surgery (Cataracts)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5106,1,0)
 ;;=^124.21IP^7^4
 ;;^UTILITY("^GMRD(124.2,",$J,5106,1,4,0)
 ;;=7230^[Extra Problem]^2^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,5106,1,5,0)
 ;;=9813^Injury Potential Related to Visual Impairment^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5106,1,6,0)
 ;;=10021^Pain (Acute) Related to Surgical Procedure^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,5106,1,7,0)
 ;;=10285^Knowledge Deficit of Home Care, S/S, and Risk Factors^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,5107,0)
 ;;=Acquired Immune Deficiency Syndrome (AIDS)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,0)
 ;;=^124.21IP^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,1,0)
 ;;=11710^Pain, Chronic^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,2,0)
 ;;=11888^Gas Exchange, Impaired^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,3,0)
 ;;=12112^Infection Potential^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,4,0)
 ;;=12361^Nutrition, Alteration in:(Less Than Required)^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,5,0)
 ;;=12550^Fluid Volume Deficit (Actual/Potential)^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,6,0)
 ;;=12700^Anxiety^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5107,1,7,0)
 ;;=12846^[Extra Problem]^2^NURSC^30
 ;;^UTILITY("^GMRD(124.2,",$J,5108,0)
 ;;=Diabetes Mellitus^2^NURSC^8^2^1^^T
