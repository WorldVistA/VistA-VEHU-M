NURCCGG2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15188,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15188,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15189,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15189,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15189,1,1,0)
 ;;=15190^Etiology/Related and/or Risk Factors^2^NURSC^201
 ;;^UTILITY("^GMRD(124.2,",$J,15189,1,2,0)
 ;;=15194^Related Problems^2^NURSC^171
 ;;^UTILITY("^GMRD(124.2,",$J,15189,1,3,0)
 ;;=15201^Goals/Expected Outcomes^2^NURSC^198
 ;;^UTILITY("^GMRD(124.2,",$J,15189,1,4,0)
 ;;=15216^Nursing Intervention/Orders^2^NURSC^166
 ;;^UTILITY("^GMRD(124.2,",$J,15189,1,5,0)
 ;;=15240^Defining Characteristics^2^NURSC^177
 ;;^UTILITY("^GMRD(124.2,",$J,15189,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15189,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15189,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15189,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,15189,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,15189,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,15190,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^201^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15190,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,15190,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15190,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,0)
 ;;=Related Problems^2^NURSC^7^171^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15194,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,15194,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15201,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^198^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15201,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15201,1,1,0)
 ;;=2551^expresses factors that contribute to decreased nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15201,1,2,0)
 ;;=15203^maintains nutritional intake to meet metabolic requirements^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15201,1,3,0)
 ;;=15210^identifies/procures food source^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15201,1,4,0)
 ;;=15457^[Extra Goal]^3^NURSC^257
 ;;^UTILITY("^GMRD(124.2,",$J,15201,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,0)
 ;;=maintains nutritional intake to meet metabolic requirements^2^NURSC^9^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,15203,1,1,0)
 ;;=2553^stable weight greater than [specify] lbs/kgs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,1,2,0)
 ;;=2554^stable weight less than [specify] lbs/kgs ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,1,3,0)
 ;;=2555^daily intake of [number of] calories^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,1,6,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,15203,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15203,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15203,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15210,0)
 ;;=identifies/procures food source^2^NURSC^9^8^1^^T^1
