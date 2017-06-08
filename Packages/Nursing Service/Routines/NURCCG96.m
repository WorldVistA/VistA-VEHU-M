NURCCG96 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4838,1,6,0)
 ;;=4888^[Extra Order]^3^NURSC^20
 ;;^UTILITY("^GMRD(124.2,",$J,4838,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4838,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4841,0)
 ;;=elevate legs when sitting^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4841,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4841,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4844,0)
 ;;=[Extra Goal]^3^NURSC^9^20^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4844,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4844,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4845,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^237^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4845,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4845,1,1,0)
 ;;=2702^bronchial hygiene q[frequency]hrs^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4845,1,2,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4845,1,3,0)
 ;;=3213^assess nutritional status q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4845,1,4,0)
 ;;=4925^[Extra Order]^3^NURSC^223
 ;;^UTILITY("^GMRD(124.2,",$J,4845,1,5,0)
 ;;=4858^use of incentive spirometer q[freq]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4845,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4845,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4846,0)
 ;;=[Extra Order]^3^NURSC^11^221^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4846,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4846,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4847,0)
 ;;=monitor B/P q[frequency], TPR q[frequency] ^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4847,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4847,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4848,0)
 ;;=[Extra Order]^3^NURSC^11^16^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4848,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4848,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4851,0)
 ;;=[Extra Order]^3^NURSC^11^48^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4851,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4851,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4852,0)
 ;;=Psychoses/Schizophrenia^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4852,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4852,1,1,0)
 ;;=4857^Thought Processes, Alteration in^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4852,1,2,0)
 ;;=4859^Violence Potential, Directed at Others^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4852,1,3,0)
 ;;=4862^[Extra Problem]^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,4854,0)
 ;;=[Extra Order]^3^NURSC^11^222^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4854,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4854,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4855,0)
 ;;=Swallowing, Impaired^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4855,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4855,1,1,0)
 ;;=4856^Etiology/Related and/or Risk Factors^2^NURSC^232
 ;;^UTILITY("^GMRD(124.2,",$J,4855,1,2,0)
 ;;=4860^Goals/Expected Outcomes^2^NURSC^237
 ;;^UTILITY("^GMRD(124.2,",$J,4855,1,3,0)
 ;;=4867^Nursing Intervention/Orders^2^NURSC^238
 ;;^UTILITY("^GMRD(124.2,",$J,4855,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4855,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4855,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4856,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^232^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4856,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4856,1,1,0)
 ;;=2611^mechanical obstruction, i.e., tumors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4856,1,2,0)
 ;;=4290^absent gag reflex^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4856,1,3,0)
 ;;=4240^minor evidence of aspiration^3^NURSC^1
