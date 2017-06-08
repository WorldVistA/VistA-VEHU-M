NURCCGDO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11894,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11894,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11894,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11894,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11899,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^159^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11899,1,0)
 ;;=^124.21PI^11^2
 ;;^UTILITY("^GMRD(124.2,",$J,11899,1,1,0)
 ;;=11900^demonstrates decreased S/S of repiratory distress ie.,SOB^3^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,11899,1,11,0)
 ;;=12090^[Extra Goal]^3^NURSC^192
 ;;^UTILITY("^GMRD(124.2,",$J,11899,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11900,0)
 ;;=demonstrates decreased S/S of repiratory distress ie.,SOB^3^NURSC^9^13^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11900,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11900,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11902,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11902,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11902,1,1,0)
 ;;=11905^Etiology/Related and/or Risk Factors^2^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,11902,1,2,0)
 ;;=11914^Related Problems^2^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,11902,1,3,0)
 ;;=11928^Goals/Expected Outcomes^2^NURSC^160
 ;;^UTILITY("^GMRD(124.2,",$J,11902,1,4,0)
 ;;=11955^Nursing Intervention/Orders^2^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,11902,1,5,0)
 ;;=12007^Defining Characteristics^2^NURSC^140
 ;;^UTILITY("^GMRD(124.2,",$J,11902,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11902,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11902,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11902,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,11902,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,11902,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,11905,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^162^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11905,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11905,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11905,1,2,0)
 ;;=2545^inability to digest/absorb nutrients due to psych. factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11905,1,3,0)
 ;;=2546^inability to digest/absorb nutrients due to economic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11905,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,0)
 ;;=Related Problems^2^NURSC^7^141^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11914,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,11914,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11925,0)
 ;;=[Extra Goal]^3^NURSC^9^190^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11925,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11925,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11927,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^194^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,0)
 ;;=^124.21PI^33^6
