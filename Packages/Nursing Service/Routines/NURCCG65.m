NURCCG65 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2497,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2498,0)
 ;;=adaptive techniques/devices for independent dressing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2498,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2498,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2499,0)
 ;;=independence in dressing/grooming^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2499,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2499,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2500,0)
 ;;=achieves independence in toileting^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2500,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2500,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2501,0)
 ;;=verbalizes prevention practice for [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2501,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2501,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2502,0)
 ;;=hypermetabolic status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2503,0)
 ;;=experiences increased calories/day of [ ]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2503,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2503,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2504,0)
 ;;=experiences decreased calories/day of [ ]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2504,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2504,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2505,0)
 ;;=experiences increased CHO of [ ]gms^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2505,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2505,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2506,0)
 ;;=experiences decreased CHO of [ ]gms^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2506,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2506,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2507,0)
 ;;=experiences an increase of [ ]gms of fat^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2507,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2507,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2508,0)
 ;;=experiences a decrease of [ ]gms of fat^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2508,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2508,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2509,0)
 ;;=experiences an increase of [ ]gms of protein^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2509,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2509,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2510,0)
 ;;=experiences a decrease of [ ]gms of protein^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2510,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2510,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2511,0)
 ;;=achieves weight loss of [number of lbs/kgs]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2511,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2511,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2512,0)
 ;;=achieves weight gain of [number of lbs/kgs]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2512,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2512,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2513,0)
 ;;=maintains optimal weight [specify lbs/kgs]^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2513,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2513,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2514,0)
 ;;=demonstrates energy to obtain/prepare/consume food^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2514,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2514,1,1,0)
 ;;=2515^obtain [#] meals per day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2514,1,2,0)
 ;;=2516^prepare [#] meals per day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2514,1,3,0)
 ;;=2517^consume [#] meals per day^3^NURSC^1^0
