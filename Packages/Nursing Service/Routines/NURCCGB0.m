NURCCGB0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7292,0)
 ;;=[Extra Order]^3^NURSC^11^138^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7292,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7292,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7293,0)
 ;;=Related Problems^2^NURSC^7^86^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7293,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,0)
 ;;=Defining Characteristics^2^NURSC^12^92^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7304,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7304,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7314,0)
 ;;=wound care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7391,0)
 ;;=[Extra Problem]^2^NURSC^2^19^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7391,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7391,1,1,0)
 ;;=7392^Etiology/Related and/or Risk Factors^2^NURSC^263
 ;;^UTILITY("^GMRD(124.2,",$J,7391,1,2,0)
 ;;=7396^Goals/Expected Outcomes^2^NURSC^274
 ;;^UTILITY("^GMRD(124.2,",$J,7391,1,3,0)
 ;;=7400^Nursing Intervention/Orders^2^NURSC^276
 ;;^UTILITY("^GMRD(124.2,",$J,7391,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7391,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7391,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7392,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^263^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7392,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7392,1,1,0)
 ;;=7394^[etiology]^3^NURSC^127
 ;;^UTILITY("^GMRD(124.2,",$J,7392,1,2,0)
 ;;=7395^[etiology]^3^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,7392,1,3,0)
 ;;=8263^[etiology]^3^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,7392,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7393,0)
 ;;=[etiology]^3^NURSC^^129^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7394,0)
 ;;=[etiology]^3^NURSC^^127^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7395,0)
 ;;=[etiology]^3^NURSC^^128^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7396,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^274^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7396,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7396,1,1,0)
 ;;=7397^[Extra Goal]^3^NURSC^338
 ;;^UTILITY("^GMRD(124.2,",$J,7396,1,2,0)
 ;;=7398^[Extra Goal]^3^NURSC^339
 ;;^UTILITY("^GMRD(124.2,",$J,7396,1,3,0)
 ;;=7399^[Extra Goal]^3^NURSC^340
 ;;^UTILITY("^GMRD(124.2,",$J,7396,7)
 ;;=D EN4^NURCCPU1
