NURCCG11 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,363,0)
 ;;=Skin Ulcer (See Skin Integrity, Impairment (Actual))^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,363,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,363,1,1,0)
 ;;=1760^Etiology/Related and/or Risk Factors^2^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,363,1,2,0)
 ;;=1764^Related Problems^2^NURSC^34^0
 ;;^UTILITY("^GMRD(124.2,",$J,363,1,3,0)
 ;;=1762^Goals/Expected Outcomes^2^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,363,1,4,0)
 ;;=1763^Nursing Intervention/Orders^2^NURSC^42^0
 ;;^UTILITY("^GMRD(124.2,",$J,363,1,5,0)
 ;;=4140^Defining Characteristics^2^NURSC^21
 ;;^UTILITY("^GMRD(124.2,",$J,363,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,363,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,363,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,364,0)
 ;;=Injury Potential^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,364,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,364,1,1,0)
 ;;=755^Etiology/Related and/or Risk Factors^2^NURSC^17^0
 ;;^UTILITY("^GMRD(124.2,",$J,364,1,2,0)
 ;;=756^Goals/Expected Outcomes^2^NURSC^16^0
 ;;^UTILITY("^GMRD(124.2,",$J,364,1,3,0)
 ;;=757^Nursing Intervention/Orders^2^NURSC^13^0
 ;;^UTILITY("^GMRD(124.2,",$J,364,1,4,0)
 ;;=797^Related Problems^2^NURSC^13^0
 ;;^UTILITY("^GMRD(124.2,",$J,364,1,5,0)
 ;;=4253^Defining Characteristics^2^NURSC^43
 ;;^UTILITY("^GMRD(124.2,",$J,364,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,364,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,364,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,364,"TD",0)
 ;;=^^3^3^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,364,"TD",1,0)
 ;;=A state in which the individual is at risk for injury as a result of
 ;;^UTILITY("^GMRD(124.2,",$J,364,"TD",2,0)
 ;;=environmental conditions interacting with the individual's adaptive
 ;;^UTILITY("^GMRD(124.2,",$J,364,"TD",3,0)
 ;;=and defensive resources.
 ;;^UTILITY("^GMRD(124.2,",$J,365,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,365,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,365,1,1,0)
 ;;=799^Etiology/Related and/or Risk Factors^2^NURSC^18^0
 ;;^UTILITY("^GMRD(124.2,",$J,365,1,2,0)
 ;;=800^Goals/Expected Outcomes^2^NURSC^17^0
 ;;^UTILITY("^GMRD(124.2,",$J,365,1,3,0)
 ;;=801^Nursing Intervention/Orders^2^NURSC^14^0
 ;;^UTILITY("^GMRD(124.2,",$J,365,1,4,0)
 ;;=802^Related Problems^2^NURSC^14^0
 ;;^UTILITY("^GMRD(124.2,",$J,365,1,5,0)
 ;;=4335^Defining Characteristics^2^NURSC^56
 ;;^UTILITY("^GMRD(124.2,",$J,365,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,365,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,365,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,365,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,365,"TD",1,0)
 ;;=A state in which the individual experiences a limitation of ability
 ;;^UTILITY("^GMRD(124.2,",$J,365,"TD",2,0)
 ;;=for independent physical movement.
 ;;^UTILITY("^GMRD(124.2,",$J,366,0)
 ;;=Pain, Chronic^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,366,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,366,1,1,0)
 ;;=1051^Etiology/Related and/or Risk Factors^2^NURSC^25^0
 ;;^UTILITY("^GMRD(124.2,",$J,366,1,2,0)
 ;;=1052^Goals/Expected Outcomes^2^NURSC^24^0
 ;;^UTILITY("^GMRD(124.2,",$J,366,1,3,0)
 ;;=1054^Nursing Intervention/Orders^2^NURSC^21^0
 ;;^UTILITY("^GMRD(124.2,",$J,366,1,4,0)
 ;;=3155^Related Problems^2^NURSC^66^0
 ;;^UTILITY("^GMRD(124.2,",$J,366,1,5,0)
 ;;=4180^Defining Characteristics^2^NURSC^28
 ;;^UTILITY("^GMRD(124.2,",$J,366,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,366,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,366,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,366,"TD",0)
 ;;=^^1^1^2890802^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,366,"TD",1,0)
 ;;=A state of discomfort that continues for more than 6 months in duration.
