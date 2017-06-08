NURCCGF7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14207,1,3,0)
 ;;=14220^Goals/Expected Outcomes^2^NURSC^187
 ;;^UTILITY("^GMRD(124.2,",$J,14207,1,4,0)
 ;;=14231^Nursing Intervention/Orders^2^NURSC^157
 ;;^UTILITY("^GMRD(124.2,",$J,14207,1,6,0)
 ;;=14348^Defining Characteristics^2^NURSC^168
 ;;^UTILITY("^GMRD(124.2,",$J,14207,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14207,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14207,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14207,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,14207,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,14207,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,14208,0)
 ;;=Related Problems^2^NURSC^7^163^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14208,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14208,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14208,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14208,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14208,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14208,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,14208,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^190^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,1,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,2,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,4,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,5,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,1,6,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14213,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^187^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,1,0)
 ;;=312^has decreased abnormal breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,2,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,3,0)
 ;;=314^has decreased use of accessory muscles^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,4,0)
 ;;=315^is afebrile^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,5,0)
 ;;=14225^verbalizes patient education information^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,6,0)
 ;;=318^S/O assists with quad cough^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,7,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14220,1,8,0)
 ;;=14493^[Extra Goal]^3^NURSC^246
 ;;^UTILITY("^GMRD(124.2,",$J,14220,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14225,0)
 ;;=verbalizes patient education information^2^NURSC^9^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14225,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,14225,1,1,0)
 ;;=319^etiological factor^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14225,1,2,0)
 ;;=2719^effective airway clearance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14225,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,14225,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14225,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14225,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14230,0)
 ;;=[Extra Goal]^3^NURSC^9^243^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14230,9)
 ;;=D EN5^NURCCPU0
