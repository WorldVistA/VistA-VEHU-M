NURCCGCJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9872,1,4,0)
 ;;=790^night light^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9872,1,5,0)
 ;;=9877^safety restraints, check restraints q[frequency]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,9872,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,9872,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9872,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9872,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9877,0)
 ;;=safety restraints, check restraints q[frequency]^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9895,0)
 ;;=[Extra Order]^3^NURSC^11^167^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9895,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9895,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9896,0)
 ;;=Related Problems^2^NURSC^7^114^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9896,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,9896,1,1,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9896,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,9896,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9897,0)
 ;;=Injury Potential^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9897,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9897,1,1,0)
 ;;=9899^Etiology/Related and/or Risk Factors^2^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,9897,1,2,0)
 ;;=9925^Goals/Expected Outcomes^2^NURSC^133
 ;;^UTILITY("^GMRD(124.2,",$J,9897,1,3,0)
 ;;=9929^Nursing Intervention/Orders^2^NURSC^114
 ;;^UTILITY("^GMRD(124.2,",$J,9897,1,4,0)
 ;;=9957^Related Problems^2^NURSC^115
 ;;^UTILITY("^GMRD(124.2,",$J,9897,1,5,0)
 ;;=9959^Defining Characteristics^2^NURSC^117
 ;;^UTILITY("^GMRD(124.2,",$J,9897,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9897,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9897,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9897,"TD",0)
 ;;=^^3^3^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,9897,"TD",1,0)
 ;;=A state in which the individual is at risk for injury as a result of
 ;;^UTILITY("^GMRD(124.2,",$J,9897,"TD",2,0)
 ;;=environmental conditions interacting with the individual's adaptive
 ;;^UTILITY("^GMRD(124.2,",$J,9897,"TD",3,0)
 ;;=and defensive resources.
 ;;^UTILITY("^GMRD(124.2,",$J,9899,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^135^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,0)
 ;;=^124.21PI^20^20
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,1,0)
 ;;=758^individual/environment conditions which impose a risk^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,2,0)
 ;;=759^biological^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,3,0)
 ;;=903^chemical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,4,0)
 ;;=760^developmental^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,5,0)
 ;;=761^physiologic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,6,0)
 ;;=762^psychologic perception^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,7,0)
 ;;=763^people provider^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,8,0)
 ;;=765^loss of motor ability from disease/injury/aging/restraints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,9,0)
 ;;=766^sensory loss from disease/injury/aging/restraints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,10,0)
 ;;=767^cognitive deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,11,0)
 ;;=768^perceptual deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,12,0)
 ;;=769^adverse effects of chemicals/drugs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,13,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,14,0)
 ;;=770^self-mutilation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,15,0)
 ;;=771^nonadherence/noncompliance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,16,0)
 ;;=772^infestation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,17,0)
 ;;=773^clothing^3^NURSC^1
