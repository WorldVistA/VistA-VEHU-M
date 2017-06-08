NURCCG64 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2477,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2477,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2477,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2477,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2478,0)
 ;;=CPAP set-up^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2479,0)
 ;;=oxygen therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2480,0)
 ;;=trach care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2481,0)
 ;;=teach patient and S/O^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2481,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2481,1,1,0)
 ;;=2482^S/S of sleep-pattern disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2481,1,2,0)
 ;;=2483^compliance with prescribed treatment program^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2481,1,3,0)
 ;;=2484^assembling, using, and cleaning of respiratory equipment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2481,1,4,0)
 ;;=2485^individuals to contact if equipment problems occur^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2481,5)
 ;;=the following:
 ;;^UTILITY("^GMRD(124.2,",$J,2481,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2481,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2481,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2482,0)
 ;;=S/S of sleep-pattern disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2483,0)
 ;;=compliance with prescribed treatment program^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2484,0)
 ;;=assembling, using, and cleaning of respiratory equipment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2485,0)
 ;;=individuals to contact if equipment problems occur^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2486,0)
 ;;=verbalizes knowledge of treatments^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2486,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2486,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2487,0)
 ;;=verbalizes knowledge of disease process & treatment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2487,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2487,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2488,0)
 ;;=verbalizes knowledge of risks^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2488,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2488,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2489,0)
 ;;=follows treatment regime^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2489,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2489,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2490,0)
 ;;=maintains or regains ability for self-care in ADL^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2490,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2490,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2491,0)
 ;;=effective decision making skills^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2491,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2491,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2492,0)
 ;;=environment clean^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2493,0)
 ;;=verbalizes acquisition of necessary supplies or equipment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2494,0)
 ;;=verbalizes community/family resource if required^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2495,0)
 ;;=demonstrates adaptive techniques/devices for self-care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2495,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2495,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2496,0)
 ;;=achieves independence in self-care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2496,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2496,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2497,0)
 ;;=achieves independence in feeding^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2497,9)
 ;;=D EN5^NURCCPU0
