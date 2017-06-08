NURCCGA8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5903,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^75^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5903,1,0)
 ;;=^124.21PI^15^5
 ;;^UTILITY("^GMRD(124.2,",$J,5903,1,1,0)
 ;;=5904^assess for signs of fatigue and weakness^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5903,1,6,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5903,1,9,0)
 ;;=5925^teach patient^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5903,1,14,0)
 ;;=6039^[Extra Order]^3^NURSC^66
 ;;^UTILITY("^GMRD(124.2,",$J,5903,1,15,0)
 ;;=2100^provide quiet environment to decrease stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5903,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5903,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5904,0)
 ;;=assess for signs of fatigue and weakness^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5904,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,5904,1,1,0)
 ;;=291^exertional dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5904,1,2,0)
 ;;=292^inability to be independent for self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5904,1,4,0)
 ;;=294^deteriorating personal appearance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5904,1,5,0)
 ;;=2150^sleep pattern disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5904,5)
 ;;=; monitor and document:
 ;;^UTILITY("^GMRD(124.2,",$J,5904,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5904,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5904,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5925,0)
 ;;=teach patient^2^NURSC^11^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5925,1,0)
 ;;=^124.21PI^4^2
 ;;^UTILITY("^GMRD(124.2,",$J,5925,1,2,0)
 ;;=498^pacing activities, exercise, rest^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5925,1,4,0)
 ;;=300^relaxation therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5925,5)
 ;;=in
 ;;^UTILITY("^GMRD(124.2,",$J,5925,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5925,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5925,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5942,0)
 ;;=[Extra Order]^3^NURSC^11^83^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5942,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5942,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5943,0)
 ;;=Related Problems^2^NURSC^7^71^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5943,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5943,1,1,0)
 ;;=136^Comfort, Altered: Chest Pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5943,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5943,1,3,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5943,1,4,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5943,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,5943,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5948,0)
 ;;=Defining Characteristics^2^NURSC^12^76^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5948,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5948,1,1,0)
 ;;=291^exertional dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5948,1,2,0)
 ;;=4031^verbal report of fatigue or weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5948,1,3,0)
 ;;=4032^abnormal heart rate or BP response to activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5948,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5948,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5953,0)
 ;;=[Extra Problem]^2^NURSC^2^49^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5953,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5953,1,1,0)
 ;;=5954^Etiology/Related and/or Risk Factors^2^NURSC^255
 ;;^UTILITY("^GMRD(124.2,",$J,5953,1,2,0)
 ;;=5958^Goals/Expected Outcomes^2^NURSC^265
 ;;^UTILITY("^GMRD(124.2,",$J,5953,1,3,0)
 ;;=5962^Nursing Intervention/Orders^2^NURSC^267
