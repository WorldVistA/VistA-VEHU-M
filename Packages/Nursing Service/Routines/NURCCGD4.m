NURCCGD4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11009,1,3,0)
 ;;=11024^Goals/Expected Outcomes^2^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,11009,1,4,0)
 ;;=11036^Nursing Intervention/Orders^2^NURSC^191
 ;;^UTILITY("^GMRD(124.2,",$J,11009,1,5,0)
 ;;=11095^Defining Characteristics^2^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,11009,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11009,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11009,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11009,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,11009,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,11009,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,11010,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^149^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11010,1,0)
 ;;=^124.21PI^6^2
 ;;^UTILITY("^GMRD(124.2,",$J,11010,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11010,1,6,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11010,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11019,0)
 ;;=Related Problems^2^NURSC^7^129^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11019,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11019,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11019,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11019,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11019,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11019,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11024,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^147^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11024,1,0)
 ;;=^124.21PI^11^2
 ;;^UTILITY("^GMRD(124.2,",$J,11024,1,3,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11024,1,11,0)
 ;;=11246^[Extra Goal]^3^NURSC^182
 ;;^UTILITY("^GMRD(124.2,",$J,11024,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11035,0)
 ;;=[Extra Goal]^3^NURSC^9^180^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11035,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11035,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11036,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^191^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11036,1,0)
 ;;=^124.21PI^33^5
 ;;^UTILITY("^GMRD(124.2,",$J,11036,1,9,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11036,1,15,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11036,1,31,0)
 ;;=11468^[Extra Order]^3^NURSC^188
 ;;^UTILITY("^GMRD(124.2,",$J,11036,1,32,0)
 ;;=4858^use of incentive spirometer q[freq]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11036,1,33,0)
 ;;=849^up in chair q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11036,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11036,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11094,0)
 ;;=[Extra Order]^3^NURSC^11^183^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11094,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11094,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11095,0)
 ;;=Defining Characteristics^2^NURSC^12^129^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11095,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11095,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11095,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11095,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11095,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11095,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
