NURCCG1C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,14,0)
 ;;=488^impaired cough mechanism^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,15,0)
 ;;=489^use of antibiotics^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,16,0)
 ;;=490^inability to breathe deeply due to weakness, chest pain etc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,468,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,1,0)
 ;;=470^has normal sputum production^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,2,0)
 ;;=471^has reduced risk of pulmonary infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,3,0)
 ;;=472^maintains intact mucous membranes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,4,0)
 ;;=473^maintains optimal weight [specify lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,5,0)
 ;;=474^maintains optimal fluid balance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,6,0)
 ;;=475^states actions taken to prevent cross infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,7,0)
 ;;=476^states S/S of infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,8,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,1,9,0)
 ;;=2876^[Extra Goal]^3^NURSC^53^0
 ;;^UTILITY("^GMRD(124.2,",$J,468,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,469,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,0)
 ;;=^124.21PI^21^21
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,3,0)
 ;;=491^monitor sputum^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,4,0)
 ;;=495^culture sputum [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,5,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,6,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,7,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,8,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,9,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,10,0)
 ;;=497^provide humidity q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,11,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,12,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,13,0)
 ;;=337^I&O q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,14,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,15,0)
 ;;=2702^bronchial hygiene q[frequency]hrs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,16,0)
 ;;=2432^isolation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,17,0)
 ;;=2741^teach S/S  of infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,18,0)
 ;;=2742^annual flu shot^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,19,0)
 ;;=2743^pneumococcus vaccine^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,20,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,1,21,0)
 ;;=2963^[Extra Order]^3^NURSC^40^0
 ;;^UTILITY("^GMRD(124.2,",$J,469,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,469,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,470,0)
 ;;=has normal sputum production^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,470,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,470,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,471,0)
 ;;=has reduced risk of pulmonary infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,471,9)
 ;;=D EN5^NURCCPU0
