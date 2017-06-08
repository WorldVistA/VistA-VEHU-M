NURCCG68 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2541,0)
 ;;=Dietetic Consult^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2541,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2541,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2542,0)
 ;;=Related Problems^2^NURSC^7^55^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,1,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,2,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,3,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,4,0)
 ;;=1987^Depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,5,0)
 ;;=1418^Comfort, Alteration In: Acute Pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,6,0)
 ;;=1419^Comfort, Alteration In: Chronic Pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,7,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,8,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,1,9,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2542,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,2542,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2543,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^68^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2543,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2543,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2543,1,2,0)
 ;;=2545^inability to digest/absorb nutrients due to psych. factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2543,1,3,0)
 ;;=2546^inability to digest/absorb nutrients due to economic factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2543,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2544,0)
 ;;=inability to digest/absorb nutrients due to biologic factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2545,0)
 ;;=inability to digest/absorb nutrients due to psych. factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2546,0)
 ;;=inability to digest/absorb nutrients due to economic factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2547,0)
 ;;=Related Problems^2^NURSC^7^56^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2547,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2547,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,2547,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2548,0)
 ;;=Appetite, Altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2549,0)
 ;;=Impaired Swallowing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2550,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^68^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2550,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2550,1,1,0)
 ;;=2551^expresses factors that contribute to decreased nutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2550,1,2,0)
 ;;=2552^maintains nutritional intake to meet metabolic requirements^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2550,1,3,0)
 ;;=2559^identifies/procures food source^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2550,1,4,0)
 ;;=2932^[Extra Goal]^3^NURSC^113^0
 ;;^UTILITY("^GMRD(124.2,",$J,2550,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2551,0)
 ;;=expresses factors that contribute to decreased nutrition^3^NURSC^9^1^^^T
