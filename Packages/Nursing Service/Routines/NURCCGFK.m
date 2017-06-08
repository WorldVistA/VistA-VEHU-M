NURCCGFK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14557,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14557,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14562,0)
 ;;=Related Problems^2^NURSC^7^166^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14562,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14562,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14562,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14562,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14562,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14562,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14564,0)
 ;;=[Extra Problem]^2^NURSC^2^40^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,14564,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14564,1,1,0)
 ;;=14567^Etiology/Related and/or Risk Factors^2^NURSC^288
 ;;^UTILITY("^GMRD(124.2,",$J,14564,1,2,0)
 ;;=14575^Goals/Expected Outcomes^2^NURSC^300
 ;;^UTILITY("^GMRD(124.2,",$J,14564,1,3,0)
 ;;=14584^Nursing Intervention/Orders^2^NURSC^304
 ;;^UTILITY("^GMRD(124.2,",$J,14564,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14564,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14564,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14567,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^288^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14567,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14567,1,1,0)
 ;;=14571^[etiology]^3^NURSC^91
 ;;^UTILITY("^GMRD(124.2,",$J,14567,1,2,0)
 ;;=14572^[etiology]^3^NURSC^92
 ;;^UTILITY("^GMRD(124.2,",$J,14567,1,3,0)
 ;;=15249^[etiology]^3^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,14567,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^191^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,3,0)
 ;;=451^identifies etiology^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,4,0)
 ;;=452^complies with treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,5,0)
 ;;=2691^has improved breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,6,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,7,0)
 ;;=2692^has no signs of paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,8,0)
 ;;=2693^has no signs of respiratory alternans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,9,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,10,0)
 ;;=14588^hemodynamically stable^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14569,1,11,0)
 ;;=14843^[Extra Goal]^3^NURSC^250
 ;;^UTILITY("^GMRD(124.2,",$J,14569,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14570,0)
 ;;=[etiology]^3^NURSC^^93^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14571,0)
 ;;=[etiology]^3^NURSC^^91^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14572,0)
 ;;=[etiology]^3^NURSC^^92^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14575,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^300^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14575,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14575,1,1,0)
 ;;=14578^[Extra Goal]^3^NURSC^398
 ;;^UTILITY("^GMRD(124.2,",$J,14575,1,2,0)
 ;;=14579^[Extra Goal]^3^NURSC^399
 ;;^UTILITY("^GMRD(124.2,",$J,14575,1,3,0)
 ;;=14582^[Extra Goal]^3^NURSC^400
 ;;^UTILITY("^GMRD(124.2,",$J,14575,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14578,0)
 ;;=[Extra Goal]^3^NURSC^9^398^^^T
