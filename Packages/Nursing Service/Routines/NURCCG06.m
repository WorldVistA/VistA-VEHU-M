NURCCG06 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,50,0)
 ;;=Home Maintenance Management, Impaired^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,50,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,50,1,1,0)
 ;;=68^Etiology/Related and/or Risk Factors^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,50,1,2,0)
 ;;=69^Goals/Expected Outcomes^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,50,1,3,0)
 ;;=70^Nursing Intervention/Orders^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,50,1,4,0)
 ;;=90^Related Problems^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,50,1,5,0)
 ;;=4177^Defining Characteristics^2^NURSC^27
 ;;^UTILITY("^GMRD(124.2,",$J,50,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,50,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,50,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,50,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,50,"TD",1,0)
 ;;=The client is unable to independently maintain a safe, growth-promoting
 ;;^UTILITY("^GMRD(124.2,",$J,50,"TD",2,0)
 ;;=immediate environment.
 ;;^UTILITY("^GMRD(124.2,",$J,51,0)
 ;;=Self-Care Deficit [Specify]^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,51,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,51,1,1,0)
 ;;=52^Etiology/Related and/or Risk Factors^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,51,1,2,0)
 ;;=53^Goals/Expected Outcomes^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,51,1,3,0)
 ;;=54^Nursing Intervention/Orders^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,51,1,4,0)
 ;;=137^Related Problems^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,51,1,5,0)
 ;;=4102^Defining Characteristics^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,51,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,51,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,51,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,51,"TD",0)
 ;;=^^3^3^2910905^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,51,"TD",1,0)
 ;;=A state in which the individual experiences an impaired ability to
 ;;^UTILITY("^GMRD(124.2,",$J,51,"TD",2,0)
 ;;=perform or complete feeding, bathing, toileting, dressing, and 
 ;;^UTILITY("^GMRD(124.2,",$J,51,"TD",3,0)
 ;;=grooming activities for oneself.
 ;;^UTILITY("^GMRD(124.2,",$J,52,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,1,0)
 ;;=207^depression, severe anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,2,0)
 ;;=208^intolerance to activity; decreased strength and endurance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,3,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,4,0)
 ;;=210^neuromuscular impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,5,0)
 ;;=211^pain, discomfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,52,1,6,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,52,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,53,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,1,0)
 ;;=212^general self-care deficit outcomes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,2,0)
 ;;=213^feeding deficit outcomes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,3,0)
 ;;=214^bathing/hygiene deficit outcomes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,4,0)
 ;;=215^dressing/grooming deficit outcomes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,5,0)
 ;;=269^toileting deficit outcomes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,53,1,6,0)
 ;;=4374^[Extra Goal]^3^NURSC^49
 ;;^UTILITY("^GMRD(124.2,",$J,53,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,54,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,54,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,54,1,1,0)
 ;;=232^general self-care deficit interventions^2^NURSC^1^0
