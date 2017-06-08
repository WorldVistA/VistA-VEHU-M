NURCCG1K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,8,0)
 ;;=2878^[Extra Goal]^3^NURSC^55^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,9,0)
 ;;=16565^reduced risk of pulmonary infection^3^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,535,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,536,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,1,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,2,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,3,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,4,0)
 ;;=495^culture sputum [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,5,0)
 ;;=334^pulmonary toilet q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,7,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,8,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,9,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,10,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,11,0)
 ;;=497^provide humidity q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,12,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,13,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,14,0)
 ;;=2432^isolation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,15,0)
 ;;=337^I&O q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,17,0)
 ;;=2436^teach prevention of infection techniques [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,1,18,0)
 ;;=2965^[Extra Order]^3^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,536,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,536,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,537,0)
 ;;=inadequate primary defenses:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,1,0)
 ;;=538^broken skin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,2,0)
 ;;=539^traumatized tissue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,3,0)
 ;;=540^decrease of ciliary action^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,4,0)
 ;;=541^stasis of body fluids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,5,0)
 ;;=542^change in pH secretions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,537,1,6,0)
 ;;=543^altered peristalsis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,537,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,537,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,538,0)
 ;;=broken skin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,539,0)
 ;;=traumatized tissue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,540,0)
 ;;=decrease of ciliary action^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,541,0)
 ;;=stasis of body fluids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,542,0)
 ;;=change in pH secretions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,543,0)
 ;;=altered peristalsis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,544,0)
 ;;=inadequate secondary defenses:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,544,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,544,1,1,0)
 ;;=545^decreased hemoglobin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,544,1,2,0)
 ;;=546^leukopenia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,544,1,3,0)
 ;;=547^suppressed inflammatory response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,544,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,544,7)
 ;;=D EN4^NURCCPU1
