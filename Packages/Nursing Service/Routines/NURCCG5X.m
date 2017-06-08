NURCCG5X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2379,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2380,0)
 ;;=neurotransmitter dysfunction^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2381,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^60^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,1,0)
 ;;=2382^collect data on sleep pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,2,0)
 ;;=1486^provide rest periods q [ ] min/24 hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,3,0)
 ;;=2384^reduce stimulation/protect from overstimulation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,4,0)
 ;;=2386^define and reinforce limits and controls with patient^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,5,0)
 ;;=2388^formulate schedule of daily activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,6,0)
 ;;=2389^encourage purposeful activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,7,0)
 ;;=2392^provide protection from disruptive behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,8,0)
 ;;=2393^have staff sit with patient to provide support/control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,9,0)
 ;;=2394^medicate as prescribed by MD^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,10,0)
 ;;=2395^teach^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,1,11,0)
 ;;=3016^[Extra Order]^3^NURSC^102^0
 ;;^UTILITY("^GMRD(124.2,",$J,2381,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2381,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2382,0)
 ;;=collect data on sleep pattern^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2382,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2382,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2383,0)
 ;;=will have adequate sleep and rest^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2383,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2383,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2384,0)
 ;;=reduce stimulation/protect from overstimulation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2384,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2384,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2385,0)
 ;;=reports improved ability to concentrate^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2385,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2385,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2386,0)
 ;;=define and reinforce limits and controls with patient^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2386,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2386,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2387,0)
 ;;=expresses realistic plans and ideas^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2387,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2387,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2388,0)
 ;;=formulate schedule of daily activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2388,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2388,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2389,0)
 ;;=encourage purposeful activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2389,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2389,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2390,0)
 ;;=demonstrates increased ability to control motor behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2390,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2390,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2391,0)
 ;;=demonstrates increased ability to control verbal behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2391,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2391,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2392,0)
 ;;=provide protection from disruptive behavior^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2392,9)
 ;;=D EN2^NURCCPU2
