NURCCGC3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9361,1,11,0)
 ;;=9372^chest tube placement^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,9361,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9372,0)
 ;;=chest tube placement^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9379,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^125^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9379,1,0)
 ;;=^124.21PI^9^4
 ;;^UTILITY("^GMRD(124.2,",$J,9379,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9379,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9379,1,8,0)
 ;;=2796^verbalizes comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9379,1,9,0)
 ;;=9468^[Extra Goal]^3^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,9379,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9388,0)
 ;;=[Extra Goal]^3^NURSC^9^157^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9388,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9388,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9389,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^186^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9389,1,0)
 ;;=^124.21PI^20^5
 ;;^UTILITY("^GMRD(124.2,",$J,9389,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9389,1,6,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9389,1,16,0)
 ;;=9730^[Extra Order]^3^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,9389,1,17,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9389,1,20,0)
 ;;=4599^teach pain control interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9389,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9389,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9405,0)
 ;;=[Extra Order]^3^NURSC^11^160^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9405,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9405,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9406,0)
 ;;=Related Problems^2^NURSC^7^108^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9406,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,0)
 ;;=Defining Characteristics^2^NURSC^12^111^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9417,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9417,7)
 ;;=D EN4^NURCCPU1
