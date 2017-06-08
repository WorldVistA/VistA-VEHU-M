NURCCGAA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5966,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,5966,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,5966,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,5967,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^83^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5967,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5967,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5967,1,2,0)
 ;;=2545^inability to digest/absorb nutrients due to psych. factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5967,1,3,0)
 ;;=2546^inability to digest/absorb nutrients due to economic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5967,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,0)
 ;;=Related Problems^2^NURSC^7^72^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5971,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,5971,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5978,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^83^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5978,1,0)
 ;;=^124.21PI^5^2
 ;;^UTILITY("^GMRD(124.2,",$J,5978,1,4,0)
 ;;=6099^[Extra Goal]^3^NURSC^122
 ;;^UTILITY("^GMRD(124.2,",$J,5978,1,5,0)
 ;;=2552^maintains nutritional intake to meet metabolic requirements^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5978,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5993,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^76^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5993,1,0)
 ;;=^124.21PI^18^5
 ;;^UTILITY("^GMRD(124.2,",$J,5993,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5993,1,4,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5993,1,14,0)
 ;;=6009^initiate consult(s):^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5993,1,17,0)
 ;;=6016^[Extra Order]^3^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,5993,1,18,0)
 ;;=4675^promote patient participation in dietary planning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5993,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5993,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6009,0)
 ;;=initiate consult(s):^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6009,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6009,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6009,1,2,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6009,1,3,0)
 ;;=2580^VNA^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6009,1,4,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6009,5)
 ;;=to:
 ;;^UTILITY("^GMRD(124.2,",$J,6009,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6009,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6009,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6016,0)
 ;;=[Extra Order]^3^NURSC^11^125^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6016,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6016,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6017,0)
 ;;=Defining Characteristics^2^NURSC^12^77^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6017,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6017,1,1,0)
 ;;=6018^body weight 20% or more under ideal^3^NURSC^2
