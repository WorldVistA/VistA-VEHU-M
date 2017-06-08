NURCCGGQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15723,0)
 ;;=identifies alternative methods of managing stressors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15723,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15723,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15724,0)
 ;;=[Extra Goal]^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15724,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15724,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15725,0)
 ;;=[Extra Goal]^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15725,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15725,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15726,0)
 ;;=[Extra Order]^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15726,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15726,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15727,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^316^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,1,0)
 ;;=15728^reality orientation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,2,0)
 ;;=15729^clarify sensory misconceptions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,3,0)
 ;;=15715^provide safe environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,4,0)
 ;;=15730^assess for presence of unilateral neglect^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,5,0)
 ;;=15674^decrease external noise and distractions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,6,0)
 ;;=15731^assist pt. to recognize horizontal and vertical planes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,7,0)
 ;;=15714^encourage support of significant others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,8,0)
 ;;=15380^divide tasks into the smallest steps possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,9,0)
 ;;=15732^keep objects within visual field^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,1,10,0)
 ;;=15733^[Extra Order]^3^NURSC^268
 ;;^UTILITY("^GMRD(124.2,",$J,15727,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15727,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15728,0)
 ;;=reality orientation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15728,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15728,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15729,0)
 ;;=clarify sensory misconceptions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15729,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15729,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15730,0)
 ;;=assess for presence of unilateral neglect^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15730,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15730,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15731,0)
 ;;=assist pt. to recognize horizontal and vertical planes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15731,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15731,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15732,0)
 ;;=keep objects within visual field^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15732,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15732,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15733,0)
 ;;=[Extra Order]^3^NURSC^11^268^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15733,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15733,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15734,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^9^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15734,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15734,1,1,0)
 ;;=15737^Etiology/Related and/or Risk Factors^2^NURSC^301
 ;;^UTILITY("^GMRD(124.2,",$J,15734,1,2,0)
 ;;=15741^Goals/Expected Outcomes^2^NURSC^315
 ;;^UTILITY("^GMRD(124.2,",$J,15734,1,3,0)
 ;;=15748^Nursing Intervention/Orders^2^NURSC^317
