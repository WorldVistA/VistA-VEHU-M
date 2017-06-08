NURCCGCG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9769,1,3,0)
 ;;=9811^Nursing Intervention/Orders^2^NURSC^112
 ;;^UTILITY("^GMRD(124.2,",$J,9769,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9769,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9769,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9769,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,9769,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,9769,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,9770,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^133^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9770,1,0)
 ;;=^124.21PI^13^5
 ;;^UTILITY("^GMRD(124.2,",$J,9770,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9770,1,4,0)
 ;;=9774^inadequate primary defenses:^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,9770,1,6,0)
 ;;=482^malnutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9770,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9770,1,13,0)
 ;;=487^mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9770,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,0)
 ;;=inadequate primary defenses:^2^NURSC^^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,1,0)
 ;;=538^broken skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,2,0)
 ;;=539^traumatized tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,3,0)
 ;;=540^decrease of ciliary action^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,4,0)
 ;;=541^stasis of body fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,5,0)
 ;;=542^change in pH secretions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,1,6,0)
 ;;=543^altered peristalsis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9774,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,9774,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^131^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,3,0)
 ;;=550^intact mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,4,0)
 ;;=551^optimal weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,5,0)
 ;;=552^optimal fluid balance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,6,0)
 ;;=9806^patient demonstrates knowledge^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,8,0)
 ;;=9862^[Extra Goal]^3^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,9800,1,9,0)
 ;;=15699^prevent complications of bleeding^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9800,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9806,0)
 ;;=patient demonstrates knowledge^2^NURSC^9^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9806,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,9806,1,1,0)
 ;;=554^actions to take to prevent cross-infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9806,1,2,0)
 ;;=555^s/s of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9806,5)
 ;;=of:
 ;;^UTILITY("^GMRD(124.2,",$J,9806,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9806,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9806,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9810,0)
 ;;=[Extra Goal]^3^NURSC^9^163^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9810,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9810,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9811,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^112^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,0)
 ;;=^124.21PI^22^11
 ;;^UTILITY("^GMRD(124.2,",$J,9811,1,1,0)
 ;;=9812^assist with personal hygiene including oral care q[specify]^3^NURSC^9
