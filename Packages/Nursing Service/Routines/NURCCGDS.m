NURCCGDS ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12076,0)
 ;;=inability to breathe deeply^2^NURSC^^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12076,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12076,1,1,0)
 ;;=2430^weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12076,1,2,0)
 ;;=2431^chest pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12076,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12076,5)
 ;;=due to:
 ;;^UTILITY("^GMRD(124.2,",$J,12076,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12080,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^161^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12080,1,0)
 ;;=^124.21PI^11^4
 ;;^UTILITY("^GMRD(124.2,",$J,12080,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12080,1,9,0)
 ;;=1169^remains free of S/S of infection^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12080,1,10,0)
 ;;=10182^identifies S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12080,1,11,0)
 ;;=1006315^[Extra Goal]^3^NURSC^172
 ;;^UTILITY("^GMRD(124.2,",$J,12080,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12090,0)
 ;;=[Extra Goal]^3^NURSC^9^192^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12090,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12090,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^135^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,0)
 ;;=^124.21PI^22^9
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,1,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,2,0)
 ;;=12093^wound drainage:assess for color,consistency,amt,odor q[frq]^3^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,18,0)
 ;;=12661^[Extra Order]^3^NURSC^205
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,19,0)
 ;;=2741^teach S/S  of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,20,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,21,0)
 ;;=15504^protect skin from urine/feces^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,1,22,0)
 ;;=15508^septemia-monitor,report S/S:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12091,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12093,0)
 ;;=wound drainage:assess for color,consistency,amt,odor q[frq]^3^NURSC^11^10^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12093,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12093,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12112,0)
 ;;=Infection Potential^2^NURSC^2^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12112,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12112,1,1,0)
 ;;=12114^Etiology/Related and/or Risk Factors^2^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,12112,1,2,0)
 ;;=12153^Goals/Expected Outcomes^2^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,12112,1,3,0)
 ;;=12164^Nursing Intervention/Orders^2^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,12112,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12112,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12112,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12112,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,12112,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,12112,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,12114,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^164^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,1,0)
 ;;=477^chronic disease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,3,0)
 ;;=93^inadequate support system^3^NURSC^1
