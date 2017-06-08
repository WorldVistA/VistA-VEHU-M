NURCCGGG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15533,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15534,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^296^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15534,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15534,1,1,0)
 ;;=15536^[etiology]^3^NURSC^89
 ;;^UTILITY("^GMRD(124.2,",$J,15534,1,2,0)
 ;;=15537^[etiology]^3^NURSC^90
 ;;^UTILITY("^GMRD(124.2,",$J,15534,1,3,0)
 ;;=15576^[etiology]^3^NURSC^52
 ;;^UTILITY("^GMRD(124.2,",$J,15534,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15535,0)
 ;;=[etiology]^3^NURSC^^88^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15536,0)
 ;;=[etiology]^3^NURSC^^89^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15537,0)
 ;;=[etiology]^3^NURSC^^90^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15538,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^309^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15538,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15538,1,1,0)
 ;;=15539^[Extra Goal]^3^NURSC^407
 ;;^UTILITY("^GMRD(124.2,",$J,15538,1,2,0)
 ;;=15540^[Extra Goal]^3^NURSC^408
 ;;^UTILITY("^GMRD(124.2,",$J,15538,1,3,0)
 ;;=15541^[Extra Goal]^3^NURSC^409
 ;;^UTILITY("^GMRD(124.2,",$J,15538,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15539,0)
 ;;=[Extra Goal]^3^NURSC^9^407^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15539,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15539,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15540,0)
 ;;=[Extra Goal]^3^NURSC^9^408^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15540,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15540,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15541,0)
 ;;=[Extra Goal]^3^NURSC^9^409^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15541,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15541,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15542,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^311^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15542,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15542,1,1,0)
 ;;=15543^[Extra Order]^3^NURSC^414
 ;;^UTILITY("^GMRD(124.2,",$J,15542,1,2,0)
 ;;=15544^[Extra Order]^3^NURSC^415
 ;;^UTILITY("^GMRD(124.2,",$J,15542,1,3,0)
 ;;=15545^[Extra Order]^3^NURSC^416
 ;;^UTILITY("^GMRD(124.2,",$J,15542,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15542,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15543,0)
 ;;=[Extra Order]^3^NURSC^11^414^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15543,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15543,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15544,0)
 ;;=[Extra Order]^3^NURSC^11^415^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15544,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15544,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15545,0)
 ;;=[Extra Order]^3^NURSC^11^416^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15545,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15545,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15546,0)
 ;;=if on peritoneal dialysis:^2^NURSC^9^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15546,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15546,1,1,0)
 ;;=15548^no S/S of infection @ peritoneal site^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15546,1,2,0)
 ;;=15549^no S/S of peritonitis (dialysis return clear, lt yellow)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15546,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15546,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15546,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15547,0)
 ;;=demonstrates understanding of spoken words and gestures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15547,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15547,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15548,0)
 ;;=no S/S of infection @ peritoneal site^3^NURSC^^1^^^T
