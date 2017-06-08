NURCCGAM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,6,0)
 ;;=2781^muscle tension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,9,0)
 ;;=2784^procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,10,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,12,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,13,0)
 ;;=2152^fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,16,0)
 ;;=972^stress and anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6482,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^90^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6482,1,0)
 ;;=^124.21PI^9^2
 ;;^UTILITY("^GMRD(124.2,",$J,6482,1,8,0)
 ;;=2796^verbalizes comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6482,1,9,0)
 ;;=6627^[Extra Goal]^3^NURSC^226
 ;;^UTILITY("^GMRD(124.2,",$J,6482,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6491,0)
 ;;=[Extra Goal]^3^NURSC^9^127^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6491,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6491,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6492,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^177^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6492,1,0)
 ;;=^124.21PI^17^3
 ;;^UTILITY("^GMRD(124.2,",$J,6492,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6492,1,16,0)
 ;;=6508^[Extra Order]^3^NURSC^133
 ;;^UTILITY("^GMRD(124.2,",$J,6492,1,17,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6492,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6492,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6508,0)
 ;;=[Extra Order]^3^NURSC^11^133^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6508,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6508,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6509,0)
 ;;=Related Problems^2^NURSC^7^77^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6509,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,0)
 ;;=Defining Characteristics^2^NURSC^12^85^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6520,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6520,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6526,0)
 ;;=[Extra Problem]^2^NURSC^2^50^1^^T^0
