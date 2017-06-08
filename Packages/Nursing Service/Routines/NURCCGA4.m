NURCCGA4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5776,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5776,1,1,0)
 ;;=5777^[Extra Order]^3^NURSC^321
 ;;^UTILITY("^GMRD(124.2,",$J,5776,1,2,0)
 ;;=5778^[Extra Order]^3^NURSC^322
 ;;^UTILITY("^GMRD(124.2,",$J,5776,1,3,0)
 ;;=5779^[Extra Order]^3^NURSC^323
 ;;^UTILITY("^GMRD(124.2,",$J,5776,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5776,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5777,0)
 ;;=[Extra Order]^3^NURSC^11^321^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5777,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5777,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5778,0)
 ;;=[Extra Order]^3^NURSC^11^322^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5778,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5778,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5779,0)
 ;;=[Extra Order]^3^NURSC^11^323^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5779,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5779,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5780,0)
 ;;=[Extra Goal]^3^NURSC^9^22^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5780,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5780,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5781,0)
 ;;=Communication Impaired^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5781,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5781,1,1,0)
 ;;=5782^Etiology/Related and/or Risk Factors^2^NURSC^80
 ;;^UTILITY("^GMRD(124.2,",$J,5781,1,2,0)
 ;;=5801^Goals/Expected Outcomes^2^NURSC^80
 ;;^UTILITY("^GMRD(124.2,",$J,5781,1,3,0)
 ;;=5807^Nursing Intervention/Orders^2^NURSC^73
 ;;^UTILITY("^GMRD(124.2,",$J,5781,1,4,0)
 ;;=5820^Defining Characteristics^2^NURSC^74
 ;;^UTILITY("^GMRD(124.2,",$J,5781,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5781,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5781,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5781,"TD",0)
 ;;=^^2^2^2890803^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,5781,"TD",1,0)
 ;;=The state in which an individual experiences a decreased or absent
 ;;^UTILITY("^GMRD(124.2,",$J,5781,"TD",2,0)
 ;;=ability to use or understand language in human interaction.
 ;;^UTILITY("^GMRD(124.2,",$J,5782,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^80^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,1,0)
 ;;=1101^anatomic deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,2,0)
 ;;=1102^cultural differences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,3,0)
 ;;=1103^decrease in circulation to the brain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,4,0)
 ;;=1104^developmental/age-related^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,5,0)
 ;;=1106^physical barrier: brain tumor, tracheostomy, intubation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,6,0)
 ;;=1107^psychological barriers, psychosis, lack of stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,7,0)
 ;;=1108^inability to speak^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,8,0)
 ;;=92^impaired cognition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,9,0)
 ;;=1038^reduced consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,10,0)
 ;;=1109^voice rest (medical protocol)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,11,0)
 ;;=1110^tracheostomy (medical protocol)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,12,0)
 ;;=1111^intubation (medical protocol)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,13,0)
 ;;=1112^psychosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,14,0)
 ;;=1113^language barriers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,15,0)
 ;;=1114^inability to understand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,16,0)
 ;;=1115^impaired articulation^3^NURSC^1
