NURCCGE8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12802,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12802,1,1,0)
 ;;=4057^apprehension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12802,1,2,0)
 ;;=4058^increased tension/helplessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12802,1,3,0)
 ;;=4060^uncertainty^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12802,1,4,0)
 ;;=4063^extraneous movement ie., foot shuffling, hand/arm movements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12802,1,5,0)
 ;;=4067^sympathetic stimulation-cardiovascular excitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12802,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12809,0)
 ;;=[Extra Order]^3^NURSC^11^207^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12809,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12809,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12817,0)
 ;;=Defining Characteristics^2^NURSC^12^149^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12817,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12824,0)
 ;;=Injury Potential^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12824,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12824,1,1,0)
 ;;=12825^Etiology/Related and/or Risk Factors^2^NURSC^172
 ;;^UTILITY("^GMRD(124.2,",$J,12824,1,2,0)
 ;;=12847^Goals/Expected Outcomes^2^NURSC^170
 ;;^UTILITY("^GMRD(124.2,",$J,12824,1,3,0)
 ;;=12854^Nursing Intervention/Orders^2^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,12824,1,4,0)
 ;;=12891^Related Problems^2^NURSC^148
 ;;^UTILITY("^GMRD(124.2,",$J,12824,1,5,0)
 ;;=12893^Defining Characteristics^2^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,12824,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12824,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12824,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12824,"TD",0)
 ;;=^^3^3^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,12824,"TD",1,0)
 ;;=A state in which the individual is at risk for injury as a result of
 ;;^UTILITY("^GMRD(124.2,",$J,12824,"TD",2,0)
 ;;=environmental conditions interacting with the individual's adaptive
 ;;^UTILITY("^GMRD(124.2,",$J,12824,"TD",3,0)
 ;;=and defensive resources.
 ;;^UTILITY("^GMRD(124.2,",$J,12825,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^172^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12825,1,0)
 ;;=^124.21PI^18^1
 ;;^UTILITY("^GMRD(124.2,",$J,12825,1,18,0)
 ;;=12843^cognitive/altered consciousness^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,12825,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12843,0)
 ;;=cognitive/altered consciousness^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12846,0)
 ;;=[Extra Problem]^2^NURSC^2^30^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,12846,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12846,1,1,0)
 ;;=12848^Etiology/Related and/or Risk Factors^2^NURSC^277
 ;;^UTILITY("^GMRD(124.2,",$J,12846,1,2,0)
 ;;=12856^Goals/Expected Outcomes^2^NURSC^289
 ;;^UTILITY("^GMRD(124.2,",$J,12846,1,3,0)
 ;;=12864^Nursing Intervention/Orders^2^NURSC^293
 ;;^UTILITY("^GMRD(124.2,",$J,12846,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12846,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12846,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12847,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^170^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12847,1,0)
 ;;=^124.21PI^3^3
