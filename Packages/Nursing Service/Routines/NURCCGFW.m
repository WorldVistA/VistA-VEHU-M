NURCCGFW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14905,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14911,0)
 ;;=Defining Characteristics^2^NURSC^12^174^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14911,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14918,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14918,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,14918,1,2,0)
 ;;=14928^Related Problems^2^NURSC^169
 ;;^UTILITY("^GMRD(124.2,",$J,14918,1,3,0)
 ;;=14933^Goals/Expected Outcomes^2^NURSC^195
 ;;^UTILITY("^GMRD(124.2,",$J,14918,1,4,0)
 ;;=14946^Nursing Intervention/Orders^2^NURSC^200
 ;;^UTILITY("^GMRD(124.2,",$J,14918,1,5,0)
 ;;=15006^Defining Characteristics^2^NURSC^175
 ;;^UTILITY("^GMRD(124.2,",$J,14918,1,6,0)
 ;;=15289^Etiology/Related and/or Risk Factors^2^NURSC^292
 ;;^UTILITY("^GMRD(124.2,",$J,14918,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14918,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14918,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14918,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,14918,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,14918,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,14928,0)
 ;;=Related Problems^2^NURSC^7^169^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14928,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14928,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14928,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14928,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14928,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14928,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^195^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,0)
 ;;=^124.21PI^10^11
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,2,0)
 ;;=423^establishes breathing pattern within normal rate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,3,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,4,0)
 ;;=425^identifies causative factors and preventive measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,5,0)
 ;;=2713^no signs of respiratory alternans or paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,6,0)
 ;;=2714^no signs of paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,7,0)
 ;;=450^remains free of S/S of hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,8,0)
 ;;=2715^remains free of hypercapnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,9,0)
 ;;=8471^decreased use of accessory muscles^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,10,0)
 ;;=836^verbalizes preventive measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14933,1,11,0)
 ;;=15215^[Extra Goal]^3^NURSC^254
 ;;^UTILITY("^GMRD(124.2,",$J,14933,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14937,0)
 ;;=teach/reinforce speech improvement exercise^3^NURSC^11^1^^^T
