NURCCGBQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8447,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8447,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8447,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,8447,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,8447,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,8448,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^116^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8448,1,0)
 ;;=^124.21PI^11^4
 ;;^UTILITY("^GMRD(124.2,",$J,8448,1,2,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8448,1,9,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8448,1,10,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8448,1,11,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8448,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8457,0)
 ;;=Related Problems^2^NURSC^7^98^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8457,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8457,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8457,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8457,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8457,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8457,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8462,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^114^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8462,1,0)
 ;;=^124.21PI^12^5
 ;;^UTILITY("^GMRD(124.2,",$J,8462,1,7,0)
 ;;=8469^return of normal respiratory rate and pattern^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8462,1,9,0)
 ;;=8471^decreased use of accessory muscles^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8462,1,10,0)
 ;;=4642^free of paradoxical breathing/respiratory alternans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8462,1,11,0)
 ;;=8638^skin color and texture WNL for pt^3^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,8462,1,12,0)
 ;;=1006314^[Extra Goal]^3^NURSC^171
 ;;^UTILITY("^GMRD(124.2,",$J,8462,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8469,0)
 ;;=return of normal respiratory rate and pattern^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8469,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8469,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8471,0)
 ;;=decreased use of accessory muscles^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8471,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8471,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8473,0)
 ;;=[Extra Goal]^3^NURSC^9^148^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8473,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8473,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8474,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^184^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8474,1,0)
 ;;=^124.21PI^33^3
 ;;^UTILITY("^GMRD(124.2,",$J,8474,1,31,0)
 ;;=9039^[Extra Order]^3^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,8474,1,32,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,8474,1,33,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,8474,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8474,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8549,0)
 ;;=[Extra Order]^3^NURSC^11^151^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8549,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8549,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8552,0)
 ;;=Defining Characteristics^2^NURSC^12^103^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8552,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8552,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
