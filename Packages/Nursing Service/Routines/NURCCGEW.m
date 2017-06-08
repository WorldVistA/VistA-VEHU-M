NURCCGEW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13932,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13942,0)
 ;;=position patient to minimize pain during voiding^3^NURSC^11^12^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13942,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13942,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13945,0)
 ;;=explain etiology of pain^3^NURSC^11^12^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13945,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13945,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13949,0)
 ;;=administer antibiotic therapy [specify]^3^NURSC^11^12^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13949,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13949,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13950,0)
 ;;=teach strategies to relieve pain/discomfort^3^NURSC^11^14^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13950,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13950,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13951,0)
 ;;=[Extra Order]^3^NURSC^11^245^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13951,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13951,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13952,0)
 ;;=Related Problems^2^NURSC^7^159^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13952,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,0)
 ;;=Defining Characteristics^2^NURSC^12^162^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13963,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13963,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13969,0)
 ;;=[Extra Problem]^2^NURSC^2^35^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,13969,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13969,1,1,0)
 ;;=13970^Etiology/Related and/or Risk Factors^2^NURSC^283
 ;;^UTILITY("^GMRD(124.2,",$J,13969,1,2,0)
 ;;=13974^Goals/Expected Outcomes^2^NURSC^295
 ;;^UTILITY("^GMRD(124.2,",$J,13969,1,3,0)
 ;;=13980^Nursing Intervention/Orders^2^NURSC^299
 ;;^UTILITY("^GMRD(124.2,",$J,13969,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13969,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13969,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13970,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^283^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13970,1,0)
 ;;=^124.21PI^3^3
