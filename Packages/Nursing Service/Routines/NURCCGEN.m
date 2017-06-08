NURCCGEN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13485,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^180^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13485,1,0)
 ;;=^124.21PI^8^2
 ;;^UTILITY("^GMRD(124.2,",$J,13485,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13485,1,8,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13485,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13494,0)
 ;;=Related Problems^2^NURSC^7^155^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13494,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13494,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13494,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13494,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13494,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13494,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13499,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^178^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13499,1,0)
 ;;=^124.21PI^11^2
 ;;^UTILITY("^GMRD(124.2,",$J,13499,1,5,0)
 ;;=2713^no signs of respiratory alternans or paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13499,1,11,0)
 ;;=13728^[Extra Goal]^3^NURSC^237
 ;;^UTILITY("^GMRD(124.2,",$J,13499,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13500,0)
 ;;=avoid straining on bowel movements^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13511,0)
 ;;=[Extra Goal]^3^NURSC^9^234^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13511,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13511,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13512,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^197^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13512,1,0)
 ;;=^124.21PI^32^2
 ;;^UTILITY("^GMRD(124.2,",$J,13512,1,31,0)
 ;;=13951^[Extra Order]^3^NURSC^245
 ;;^UTILITY("^GMRD(124.2,",$J,13512,1,32,0)
 ;;=2702^bronchial hygiene q[frequency]hrs^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13512,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13512,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13570,0)
 ;;=[Extra Order]^3^NURSC^11^240^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13570,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13570,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13571,0)
 ;;=Defining Characteristics^2^NURSC^12^157^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13571,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13571,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13571,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13571,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13571,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13571,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13571,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13575,0)
 ;;=report severe eye pain or irritation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13578,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13578,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13578,1,1,0)
 ;;=13579^Etiology/Related and/or Risk Factors^2^NURSC^181
 ;;^UTILITY("^GMRD(124.2,",$J,13578,1,2,0)
 ;;=13599^Goals/Expected Outcomes^2^NURSC^179
 ;;^UTILITY("^GMRD(124.2,",$J,13578,1,3,0)
 ;;=13604^Nursing Intervention/Orders^2^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,13578,1,4,0)
 ;;=13627^Related Problems^2^NURSC^156
 ;;^UTILITY("^GMRD(124.2,",$J,13578,1,5,0)
 ;;=13633^Defining Characteristics^2^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,13578,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13578,9)
 ;;=D EN2^NURCCPU3
