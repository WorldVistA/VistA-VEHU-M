NURCCGC0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9212,1,4,0)
 ;;=9293^Related Problems^2^NURSC^107
 ;;^UTILITY("^GMRD(124.2,",$J,9212,1,5,0)
 ;;=9307^Defining Characteristics^2^NURSC^109
 ;;^UTILITY("^GMRD(124.2,",$J,9212,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9212,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9212,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9212,"TD",0)
 ;;=^^2^2^2890306^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9212,"TD",1,0)
 ;;=Ineffective coping is the impairment of adaptive behaviors and problem
 ;;^UTILITY("^GMRD(124.2,",$J,9212,"TD",2,0)
 ;;=solving abilities of a person in meeting life's demands and roles.
 ;;^UTILITY("^GMRD(124.2,",$J,9213,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^125^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,0)
 ;;=^124.21PI^14^10
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,1,0)
 ;;=1842^inadequate coping method^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,2,0)
 ;;=1843^inadequate relaxation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,3,0)
 ;;=1844^inadequate support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,5,0)
 ;;=1847^maturational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,7,0)
 ;;=1849^personal vulnerability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,9,0)
 ;;=1851^situational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,11,0)
 ;;=1853^unmet expectations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,12,0)
 ;;=1854^unrealistic perceptions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,13,0)
 ;;=1856^work overload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,1,14,0)
 ;;=15601^temporary/permanent role change^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9213,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9216,0)
 ;;=Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9216,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9216,1,1,0)
 ;;=9219^Etiology/Related and/or Risk Factors^2^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,9216,1,2,0)
 ;;=9230^Related Problems^2^NURSC^106
 ;;^UTILITY("^GMRD(124.2,",$J,9216,1,3,0)
 ;;=9238^Goals/Expected Outcomes^2^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,9216,1,4,0)
 ;;=9291^Nursing Intervention/Orders^2^NURSC^106
 ;;^UTILITY("^GMRD(124.2,",$J,9216,1,5,0)
 ;;=9353^Defining Characteristics^2^NURSC^110
 ;;^UTILITY("^GMRD(124.2,",$J,9216,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9216,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9216,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9219,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^126^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9219,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,9219,1,1,0)
 ;;=1372^alteration in afterload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9219,1,3,0)
 ;;=1375^alteration in preload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9219,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9230,0)
 ;;=Related Problems^2^NURSC^7^106^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9230,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9230,1,1,0)
 ;;=1383^Activity Intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9230,1,2,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9230,1,3,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9230,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9235,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^123^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9235,1,0)
 ;;=^124.21PI^10^4
 ;;^UTILITY("^GMRD(124.2,",$J,9235,1,3,0)
 ;;=1862^identifies three alternative methods of managing stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9235,1,6,0)
 ;;=1865^expresses feeling of greater control over stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9235,1,8,0)
 ;;=9288^[Extra Goal]^3^NURSC^156
