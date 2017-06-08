NURCCGD8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11324,0)
 ;;=assess for S/S of hypo/hyperglycemia & neuro changes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11324,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11324,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11325,0)
 ;;=Related Problems^2^NURSC^7^131^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11325,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,0)
 ;;=Defining Characteristics^2^NURSC^12^131^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11336,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11336,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11342,0)
 ;;=[Extra Problem]^2^NURSC^2^26^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,11342,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11342,1,1,0)
 ;;=11343^Etiology/Related and/or Risk Factors^2^NURSC^272
 ;;^UTILITY("^GMRD(124.2,",$J,11342,1,2,0)
 ;;=11347^Goals/Expected Outcomes^2^NURSC^284
 ;;^UTILITY("^GMRD(124.2,",$J,11342,1,3,0)
 ;;=11351^Nursing Intervention/Orders^2^NURSC^288
 ;;^UTILITY("^GMRD(124.2,",$J,11342,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11342,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11342,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11343,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^272^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11343,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11343,1,1,0)
 ;;=11345^[etiology]^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,11343,1,2,0)
 ;;=11346^[etiology]^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,11343,1,3,0)
 ;;=11632^[etiology]^3^NURSC^60
 ;;^UTILITY("^GMRD(124.2,",$J,11343,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11344,0)
 ;;=[etiology]^3^NURSC^^31^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11345,0)
 ;;=[etiology]^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11346,0)
 ;;=[etiology]^3^NURSC^^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11347,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^284^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11347,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11347,1,1,0)
 ;;=11348^[Extra Goal]^3^NURSC^359
 ;;^UTILITY("^GMRD(124.2,",$J,11347,1,2,0)
 ;;=11349^[Extra Goal]^3^NURSC^360
 ;;^UTILITY("^GMRD(124.2,",$J,11347,1,3,0)
 ;;=11350^[Extra Goal]^3^NURSC^361
 ;;^UTILITY("^GMRD(124.2,",$J,11347,7)
 ;;=D EN4^NURCCPU1
