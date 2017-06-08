NURCCGB6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7516,1,1,0)
 ;;=7517^Etiology/Related and/or Risk Factors^2^NURSC^105
 ;;^UTILITY("^GMRD(124.2,",$J,7516,1,2,0)
 ;;=7547^Goals/Expected Outcomes^2^NURSC^103
 ;;^UTILITY("^GMRD(124.2,",$J,7516,1,3,0)
 ;;=7558^Nursing Intervention/Orders^2^NURSC^181
 ;;^UTILITY("^GMRD(124.2,",$J,7516,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7516,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7516,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7516,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,7516,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,7516,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,7517,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^105^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7517,1,0)
 ;;=^124.21PI^21^3
 ;;^UTILITY("^GMRD(124.2,",$J,7517,1,19,0)
 ;;=481^inadequate secondary defenses^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7517,1,20,0)
 ;;=15562^dialysis an invasive therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7517,1,21,0)
 ;;=15563^decreased WBC activity with uremia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7517,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^103^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,2,0)
 ;;=549^reduced risk of pulmonary infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,3,0)
 ;;=550^intact mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,5,0)
 ;;=552^optimal fluid balance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,6,0)
 ;;=7553^patient demonstrates knowledge^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,8,0)
 ;;=7607^[Extra Goal]^3^NURSC^138
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,9,0)
 ;;=15546^if on peritoneal dialysis:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,1,10,0)
 ;;=15558^optimal dry weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7547,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7553,0)
 ;;=patient demonstrates knowledge^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7553,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,7553,1,1,0)
 ;;=554^actions to take to prevent cross-infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7553,1,2,0)
 ;;=555^s/s of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7553,5)
 ;;=of:
 ;;^UTILITY("^GMRD(124.2,",$J,7553,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7553,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7553,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7557,0)
 ;;=[Extra Goal]^3^NURSC^9^137^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7557,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7557,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^181^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,0)
 ;;=^124.21PI^19^18
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,1,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,2,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,3,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,4,0)
 ;;=495^culture sputum [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,8,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,9,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,10,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
