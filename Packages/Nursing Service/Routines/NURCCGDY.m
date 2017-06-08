NURCCGDY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12290,0)
 ;;=able to administer insulin injections/oral hypoglycemics^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12360,0)
 ;;=Related Problems^2^NURSC^7^142^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12360,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,12360,1,1,0)
 ;;=139^coping, ineffective, individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12360,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12360,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,12360,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12361,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12361,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12361,1,1,0)
 ;;=12362^Etiology/Related and/or Risk Factors^2^NURSC^166
 ;;^UTILITY("^GMRD(124.2,",$J,12361,1,2,0)
 ;;=12369^Related Problems^2^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,12361,1,3,0)
 ;;=12381^Goals/Expected Outcomes^2^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,12361,1,4,0)
 ;;=12396^Nursing Intervention/Orders^2^NURSC^138
 ;;^UTILITY("^GMRD(124.2,",$J,12361,1,5,0)
 ;;=12440^Defining Characteristics^2^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,12361,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12361,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12361,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12361,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,12361,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,12361,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,12362,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^166^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12362,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12362,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12362,1,2,0)
 ;;=2545^inability to digest/absorb nutrients due to psych. factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12362,1,3,0)
 ;;=2546^inability to digest/absorb nutrients due to economic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12362,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12367,0)
 ;;=Defining Characteristics^2^NURSC^12^142^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12367,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12367,1,1,0)
 ;;=4110^inability to wash body,obtain water & regulate water temp^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12367,1,2,0)
 ;;=4112^inability to dress & groom self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12367,1,3,0)
 ;;=4113^inability to feed self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12367,1,4,0)
 ;;=4114^inability to toilet self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12367,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,0)
 ;;=Related Problems^2^NURSC^7^143^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12369,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,12369,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12381,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^164^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12381,1,0)
 ;;=^124.21PI^5^3
 ;;^UTILITY("^GMRD(124.2,",$J,12381,1,1,0)
 ;;=12382^participates in nutritional planning^3^NURSC^6
