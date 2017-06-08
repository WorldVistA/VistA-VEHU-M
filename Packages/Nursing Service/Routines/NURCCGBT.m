NURCCGBT ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8728,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^117^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8728,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,8728,1,1,0)
 ;;=275^verbalizes/demonstrates decreased fatigue with activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8728,1,3,0)
 ;;=277^demonstrates increased independence for self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8728,1,4,0)
 ;;=8732^hemodynamically stable during activity^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8728,1,6,0)
 ;;=8843^[Extra Goal]^3^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,8728,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8732,0)
 ;;=hemodynamically stable during activity^2^NURSC^9^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8732,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8732,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8732,1,2,0)
 ;;=280^B/P^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8732,1,3,0)
 ;;=7604^skin color and texture WNL for pt^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,8732,1,4,0)
 ;;=8736^pulse oximetry indicates oxygen saturation of 90% or greater^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8732,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,8732,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8732,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8732,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8736,0)
 ;;=pulse oximetry indicates oxygen saturation of 90% or greater^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8738,0)
 ;;=[Extra Goal]^3^NURSC^9^150^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8738,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8738,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8739,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^100^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8739,1,0)
 ;;=^124.21PI^15^4
 ;;^UTILITY("^GMRD(124.2,",$J,8739,1,4,0)
 ;;=285^plan activities to maximize medication/treatment benefits^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8739,1,5,0)
 ;;=242^encourage patient to control timing of self-care activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8739,1,14,0)
 ;;=9211^[Extra Order]^3^NURSC^157
 ;;^UTILITY("^GMRD(124.2,",$J,8739,1,15,0)
 ;;=15360^assess & monitor pulse,skin color,oxygen sat during exercise^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8739,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8739,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8778,0)
 ;;=[Extra Order]^3^NURSC^11^153^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8778,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8778,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8779,0)
 ;;=Related Problems^2^NURSC^7^101^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8779,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8779,1,1,0)
 ;;=136^Comfort, Altered: Chest Pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8779,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8779,1,3,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8779,1,4,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8779,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,8779,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8784,0)
 ;;=Defining Characteristics^2^NURSC^12^105^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8784,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8784,1,1,0)
 ;;=291^exertional dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8784,1,2,0)
 ;;=4031^verbal report of fatigue or weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8784,1,3,0)
 ;;=4032^abnormal heart rate or BP response to activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8784,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8784,7)
 ;;=D EN4^NURCCPU1
