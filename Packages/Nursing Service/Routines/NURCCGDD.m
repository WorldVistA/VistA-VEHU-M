NURCCGDD ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11459,1,4,0)
 ;;=938^provide comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11459,1,6,0)
 ;;=11467^teach causative factors for pain^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11459,1,7,0)
 ;;=11874^[Extra Order]^3^NURSC^192
 ;;^UTILITY("^GMRD(124.2,",$J,11459,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11459,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11460,0)
 ;;=teach patient to avoid prolonged sitting/standing^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11460,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11460,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11461,0)
 ;;=teach techniques to reduce pain during dressing changes^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11461,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11461,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11467,0)
 ;;=teach causative factors for pain^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11467,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11467,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11468,0)
 ;;=[Extra Order]^3^NURSC^11^188^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11468,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11468,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11469,0)
 ;;=Related Problems^2^NURSC^7^133^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,3,0)
 ;;=1383^Activity Intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,4,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,5,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,7,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,8,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,1,9,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11469,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11490,0)
 ;;=teach pt & S/O prevention/tx of hypo/hyperglycemia^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11490,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11490,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11546,0)
 ;;=Defining Characteristics^2^NURSC^12^134^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11546,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11546,1,1,0)
 ;;=4185^verbal report of pain experienced for more than 6 months^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11546,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11546,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11546,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11546,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11546,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11552,0)
 ;;=Skin Integrity, Impaired ^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11552,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11552,1,1,0)
 ;;=11553^Etiology/Related and/or Risk Factors^2^NURSC^273
 ;;^UTILITY("^GMRD(124.2,",$J,11552,1,2,0)
 ;;=11556^Goals/Expected Outcomes^2^NURSC^285
 ;;^UTILITY("^GMRD(124.2,",$J,11552,1,3,0)
 ;;=11560^Nursing Intervention/Orders^2^NURSC^289
 ;;^UTILITY("^GMRD(124.2,",$J,11552,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11552,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11552,10)
 ;;=D EN3^NURCCPU1
