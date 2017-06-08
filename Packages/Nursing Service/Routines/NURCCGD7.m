NURCCGD7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,21,0)
 ;;=4446^initiate febrile protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,22,0)
 ;;=15521^assess integrity of chest tubes/drainage system q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,23,0)
 ;;=15522^assess incision site for S/S of infection q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11247,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11247,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11277,0)
 ;;=[Extra Order]^3^NURSC^11^185^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11277,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11277,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11278,0)
 ;;=Pain, Acute^2^NURSC^2^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11278,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11278,1,1,0)
 ;;=11279^Etiology/Related and/or Risk Factors^2^NURSC^152
 ;;^UTILITY("^GMRD(124.2,",$J,11278,1,2,0)
 ;;=11297^Goals/Expected Outcomes^2^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,11278,1,3,0)
 ;;=11307^Nursing Intervention/Orders^2^NURSC^192
 ;;^UTILITY("^GMRD(124.2,",$J,11278,1,4,0)
 ;;=11325^Related Problems^2^NURSC^131
 ;;^UTILITY("^GMRD(124.2,",$J,11278,1,5,0)
 ;;=11336^Defining Characteristics^2^NURSC^131
 ;;^UTILITY("^GMRD(124.2,",$J,11278,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11278,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11278,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11278,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,11278,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,11278,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,11279,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^152^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11279,1,0)
 ;;=^124.21PI^10^1
 ;;^UTILITY("^GMRD(124.2,",$J,11279,1,10,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11279,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11297,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^150^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11297,1,0)
 ;;=^124.21PI^11^3
 ;;^UTILITY("^GMRD(124.2,",$J,11297,1,7,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11297,1,9,0)
 ;;=11458^[Extra Goal]^3^NURSC^185
 ;;^UTILITY("^GMRD(124.2,",$J,11297,1,11,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11297,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11306,0)
 ;;=[Extra Goal]^3^NURSC^9^183^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11306,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11306,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11307,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^192^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,0)
 ;;=^124.21PI^19^6
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,7,0)
 ;;=2805^teach splinting of the incision to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,16,0)
 ;;=11701^[Extra Order]^3^NURSC^190
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,18,0)
 ;;=15530^teach pt to turn/ambulate while supporting chest tubes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11307,1,19,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11307,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11307,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11323,0)
 ;;=[Extra Order]^3^NURSC^11^186^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11323,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11323,10)
 ;;=D EN1^NURCCPU3
