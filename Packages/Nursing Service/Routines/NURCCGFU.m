NURCCGFU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14820,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14820,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,14820,1,1,0)
 ;;=14821^Related Problems^2^NURSC^168
 ;;^UTILITY("^GMRD(124.2,",$J,14820,1,2,0)
 ;;=14826^Etiology/Related and/or Risk Factors^2^NURSC^197
 ;;^UTILITY("^GMRD(124.2,",$J,14820,1,3,0)
 ;;=14833^Goals/Expected Outcomes^2^NURSC^194
 ;;^UTILITY("^GMRD(124.2,",$J,14820,1,4,0)
 ;;=14844^Nursing Intervention/Orders^2^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,14820,1,6,0)
 ;;=14911^Defining Characteristics^2^NURSC^174
 ;;^UTILITY("^GMRD(124.2,",$J,14820,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14820,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14820,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14820,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,14820,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,14820,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,14821,0)
 ;;=Related Problems^2^NURSC^7^168^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14821,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14821,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14821,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14821,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14821,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14821,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,14821,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14826,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^197^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14826,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14826,1,1,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14826,1,2,0)
 ;;=14828^infection, pulmonary^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14826,1,3,0)
 ;;=14829^obstruction, pulmonary^3^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,14826,1,4,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14826,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14828,0)
 ;;=infection, pulmonary^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14829,0)
 ;;=obstruction, pulmonary^3^NURSC^^16^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14833,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^194^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,0)
 ;;=^124.21PI^11^9
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,1,0)
 ;;=312^has decreased abnormal breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,2,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,3,0)
 ;;=314^has decreased use of accessory muscles^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,4,0)
 ;;=315^is afebrile^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,6,0)
 ;;=318^S/O assists with quad cough^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,7,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,8,0)
 ;;=15157^[Extra Goal]^3^NURSC^253
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,10,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,1,11,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14833,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14843,0)
 ;;=[Extra Goal]^3^NURSC^9^250^^^T
