NURCCGCH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,5,0)
 ;;=9818^promote proper handwashing^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,6,0)
 ;;=9819^initiate and administer blood tranfusions as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,10,0)
 ;;=9827^monitor for signs and symptoms of sepsis^3^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,11,0)
 ;;=9830^institute neutropenic precautions if WBC warrants^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,12,0)
 ;;=9832^initiate intravenous therapy protocol^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,16,0)
 ;;=9847^observe for evidence of bleeding^3^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,18,0)
 ;;=10071^[Extra Order]^3^NURSC^170
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,20,0)
 ;;=15703^monitor laboratory values q[frequency]^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,21,0)
 ;;=15709^test all secretions for presence of blood^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,22,0)
 ;;=15710^if WBC low restrict use of catheters,injections,enemas,etc.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9811,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9811,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9812,0)
 ;;=assist with personal hygiene including oral care q[specify]^3^NURSC^11^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9812,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,9812,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9812,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9813,0)
 ;;=Injury Potential Related to Visual Impairment^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9813,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9813,1,1,0)
 ;;=9816^Etiology/Related and/or Risk Factors^2^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,9813,1,2,0)
 ;;=9855^Goals/Expected Outcomes^2^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,9813,1,3,0)
 ;;=9865^Nursing Intervention/Orders^2^NURSC^113
 ;;^UTILITY("^GMRD(124.2,",$J,9813,1,4,0)
 ;;=9896^Related Problems^2^NURSC^114
 ;;^UTILITY("^GMRD(124.2,",$J,9813,1,5,0)
 ;;=9900^Defining Characteristics^2^NURSC^116
 ;;^UTILITY("^GMRD(124.2,",$J,9813,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9813,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9813,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9813,"TD",0)
 ;;=^^3^3^2910829^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9813,"TD",1,0)
 ;;=A state in which the individual is at risk for injury as a result of
 ;;^UTILITY("^GMRD(124.2,",$J,9813,"TD",2,0)
 ;;=environmental conditions interacting with the individual's adaptive
 ;;^UTILITY("^GMRD(124.2,",$J,9813,"TD",3,0)
 ;;=and defensive resources.
 ;;^UTILITY("^GMRD(124.2,",$J,9816,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^134^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,0)
 ;;=^124.21PI^18^7
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,1,0)
 ;;=758^individual/environment conditions which impose a risk^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,8,0)
 ;;=765^loss of motor ability from disease/injury/aging/restraints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,9,0)
 ;;=766^sensory loss from disease/injury/aging/restraints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,10,0)
 ;;=767^cognitive deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,11,0)
 ;;=768^perceptual deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,13,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,1,18,0)
 ;;=774^unfamiliar setting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9816,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9818,0)
 ;;=promote proper handwashing^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9818,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9818,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9819,0)
 ;;=initiate and administer blood tranfusions as ordered^3^NURSC^11^6^^^T
