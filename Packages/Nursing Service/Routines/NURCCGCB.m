NURCCGCB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,18,0)
 ;;=629^refer for consultation or support resource^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,19,0)
 ;;=15325^discuss options (hemo or peritoneal dialysis,transplant)PRN ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,1,20,0)
 ;;=15333^promote optimal learning opportunity for pt/SO^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9610,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9648,0)
 ;;=teach importance: diet & meds to minimize disease progress^2^NURSC^11^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,0)
 ;;=^124.21PI^8^7
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,1,0)
 ;;=1738^calories^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,2,0)
 ;;=1739^sodium^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,3,0)
 ;;=1740^potassium^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,4,0)
 ;;=1741^cholesterol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,5,0)
 ;;=1742^low-density lipoprotein (LDL)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,7,0)
 ;;=1745^discuss rationale for food restrictions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,1,8,0)
 ;;=1744^high-density lipoprotein (HDL)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,9648,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9648,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9648,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9656,0)
 ;;=[Extra Order]^3^NURSC^11^163^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9656,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9656,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9657,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9657,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9657,1,1,0)
 ;;=9658^Etiology/Related and/or Risk Factors^2^NURSC^131
 ;;^UTILITY("^GMRD(124.2,",$J,9657,1,2,0)
 ;;=9662^Related Problems^2^NURSC^112
 ;;^UTILITY("^GMRD(124.2,",$J,9657,1,3,0)
 ;;=9669^Goals/Expected Outcomes^2^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,9657,1,4,0)
 ;;=9685^Nursing Intervention/Orders^2^NURSC^110
 ;;^UTILITY("^GMRD(124.2,",$J,9657,1,5,0)
 ;;=9732^Defining Characteristics^2^NURSC^114
 ;;^UTILITY("^GMRD(124.2,",$J,9657,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9657,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9657,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9657,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9657,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,9657,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,9658,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^131^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9658,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,9658,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9658,1,4,0)
 ;;=15695^appetite altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9658,1,5,0)
 ;;=2824^impaired swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9658,1,6,0)
 ;;=2609^alteration in oral mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9658,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,0)
 ;;=Related Problems^2^NURSC^7^112^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,2,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,3,0)
 ;;=2549^Impaired Swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,4,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,5,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
