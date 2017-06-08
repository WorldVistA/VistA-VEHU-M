NURCCGBA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,16,0)
 ;;=972^stress and anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7660,0)
 ;;=[Extra Order]^3^NURSC^11^141^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7660,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7660,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7663,0)
 ;;=Related Problems^2^NURSC^7^89^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7663,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,7663,1,1,0)
 ;;=136^Comfort, Altered: Chest Pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7663,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7663,1,3,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7663,1,4,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7663,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,7663,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7671,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^105^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7671,1,0)
 ;;=^124.21PI^10^5
 ;;^UTILITY("^GMRD(124.2,",$J,7671,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7671,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7671,1,8,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7671,1,9,0)
 ;;=7756^[Extra Goal]^3^NURSC^140
 ;;^UTILITY("^GMRD(124.2,",$J,7671,1,10,0)
 ;;=4362^verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7671,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7674,0)
 ;;=Defining Characteristics^2^NURSC^12^94^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7674,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,7674,1,1,0)
 ;;=291^exertional dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7674,1,2,0)
 ;;=4031^verbal report of fatigue or weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7674,1,3,0)
 ;;=4032^abnormal heart rate or BP response to activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7674,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7674,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7682,0)
 ;;=assess for stage of withdrawal^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7682,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7682,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7688,0)
 ;;=[Extra Goal]^3^NURSC^9^139^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7688,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7688,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7689,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^182^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7689,1,0)
 ;;=^124.21PI^18^5
 ;;^UTILITY("^GMRD(124.2,",$J,7689,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7689,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7689,1,5,0)
 ;;=2803^support verbalization of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7689,1,6,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7689,1,18,0)
 ;;=7803^[Extra Order]^3^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,7689,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7689,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7706,0)
 ;;=Related Problems^2^NURSC^7^90^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
