NURCCGFP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14699,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14699,5)
 ;;=due to:
 ;;^UTILITY("^GMRD(124.2,",$J,14699,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^192^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,2,0)
 ;;=549^reduced risk of pulmonary infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,3,0)
 ;;=550^intact mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,4,0)
 ;;=551^optimal weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,5,0)
 ;;=552^optimal fluid balance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,6,0)
 ;;=14709^patient demonstrates knowledge^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14703,1,8,0)
 ;;=14945^[Extra Goal]^3^NURSC^251
 ;;^UTILITY("^GMRD(124.2,",$J,14703,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14709,0)
 ;;=patient demonstrates knowledge^2^NURSC^9^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14709,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,14709,1,1,0)
 ;;=554^actions to take to prevent cross-infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14709,1,2,0)
 ;;=555^s/s of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14709,5)
 ;;=of:
 ;;^UTILITY("^GMRD(124.2,",$J,14709,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14709,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14709,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14713,0)
 ;;=[Extra Goal]^3^NURSC^9^248^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14713,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14713,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^161^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,1,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,2,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,3,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,4,0)
 ;;=495^culture sputum [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,5,0)
 ;;=334^pulmonary toilet q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,7,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,8,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,9,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,10,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,11,0)
 ;;=497^provide humidity q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,12,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,13,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,14,0)
 ;;=14728^isolation^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,15,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,17,0)
 ;;=14734^teach prevention of infection techniques [specify]^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,14714,1,18,0)
 ;;=15188^[Extra Order]^3^NURSC^259
 ;;^UTILITY("^GMRD(124.2,",$J,14714,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14714,9)
 ;;=D EN1^NURCCPU2
