NURCCGE5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12638,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12661,0)
 ;;=[Extra Order]^3^NURSC^11^205^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12661,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12661,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12662,0)
 ;;=Defining Characteristics^2^NURSC^12^146^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12662,1,0)
 ;;=^124.21PI^8^5
 ;;^UTILITY("^GMRD(124.2,",$J,12662,1,2,0)
 ;;=4072^intake altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12662,1,3,0)
 ;;=4073^thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12662,1,6,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12662,1,7,0)
 ;;=4199^skin turgor decreased^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12662,1,8,0)
 ;;=4201^urine output altered (diluted, increased or decreased)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12662,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12671,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12671,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,12671,1,1,0)
 ;;=12672^Related Problems^2^NURSC^146
 ;;^UTILITY("^GMRD(124.2,",$J,12671,1,2,0)
 ;;=12677^Etiology/Related and/or Risk Factors^2^NURSC^170
 ;;^UTILITY("^GMRD(124.2,",$J,12671,1,3,0)
 ;;=12684^Goals/Expected Outcomes^2^NURSC^168
 ;;^UTILITY("^GMRD(124.2,",$J,12671,1,4,0)
 ;;=12695^Nursing Intervention/Orders^2^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,12671,1,6,0)
 ;;=12817^Defining Characteristics^2^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,12671,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12671,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12671,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12671,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,12671,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,12671,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,12672,0)
 ;;=Related Problems^2^NURSC^7^146^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12672,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12672,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12672,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12672,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12672,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12672,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,12672,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12677,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^170^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12677,1,0)
 ;;=^124.21PI^3^1
 ;;^UTILITY("^GMRD(124.2,",$J,12677,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12677,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12684,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^168^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12684,1,0)
 ;;=^124.21PI^9^2
 ;;^UTILITY("^GMRD(124.2,",$J,12684,1,3,0)
 ;;=12687^maintains effective respiratory pattern/patent airway^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12684,1,9,0)
 ;;=12923^[Extra Goal]^3^NURSC^206
 ;;^UTILITY("^GMRD(124.2,",$J,12684,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12687,0)
 ;;=maintains effective respiratory pattern/patent airway^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12687,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12687,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12695,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^142^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12695,1,0)
 ;;=^124.21PI^33^3
 ;;^UTILITY("^GMRD(124.2,",$J,12695,1,2,0)
 ;;=12697^place in lying position/flat/head to side during seizures^3^NURSC^19
