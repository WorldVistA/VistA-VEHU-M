NURCCGEI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13197,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,13197,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13197,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13202,0)
 ;;=Related Problems^2^NURSC^7^153^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13202,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13202,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13202,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13202,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13202,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13202,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13208,0)
 ;;=assess for S/S of decreased tissue perfussion q[frequency]^3^NURSC^11^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13208,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13208,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13213,0)
 ;;=assess for factors that improve mobility^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13213,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13213,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13216,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^175^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13216,1,0)
 ;;=^124.21PI^11^2
 ;;^UTILITY("^GMRD(124.2,",$J,13216,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13216,1,11,0)
 ;;=13511^[Extra Goal]^3^NURSC^234
 ;;^UTILITY("^GMRD(124.2,",$J,13216,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13229,0)
 ;;=implement measures to improve cerebral blood flow [specify]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13229,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13229,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13242,0)
 ;;=[Extra Goal]^3^NURSC^9^231^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13242,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13242,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^148^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,0)
 ;;=^124.21PI^31^9
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,4,0)
 ;;=13258^respiratory pattern q[frequency]^2^NURSC^25
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,18,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,20,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,22,0)
 ;;=13294^provide patient teaching (Gas Exchange, Impaired)^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,29,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,30,0)
 ;;=13358^refer for appropriate consults^2^NURSC^72
 ;;^UTILITY("^GMRD(124.2,",$J,13245,1,31,0)
 ;;=13677^[Extra Order]^3^NURSC^242
 ;;^UTILITY("^GMRD(124.2,",$J,13245,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13245,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13258,0)
 ;;=respiratory pattern q[frequency]^2^NURSC^11^25^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13258,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,13258,1,1,0)
 ;;=2697^respiratory altenans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13258,1,2,0)
 ;;=2698^paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13258,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,13258,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13258,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13258,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13270,0)
 ;;=teach techniques to prevent complications^3^NURSC^11^3^^^T
