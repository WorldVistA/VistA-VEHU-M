NURCCGG0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,19,0)
 ;;=454^encourage rest^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,20,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,21,0)
 ;;=434^provide calm, supportive environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,24,0)
 ;;=437^provide communication (see Communication, Impaired Verbal)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,25,0)
 ;;=2699^ear oximetry q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,26,0)
 ;;=2700^document use of accessory muscles q [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,27,0)
 ;;=2701^peak flows [frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,29,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,31,0)
 ;;=15630^[Extra Order]^3^NURSC^263
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,32,0)
 ;;=331^position to mobilize secretions q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,33,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,34,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15108,0)
 ;;=[Extra Order]^3^NURSC^11^258^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15108,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15108,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15109,0)
 ;;=Defining Characteristics^2^NURSC^12^176^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15109,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15116,0)
 ;;=Infection Potential^2^NURSC^2^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15116,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15116,1,1,0)
 ;;=15117^Etiology/Related and/or Risk Factors^2^NURSC^200
 ;;^UTILITY("^GMRD(124.2,",$J,15116,1,2,0)
 ;;=15147^Goals/Expected Outcomes^2^NURSC^197
 ;;^UTILITY("^GMRD(124.2,",$J,15116,1,3,0)
 ;;=15158^Nursing Intervention/Orders^2^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,15116,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15116,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15116,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15116,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,15116,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,15116,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,15117,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^200^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15117,1,0)
 ;;=^124.21PI^18^4
 ;;^UTILITY("^GMRD(124.2,",$J,15117,1,6,0)
 ;;=482^malnutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15117,1,14,0)
 ;;=488^impaired cough mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15117,1,17,0)
 ;;=15143^inability to breathe deeply^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,15117,1,18,0)
 ;;=477^chronic disease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15117,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15143,0)
 ;;=inability to breathe deeply^2^NURSC^^11^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15143,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15143,1,1,0)
 ;;=2430^weakness^3^NURSC^1
