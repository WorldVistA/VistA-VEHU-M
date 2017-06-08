NURCCGC7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9510,1,0)
 ;;=^124.21PI^8^5
 ;;^UTILITY("^GMRD(124.2,",$J,9510,1,2,0)
 ;;=4072^intake altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9510,1,3,0)
 ;;=4073^thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9510,1,6,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9510,1,7,0)
 ;;=4199^skin turgor decreased^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9510,1,8,0)
 ;;=4201^urine output altered (diluted, increased or decreased)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9510,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9519,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9519,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9519,1,1,0)
 ;;=9520^Etiology/Related and/or Risk Factors^2^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,9519,1,2,0)
 ;;=9524^Related Problems^2^NURSC^110
 ;;^UTILITY("^GMRD(124.2,",$J,9519,1,3,0)
 ;;=9531^Goals/Expected Outcomes^2^NURSC^127
 ;;^UTILITY("^GMRD(124.2,",$J,9519,1,4,0)
 ;;=9546^Nursing Intervention/Orders^2^NURSC^108
 ;;^UTILITY("^GMRD(124.2,",$J,9519,1,5,0)
 ;;=9570^Defining Characteristics^2^NURSC^113
 ;;^UTILITY("^GMRD(124.2,",$J,9519,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9519,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9519,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9519,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9519,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,9519,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,9520,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^129^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9520,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9520,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9520,1,2,0)
 ;;=2545^inability to digest/absorb nutrients due to psych. factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9520,1,3,0)
 ;;=2546^inability to digest/absorb nutrients due to economic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9520,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,0)
 ;;=Related Problems^2^NURSC^7^110^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9524,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,9524,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9531,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^127^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9531,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,9531,1,1,0)
 ;;=2551^expresses factors that contribute to decreased nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9531,1,2,0)
 ;;=9533^maintains intake to meet metabolic/nutritional requirements:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9531,1,4,0)
 ;;=9609^[Extra Goal]^3^NURSC^160
 ;;^UTILITY("^GMRD(124.2,",$J,9531,1,5,0)
 ;;=15290^describes diet,fluid restrictions,& food content^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9531,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9533,0)
 ;;=maintains intake to meet metabolic/nutritional requirements:^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9533,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,9533,1,1,0)
 ;;=9534^stable weight [specify weight range]lbs/kgs, w/i 20% ideal^3^NURSC^2
