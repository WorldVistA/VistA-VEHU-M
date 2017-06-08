NURCCGAI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,0)
 ;;=Defining Characteristics^2^NURSC^12^82^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6333,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6333,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6339,0)
 ;;=[Extra Problem]^2^NURSC^2^15^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,6339,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6339,1,1,0)
 ;;=6340^Etiology/Related and/or Risk Factors^2^NURSC^257
 ;;^UTILITY("^GMRD(124.2,",$J,6339,1,2,0)
 ;;=6344^Goals/Expected Outcomes^2^NURSC^268
 ;;^UTILITY("^GMRD(124.2,",$J,6339,1,3,0)
 ;;=6348^Nursing Intervention/Orders^2^NURSC^270
 ;;^UTILITY("^GMRD(124.2,",$J,6339,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6339,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6339,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6340,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^257^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6340,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6340,1,1,0)
 ;;=6342^[etiology]^3^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,6340,1,2,0)
 ;;=6343^[etiology]^3^NURSC^20
 ;;^UTILITY("^GMRD(124.2,",$J,6340,1,3,0)
 ;;=6528^[etiology]^3^NURSC^77
 ;;^UTILITY("^GMRD(124.2,",$J,6340,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6341,0)
 ;;=[etiology]^3^NURSC^^18^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6342,0)
 ;;=[etiology]^3^NURSC^^19^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6343,0)
 ;;=[etiology]^3^NURSC^^20^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6344,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^268^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6344,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6344,1,1,0)
 ;;=6345^[Extra Goal]^3^NURSC^323
 ;;^UTILITY("^GMRD(124.2,",$J,6344,1,2,0)
 ;;=6346^[Extra Goal]^3^NURSC^324
 ;;^UTILITY("^GMRD(124.2,",$J,6344,1,3,0)
 ;;=6347^[Extra Goal]^3^NURSC^325
 ;;^UTILITY("^GMRD(124.2,",$J,6344,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6345,0)
 ;;=[Extra Goal]^3^NURSC^9^323^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6345,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6345,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6346,0)
 ;;=[Extra Goal]^3^NURSC^9^324^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6346,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6346,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6347,0)
 ;;=[Extra Goal]^3^NURSC^9^325^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6347,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6347,10)
 ;;=D EN2^NURCCPU1
